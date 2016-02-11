From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 11 Feb 2016 12:25:07 +0100
Subject: [PATCH V5 09/11] soc: mediatek: PMIC wrap: add a slave specific
 struct
In-Reply-To: <1454841778-35529-10-git-send-email-blogic@openwrt.org>
References: <1454841778-35529-1-git-send-email-blogic@openwrt.org>
 <1454841778-35529-10-git-send-email-blogic@openwrt.org>
Message-ID: <56BC6F93.8020600@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/02/16 11:42, John Crispin wrote:
> This patch adds a new struct pwrap_slv_type that we use to store the slave
> specific data. The patch adds 2 new helper functions to access the dew
> registers. The slave type is looked up via the wrappers child node.
>
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
> Changes in V5
> * drop the dew i/o wrappers
>
> Changed in V4
> * drop unused MT8173 specifc variable declarations
>
>   drivers/soc/mediatek/mtk-pmic-wrap.c |  157 ++++++++++++++++++++++++----------
>   1 file changed, 110 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index fbf94e4..2628271 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -69,33 +69,52 @@
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
> +};

Comparing with the implementation of MT6323, the following registers 
seem MT6397 only:
PWRAP_DEW_EVENT_OUT_EN
PWRAP_DEW_EVENT_SRC_EN,
PWRAP_DEW_EVENT_SRC
PWRAP_DEW_EVENT_FLAG
PWRAP_DEW_MON_FLAG_SEL
PWRAP_DEW_EVENT_TEST
PWRAP_DEW_CIPHER_LOAD
PWRAP_DEW_CIPHER_START

Can you please check that and put the ones which are really MT6397 only 
in a separate paragraph?

Thanks,
Matthias
