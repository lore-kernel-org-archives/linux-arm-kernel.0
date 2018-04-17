From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 17 Apr 2018 23:10:15 +0200
Subject: [PATCH V3 3/4] soc: mediatek: pwrap: add mt6351 for mt6797 SoCs
In-Reply-To: <20180323083238.13569-4-argus.lin@mediatek.com>
References: <20180323083238.13569-1-argus.lin@mediatek.com>
 <20180323083238.13569-4-argus.lin@mediatek.com>
Message-ID: <427130f0-9f7e-22cc-3679-2a8d22124515@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please update the subject line, we don't add mt5797 here.

More comments below.

On 03/23/2018 09:32 AM, argus.lin at mediatek.com wrote:
> From: Argus Lin <argus.lin@mediatek.com>
> 
> mt6351 is a new power management IC and it is
> used for mt6797 SoCs. We need to add mt6351_regs for
> pmic register mapping and pmic_mt6351 for
> register accessing by regmap.
> 
> Signed-off-by: Argus Lin <argus.lin@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-pmic-wrap.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index d0a0a3d7e88d..d81a585fadf5 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -153,6 +153,21 @@ static const u32 mt6397_regs[] = {
>  	[PWRAP_DEW_CIPHER_SWRST] =	0xbc24,
>  };
>  
> +static const u32 mt6351_regs[] = {
> +	[PWRAP_DEW_DIO_EN] =		0x02F2,
> +	[PWRAP_DEW_READ_TEST] =		0x02F4,
> +	[PWRAP_DEW_WRITE_TEST] =	0x02F6,
> +	[PWRAP_DEW_CRC_EN] =		0x02FA,
> +	[PWRAP_DEW_CRC_VAL] =		0x02FC,
> +	[PWRAP_DEW_CIPHER_KEY_SEL] =	0x0300,
> +	[PWRAP_DEW_CIPHER_IV_SEL] =	0x0302,
> +	[PWRAP_DEW_CIPHER_EN] =		0x0304,
> +	[PWRAP_DEW_CIPHER_RDY] =	0x0306,
> +	[PWRAP_DEW_CIPHER_MODE] =	0x0308,
> +	[PWRAP_DEW_CIPHER_SWRST] =	0x030A,
> +	[PWRAP_DEW_RDDMY_NO] =		0x030C,
> +};
> +
>  enum pwrap_regs {
>  	PWRAP_MUX_SEL,
>  	PWRAP_WRAP_EN,
> @@ -721,6 +736,7 @@ static int mt8135_regs[] = {
>  
>  enum pmic_type {
>  	PMIC_MT6323,
> +	PMIC_MT6351,
>  	PMIC_MT6380,
>  	PMIC_MT6397,
>  };
> @@ -1179,8 +1195,6 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
>  	pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_SWRST], 0x0);
>  	pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_KEY_SEL], 0x1);
>  	pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_IV_SEL], 0x2);
> -	pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_LOAD], 0x1);
> -	pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_START], 0x1);

That might break the driver for other devices. You can't just delete these lines
without explanation. If you think these lines are not needed, then please put
the deletion in another patch explaining why.

Other then these two comments, patch looks fine.

Regards,
Matthias
