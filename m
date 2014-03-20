From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Mar 2014 12:57:55 +0100
Subject: [PATCH 06/62] ARM: davinci: export da8xx_syscfg0_base
In-Reply-To: <532AB3CF.30806@ti.com>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <4836281.0IgPinItBq@wuerfel> <532AB3CF.30806@ti.com>
Message-ID: <201403201257.56090.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 March 2014, Sekhar Nori wrote:
> There is another thing we can do albeit in the driver (see patch).
> Not sure how the USB maintainer will feel about it but I think this
> has the advantage of not creating any hacky interfaces. And it
> leaves me with the hope that someone will find the time to convert
> to phy driver based on syscon at some point.

Interesting hack.

> diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
> index 3586460..c807d3f 100644
> --- a/drivers/usb/host/ohci-hcd.c
> +++ b/drivers/usb/host/ohci-hcd.c
> @@ -1178,7 +1178,8 @@ MODULE_LICENSE ("GPL");
>  #define SA1111_DRIVER          ohci_hcd_sa1111_driver
>  #endif
>  
> -#ifdef CONFIG_ARCH_DAVINCI_DA8XX
> +/* DA8XX uses platform internal symbols. Cannot be built as module. */
> +#if defined(CONFIG_ARCH_DAVINCI_DA8XX) && !defined(CONFIG_USB_OHCI_HCD_MODULE)
>  #include "ohci-da8xx.c"
>  #define DAVINCI_PLATFORM_DRIVER        ohci_hcd_da8xx_driver
>  #endif

I wouldn't want to submit that patch to GregKH ;-)

How about doing the same thing in a somewhat less sneaky way?

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 0fe936c..857250a 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -417,6 +417,16 @@ config USB_OHCI_HCD_OMAP3
 	  Enables support for the on-chip OHCI controller on
 	  OMAP3 and later chips.
 
+config USB_OHCI_HCD_DAVINCI
+	bool "OHCI support for TI DaVinci DA8xx"
+	depends on ARCH_DAVINCI_DA8XX
+	depends on USB_OHCI_HCD=y
+	default y
+	help
+	  Enables support for the DaVinci DA8xx integrated OHCI
+	  controller. This driver cannot currently be a loadable
+	  module because it lacks a proper PHY abstraction.
+
 config USB_OHCI_ATH79
 	bool "USB OHCI support for the Atheros AR71XX/AR7240 SoCs (DEPRECATED)"
 	depends on (SOC_AR71XX || SOC_AR724X)
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 3586460..f98d03f 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1178,7 +1178,7 @@ MODULE_LICENSE ("GPL");
 #define SA1111_DRIVER		ohci_hcd_sa1111_driver
 #endif
 
-#ifdef CONFIG_ARCH_DAVINCI_DA8XX
+#ifdef CONFIG_USB_OHCI_HCD_DAVINCI
 #include "ohci-da8xx.c"
 #define DAVINCI_PLATFORM_DRIVER	ohci_hcd_da8xx_driver
 #endif
