From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 10 Mar 2015 12:03:59 +0100
Subject: [PATCH 02/15] phy-sun4i-usb: Add a helper function to update
 the iscr register
In-Reply-To: <54FECD30.6080106@ti.com>
References: <1425933628-9672-1-git-send-email-hdegoede@redhat.com>
 <4772280.xE1WBZVd8Z@wuerfel> <54FEA59B.7020400@redhat.com>
 <2515825.598CypcWU3@wuerfel> <54FEC3DD.10108@redhat.com>
 <54FECD30.6080106@ti.com>
Message-ID: <54FECF9F.7020606@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10-03-15 11:53, Kishon Vijay Abraham I wrote:
> Hi,
>
> On Tuesday 10 March 2015 03:43 PM, Hans de Goede wrote:
>> Hi,
>>
>> On 10-03-15 09:57, Arnd Bergmann wrote:
>>> On Tuesday 10 March 2015 09:04:43 Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 09-03-15 22:47, Arnd Bergmann wrote:
>>>>> On Monday 09 March 2015 21:40:15 Hans de Goede wrote:
>>>>>> +void sun4i_usb_phy_update_iscr(struct phy *_phy, u32 clr, u32 set)
>>>>>> +{
>>>>>> +       struct sun4i_usb_phy *phy = phy_get_drvdata(_phy);
>>>>>> +       struct sun4i_usb_phy_data *data = to_sun4i_usb_phy_data(phy);
>>>>>> +       u32 iscr;
>>>>>> +
>>>>>> +       iscr = readl(data->base + REG_ISCR);
>>>>>> +       iscr &= ~clr;
>>>>>> +       iscr |= set;
>>>>>> +       writel(iscr, data->base + REG_ISCR);
>>>>>> +}
>>>>>> +EXPORT_SYMBOL(sun4i_usb_phy_update_iscr);
>>>>>> +
>>>>>>
>>>>>
>>>>> I would generally consider this a bad design. What is the purpose of
>>>>> calling sun4i_usb_phy_update_iscr()
>
> right. That would bind the PHY driver and the controller driver and would
> start creating problems when a different PHY is connected with the
> controller.
>>>>
>>>> There are 2 different use cases for this one is to enable the dataline
>>>> pull-ups at driver init and disable them at driver exit, this could /
>>>> should probably be moved to the phy_init / phy_exit code for the usb0 phy
>>>> removing the need to do this from within the sunxi musb glue.
>>>>
>>>> The second use-case is more tricky, for some reasons Allwinner has decided
>>>> to not use the dedicated id-detect and vusb-sense pins of the phy they are
>>>> using (these pins are not routed to the outside).
>>>>
>>>> Instead id-detect and vusb-sense are done through any $random gpio pins
>>>> (including non irq capable pins on some designs requiring polling).
>
> The polling can still be done in PHY driver and can use the extcon framework
> to report the status to controller driver no?

Technically the polling can be moved to the phy driver yes, but it is not easy,
e.g. we only need to poll when we're in otg mode rather then host-only
or peripheral-only mode, and the mode gets set by the musb driver not phy
the phy driver. The sunxi musb implementation uses an integrated phy, so it
is just much easier and more logical to have all control / polling happening
from a single module rather then from 2 different modules.

>>>>
>>>> But the musb-core still needs to know the status of the id and vbus pins,
>
> musb-core or the musb-glue (musb/sunxi.c in this case)?
>>>> and gets this from the usb0-phy iscr register, which reflects the status of
>>>> the not connected dedicated pins of the phy. The reason this can still
>>>> work at all is because the iscr register allows the user to override
>>>> whatever the not connected phy pins are seeing and forcing a value to
>>>> report to the musb core as id and vbus status.
>>>>
>>>> This is done by these 2 functions in the musb sunxi glue:
>>>>
>>>> static void sunxi_musb_force_id(struct musb *musb, u32 val)
>>>> {
>>>>           struct sunxi_glue *glue = dev_get_drvdata(musb->controller->parent);
>>>>
>>>>           if (val)
>>>>                   val = SUNXI_ISCR_FORCE_ID_HIGH;
>>>>           else
>>>>                   val = SUNXI_ISCR_FORCE_ID_LOW;
>>>>
>>>>           sun4i_usb_phy_update_iscr(glue->phy, SUNXI_ISCR_FORCE_ID_MASK, val);
>
> What will writing to this register lead to? call to sunxi_musb_id_vbus_det_irq
> interrupt handler?

No this changes the vbus and id status as seen by the musb core, and the musb
responds to this, by e.g. starting a session, or when vbus does not get high
after a session request by reporting a vbus-error interrupt.

The sunxi_musb_id_vbus_det_irq handler gets triggered by edges on the gpio
pins which are used to monitor the id and vbus status.


>>>> }
>>>>
>>>> static void sunxi_musb_force_vbus(struct musb *musb, u32 val)
>>>> {
>>>>           struct sunxi_glue *glue = dev_get_drvdata(musb->controller->parent);
>>>>
>>>>           if (val)
>>>>                   val = SUNXI_ISCR_FORCE_VBUS_HIGH;
>>>>           else
>>>>                   val = SUNXI_ISCR_FORCE_VBUS_LOW;
>>>>
>>>>           sun4i_usb_phy_update_iscr(glue->phy, SUNXI_ISCR_FORCE_VBUS_MASK,
>>>> val);
>>>> }
>>>>
>>>> I will happily admit that these 2 functions are a better API between the
>>>> sunxi musb
>>>> glue and the sunxi usb phy driver. I started with the minimal
>>>> sun4i_usb_phy_update_iscr
>>>> approach as I wanted to keep the API as small as possible, but having 2
>>>> functions like
>>>> the one above, which actually reflect what is happening would indeed be better.
>>>
>>> Ok, that would definitely improve things.
>>>
>>>> Note that the polling of the pins cannot (easily) be moved into the phy
>>>> driver for various
>>>> reasons:
>>>>
>>>> 1) It depends on dr_mode, the otg may be used in host only mode in which
>>>> case there are no
>>>> pins at all.
>>>> 2) the musb set_vbus callback needs access to the pins
>>>> 3) When id changes some musb core state changes are necessary.
>>>>
>>>> I'll respin the patch set to do things this way as soon as we've agreement on
>>>> your second point.
>>>>
>>>>   > and why can't there be a high-level
>>>>> PHY API for this?
>>>>
>>>> The current generic phy API seems to not have any bus specific methods, I
>>>> know that
>>>> in the long run people want to get rid of struct usb_phy, so maybe we should
>>>> consider
>>>> adding bus specific methods to the generic phy API for things like otg.
>>>>
>>>> If we decide to add bus specific methods, then the question becomes if having
>>>>
>>>> int phy_usb_set_id_detect(struct phy *phy, bool val);
>>>> int phy_usb_set_vbus_detect(struct phy *phy, bool val);
>>>>
>>>> Functions in the generic phy API is a good idea, or if this is too sunxi
>>>> specific,
>>>> I'm fine with doing this either way. If we want to go the generic phy route
>>>> I'll split this in 2 patches, one adding these 2 generic functions &
>>>> phy-ops, and
>>>> 1 doing the sunxi implementation.
>
> Please don't do that. We don't want to be bloating phy framework with platform
> specific hooks.

Right, that was my feeling too. I believe that using sunxi specific phy functions
here is best given that we're dealing with an otg controller + phy both if which
are integrated in the same SoC, so we will never seen one used without the other
or vice versa.

Regards,

Hans
