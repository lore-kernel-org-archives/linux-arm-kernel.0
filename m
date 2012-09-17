From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Sep 2012 11:44:18 +0000
Subject: [PATCH 34/34] ARM: imx: enable multi-platform build
In-Reply-To: <1347860103-4141-35-git-send-email-shawn.guo@linaro.org>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
 <1347860103-4141-35-git-send-email-shawn.guo@linaro.org>
Message-ID: <201209171144.18507.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 September 2012, Shawn Guo wrote:
> -menu "Freescale MXC Implementations"
> -
> -choice
> -       prompt "Freescale CPU family:"
> -       default ARCH_IMX_V6_V7
> -
>  config ARCH_IMX_V4_V5
> -       bool "i.MX1, i.MX21, i.MX25, i.MX27"
> -       select AUTO_ZRELADDR if !ZBOOT_ROM
> -       select ARM_PATCH_PHYS_VIRT
> -       help
> -         This enables support for systems based on the Freescale i.MX ARMv4
> -         and ARMv5 SoCs
> +       def_bool y
> +       depends on ARCH_MULTI_V4_V5
>  

This is good, but I'd also suggest using specific dependencies on the
architecture level (V4, V4T, V5, V6, V6K, V7). For the other platforms
in the Rob's multiplatform series, this is not an issue because each
of them only works on exactly one architecture level.

For i.MX and other platforms that us a bunch of different CPU cores,
I think it's helpful if you can limit the configuration to a specific
architecture level, because that can result in a slightly more
efficient kernel binary. E.g. when you want to build a THUMB2 based
kernel, you can start by enabling only ARMv7 CPUs, and then select all
the board configurations without having to know which ones are actually
V6 or V7.

Doing this will require another update to the defconfig file, in addition
to the one mentioned by Sascha.

	Arnd
