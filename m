From: amelie.delaunay@st.com (Amelie DELAUNAY)
Date: Tue, 20 Feb 2018 13:48:18 +0000
Subject: [PATCH v2] usb: host: ehci-platform: add support for optional
 external vbus supply
In-Reply-To: <87h8qbq0em.fsf@linux.intel.com>
References: <1519131492-27913-1-git-send-email-amelie.delaunay@st.com>
 <87h8qbq0em.fsf@linux.intel.com>
Message-ID: <a34d376e-45c2-0791-7c69-d6647170aff9@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/20/2018 02:02 PM, Felipe Balbi wrote:
> 
> Hi,
> 
> Amelie Delaunay <amelie.delaunay@st.com> writes:
>> On some boards, especially when vbus supply requires large current,
>> and the charge pump on the PHY isn't enough, an external vbus power switch
>> may be used.
>> Add support for this optional external vbus supply in ehci-platform.
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
>>
>> ---
>> Changes in v2:
>>   * Address Roger Quadros comments: move regulator_enable/disable from
>> ehci_platform_power_on/off to ehci_platform_port_power.
>> ---
>>   Documentation/devicetree/bindings/usb/usb-ehci.txt |  1 +
>>   drivers/usb/host/ehci-platform.c                   | 31 ++++++++++++++++++++++
>>   2 files changed, 32 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/usb-ehci.txt b/Documentation/devicetree/bindings/usb/usb-ehci.txt
>> index 3efde12..fc480cd 100644
>> --- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
>> +++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
>> @@ -19,6 +19,7 @@ Optional properties:
>>    - phys : phandle + phy specifier pair
>>    - phy-names : "usb"
>>    - resets : phandle + reset specifier pair
>> + - vbus-supply : phandle of regulator supplying vbus
>>   
>>   Example (Sequoia 440EPx):
>>       ehci at e0000300 {
>> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
>> index b065a96..05be100 100644
>> --- a/drivers/usb/host/ehci-platform.c
>> +++ b/drivers/usb/host/ehci-platform.c
>> @@ -29,6 +29,7 @@
>>   #include <linux/of.h>
>>   #include <linux/phy/phy.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/regulator/consumer.h>
>>   #include <linux/reset.h>
>>   #include <linux/usb.h>
>>   #include <linux/usb/hcd.h>
>> @@ -46,6 +47,7 @@ struct ehci_platform_priv {
>>   	struct reset_control *rsts;
>>   	struct phy **phys;
>>   	int num_phys;
>> +	struct regulator *vbus_supply;
>>   	bool reset_on_resume;
>>   };
>>   
>> @@ -76,6 +78,25 @@ static int ehci_platform_reset(struct usb_hcd *hcd)
>>   	return 0;
>>   }
>>   
>> +static int ehci_platform_port_power(struct usb_hcd *hcd, int portnum,
>> +				    bool enable)
>> +{
>> +	struct ehci_platform_priv *priv = hcd_to_ehci_priv(hcd);
>> +	int ret = 0;
>> +
>> +	if (priv->vbus_supply) {
> 
> you can reduce indentation here:
> 
> 	if (!priv->vbus_supply)
>          	return 0;
> 

You're right, thanks! I will fix it in upcoming v3, waiting for other 
additional comments.
Amelie
