From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 8 Feb 2013 09:57:19 +0530
Subject: [PATCH 03/10] USB: EHCI: make ehci-spear a separate driver
In-Reply-To: <5113e5e7.c84e420a.08c3.ffffbe87@mx.google.com>
References: <5113e5e7.c84e420a.08c3.ffffbe87@mx.google.com>
Message-ID: <CAOh2x=n1qZrGFaLv2pT7+GdZMK=27FapVq4nwb=ECjj5E2NdNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 7, 2013 at 11:04 PM,  <manjunath.goudar@linaro.org> wrote:
> From: Manjunath Goudar <manjunath.goudar@linaro.org>
>
> Separate the Spear host controller driver from ehci-hcd host code
> into its own driver module.

Please write spear as SPEAr everywhere, leaving
functions/variables/config options.

> Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
> Signed-off-by: Deepak Saxena <dsaxena@linaro.org>
> Cc: Greg KH <greg@kroah.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: Shiraz Hashim <shiraz.hashim@st.com>
> Cc: linux-usb at vger.kernel.org
> Cc: spear-devel at list.st.com
> ---
>  drivers/usb/host/Kconfig      |    8 +++++
>  drivers/usb/host/Makefile     |    1 +
>  drivers/usb/host/ehci-hcd.c   |    6 +---
>  drivers/usb/host/ehci-spear.c |   77 ++++++++++++++++++++++-------------------
>  4 files changed, 51 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 11e102e..4413075 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -162,6 +162,14 @@ config USB_EHCI_HCD_OMAP
>           Enables support for the on-chip EHCI controller on
>           OMAP3 and later chips.
>
> +config USB_EHCI_HCD_SPEAR
> +        tristate "Support for ST spear on-chip EHCI USB controller"
> +        depends on USB_EHCI_HCD && PLAT_SPEAR
> +        default y
> +        ---help---
> +          Enables support for the on-chip EHCI controller on
> +          ST spear chips.
> +
>  config USB_EHCI_MSM
>         bool "Support for MSM on-chip EHCI USB controller"
>         depends on USB_EHCI_HCD && ARCH_MSM
> diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
> index b54a597..c97f4ab 100644
> --- a/drivers/usb/host/Makefile
> +++ b/drivers/usb/host/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_USB_EHCI_PCI)    += ehci-pci.o
>  obj-$(CONFIG_USB_EHCI_HCD_PLATFORM)    += ehci-platform.o
>  obj-$(CONFIG_USB_EHCI_MXC)     += ehci-mxc.o
>  obj-$(CONFIG_USB_EHCI_HCD_OMAP) += ehci-omap.o
> +obj-$(CONFIG_USB_EHCI_HCD_SPEAR)+= ehci-spear.o
>  obj-$(CONFIG_USB_OXU210HP_HCD) += oxu210hp-hcd.o
>  obj-$(CONFIG_USB_ISP116X_HCD)  += isp116x-hcd.o
>  obj-$(CONFIG_USB_ISP1362_HCD)  += isp1362-hcd.o
> diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
> index aaf93ca..68cea63 100644
> --- a/drivers/usb/host/ehci-hcd.c
> +++ b/drivers/usb/host/ehci-hcd.c
> @@ -1292,11 +1292,6 @@ MODULE_LICENSE ("GPL");
>  #define        PLATFORM_DRIVER         vt8500_ehci_driver
>  #endif
>
> -#ifdef CONFIG_PLAT_SPEAR
> -#include "ehci-spear.c"
> -#define PLATFORM_DRIVER                spear_ehci_hcd_driver
> -#endif
> -
>  #ifdef CONFIG_USB_EHCI_MSM
>  #include "ehci-msm.c"
>  #define PLATFORM_DRIVER                ehci_msm_driver
> @@ -1343,6 +1338,7 @@ MODULE_LICENSE ("GPL");
>         !IS_ENABLED(CONFIG_USB_EHCI_MXC) && \
>         !defined(PLATFORM_DRIVER) && \
>         !IS_ENABLED(CONFIG_USB_EHCI_HCD_OMAP) && \
> +       !IS_ENABLED(CONFIG_PLAT_SPEAR) && \
>         !defined(PS3_SYSTEM_BUS_DRIVER) && \
>         !defined(OF_PLATFORM_DRIVER) && \
>         !defined(XILINX_OF_PLATFORM_DRIVER)
> diff --git a/drivers/usb/host/ehci-spear.c b/drivers/usb/host/ehci-spear.c
> index 466c1bb..6e42cee 100644
> --- a/drivers/usb/host/ehci-spear.c
> +++ b/drivers/usb/host/ehci-spear.c
> @@ -11,11 +11,25 @@
>  * more details.
>  */
>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/usb.h>
> +#include <linux/usb/hcd.h>
> +#include <linux/io.h>
> +
> +

remove these blank lines.

>  #include <linux/clk.h>
>  #include <linux/jiffies.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm.h>
> +#include <linux/dma-mapping.h>


Keep all of them in alphabetical order.

> +#include "ehci.h"
> +
> +#define DRIVER_DESC "EHCI spear driver"
> +
> +static const char hcd_name[] = "ehci-spear";
>
>  struct spear_ehci {
>         struct ehci_hcd ehci;
> @@ -43,40 +57,7 @@ static int ehci_spear_setup(struct usb_hcd *hcd)
>
>         return ehci_setup(hcd);
>  }
> -
> -static const struct hc_driver ehci_spear_hc_driver = {
> -       .description                    = hcd_name,
> -       .product_desc                   = "SPEAr EHCI",
> -       .hcd_priv_size                  = sizeof(struct spear_ehci),
> -
> -       /* generic hardware linkage */
> -       .irq                            = ehci_irq,
> -       .flags                          = HCD_MEMORY | HCD_USB2,
> -
> -       /* basic lifecycle operations */
> -       .reset                          = ehci_spear_setup,
> -       .start                          = ehci_run,
> -       .stop                           = ehci_stop,
> -       .shutdown                       = ehci_shutdown,
> -
> -       /* managing i/o requests and associated device resources */
> -       .urb_enqueue                    = ehci_urb_enqueue,
> -       .urb_dequeue                    = ehci_urb_dequeue,
> -       .endpoint_disable               = ehci_endpoint_disable,
> -       .endpoint_reset                 = ehci_endpoint_reset,
> -
> -       /* scheduling support */
> -       .get_frame_number               = ehci_get_frame,
> -
> -       /* root hub support */
> -       .hub_status_data                = ehci_hub_status_data,
> -       .hub_control                    = ehci_hub_control,
> -       .bus_suspend                    = ehci_bus_suspend,
> -       .bus_resume                     = ehci_bus_resume,
> -       .relinquish_port                = ehci_relinquish_port,
> -       .port_handed_over               = ehci_port_handed_over,
> -       .clear_tt_buffer_complete       = ehci_clear_tt_buffer_complete,
> -};
> +static struct hc_driver __read_mostly ehci_spear_hc_driver;
>
>  #ifdef CONFIG_PM
>  static int ehci_spear_drv_suspend(struct device *dev)
> @@ -209,11 +190,35 @@ static struct platform_driver spear_ehci_hcd_driver = {
>         .remove         = spear_ehci_hcd_drv_remove,
>         .shutdown       = usb_hcd_platform_shutdown,
>         .driver         = {
> -               .name = "spear-ehci",
> +               .name = hcd_name,
>                 .bus = &platform_bus_type,
>                 .pm = &ehci_spear_pm_ops,
>                 .of_match_table = of_match_ptr(spear_ehci_id_table),
>         }
>  };
>
> -MODULE_ALIAS("platform:spear-ehci");
> +
> +static const struct ehci_driver_overrides spear_overrides __initdata = {
> +       .reset = ehci_spear_setup,
> +};
> +
> +static int __init ehci_spear_init(void)
> +{
> +       if (usb_disabled())
> +               return -ENODEV;
> +
> +       pr_info("%s: " DRIVER_DESC "\n", hcd_name);
> +
> +       ehci_init_driver(&ehci_spear_hc_driver, &spear_overrides);
> +       return platform_driver_register(&spear_ehci_hcd_driver);
> +}
> +module_init(ehci_spear_init);
> +
> +static void __exit ehci_spear_cleanup(void)
> +{
> +       platform_driver_unregister(&spear_ehci_hcd_driver);
> +}
> +module_exit(ehci_spear_cleanup);
> +
> +MODULE_DESCRIPTION(DRIVER_DESC);
> +MODULE_LICENSE("GPL");
> --
> 1.7.9.5
>
