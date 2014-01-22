From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 22 Jan 2014 21:52:20 +0100
Subject: [PATCH 2/2] ehci-platform: Add support for controllers with
 big-endian regs / descriptors
In-Reply-To: <20140122213434.00000f25@openwrt.org>
References: <1390319315-8391-1-git-send-email-hdegoede@redhat.com>	<1390319315-8391-2-git-send-email-hdegoede@redhat.com>	<CAGVrzcZJBjVvJm5WkpXpp_u3a-q4qMqgHvcxCJF=RUoeEwdzjQ@mail.gmail.com>	<52E01BDA.8000606@redhat.com>
 <20140122213434.00000f25@openwrt.org>
Message-ID: <52E02F84.70705@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/22/2014 09:34 PM, Jonas Gorski wrote:
> Hi,
>
> On Wed, 22 Jan 2014 20:28:26 +0100
> Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 01/21/2014 08:39 PM, Florian Fainelli wrote:
>>> 2014/1/21 Hans de Goede <hdegoede@redhat.com>:
>>>> This uses the already documented devicetree booleans for this.
>>>
>>> (I would greatly appreciate if you could CC people who gave you
>>> feedback on this before)
>>
>> Will do.
>>
>>> A more informative commit message would be welcome, along with a
>>> reference to which Device Tree binding documentation you are referring
>>> to.
>>
>> I've added a reference to the bindings doc in the commit msg for my next version.
>>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>>    drivers/usb/host/Kconfig         |  3 +++
>>>>    drivers/usb/host/ehci-platform.c | 33 +++++++++++++++++++++++++++++++--
>>>>    2 files changed, 34 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
>>>> index 237d7b1..4af41f3 100644
>>>> --- a/drivers/usb/host/Kconfig
>>>> +++ b/drivers/usb/host/Kconfig
>>>> @@ -256,6 +256,9 @@ config USB_EHCI_ATH79
>>>>    config USB_EHCI_HCD_PLATFORM
>>>>           tristate "Generic EHCI driver for a platform device"
>>>>           depends on !PPC_OF
>>>> +       # Support BE on architectures which have readl_be
>>>> +       select USB_EHCI_BIG_ENDIAN_DESC if (AVR32 || MIPS || MICROBLAZE || SPARC || PPC32 || PPC64)
>>>> +       select USB_EHCI_BIG_ENDIAN_MMIO if (AVR32 || MIPS || MICROBLAZE || SPARC || PPC32 || PPC64)
>>>
>>> I do not think this is that simple nor correct for at least Microblaze
>>> and MIPS since they can run in either BE or LE mode, and those
>>> specific platforms should already do the proper select at the
>>> board/SoC level. This *might* be correct for SPARC, PPC32 and PPC64,
>>> although I believe some specific PPC64 boards can run in little-endian
>>> mode like the P-series, SPARC might too.
>>>
>>> It seems to me that you should not touch this and keep the existing
>>> selects in place, if it turns out that the selects are missing the
>>> error messages you added below are catching those misuses.
>>
>> As discussed with Alan, I will drop these lines from my next version.
>>
>>>>           default n
>>>>           ---help---
>>>>             Adds an EHCI host driver for a generic platform device, which
>>>> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
>>>> index d8aebc0..5888abb 100644
>>>> --- a/drivers/usb/host/ehci-platform.c
>>>> +++ b/drivers/usb/host/ehci-platform.c
>>>> @@ -55,8 +55,10 @@ static int ehci_platform_reset(struct usb_hcd *hcd)
>>>>
>>>>           hcd->has_tt = pdata->has_tt;
>>>>           ehci->has_synopsys_hc_bug = pdata->has_synopsys_hc_bug;
>>>> -       ehci->big_endian_desc = pdata->big_endian_desc;
>>>> -       ehci->big_endian_mmio = pdata->big_endian_mmio;
>>>> +       if (pdata->big_endian_desc)
>>>> +               ehci->big_endian_desc = 1;
>>>> +       if (pdata->big_endian_mmio)
>>>> +               ehci->big_endian_mmio = 1;
>>>>
>>>>           if (pdata->pre_setup) {
>>>>                   retval = pdata->pre_setup(hcd);
>>>> @@ -142,6 +144,7 @@ static int ehci_platform_probe(struct platform_device *dev)
>>>>           struct resource *res_mem;
>>>>           struct usb_ehci_pdata *pdata = dev_get_platdata(&dev->dev);
>>>>           struct ehci_platform_priv *priv;
>>>> +       struct ehci_hcd *ehci;
>>>>           int err, irq, clk = 0;
>>>>
>>>>           if (usb_disabled())
>>>> @@ -177,8 +180,34 @@ static int ehci_platform_probe(struct platform_device *dev)
>>>>           platform_set_drvdata(dev, hcd);
>>>>           dev->dev.platform_data = pdata;
>>>>           priv = hcd_to_ehci_priv(hcd);
>>>> +       ehci = hcd_to_ehci(hcd);
>>>>
>>>>           if (pdata == &ehci_platform_defaults && dev->dev.of_node) {
>>>> +               if (of_property_read_bool(dev->dev.of_node, "big-endian-regs"))
>>>> +                       ehci->big_endian_mmio = 1;
>>>> +
>>>> +               if (of_property_read_bool(dev->dev.of_node, "big-endian-desc"))
>>>> +                       ehci->big_endian_desc = 1;
>>>> +
>>>> +               if (of_property_read_bool(dev->dev.of_node, "big-endian"))
>>>> +                       ehci->big_endian_mmio = ehci->big_endian_desc = 1;
>>>
>>> Ok, so I am confused now, should you update
>>> pdata->ehci_big_endian_{desc,mmio} here or is it valid to directly
>>> modify ehci->big_endian_{desc,mmio}, is not there any risk  to undo
>>> what is done in ehci_platform_reset(), or is ehci_platform_reset()
>>> only called for non-DT cases?
>>
>> Both the pdata checks in ehci_platform_reset() and the dt checks here only
>> ever set these flags, neither code path clears them. And in the dt case pdata
>> will be NULL and vice versa.
>
> If it's safe to set ehci->big_endian_{desc,mmio} from the _probe()
> routine, then maybe the pdata sets in _reset() should be moved into here
> instead of adding extra cludges/checks into _reset().

That seems like an entire separate patch / improvement on top of adding support
for big-endian controllers to the dt code.

If people won't to improve on thus further and / or clean things up further I'm
sure the usb-subsys maintainers would welcome patches.

<snip more suggestions best done in a separate patch written by someone else>

Regards,

Hans
