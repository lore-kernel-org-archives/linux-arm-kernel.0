From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 2 Mar 2015 15:29:50 +0100
Subject: [PATCH] ARM: at91: remove NEED_MACH_IO_H
In-Reply-To: <2695765.t2RUmlZpTO@wuerfel>
References: <2695765.t2RUmlZpTO@wuerfel>
Message-ID: <20150302142950.GS4094@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/03/2015 at 14:09:57 +0100, Arnd Bergmann wrote :
> The mach/io.h header on at91 is used to support a nonstandard I/O space
> window for the cf card driver. This changes the driver to use pci_ioremap_io
> in order to have the standard location, and then removes the custom
> mach/io.h.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ----
> I've found this patch in an old git tree of mine. I think it's still needed,
> but see for yourselves.
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 4db6c803eaf2..b2798e25829a 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -351,7 +351,6 @@ config ARCH_AT91
>  	select ARCH_REQUIRE_GPIOLIB
>  	select CLKDEV_LOOKUP
>  	select IRQ_DOMAIN
> -	select NEED_MACH_IO_H if PCCARD
>  	select PINCTRL
>  	select PINCTRL_AT91
>  	select USE_OF

That also needs:

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index c74a44324e5b..7ecde7de69da 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -81,6 +81,7 @@ config SOC_AT91RM9200
        select CPU_ARM920T
        select GENERIC_CLOCKEVENTS
        select HAVE_AT91_USB_CLK
+       select MIGHT_HAVE_PCI
 
 config SOC_AT91SAM9
        bool "AT91SAM9"
diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index 3bb49252a098..075d5cd4c5ab 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -278,6 +278,7 @@ config BFIN_CFPCMCIA
 
 config AT91_CF
        tristate "AT91 CompactFlash Controller"
+       depends on PCI
        depends on PCMCIA && ARCH_AT91
        depends on !ARCH_MULTIPLATFORM
        help

I'll amend the patch if you agree.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
