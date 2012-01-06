From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 6 Jan 2012 12:40:29 +0100
Subject: [PATCH 1/2] ARM: mxs: detect SoC by checking CHIPID register
In-Reply-To: <1325817712-4573-2-git-send-email-shawn.guo@linaro.org>
References: <1325817712-4573-1-git-send-email-shawn.guo@linaro.org>
 <1325817712-4573-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120106114029.GB2610@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2012 at 10:41:51AM +0800, Shawn Guo wrote:
> Both imx23 and imx28 have CHIPID register at address 0x8001c310, which
> can be used to identify the SoC.  This patch changes cpu_is_xxx and
> __arch_decomp_setup to use this CHIPID register than machine type to
> detect the chip between imx23 and imx28, so that we do not need to
> change these functions whenever a new board/machine gets added.
> 
> Suggested-by: Wolfram Sang <w.sang@pengutronix.de>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

[...]

> +
> +/*
> + * MXS CPU types
> + */
> +#define CHIPID	(MXS_IO_ADDRESS(MXS_DIGCTL_BASE_ADDR) + 0x310)

Hmm, in general I don't like accessing single registers this way. Since
we only read, it might work for now, but I think it will turn ugly the
more we use from DIGCTL (which is annoying to abstract, yes).

0x310 should not be hardcoded. CHIPID could be MXS_CHIPID.

> diff --git a/arch/arm/mach-mxs/include/mach/uncompress.h b/arch/arm/mach-mxs/include/mach/uncompress.h
> index 6777674..a8de26d 100644
> --- a/arch/arm/mach-mxs/include/mach/uncompress.h
> +++ b/arch/arm/mach-mxs/include/mach/uncompress.h
> @@ -55,16 +55,17 @@ static inline void flush(void)
>  
>  #define MX23_DUART_BASE_ADDR	0x80070000
>  #define MX28_DUART_BASE_ADDR	0x80074000
> +#define MXS_DIGCTL_CHIPID	0x8001c310
>  
>  static inline void __arch_decomp_setup(unsigned long arch_id)
>  {
> -	switch (arch_id) {
> -	case MACH_TYPE_MX23EVK:
> +	u16 chipid = (*(volatile unsigned long *) MXS_DIGCTL_CHIPID) >> 16;

Can't we use the cpu_is-functions here?

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120106/a5c81ef0/attachment.sig>
