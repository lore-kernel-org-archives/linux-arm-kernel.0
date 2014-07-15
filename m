From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 15 Jul 2014 16:24:15 +0200
Subject: [PATCH v3 4/4] can: flexcan: add vf610 support for FlexCAN
In-Reply-To: <ff2ea1726b13dc2ffa3519ce9244f3633cf1420d.1405428166.git.stefan@agner.ch>
References: <cover.1405428166.git.stefan@agner.ch>
 <ff2ea1726b13dc2ffa3519ce9244f3633cf1420d.1405428166.git.stefan@agner.ch>
Message-ID: <53C5398F.2000005@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/2014 02:56 PM, Stefan Agner wrote:
> Extend FlexCAN driver to support Vybrid. Vybrids variant of the IP
> has ECC support which is controlled through the memory error
> control register (MECR). There is also an errata which leads to
> false positive error detections (ID e5295). This patch disables
> the memory error detection completely.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/net/can/flexcan.c | 73 +++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 64 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 89745aa..1c31a5d 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -92,6 +92,27 @@
>  #define FLEXCAN_CTRL_ERR_ALL \
>  	(FLEXCAN_CTRL_ERR_BUS | FLEXCAN_CTRL_ERR_STATE)
>  
> +/* FLEXCAN control register 2 (CTRL2) bits */
> +#define FLEXCAN_CRL2_ECRWRE		BIT(29)
> +#define FLEXCAN_CRL2_WRMFRZ		BIT(28)
> +#define FLEXCAN_CRL2_RFFN(x)		(((x) & 0x0f) << 24)
> +#define FLEXCAN_CRL2_TASD(x)		(((x) & 0x1f) << 19)
> +#define FLEXCAN_CRL2_MRP		BIT(18)
> +#define FLEXCAN_CRL2_RRS		BIT(17)
> +#define FLEXCAN_CRL2_EACEN		BIT(16)
> +
> +/* FLEXCAN memory error control register (MECR) bits */
> +#define FLEXCAN_MECR_ECRWRDIS		BIT(31)
> +#define FLEXCAN_MECR_HANCEI_MSK		BIT(19)
> +#define FLEXCAN_MECR_FANCEI_MSK		BIT(18)
> +#define FLEXCAN_MECR_CEI_MSK		BIT(16)
> +#define FLEXCAN_MECR_HAERRIE		BIT(15)
> +#define FLEXCAN_MECR_FAERRIE		BIT(14)
> +#define FLEXCAN_MECR_EXTERRIE		BIT(13)
> +#define FLEXCAN_MECR_RERRDIS		BIT(9)
> +#define FLEXCAN_MECR_ECCDIS		BIT(8)
> +#define FLEXCAN_MECR_NCEFAFRZ		BIT(7)
> +
>  /* FLEXCAN error and status register (ESR) bits */
>  #define FLEXCAN_ESR_TWRN_INT		BIT(17)
>  #define FLEXCAN_ESR_RWRN_INT		BIT(16)
> @@ -150,18 +171,20 @@
>   * FLEXCAN hardware feature flags
>   *
>   * Below is some version info we got:
> - *    SOC   Version   IP-Version  Glitch-  [TR]WRN_INT
> - *                                Filter?   connected?
> - *   MX25  FlexCAN2  03.00.00.00     no         no
> - *   MX28  FlexCAN2  03.00.04.00    yes        yes
> - *   MX35  FlexCAN2  03.00.00.00     no         no
> - *   MX53  FlexCAN2  03.00.00.00    yes         no
> - *   MX6s  FlexCAN3  10.00.12.00    yes        yes
> + *    SOC   Version   IP-Version  Glitch-  [TR]WRN_INT  Memory err
> + *                                Filter?   connected?  detection
> + *   MX25  FlexCAN2  03.00.00.00     no         no         no
> + *   MX28  FlexCAN2  03.00.04.00    yes        yes         no
> + *   MX35  FlexCAN2  03.00.00.00     no         no         no
> + *   MX53  FlexCAN2  03.00.00.00    yes         no         no
> + *   MX6s  FlexCAN3  10.00.12.00    yes        yes         no
> + *   VF610 FlexCAN3  ?               no         no        yes
                                        ^^         ^^

Can you check the datasheet if the flexcan core has a "Glitch Filter
Width Register (FLEXCANx_GFWR)"

Can you check if the core generates a warning interrupt with the current
setup, if you don't switch on bus error reporting? This means internally
the [TR]WRN_INT is connected and works as specified.

>   *
>   * Some SOCs do not have the RX_WARN & TX_WARN interrupt line connected.
>   */
>  #define FLEXCAN_HAS_V10_FEATURES	BIT(1) /* For core version >= 10 */
>  #define FLEXCAN_HAS_BROKEN_ERR_STATE	BIT(2) /* [TR]WRN_INT not connected */
> +#define FLEXCAN_HAS_MECR_FEATURES	BIT(3) /* Memory error detection */
>  
>  /* Structure of the message buffer */
>  struct flexcan_mb {
> @@ -192,8 +215,11 @@ struct flexcan_regs {
>  	u32 crcr;		/* 0x44 */
>  	u32 rxfgmask;		/* 0x48 */
>  	u32 rxfir;		/* 0x4c */
> -	u32 _reserved3[12];
> +	u32 _reserved3[12];	/* 0x50 */
>  	struct flexcan_mb cantxfg[64];
> +	u32 _reserved4[408];
> +	u32 mecr;		/* 0xae0 */
> +	u32 erriar;		/* 0xae4 */
>  };
>  
>  struct flexcan_devtype_data {
> @@ -223,6 +249,9 @@ static struct flexcan_devtype_data fsl_imx28_devtype_data;
>  static struct flexcan_devtype_data fsl_imx6q_devtype_data = {
>  	.features = FLEXCAN_HAS_V10_FEATURES,
>  };
> +static struct flexcan_devtype_data fsl_vf610_devtype_data = {
> +	.features = FLEXCAN_HAS_V10_FEATURES | FLEXCAN_HAS_MECR_FEATURES,
> +};

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 242 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140715/c91045cb/attachment.sig>
