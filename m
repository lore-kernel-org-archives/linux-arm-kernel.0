From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 09 Jun 2016 10:43:04 +0200
Subject: [RFC v4 4/7] extcon: usb-gpio: Add support for VBUS detection
In-Reply-To: <57592B02.2070609@ti.com>
References: <1465393686-16644-1-git-send-email-k.kozlowski@samsung.com>
 <1465393686-16644-5-git-send-email-k.kozlowski@samsung.com>
 <57592B02.2070609@ti.com>
Message-ID: <57592C18.8020609@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/09/2016 10:38 AM, Roger Quadros wrote:
> Hi,
> 
> On 08/06/16 16:48, Krzysztof Kozlowski wrote:
>> Add VBUS pin detection support to extcon-usb-gpio driver for boards
>> which have both VBUS and ID pins, or only one of them.
>>
>> The logic behind reporting USB and USB-HOST extcon cables is not
>> affected. The driver however will report extcon changes for USB-VBUS and
>> USB-ID.
>>
>> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>
>> ---
>>
>> Some parts base on old Robert's patchset.
>> ---
>>  drivers/extcon/extcon-usb-gpio.c | 125 +++++++++++++++++++++++++++++++--------
>>  1 file changed, 99 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/extcon/extcon-usb-gpio.c b/drivers/extcon/extcon-usb-gpio.c
>> index a36aab007022..85b8a0ce5731 100644
>> --- a/drivers/extcon/extcon-usb-gpio.c
>> +++ b/drivers/extcon/extcon-usb-gpio.c
>> @@ -35,7 +35,9 @@ struct usb_extcon_info {
>>  	struct extcon_dev *edev;
>>  
>>  	struct gpio_desc *id_gpiod;
>> +	struct gpio_desc *vbus_gpiod;
>>  	int id_irq;
>> +	int vbus_irq;
>>  
>>  	unsigned long debounce_jiffies;
>>  	struct delayed_work wq_detcable;
>> @@ -44,6 +46,8 @@ struct usb_extcon_info {
>>  static const unsigned int usb_extcon_cable[] = {
>>  	EXTCON_USB,
>>  	EXTCON_USB_HOST,
>> +	EXTCON_USB_ID,
>> +	EXTCON_USB_VBUS,
>>  	EXTCON_NONE,
>>  };
>>  
>> @@ -55,7 +59,8 @@ static void usb_extcon_detect_cable(struct work_struct *work)
>>  						    wq_detcable);
>>  
>>  	/* check ID and update cable state */
>> -	id = gpiod_get_value_cansleep(info->id_gpiod);
>> +	id = info->id_gpiod ? gpiod_get_value_cansleep(info->id_gpiod) : 1;
>> +
>>  	if (id) {
>>  		/*
>>  		 * ID = 1 means USB HOST cable detached.
>> @@ -73,6 +78,14 @@ static void usb_extcon_detect_cable(struct work_struct *work)
>>  		extcon_set_cable_state_(info->edev, EXTCON_USB, false);
>>  		extcon_set_cable_state_(info->edev, EXTCON_USB_HOST, true);
>>  	}
>> +
>> +	if (info->id_gpiod)
>> +		extcon_set_cable_state_(info->edev, EXTCON_USB_ID, id);
>> +	if (info->vbus_gpiod) {
>> +		int vbus = gpiod_get_value_cansleep(info->vbus_gpiod);
>> +
>> +		extcon_set_cable_state_(info->edev, EXTCON_USB_VBUS, vbus);
>> +	}
> 
> What happens if either id_gpiod or vbus_gpiod is present?
> 
> As per the DT binding document
> "In general we have three cases:
> 1. If VBUS and ID gpios are present we pass them as is
> USB-HOST = !ID, USB = VBUS
> 2. If only VBUS gpio is present we assume that ID pin is always High.
> USB-HOST = false, USB = VBUS.
> 3. If only ID pin is available we infer the VBUS pin states based on ID.
> USB-HOST = !ID, USB = ID"
> 
> So do you want to be consistent and infer VBUS and ID states based on the other?

Right, I couldn't make up my mind whether I want to change/improve
existing logic or just add VBUS/ID raw notifying. Finally I left
original code for USB/USB-HOST cables alone.

Best regards,
Krzysztof
