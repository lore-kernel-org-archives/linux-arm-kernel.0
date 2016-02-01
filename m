From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 1 Feb 2016 12:02:05 +0100
Subject: [PATCH V3 09/11] soc: mediatek: PMIC wrap: add a slave specific
 struct
In-Reply-To: <1453715604-36856-10-git-send-email-blogic@openwrt.org>
References: <1453715604-36856-1-git-send-email-blogic@openwrt.org>
 <1453715604-36856-10-git-send-email-blogic@openwrt.org>
Message-ID: <56AF3B2D.7040607@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/01/16 10:53, John Crispin wrote:
> This patch adds a new struct pwrap_slv_type that we use to store the slave
> specific data. The patch adds 2 new helper functions to access the dew
> registers. The slave type is looked up via the wrappers child node.
>
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>   drivers/soc/mediatek/mtk-pmic-wrap.c |  170 +++++++++++++++++++++++++---------
>   1 file changed, 124 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index 54553b4..21d8e5a 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -69,33 +69,64 @@
>   					  PWRAP_WDT_SRC_EN_HARB_STAUPD_DLE | \
>   					  PWRAP_WDT_SRC_EN_HARB_STAUPD_ALE)
>
> -/* macro for slave device wrapper registers */
> -#define PWRAP_DEW_BASE			0xbc00
> -#define PWRAP_DEW_EVENT_OUT_EN		(PWRAP_DEW_BASE + 0x0)
> -#define PWRAP_DEW_DIO_EN		(PWRAP_DEW_BASE + 0x2)
> -#define PWRAP_DEW_EVENT_SRC_EN		(PWRAP_DEW_BASE + 0x4)
> -#define PWRAP_DEW_EVENT_SRC		(PWRAP_DEW_BASE + 0x6)
> -#define PWRAP_DEW_EVENT_FLAG		(PWRAP_DEW_BASE + 0x8)
> -#define PWRAP_DEW_READ_TEST		(PWRAP_DEW_BASE + 0xa)
> -#define PWRAP_DEW_WRITE_TEST		(PWRAP_DEW_BASE + 0xc)
> -#define PWRAP_DEW_CRC_EN		(PWRAP_DEW_BASE + 0xe)
> -#define PWRAP_DEW_CRC_VAL		(PWRAP_DEW_BASE + 0x10)
> -#define PWRAP_DEW_MON_GRP_SEL		(PWRAP_DEW_BASE + 0x12)
> -#define PWRAP_DEW_MON_FLAG_SEL		(PWRAP_DEW_BASE + 0x14)
> -#define PWRAP_DEW_EVENT_TEST		(PWRAP_DEW_BASE + 0x16)
> -#define PWRAP_DEW_CIPHER_KEY_SEL	(PWRAP_DEW_BASE + 0x18)
> -#define PWRAP_DEW_CIPHER_IV_SEL		(PWRAP_DEW_BASE + 0x1a)
> -#define PWRAP_DEW_CIPHER_LOAD		(PWRAP_DEW_BASE + 0x1c)
> -#define PWRAP_DEW_CIPHER_START		(PWRAP_DEW_BASE + 0x1e)
> -#define PWRAP_DEW_CIPHER_RDY		(PWRAP_DEW_BASE + 0x20)
> -#define PWRAP_DEW_CIPHER_MODE		(PWRAP_DEW_BASE + 0x22)
> -#define PWRAP_DEW_CIPHER_SWRST		(PWRAP_DEW_BASE + 0x24)
> -#define PWRAP_MT8173_DEW_CIPHER_IV0	(PWRAP_DEW_BASE + 0x26)
> -#define PWRAP_MT8173_DEW_CIPHER_IV1	(PWRAP_DEW_BASE + 0x28)
> -#define PWRAP_MT8173_DEW_CIPHER_IV2	(PWRAP_DEW_BASE + 0x2a)
> -#define PWRAP_MT8173_DEW_CIPHER_IV3	(PWRAP_DEW_BASE + 0x2c)
> -#define PWRAP_MT8173_DEW_CIPHER_IV4	(PWRAP_DEW_BASE + 0x2e)
> -#define PWRAP_MT8173_DEW_CIPHER_IV5	(PWRAP_DEW_BASE + 0x30)
> +/* defines for slave device wrapper registers */
> +enum dew_regs {
> +	PWRAP_DEW_BASE,
> +	PWRAP_DEW_EVENT_OUT_EN,
> +	PWRAP_DEW_DIO_EN,
> +	PWRAP_DEW_EVENT_SRC_EN,
> +	PWRAP_DEW_EVENT_SRC,
> +	PWRAP_DEW_EVENT_FLAG,
> +	PWRAP_DEW_READ_TEST,
> +	PWRAP_DEW_WRITE_TEST,
> +	PWRAP_DEW_CRC_EN,
> +	PWRAP_DEW_CRC_VAL,
> +	PWRAP_DEW_MON_GRP_SEL,
> +	PWRAP_DEW_MON_FLAG_SEL,
> +	PWRAP_DEW_EVENT_TEST,
> +	PWRAP_DEW_CIPHER_KEY_SEL,
> +	PWRAP_DEW_CIPHER_IV_SEL,
> +	PWRAP_DEW_CIPHER_LOAD,
> +	PWRAP_DEW_CIPHER_START,
> +	PWRAP_DEW_CIPHER_RDY,
> +	PWRAP_DEW_CIPHER_MODE,
> +	PWRAP_DEW_CIPHER_SWRST,
> +	PWRAP_MT8173_DEW_CIPHER_IV0,
> +	PWRAP_MT8173_DEW_CIPHER_IV1,
> +	PWRAP_MT8173_DEW_CIPHER_IV2,
> +	PWRAP_MT8173_DEW_CIPHER_IV3,
> +	PWRAP_MT8173_DEW_CIPHER_IV4,
> +	PWRAP_MT8173_DEW_CIPHER_IV5,
> +};
> +
> +static const u32 mt6397_regs[] = {
> +	[PWRAP_DEW_BASE] =		0xbc00,
> +	[PWRAP_DEW_EVENT_OUT_EN] =	0xbc00,
> +	[PWRAP_DEW_DIO_EN] =		0xbc02,
> +	[PWRAP_DEW_EVENT_SRC_EN] =	0xbc04,
> +	[PWRAP_DEW_EVENT_SRC] =		0xbc06,
> +	[PWRAP_DEW_EVENT_FLAG] =	0xbc08,
> +	[PWRAP_DEW_READ_TEST] =		0xbc0a,
> +	[PWRAP_DEW_WRITE_TEST] =	0xbc0c,
> +	[PWRAP_DEW_CRC_EN] =		0xbc0e,
> +	[PWRAP_DEW_CRC_VAL] =		0xbc10,
> +	[PWRAP_DEW_MON_GRP_SEL] =	0xbc12,
> +	[PWRAP_DEW_MON_FLAG_SEL] =	0xbc14,
> +	[PWRAP_DEW_EVENT_TEST] =	0xbc16,
> +	[PWRAP_DEW_CIPHER_KEY_SEL] =	0xbc18,
> +	[PWRAP_DEW_CIPHER_IV_SEL] =	0xbc1a,
> +	[PWRAP_DEW_CIPHER_LOAD] =	0xbc1c,
> +	[PWRAP_DEW_CIPHER_START] =	0xbc1e,
> +	[PWRAP_DEW_CIPHER_RDY] =	0xbc20,
> +	[PWRAP_DEW_CIPHER_MODE] =	0xbc22,
> +	[PWRAP_DEW_CIPHER_SWRST] =	0xbc24,
> +	[PWRAP_MT8173_DEW_CIPHER_IV0] = 0xbc26,
> +	[PWRAP_MT8173_DEW_CIPHER_IV1] = 0xbc28,
> +	[PWRAP_MT8173_DEW_CIPHER_IV2] = 0xbc2a,
> +	[PWRAP_MT8173_DEW_CIPHER_IV3] = 0xbc2c,
> +	[PWRAP_MT8173_DEW_CIPHER_IV4] = 0xbc2e,
> +	[PWRAP_MT8173_DEW_CIPHER_IV5] = 0xbc30,
> +};
>
>   enum pwrap_regs {
>   	PWRAP_MUX_SEL,
> @@ -349,16 +380,26 @@ static int mt8135_regs[] = {
>   	[PWRAP_DCM_DBC_PRD] =		0x160,
>   };
>
> +enum pmic_type {
> +	PMIC_MT6397,
> +};
> +
>   enum pwrap_type {
>   	PWRAP_MT8135,
>   	PWRAP_MT8173,
>   };
>
> +struct pwrap_slv_type {
> +	const u32 *dew_regs;
> +	enum pmic_type type;
> +};
> +
>   struct pmic_wrapper {
>   	struct device *dev;
>   	void __iomem *base;
>   	struct regmap *regmap;
>   	const struct pmic_wrapper_type *master;
> +	const struct pwrap_slv_type *slave;
>   	struct clk *clk_spi;
>   	struct clk *clk_wrap;
>   	struct reset_control *rstc;
> @@ -484,6 +525,16 @@ static int pwrap_read(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
>   	return 0;
>   }
>
> +static int pwrap_dew_write(struct pmic_wrapper *wrp, u32 reg, u32 wdata)
> +{
> +	return pwrap_write(wrp, wrp->slave->dew_regs[reg], wdata);
> +}
> +
> +static int pwrap_dew_read(struct pmic_wrapper *wrp, u32 reg, u32 *rdata)
> +{
> +	return pwrap_read(wrp, wrp->slave->dew_regs[reg], rdata);
> +}
> +

I would prefer to use pwrap_[read,write] directly instead of adding 
another indirection.
