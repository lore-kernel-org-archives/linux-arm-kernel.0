From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 10 Aug 2016 09:29:44 +0100
Subject: [RESEND v2 06/10] mfd: stmpe: rework registers access
In-Reply-To: <1470814755-19447-7-git-send-email-patrice.chotard@st.com>
References: <1470814755-19447-1-git-send-email-patrice.chotard@st.com>
 <1470814755-19447-7-git-send-email-patrice.chotard@st.com>
Message-ID: <20160810082944.GL1581@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 10 Aug 2016, patrice.chotard at st.com wrote:

> From: Patrice Chotard <patrice.chotard@st.com>
> 
> this update allows to use registers map as following :
> regs[reg_index + offset] instead of
> regs[reg_index] + offset
> 
> This makes code clearer and will facilitate the addition of STMPE1600
> on which LSB and MSB registers are respectively located at addr and addr + 1.
> Despite for all others STMPE variant, LSB and MSB registers are respectively
> located in reverse order at addr + 1 and addr.
> 
> For variant which have 3 registers's bank, we use LSB,CSB and MSB indexes
> which contains respectively LSB (or LOW), CSB (or MID) and MSB (or HIGH)
> register addresses (STMPE1801/STMPE24xx).
> For variant which have 2 registers's bank, we use LSB and CSB indexes only.
> In this case the CSB index contains the MSB regs address (STMPE 1601).
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> ---
>  drivers/mfd/stmpe.c       | 48 ++++++++++++++++++++++++++++++++++++++++++----
>  drivers/mfd/stmpe.h       | 49 +++++++++++++++++++++++++++++++++++++++++------
>  include/linux/mfd/stmpe.h | 18 +++++++++++++++++
>  3 files changed, 105 insertions(+), 10 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
> index 2556463..a060809 100644
> --- a/drivers/mfd/stmpe.c
> +++ b/drivers/mfd/stmpe.c
> @@ -462,7 +462,7 @@ static const u8 stmpe811_regs[] = {
>  	[STMPE_IDX_GPAFR_U_MSB]	= STMPE811_REG_GPIO_AF,
>  	[STMPE_IDX_IEGPIOR_LSB]	= STMPE811_REG_GPIO_INT_EN,
>  	[STMPE_IDX_ISGPIOR_MSB]	= STMPE811_REG_GPIO_INT_STA,
> -	[STMPE_IDX_GPEDR_MSB]	= STMPE811_REG_GPIO_ED,
> +	[STMPE_IDX_GPEDR_LSB]	= STMPE811_REG_GPIO_ED,
>  };
>  
>  static struct stmpe_variant_block stmpe811_blocks[] = {
> @@ -540,19 +540,28 @@ static const u8 stmpe1601_regs[] = {
>  	[STMPE_IDX_SYS_CTRL]	= STMPE1601_REG_SYS_CTRL,
>  	[STMPE_IDX_SYS_CTRL2]	= STMPE1601_REG_SYS_CTRL2,
>  	[STMPE_IDX_ICR_LSB]	= STMPE1601_REG_ICR_LSB,
> +	[STMPE_IDX_IER_MSB]	= STMPE1601_REG_IER_MSB,
>  	[STMPE_IDX_IER_LSB]	= STMPE1601_REG_IER_LSB,
>  	[STMPE_IDX_ISR_MSB]	= STMPE1601_REG_ISR_MSB,
>  	[STMPE_IDX_GPMR_LSB]	= STMPE1601_REG_GPIO_MP_LSB,
> +	[STMPE_IDX_GPMR_CSB]	= STMPE1601_REG_GPIO_MP_MSB,
>  	[STMPE_IDX_GPSR_LSB]	= STMPE1601_REG_GPIO_SET_LSB,
> +	[STMPE_IDX_GPSR_CSB]	= STMPE1601_REG_GPIO_SET_MSB,
>  	[STMPE_IDX_GPCR_LSB]	= STMPE1601_REG_GPIO_CLR_LSB,
> +	[STMPE_IDX_GPCR_CSB]	= STMPE1601_REG_GPIO_CLR_MSB,
>  	[STMPE_IDX_GPDR_LSB]	= STMPE1601_REG_GPIO_SET_DIR_LSB,
> +	[STMPE_IDX_GPDR_CSB]	= STMPE1601_REG_GPIO_SET_DIR_MSB,
> +	[STMPE_IDX_GPEDR_LSB]	= STMPE1601_REG_GPIO_ED_LSB,
> +	[STMPE_IDX_GPEDR_CSB]	= STMPE1601_REG_GPIO_ED_MSB,
>  	[STMPE_IDX_GPRER_LSB]	= STMPE1601_REG_GPIO_RE_LSB,
> +	[STMPE_IDX_GPRER_CSB]	= STMPE1601_REG_GPIO_RE_MSB,
>  	[STMPE_IDX_GPFER_LSB]	= STMPE1601_REG_GPIO_FE_LSB,
> +	[STMPE_IDX_GPFER_CSB]	= STMPE1601_REG_GPIO_FE_MSB,
>  	[STMPE_IDX_GPPUR_LSB]	= STMPE1601_REG_GPIO_PU_LSB,
>  	[STMPE_IDX_GPAFR_U_MSB]	= STMPE1601_REG_GPIO_AF_U_MSB,
>  	[STMPE_IDX_IEGPIOR_LSB]	= STMPE1601_REG_INT_EN_GPIO_MASK_LSB,
> +	[STMPE_IDX_IEGPIOR_CSB]	= STMPE1601_REG_INT_EN_GPIO_MASK_MSB,
>  	[STMPE_IDX_ISGPIOR_MSB]	= STMPE1601_REG_INT_STA_GPIO_MSB,
> -	[STMPE_IDX_GPEDR_MSB]	= STMPE1601_REG_GPIO_ED_MSB,
>  };
>  
>  static struct stmpe_variant_block stmpe1601_blocks[] = {
> @@ -698,14 +707,28 @@ static const u8 stmpe1801_regs[] = {
>  	[STMPE_IDX_IER_LSB]	= STMPE1801_REG_INT_EN_MASK_LOW,
>  	[STMPE_IDX_ISR_LSB]	= STMPE1801_REG_INT_STA_LOW,
>  	[STMPE_IDX_GPMR_LSB]	= STMPE1801_REG_GPIO_MP_LOW,
> +	[STMPE_IDX_GPMR_CSB]	= STMPE1801_REG_GPIO_MP_MID,
> +	[STMPE_IDX_GPMR_MSB]	= STMPE1801_REG_GPIO_MP_HIGH,
>  	[STMPE_IDX_GPSR_LSB]	= STMPE1801_REG_GPIO_SET_LOW,
> +	[STMPE_IDX_GPSR_CSB]	= STMPE1801_REG_GPIO_SET_MID,
> +	[STMPE_IDX_GPSR_MSB]	= STMPE1801_REG_GPIO_SET_HIGH,
>  	[STMPE_IDX_GPCR_LSB]	= STMPE1801_REG_GPIO_CLR_LOW,
> +	[STMPE_IDX_GPCR_CSB]	= STMPE1801_REG_GPIO_CLR_MID,
> +	[STMPE_IDX_GPCR_MSB]	= STMPE1801_REG_GPIO_CLR_HIGH,
>  	[STMPE_IDX_GPDR_LSB]	= STMPE1801_REG_GPIO_SET_DIR_LOW,
> +	[STMPE_IDX_GPDR_CSB]	= STMPE1801_REG_GPIO_SET_DIR_MID,
> +	[STMPE_IDX_GPDR_MSB]	= STMPE1801_REG_GPIO_SET_DIR_HIGH,
>  	[STMPE_IDX_GPRER_LSB]	= STMPE1801_REG_GPIO_RE_LOW,
> +	[STMPE_IDX_GPRER_CSB]	= STMPE1801_REG_GPIO_RE_MID,
> +	[STMPE_IDX_GPRER_MSB]	= STMPE1801_REG_GPIO_RE_HIGH,
>  	[STMPE_IDX_GPFER_LSB]	= STMPE1801_REG_GPIO_FE_LOW,
> +	[STMPE_IDX_GPFER_CSB]	= STMPE1801_REG_GPIO_FE_MID,
> +	[STMPE_IDX_GPFER_MSB]	= STMPE1801_REG_GPIO_FE_HIGH,
>  	[STMPE_IDX_GPPUR_LSB]	= STMPE1801_REG_GPIO_PULL_UP_LOW,
>  	[STMPE_IDX_IEGPIOR_LSB]	= STMPE1801_REG_INT_EN_GPIO_MASK_LOW,
> -	[STMPE_IDX_ISGPIOR_LSB]	= STMPE1801_REG_INT_STA_GPIO_LOW,
> +	[STMPE_IDX_IEGPIOR_CSB]	= STMPE1801_REG_INT_EN_GPIO_MASK_MID,
> +	[STMPE_IDX_IEGPIOR_MSB]	= STMPE1801_REG_INT_EN_GPIO_MASK_HIGH,
> +	[STMPE_IDX_ISGPIOR_MSB]	= STMPE1801_REG_INT_STA_GPIO_HIGH,
>  };
>  
>  static struct stmpe_variant_block stmpe1801_blocks[] = {
> @@ -790,19 +813,36 @@ static const u8 stmpe24xx_regs[] = {
>  	[STMPE_IDX_SYS_CTRL]	= STMPE24XX_REG_SYS_CTRL,
>  	[STMPE_IDX_SYS_CTRL2]	= STMPE24XX_REG_SYS_CTRL2,
>  	[STMPE_IDX_ICR_LSB]	= STMPE24XX_REG_ICR_LSB,
> +	[STMPE_IDX_IER_MSB]	= STMPE24XX_REG_IER_MSB,
>  	[STMPE_IDX_IER_LSB]	= STMPE24XX_REG_IER_LSB,
>  	[STMPE_IDX_ISR_MSB]	= STMPE24XX_REG_ISR_MSB,
>  	[STMPE_IDX_GPMR_LSB]	= STMPE24XX_REG_GPMR_LSB,
> +	[STMPE_IDX_GPMR_CSB]	= STMPE24XX_REG_GPMR_CSB,
> +	[STMPE_IDX_GPMR_MSB]	= STMPE24XX_REG_GPMR_MSB,
>  	[STMPE_IDX_GPSR_LSB]	= STMPE24XX_REG_GPSR_LSB,
> +	[STMPE_IDX_GPSR_CSB]	= STMPE24XX_REG_GPSR_CSB,
> +	[STMPE_IDX_GPSR_MSB]	= STMPE24XX_REG_GPSR_MSB,
>  	[STMPE_IDX_GPCR_LSB]	= STMPE24XX_REG_GPCR_LSB,
> +	[STMPE_IDX_GPCR_CSB]	= STMPE24XX_REG_GPCR_CSB,
> +	[STMPE_IDX_GPCR_MSB]	= STMPE24XX_REG_GPCR_MSB,
>  	[STMPE_IDX_GPDR_LSB]	= STMPE24XX_REG_GPDR_LSB,
> +	[STMPE_IDX_GPDR_CSB]	= STMPE24XX_REG_GPDR_CSB,
> +	[STMPE_IDX_GPDR_MSB]	= STMPE24XX_REG_GPDR_MSB,
>  	[STMPE_IDX_GPRER_LSB]	= STMPE24XX_REG_GPRER_LSB,
> +	[STMPE_IDX_GPRER_CSB]	= STMPE24XX_REG_GPRER_CSB,
> +	[STMPE_IDX_GPRER_MSB]	= STMPE24XX_REG_GPRER_MSB,
>  	[STMPE_IDX_GPFER_LSB]	= STMPE24XX_REG_GPFER_LSB,
> +	[STMPE_IDX_GPFER_CSB]	= STMPE24XX_REG_GPFER_CSB,
> +	[STMPE_IDX_GPFER_MSB]	= STMPE24XX_REG_GPFER_MSB,
>  	[STMPE_IDX_GPPUR_LSB]	= STMPE24XX_REG_GPPUR_LSB,
>  	[STMPE_IDX_GPPDR_LSB]	= STMPE24XX_REG_GPPDR_LSB,
>  	[STMPE_IDX_GPAFR_U_MSB]	= STMPE24XX_REG_GPAFR_U_MSB,
>  	[STMPE_IDX_IEGPIOR_LSB]	= STMPE24XX_REG_IEGPIOR_LSB,
> +	[STMPE_IDX_IEGPIOR_CSB]	= STMPE24XX_REG_IEGPIOR_CSB,
> +	[STMPE_IDX_IEGPIOR_MSB]	= STMPE24XX_REG_IEGPIOR_MSB,
>  	[STMPE_IDX_ISGPIOR_MSB]	= STMPE24XX_REG_ISGPIOR_MSB,
> +	[STMPE_IDX_GPEDR_LSB]	= STMPE24XX_REG_GPEDR_LSB,
> +	[STMPE_IDX_GPEDR_CSB]	= STMPE24XX_REG_GPEDR_CSB,
>  	[STMPE_IDX_GPEDR_MSB]	= STMPE24XX_REG_GPEDR_MSB,
>  };
>  
> @@ -977,7 +1017,7 @@ static void stmpe_irq_sync_unlock(struct irq_data *data)
>  			continue;
>  
>  		stmpe->oldier[i] = new;
> -		stmpe_reg_write(stmpe, stmpe->regs[STMPE_IDX_IER_LSB] - i, new);
> +		stmpe_reg_write(stmpe, stmpe->regs[STMPE_IDX_IER_LSB + i], new);
>  	}
>  
>  	mutex_unlock(&stmpe->irq_lock);
> diff --git a/drivers/mfd/stmpe.h b/drivers/mfd/stmpe.h
> index 4ba1123..f127342 100644
> --- a/drivers/mfd/stmpe.h
> +++ b/drivers/mfd/stmpe.h
> @@ -179,19 +179,32 @@ int stmpe_remove(struct stmpe *stmpe);
>  
>  #define STMPE1601_REG_SYS_CTRL			0x02
>  #define STMPE1601_REG_SYS_CTRL2			0x03
> +#define STMPE1601_REG_ICR_MSB			0x10
>  #define STMPE1601_REG_ICR_LSB			0x11
> +#define STMPE1601_REG_IER_MSB			0x12
>  #define STMPE1601_REG_IER_LSB			0x13
>  #define STMPE1601_REG_ISR_MSB			0x14
> -#define STMPE1601_REG_CHIP_ID			0x80
> +#define STMPE1601_REG_ISR_LSB			0x15
> +#define STMPE1601_REG_INT_EN_GPIO_MASK_MSB	0x16
>  #define STMPE1601_REG_INT_EN_GPIO_MASK_LSB	0x17
>  #define STMPE1601_REG_INT_STA_GPIO_MSB		0x18
> -#define STMPE1601_REG_GPIO_MP_LSB		0x87
> +#define STMPE1601_REG_INT_STA_GPIO_LSB		0x19
> +#define STMPE1601_REG_CHIP_ID			0x80
> +#define STMPE1601_REG_GPIO_SET_MSB		0x82
>  #define STMPE1601_REG_GPIO_SET_LSB		0x83
> +#define STMPE1601_REG_GPIO_CLR_MSB		0x84
>  #define STMPE1601_REG_GPIO_CLR_LSB		0x85
> +#define STMPE1601_REG_GPIO_MP_MSB		0x86
> +#define STMPE1601_REG_GPIO_MP_LSB		0x87
> +#define STMPE1601_REG_GPIO_SET_DIR_MSB		0x88
>  #define STMPE1601_REG_GPIO_SET_DIR_LSB		0x89
>  #define STMPE1601_REG_GPIO_ED_MSB		0x8A
> +#define STMPE1601_REG_GPIO_ED_LSB		0x8B
> +#define STMPE1601_REG_GPIO_RE_MSB		0x8C
>  #define STMPE1601_REG_GPIO_RE_LSB		0x8D
> +#define STMPE1601_REG_GPIO_FE_MSB		0x8E
>  #define STMPE1601_REG_GPIO_FE_LSB		0x8F
> +#define STMPE1601_REG_GPIO_PU_MSB		0x90
>  #define STMPE1601_REG_GPIO_PU_LSB		0x91
>  #define STMPE1601_REG_GPIO_AF_U_MSB		0x92
>  
> @@ -267,23 +280,47 @@ int stmpe_remove(struct stmpe *stmpe);
>  
>  #define STMPE24XX_REG_SYS_CTRL		0x02
>  #define STMPE24XX_REG_SYS_CTRL2		0x03
> +#define STMPE24XX_REG_ICR_MSB		0x10
>  #define STMPE24XX_REG_ICR_LSB		0x11
> +#define STMPE24XX_REG_IER_MSB		0x12
>  #define STMPE24XX_REG_IER_LSB		0x13
>  #define STMPE24XX_REG_ISR_MSB		0x14
> -#define STMPE24XX_REG_CHIP_ID		0x80
> +#define STMPE24XX_REG_ISR_LSB		0x15
> +#define STMPE24XX_REG_IEGPIOR_MSB	0x16
> +#define STMPE24XX_REG_IEGPIOR_CSB	0x17
>  #define STMPE24XX_REG_IEGPIOR_LSB	0x18
>  #define STMPE24XX_REG_ISGPIOR_MSB	0x19
> -#define STMPE24XX_REG_GPMR_LSB		0xA4
> +#define STMPE24XX_REG_ISGPIOR_CSB	0x1A
> +#define STMPE24XX_REG_ISGPIOR_LSB	0x1B
> +#define STMPE24XX_REG_CHIP_ID		0x80
> +#define STMPE24XX_REG_GPSR_MSB		0x83
> +#define STMPE24XX_REG_GPSR_CSB		0x84
>  #define STMPE24XX_REG_GPSR_LSB		0x85
> +#define STMPE24XX_REG_GPCR_MSB		0x86
> +#define STMPE24XX_REG_GPCR_CSB		0x87
>  #define STMPE24XX_REG_GPCR_LSB		0x88
> +#define STMPE24XX_REG_GPDR_MSB		0x89
> +#define STMPE24XX_REG_GPDR_CSB		0x8A
>  #define STMPE24XX_REG_GPDR_LSB		0x8B
>  #define STMPE24XX_REG_GPEDR_MSB		0x8C
> +#define STMPE24XX_REG_GPEDR_CSB		0x8D
> +#define STMPE24XX_REG_GPEDR_LSB		0x8E
> +#define STMPE24XX_REG_GPRER_MSB		0x8F
> +#define STMPE24XX_REG_GPRER_CSB		0x90
>  #define STMPE24XX_REG_GPRER_LSB		0x91
> +#define STMPE24XX_REG_GPFER_MSB		0x92
> +#define STMPE24XX_REG_GPFER_CSB		0x93
>  #define STMPE24XX_REG_GPFER_LSB		0x94
> +#define STMPE24XX_REG_GPPUR_MSB		0x95
> +#define STMPE24XX_REG_GPPUR_CSB		0x96
>  #define STMPE24XX_REG_GPPUR_LSB		0x97
> -#define STMPE24XX_REG_GPPDR_LSB		0x9a
> +#define STMPE24XX_REG_GPPDR_MSB		0x98
> +#define STMPE24XX_REG_GPPDR_CSB		0x99
> +#define STMPE24XX_REG_GPPDR_LSB		0x9A
>  #define STMPE24XX_REG_GPAFR_U_MSB	0x9B
> -
> +#define STMPE24XX_REG_GPMR_MSB		0xA2
> +#define STMPE24XX_REG_GPMR_CSB		0xA3
> +#define STMPE24XX_REG_GPMR_LSB		0xA4
>  #define STMPE24XX_SYS_CTRL_ENABLE_GPIO		(1 << 3)
>  #define STMPE24XX_SYSCON_ENABLE_PWM		(1 << 2)
>  #define STMPE24XX_SYS_CTRL_ENABLE_KPC		(1 << 1)
> diff --git a/include/linux/mfd/stmpe.h b/include/linux/mfd/stmpe.h
> index 6c6690f..3dced4a 100644
> --- a/include/linux/mfd/stmpe.h
> +++ b/include/linux/mfd/stmpe.h
> @@ -43,20 +43,38 @@ enum {
>  	STMPE_IDX_SYS_CTRL2,
>  	STMPE_IDX_ICR_LSB,
>  	STMPE_IDX_IER_LSB,
> +	STMPE_IDX_IER_MSB,
>  	STMPE_IDX_ISR_LSB,
>  	STMPE_IDX_ISR_MSB,
>  	STMPE_IDX_GPMR_LSB,
> +	STMPE_IDX_GPMR_CSB,
> +	STMPE_IDX_GPMR_MSB,
>  	STMPE_IDX_GPSR_LSB,
> +	STMPE_IDX_GPSR_CSB,
> +	STMPE_IDX_GPSR_MSB,
>  	STMPE_IDX_GPCR_LSB,
> +	STMPE_IDX_GPCR_CSB,
> +	STMPE_IDX_GPCR_MSB,
>  	STMPE_IDX_GPDR_LSB,
> +	STMPE_IDX_GPDR_CSB,
> +	STMPE_IDX_GPDR_MSB,
> +	STMPE_IDX_GPEDR_LSB,
> +	STMPE_IDX_GPEDR_CSB,
>  	STMPE_IDX_GPEDR_MSB,
>  	STMPE_IDX_GPRER_LSB,
> +	STMPE_IDX_GPRER_CSB,
> +	STMPE_IDX_GPRER_MSB,
>  	STMPE_IDX_GPFER_LSB,
> +	STMPE_IDX_GPFER_CSB,
> +	STMPE_IDX_GPFER_MSB,
>  	STMPE_IDX_GPPUR_LSB,
>  	STMPE_IDX_GPPDR_LSB,
>  	STMPE_IDX_GPAFR_U_MSB,
>  	STMPE_IDX_IEGPIOR_LSB,
> +	STMPE_IDX_IEGPIOR_CSB,
> +	STMPE_IDX_IEGPIOR_MSB,
>  	STMPE_IDX_ISGPIOR_LSB,
> +	STMPE_IDX_ISGPIOR_CSB,
>  	STMPE_IDX_ISGPIOR_MSB,
>  	STMPE_IDX_MAX,
>  };

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
