From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 09 Jun 2016 18:32:42 +0900
Subject: [RFC v4 0/7] extcon: usb-gpio: fixes and improvements
In-Reply-To: <57592B4A.4000407@samsung.com>
References: <CGME20160608134820epcas1p4ee75a89888f2ae2adb733124a330bd2c@epcas1p4.samsung.com>
 <1465393686-16644-1-git-send-email-k.kozlowski@samsung.com>
 <57592A40.9080608@samsung.com> <57592B4A.4000407@samsung.com>
Message-ID: <575937BA.1070609@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2016? 06? 09? 17:39, Krzysztof Kozlowski wrote:
> 
> Hi,
> 
> 
> On 06/09/2016 10:35 AM, Chanwoo Choi wrote:
>> Hi,
>>
>> It is good to support USB_ID and USB_VBUS by extcon.
>>
>> But,
>> there is some issue about adding the new cable type for
>> both EXTCON_USB_ID and EXTCON_USB_VBUS
>>
>> I think that the ID and VBUS state are not cable type
>> Instead, ID and VBUS state are the property of USB cable.
>>
>> So, I'd like to add the following function to support
>> the property of each cable as following:
>> The client driver can get the state of property by using
>> the extcon_get_cable_property_state().
>>
>> - int extcon_get_cable_property_state(struct extcon_dev *edev,
>> 				unsigned int id,
>> 				enum extcon_property property);
>> - int extcon_set_cable_property_state(struct extcon_dev *edev,
>> 				unsigned int id,
>> 				enum extcon_property property,
>> 				unsigned int state);
>>
>> For example,
>> In extcon-usb-gpio.c, set state of property as follwoing:
>> 	extcon_set_cable_property_state(edev, EXTCON_USB, EXTCON_USB_PROP_ID, 1);
>> 	extcon_set_cable_property_state(edev, EXTCON_USB, EXTCON_USB_PROP_VBUS, 1);
>>
>>
>> In the extcon client driver, get state of property as following:
>> 	id_state = extcon_get_cable_property_state(edev, EXTCON_USB, EXTCON_USB_PROP_ID);
>> 	vbus_state = extcon_get_cable_property_state(edev, EXTCON_USB, EXTCON_USB_PROP_VUBS);
> 
> How one can receive notifications with this API?

I think that the extcon don't support the notification only for property.
When USB or USB_HOST cable state is changed, the client driver
call the extcon_get_cable_property_state() to read the state of property.

Namely, the property depend on the specific external connector.

> 
> Last time you wrote, at the end of discussion:
> http://thread.gmane.org/gmane.linux.kernel/1923192/focus=1923193
>> IMO, if some usb driver check both id and vbus pin at the same time,
>> the usb driver can know the both id and vbus pin state through only
> one notifier event.
>>
>> Also,
>> If some usb driver want to know the state of id pin except of vbus state,
>> when receiving following events, id pin is low.
>> 	#define EXTCON_USB_ID_L_VBUS_L0
>> 	#define EXTCON_USB_ID_L_VBUS_H1
>> when receiving following events, id pin is high.
>> 	#define EXTCON_USB_ID_H_VBUS_L2
>> 	#define EXTCON_USB_ID_H_VBUS_H3
>> Also, some usb driver would catch the vbus pin state with same method.
>>
>> But, it is just my opinion. We may use following notifier events for
> each pin.
>> We need to discuss it.
>> 	#define EXTCON_USB_ID_LOW
>> 	#define EXTCON_USB_ID_HIGH	
>> 	#define EXTCON_USB_VBUS_LOW
>> 	#define EXTCON_USB_VBUS_HIGH
> 
> ... all other participants agreed on that conclusion. So why change of
> view point now?

Unitl now, the extcon framework only handle the state of external connector(cable).
- The state of external connector is either attached or detached.

I think that ID and VBUS are not external connector(cable).
The ID and VBUS are more appropriate as property than new type of external connector.

Regards,
Chanwoo Choi
