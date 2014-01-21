From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 21 Jan 2014 11:39:46 -0800
Subject: [PATCH 2/2] ehci-platform: Add support for controllers with
 big-endian regs / descriptors
In-Reply-To: <1390319315-8391-2-git-send-email-hdegoede@redhat.com>
References: <1390319315-8391-1-git-send-email-hdegoede@redhat.com>
 <1390319315-8391-2-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGVrzcZJBjVvJm5WkpXpp_u3a-q4qMqgHvcxCJF=RUoeEwdzjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014/1/21 Hans de Goede <hdegoede@redhat.com>:
> This uses the already documented devicetree booleans for this.

(I would greatly appreciate if you could CC people who gave you
feedback on this before)

A more informative commit message would be welcome, along with a
reference to which Device Tree binding documentation you are referring
to.

>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/usb/host/Kconfig         |  3 +++
>  drivers/usb/host/ehci-platform.c | 33 +++++++++++++++++++++++++++++++--
>  2 files changed, 34 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 237d7b1..4af41f3 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -256,6 +256,9 @@ config USB_EHCI_ATH79
>  config USB_EHCI_HCD_PLATFORM
>         tristate "Generic EHCI driver for a platform device"
>         depends on !PPC_OF
> +       # Support BE on architectures which have readl_be
> +       select USB_EHCI_BIG_ENDIAN_DESC if (AVR32 || MIPS || MICROBLAZE || SPARC || PPC32 || PPC64)
> +       select USB_EHCI_BIG_ENDIAN_MMIO if (AVR32 || MIPS || MICROBLAZE || SPARC || PPC32 || PPC64)

I do not think this is that simple nor correct for at least Microblaze
and MIPS since they can run in either BE or LE mode, and those
specific platforms should already do the proper select at the
board/SoC level. This *might* be correct for SPARC, PPC32 and PPC64,
although I believe some specific PPC64 boards can run in little-endian
mode like the P-series, SPARC might too.

It seems to me that you should not touch this and keep the existing
selects in place, if it turns out that the selects are missing the
error messages you added below are catching those misuses.

>         default n
>         ---help---
>           Adds an EHCI host driver for a generic platform device, which
> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> index d8aebc0..5888abb 100644
> --- a/drivers/usb/host/ehci-platform.c
> +++ b/drivers/usb/host/ehci-platform.c
> @@ -55,8 +55,10 @@ static int ehci_platform_reset(struct usb_hcd *hcd)
>
>         hcd->has_tt = pdata->has_tt;
>         ehci->has_synopsys_hc_bug = pdata->has_synopsys_hc_bug;
> -       ehci->big_endian_desc = pdata->big_endian_desc;
> -       ehci->big_endian_mmio = pdata->big_endian_mmio;
> +       if (pdata->big_endian_desc)
> +               ehci->big_endian_desc = 1;
> +       if (pdata->big_endian_mmio)
> +               ehci->big_endian_mmio = 1;
>
>         if (pdata->pre_setup) {
>                 retval = pdata->pre_setup(hcd);
> @@ -142,6 +144,7 @@ static int ehci_platform_probe(struct platform_device *dev)
>         struct resource *res_mem;
>         struct usb_ehci_pdata *pdata = dev_get_platdata(&dev->dev);
>         struct ehci_platform_priv *priv;
> +       struct ehci_hcd *ehci;
>         int err, irq, clk = 0;
>
>         if (usb_disabled())
> @@ -177,8 +180,34 @@ static int ehci_platform_probe(struct platform_device *dev)
>         platform_set_drvdata(dev, hcd);
>         dev->dev.platform_data = pdata;
>         priv = hcd_to_ehci_priv(hcd);
> +       ehci = hcd_to_ehci(hcd);
>
>         if (pdata == &ehci_platform_defaults && dev->dev.of_node) {
> +               if (of_property_read_bool(dev->dev.of_node, "big-endian-regs"))
> +                       ehci->big_endian_mmio = 1;
> +
> +               if (of_property_read_bool(dev->dev.of_node, "big-endian-desc"))
> +                       ehci->big_endian_desc = 1;
> +
> +               if (of_property_read_bool(dev->dev.of_node, "big-endian"))
> +                       ehci->big_endian_mmio = ehci->big_endian_desc = 1;

Ok, so I am confused now, should you update
pdata->ehci_big_endian_{desc,mmio} here or is it valid to directly
modify ehci->big_endian_{desc,mmio}, is not there any risk  to undo
what is done in ehci_platform_reset(), or is ehci_platform_reset()
only called for non-DT cases?

> +
> +#ifndef CONFIG_USB_EHCI_BIG_ENDIAN_MMIO
> +               if (ehci->big_endian_mmio) {
> +                       dev_err(&dev->dev,
> +                               "Error big-endian-regs not compiled in\n");

I do not think using the Device Tree property name would be very
informative since this is supposed to guard against misconfigurations
for both DT and non-DT enabled platforms, how about something like the
following:

"support for big-endian MMIO registers not enabled".

> +                       err = -EINVAL;
> +                       goto err_put_hcd;
> +               }
> +#endif
> +#ifndef CONFIG_USB_EHCI_BIG_ENDIAN_DESC
> +               if (ehci->big_endian_desc) {
> +                       dev_err(&dev->dev,
> +                               "Error big-endian-desc not compiled in\n");
> +                       err = -EINVAL;
> +                       goto err_put_hcd;

And here "support for big-endian descriptors not enabled".

> +               }
> +#endif
>                 priv->phy = devm_phy_get(&dev->dev, "usb");
>                 if (IS_ERR(priv->phy)) {
>                         err = PTR_ERR(priv->phy);
> --
> 1.8.5.3
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Florian
