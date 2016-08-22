From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 22 Aug 2016 17:32:57 +0200
Subject: [PATCH v2 7/7] musb: sunxi: Add support for platform_set_mode
In-Reply-To: <20160822152421.GH1853@uda0271908>
References: <1471288892-21702-1-git-send-email-hdegoede@redhat.com>
 <1471288892-21702-8-git-send-email-hdegoede@redhat.com>
 <20160819213049.GC1853@uda0271908>
 <2a55a1bf-7ebf-3ab4-b231-85eba20103f1@redhat.com>
 <20160822141158.GF1853@uda0271908>
 <9699b62e-421a-ae8e-c25e-ef48beb84ce0@redhat.com>
 <20160822152421.GH1853@uda0271908>
Message-ID: <fd1e9692-2c69-da16-0e6e-ac7fa50077ac@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

On 22-08-16 17:24, Bin Liu wrote:
> On Mon, Aug 22, 2016 at 05:08:56PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 22-08-16 16:11, Bin Liu wrote:
>>> Hi,
>>>
>>> On Sun, Aug 21, 2016 at 12:10:26PM +0200, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 19-08-16 23:30, Bin Liu wrote:
>>>>> Hi,
>>>>>
>>>>> On Mon, Aug 15, 2016 at 09:21:32PM +0200, Hans de Goede wrote:
>>>>>> This allows run-time dr_mode switching support via the "mode" musb
>>>>>> sysfs attribute.
>>>>>>
>>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>>> ---
>>>>>> drivers/usb/musb/sunxi.c | 52 ++++++++++++++++++++++++++++++++++++++++++++----
>>>>>> 1 file changed, 48 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
>>>>>> index c6ee166..1fe7451 100644
>>>>>> --- a/drivers/usb/musb/sunxi.c
>>>>>> +++ b/drivers/usb/musb/sunxi.c
>>>>>> @@ -74,6 +74,7 @@
>>>>>> #define SUNXI_MUSB_FL_HAS_SRAM			5
>>>>>> #define SUNXI_MUSB_FL_HAS_RESET			6
>>>>>> #define SUNXI_MUSB_FL_NO_CONFIGDATA		7
>>>>>> +#define SUNXI_MUSB_FL_PHY_MODE_PEND		8
>>>>>>
>>>>>> /* Our read/write methods need access and do not get passed in a musb ref :| */
>>>>>> static struct musb *sunxi_musb;
>>>>>> @@ -87,6 +88,7 @@ struct sunxi_glue {
>>>>>> 	struct phy		*phy;
>>>>>> 	struct platform_device	*usb_phy;
>>>>>> 	struct usb_phy		*xceiv;
>>>>>> +	enum phy_mode		phy_mode;
>>>>>> 	unsigned long		flags;
>>>>>> 	struct work_struct	work;
>>>>>> 	struct extcon_dev	*extcon;
>>>>>> @@ -140,6 +142,9 @@ static void sunxi_musb_work(struct work_struct *work)
>>>>>> 			clear_bit(SUNXI_MUSB_FL_PHY_ON, &glue->flags);
>>>>>> 		}
>>>>>> 	}
>>>>>> +
>>>>>> +	if (test_and_clear_bit(SUNXI_MUSB_FL_PHY_MODE_PEND, &glue->flags))
>>>>>> +		phy_set_mode(glue->phy, glue->phy_mode);
>>>>>> }
>>>>>>
>>>>>> static void sunxi_musb_set_vbus(struct musb *musb, int is_on)
>>>>>> @@ -341,6 +346,41 @@ static void sunxi_musb_dma_controller_destroy(struct dma_controller *c)
>>>>>> {
>>>>>> }
>>>>>>
>>>>>> +static int sunxi_musb_set_mode(struct musb *musb, u8 mode)
>>>>>> +{
>>>>>> +	struct sunxi_glue *glue = dev_get_drvdata(musb->controller->parent);
>>>>>> +	enum phy_mode new_mode;
>>>>>> +
>>>>>> +	switch (mode) {
>>>>>> +	case MUSB_HOST:		new_mode = PHY_MODE_USB_HOST; break;
>>>>>> +	case MUSB_PERIPHERAL:	new_mode = PHY_MODE_USB_DEVICE; break;
>>>>>> +	case MUSB_OTG:		new_mode = PHY_MODE_USB_OTG; break;
>>>>>
>>>>> Please fix the code style as commented in patch 4/7.
>>>>
>>>> Ok I will send a new version with this fixed.
>>>>
>>>>>
>>>>>> +	default:
>>>>>> +		dev_err(musb->controller->parent,
>>>>>> +			"Error requested mode not supported by this kernel\n");
>>>>>> +		return -EINVAL;
>>>>>> +	}
>>>>>> +
>>>>>> +	if (glue->phy_mode == new_mode)
>>>>>> +		return 0;
>>>>>> +
>>>>>> +	if (musb->port_mode != MUSB_PORT_MODE_DUAL_ROLE) {
>>>>>> +		dev_err(musb->controller->parent,
>>>>>> +			"Error changing modes is only supported in dual role mode\n");
>>>>>> +		return -EINVAL;
>>>>>> +	}
>>>>>> +
>>>>>> +	/*
>>>>>> +	 * phy_set_mode may sleep, and we're called with a spinlock held,
>>>>>> +	 * so let sunxi_musb_work deal with it.
>>>>>> +	 */
>>>>>> +	glue->phy_mode = new_mode;
>>>>>> +	set_bit(SUNXI_MUSB_FL_PHY_MODE_PEND, &glue->flags);
>>>>>> +	schedule_work(&glue->work);
>>>>>
>>>>> When switching from host to peripheral mode, if an usb device is still
>>>>> plugged and enumerated, how do you handle the device disconnect?
>>>>
>>>> The phy code will report vbus low for long enough for the musb to end
>>>> the current session. It already does this for boards which do not
>>>> have working vbus detection.
>>>
>>> But you didn't disconnect DP/DM, right? then musb detects vbus is gone
>>> without receiving disconnect event, this is vbus error case, not a normal
>>> teardown.
>>
>> Correct, there is no way to disconnect DP/DM and reporting Vbus low for
>> a while does the trick.
>
> Without physically disconnecting DP/DM, we still have a way to properly
> teardown the enumerated devices. Please check musb_softconnect_write()
> in musb_debugfs.c.

That is manipulating the session bit in the devctl reg, that does not
work to switch from device to host role or from host to device role,
at least not on allwinner's musb implementation. I've already tried that
before writing the code to report VBus low.

Regards,

Hans
