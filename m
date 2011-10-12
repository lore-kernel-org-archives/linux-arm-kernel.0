From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 12 Oct 2011 10:27:02 +0200
Subject: [RFC][PATCH] plat-mxc: iomux-v3.h: implicitly enable
	pull-up/down when that's desired
In-Reply-To: <201110100758.p9A7wCYT011235@home.pavel.comp>
References: <201110100758.p9A7wCYT011235@home.pavel.comp>
Message-ID: <20111012082702.GM13898@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 10, 2011 at 11:19:23AM +0400, Paul Fertser wrote:
> To configure pads during the initialisation a set of special constants
> is used, e.g.
> #define MX25_PAD_FEC_MDIO__FEC_MDIO IOMUX_PAD(0x3c4, 0x1cc, 0x10, 0, 0, PAD_CTL_HYS | PAD_CTL_PUS_22K_UP)
> 
> The problem is that no pull-up/down is getting activated unless both
> PAD_CTL_PUE (pull-up enable) and PAD_CTL_PKE (pull/keeper module
> enable) set. This is clearly stated in the i.MX25 datasheet and is
> confirmed by the measurements on hardware. This leads to some rather
> hard to understand bugs such as misdetecting an absent ethernet PHY (a
> real bug i had), unstable data transfer etc. This might affect mx25,
> mx35, mx50, mx51 and mx53 SoCs.
> 
> It's reasonable to expect that if the pullup value is specified, the
> intention was to have it actually active, so we implicitly add the
> needed bits.
> 
> Cc: stable at kernel.org
> Signed-off-by: Paul Fertser <fercerpav@gmail.com>
> ---
> 
> I'm not sure if that's really suitable for -stable so please excuse me
> if it's not.

I think it's not suitable for stable unless there is a real bug, that
is PUE or PKE are forgotten somewhere.

> The issue looks real though and if you prefer fixing it
> any other way, please let me know. Sascha, if you think this's appropriate,
> i'll be happy to send the same fix for barebox.

Yes please, once we agree what to do about this issue.

> 
>  arch/arm/plat-mxc/include/mach/iomux-v3.h |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/iomux-v3.h b/arch/arm/plat-mxc/include/mach/iomux-v3.h
> index ebbce33..4509956 100644
> --- a/arch/arm/plat-mxc/include/mach/iomux-v3.h
> +++ b/arch/arm/plat-mxc/include/mach/iomux-v3.h
> @@ -89,11 +89,11 @@ typedef u64 iomux_v3_cfg_t;
>  #define PAD_CTL_HYS			(1 << 8)
>  
>  #define PAD_CTL_PKE			(1 << 7)
> -#define PAD_CTL_PUE			(1 << 6)
> -#define PAD_CTL_PUS_100K_DOWN		(0 << 4)
> -#define PAD_CTL_PUS_47K_UP		(1 << 4)
> -#define PAD_CTL_PUS_100K_UP		(2 << 4)
> -#define PAD_CTL_PUS_22K_UP		(3 << 4)
> +#define PAD_CTL_PUE			(1 << 6 | PAD_CTL_PKE)
> +#define PAD_CTL_PUS_100K_DOWN		(0 << 4 | PAD_CTL_PUE)
> +#define PAD_CTL_PUS_47K_UP		(1 << 4 | PAD_CTL_PUE)
> +#define PAD_CTL_PUS_100K_UP		(2 << 4 | PAD_CTL_PUE)
> +#define PAD_CTL_PUS_22K_UP		(3 << 4 | PAD_CTL_PUE)

I don't like that the defines which are supposed to be defines for
the individual bits are changed. This may lead to trouble and confusion
once someone wants to read the values from the iomux registers and
tests for bits. How about Adding new defines like this instead:

/*
 * pullup/down only works with PKE/PUE set. Use these in board code
 */
#define PAD_CTL_100K_DOWN        (PAD_CTL_PUS_100K_DOWN | PAD_CTL_PUE | PAD_CTL_PKE)
#define PAD_CTL_47K_UP           (PAD_CTL_PUS_47K_UP | PAD_CTL_PUE | PAD_CTL_PKE)
#define PAD_CTL_100K_UP          (PAD_CTL_PUS_100K_UP | PAD_CTL_PUE | PAD_CTL_PKE)
#define PAD_CTL_22K_UP           (PAD_CTL_PUS_22K_UP | PAD_CTL_PUE | PAD_CTL_PKE)


Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
