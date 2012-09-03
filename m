From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 3 Sep 2012 21:38:40 +0000
Subject: [PATCH 05/11] ARM: shmobile: r8a7779: add USB common phy
 initializer
In-Reply-To: <1346376502-12114-6-git-send-email-horms@verge.net.au>
References: <1346376502-12114-1-git-send-email-horms@verge.net.au>
 <1346376502-12114-6-git-send-email-horms@verge.net.au>
Message-ID: <201209032138.41485.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 31 August 2012, Simon Horman wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch adds common USB phy ports initializer for r8a7779.
> 
> The note is that each USB IP have own MSTP clock bit,
> and common USB phy port doesn't have MSTP clock,
> but this USB phy needs USB clock.
> Each USB driver / platform should keep USB MSTP clock somehow.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>
> ---
>  arch/arm/mach-shmobile/include/mach/common.h |  1 +
>  arch/arm/mach-shmobile/setup-r8a7779.c       | 93 ++++++++++++++++++++++++++++
>  2 files changed, 94 insertions(+)

Shouldn't the USB PHY driver go to drivers/usb/phy/ or
drivers/usb/host/ehci-sh.c?

We are trying hard to move driver code out of the platform and into driver
directories these days, and having it wired up as part of the platform
the way you do also means it is always powered on.

On Friday 31 August 2012, Simon Horman wrote:
> +#ifdef CONFIG_ARCH_SUPPORTS_BIG_ENDIAN
> +# define xHCI_ENDIAN "BIG"
> +# define xHCI_NO_SWAP 0x00000003
> +#else
> +# define xHCI_ENDIAN "LITTLE"
> +# define xHCI_NO_SWAP 0x00000000
> +#endif
> +
> +/*
> + * USB initial/install operation.
> + *
> + * This function setup USB phy.
> + * The used value and setting order came from
> + * [USB :: Initial setting] on datasheet.
> + */
> +int __init r8a7779_usb_phy_init(u32 usbpctrl0)
> +{
> +       void __iomem *reg0, *reg1;
> +       int i;
> +       u32 val;
> +
> +       reg0 = ioremap_nocache(0xffe70000, 0x900);
> +       reg1 = ioremap_nocache(0xfff70000, 0x900);
> +

I see neither big-endian support on shmobile, nor any XHCI (USB-3.0) driver, just
the old EHCI (USB-2.0) and OHCI (USB-1.1) drivers. Are you submitting the XHCI
support and big-endian platform code separately?

	Arnd
