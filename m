From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 09 Jan 2014 14:32:28 +0100
Subject: [PATCH v2 1/2] ohci-platform: Add support for devicetree
 instantiation
In-Reply-To: <CAGVrzcbsvm1MLj0U=jSZRRsorz6XLEoNTv4vhseL4Oq06FDz=A@mail.gmail.com>
References: <1389198608-24339-1-git-send-email-hdegoede@redhat.com>
 <1389198608-24339-2-git-send-email-hdegoede@redhat.com>
 <CAGVrzcbsvm1MLj0U=jSZRRsorz6XLEoNTv4vhseL4Oq06FDz=A@mail.gmail.com>
Message-ID: <52CEA4EC.5010007@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/08/2014 09:36 PM, Florian Fainelli wrote:
> Hello,
>
> 2014/1/8 Hans de Goede <hdegoede@redhat.com>:
>> Add support for ohci-platform instantiation from devicetree, including
>> optionally getting clks and a phy from devicetree, and enabling / disabling
>> those on power_on / off.
>>
>> This should allow using ohci-platform from devicetree in various cases.
>> Specifically after this commit it can be used for the ohci controller found
>> on Allwinner sunxi SoCs.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   .../devicetree/bindings/usb/platform-ohci.txt      |  25 ++++
>>   drivers/usb/host/ohci-platform.c                   | 148 ++++++++++++++++++---
>>   2 files changed, 153 insertions(+), 20 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/usb/platform-ohci.txt
>>
>> diff --git a/Documentation/devicetree/bindings/usb/platform-ohci.txt b/Documentation/devicetree/bindings/usb/platform-ohci.txt
>> new file mode 100644
>> index 0000000..44bfa57
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/platform-ohci.txt
>
> ohci-mmio might be a better name than platform maybe?

We already have platform-uhci too, and this matches the name of
the .c file so that people can actually correlate the 2.

>
> [snip]
>
>> +static int ohci_platform_power_on(struct platform_device *dev)
>> +{
>> +       struct usb_hcd *hcd = platform_get_drvdata(dev);
>> +       struct ohci_platform_priv *priv =
>> +               (struct ohci_platform_priv *)hcd_to_ohci(hcd)->priv;
>> +       int clk, ret;
>> +
>> +       for (clk = 0; priv->clks[clk] && clk < OHCI_MAX_CLKS; clk++) {
>> +               ret = clk_prepare_enable(priv->clks[clk]);
>> +               if (ret)
>> +                       goto err_disable_clks;
>> +       }
>
> Do we really need to cap this to OHCI_MAX_CLKS, the next driver which
> has 4 clocks will have to bump this, so maybe a linked-list would be
> best?

I can make OHCI_MAX_CLKS 4 or 8 if that makes you happy, other then
that I greatly prefer to keep this KISS. Devices with 3 clks are already
quite rare, so its not like we're going to need to bump this every other
week a linked list where a simple array suffices is just overkill and
unnecessarily complicates things.

>
>> +
>> +       if (priv->phy) {
>> +               ret = phy_init(priv->phy);
>> +               if (ret)
>> +                       goto err_disable_clks;
>> +
>> +               ret = phy_power_on(priv->phy);
>> +               if (ret)
>> +                       goto err_exit_phy;
>> +       }
>
> Although I do value the idea of having DT probing for ohci-platform,
> ehci-platform et al, I am not sure if this really belongs in the
> generic OHCI platform driver, or if we should rather have small glue
> drivers which register the ohci-platform driver and which provides all
> the platform-specific power_on, power_off, suspend callbacks to the
> ohci platform driver? Such glue driver would be the one which gets
> probed based off a specific compatible string a

This can already be done by having a platform driver with its own
compatible string providing platform data with the hooks. The whole idea
here is to avoid having to write such a glue driver for every other soc,
so cover the common simple case, and use glue drivers for more complicated
scenarios.

> At first glance it does look like this covers 80% of the existing OHCI
> drivers out there, so this is good. We might also want to support
> clock pointers provided via platform_data so we can remove ohci-at91,
> ohci-ep93xx, ohci-spear and friends in the future.

Lets first get the generic devicetree support merged as is, if after
that people want to extend it, so that (more) existing ohci drivers can
be removed, they are very much welcome to do so. Preferably people
with access to the hardware, so that they can actually test the changes.

> ohci-ppc-of could also probably be removed once we add quirks and
> endian properties parsing to ohci-platform?

Add-on patches extending my initial work are welcome. Again probably
best done by people who actually have access to the relevant hw.

Regards,

Hans
