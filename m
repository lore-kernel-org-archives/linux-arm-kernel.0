From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 11 Jul 2013 12:43:22 +0200
Subject: [PATCH] ASoC: Samsung: Modify the I2S driver to support I2S on
 Exynos5420
In-Reply-To: <1373526505-27115-1-git-send-email-padma.v@samsung.com>
References: <1373526505-27115-1-git-send-email-padma.v@samsung.com>
Message-ID: <29860116.IF545KsGYb@thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Padmavathi,

On Thursday 11 of July 2013 12:38:24 Padmavathi Venna wrote:
> Exynos5420 added support for I2S TDM mode. For this, there are some
> register changes in the I2S controller. This patch adds the relevant
> register changes to support I2S in normal mode. This patch adds a
> quirk for TDM mode and if TDM mode is present all the relevent changes
> will be applied.
> 
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
> [abrestic: style cleanup and documentation]
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Reviewed-on: https://gerrit-int.chromium.org/37840
> Reviewed-by: Simon Glass <sjg@google.com>
> ---
>  .../devicetree/bindings/sound/samsung-i2s.txt      |    2 +
>  include/linux/platform_data/asoc-s3c.h             |    1 +
>  sound/soc/samsung/i2s-regs.h                       |   51 ++++++---
>  sound/soc/samsung/i2s.c                            |  117
> ++++++++++++++++---- 4 files changed, 132 insertions(+), 39 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/samsung-i2s.txt
> b/Documentation/devicetree/bindings/sound/samsung-i2s.txt index
> 025e66b..b8593d5 100644
> --- a/Documentation/devicetree/bindings/sound/samsung-i2s.txt
> +++ b/Documentation/devicetree/bindings/sound/samsung-i2s.txt
> @@ -28,6 +28,8 @@ Optional SoC Specific Properties:
>    enabled or disabled based on need.
>  - samsung,supports-secdai:If I2S block has a secondary FIFO and internal
> DMA, then this flag is enabled.
> +- samsung,supports-tdm: If the I2S controller supports TDM, then this flag
> +  must be enabled.

I think this should be rather handled by a different compatible value, not a 
flag. Also a word about what this TDM mode is would be nice.

Best regards,
Tomasz

>  - samsung,idma-addr: Internal DMA register base address of the audio
>    sub system(used in secondary sound source).
>  - pinctrl-0: Should specify pin control groups used for this controller.
> diff --git a/include/linux/platform_data/asoc-s3c.h
> b/include/linux/platform_data/asoc-s3c.h index 8827259..9efc04d 100644
> --- a/include/linux/platform_data/asoc-s3c.h
> +++ b/include/linux/platform_data/asoc-s3c.h
> @@ -36,6 +36,7 @@ struct samsung_i2s {
>   */
>  #define QUIRK_NO_MUXPSR		(1 << 2)
>  #define QUIRK_NEED_RSTCLR	(1 << 3)
> +#define QUIRK_SUPPORTS_TDM	(1 << 4)
>  	/* Quirks of the I2S controller */
>  	u32 quirks;
>  	dma_addr_t idma_addr;
> diff --git a/sound/soc/samsung/i2s-regs.h b/sound/soc/samsung/i2s-regs.h
> index c0e6d9a..821a502 100644
> --- a/sound/soc/samsung/i2s-regs.h
> +++ b/sound/soc/samsung/i2s-regs.h
> @@ -31,6 +31,10 @@
>  #define I2SLVL1ADDR	0x34
>  #define I2SLVL2ADDR	0x38
>  #define I2SLVL3ADDR	0x3c
> +#define I2SSTR1		0x40
> +#define I2SVER		0x44
> +#define I2SFIC2		0x48
> +#define I2STDM		0x4c
> 
>  #define CON_RSTCLR		(1 << 31)
>  #define CON_FRXOFSTATUS		(1 << 26)
> @@ -95,24 +99,39 @@
>  #define MOD_RXONLY		(1 << 8)
>  #define MOD_TXRX		(2 << 8)
>  #define MOD_MASK		(3 << 8)
> -#define MOD_LR_LLOW		(0 << 7)
> -#define MOD_LR_RLOW		(1 << 7)
> -#define MOD_SDF_IIS		(0 << 5)
> -#define MOD_SDF_MSB		(1 << 5)
> -#define MOD_SDF_LSB		(2 << 5)
> -#define MOD_SDF_MASK		(3 << 5)
> -#define MOD_RCLK_256FS		(0 << 3)
> -#define MOD_RCLK_512FS		(1 << 3)
> -#define MOD_RCLK_384FS		(2 << 3)
> -#define MOD_RCLK_768FS		(3 << 3)
> -#define MOD_RCLK_MASK		(3 << 3)
> -#define MOD_BCLK_32FS		(0 << 1)
> -#define MOD_BCLK_48FS		(1 << 1)
> -#define MOD_BCLK_16FS		(2 << 1)
> -#define MOD_BCLK_24FS		(3 << 1)
> -#define MOD_BCLK_MASK		(3 << 1)
> +#define MOD_LRP_SHIFT		7
> +#define MOD_LR_LLOW		0
> +#define MOD_LR_RLOW		1
> +#define MOD_SDF_SHIFT		5
> +#define MOD_SDF_IIS		0
> +#define MOD_SDF_MSB		1
> +#define MOD_SDF_LSB		2
> +#define MOD_SDF_MASK		3
> +#define MOD_RCLK_SHIFT		3
> +#define MOD_RCLK_256FS		0
> +#define MOD_RCLK_512FS		1
> +#define MOD_RCLK_384FS		2
> +#define MOD_RCLK_768FS		3
> +#define MOD_RCLK_MASK		3
> +#define MOD_BCLK_SHIFT		1
> +#define MOD_BCLK_32FS		0
> +#define MOD_BCLK_48FS		1
> +#define MOD_BCLK_16FS		2
> +#define MOD_BCLK_24FS		3
> +#define MOD_BCLK_MASK		3
>  #define MOD_8BIT		(1 << 0)
> 
> +#define EXYNOS5420_MOD_LRP_SHIFT	15
> +#define EXYNOS5420_MOD_SDF_SHIFT	6
> +#define EXYNOS5420_MOD_RCLK_SHIFT	4
> +#define EXYNOS5420_MOD_BCLK_SHIFT	0
> +#define EXYNOS5420_MOD_BCLK_64FS	4
> +#define EXYNOS5420_MOD_BCLK_96FS	5
> +#define EXYNOS5420_MOD_BCLK_128FS	6
> +#define EXYNOS5420_MOD_BCLK_192FS	7
> +#define EXYNOS5420_MOD_BCLK_256FS	8
> +#define EXYNOS5420_MOD_BCLK_MASK	0xf
> +
>  #define MOD_CDCLKCON		(1 << 12)
> 
>  #define PSR_PSREN		(1 << 15)
> diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
> index 3fcf8d7..398f8db 100644
> --- a/sound/soc/samsung/i2s.c
> +++ b/sound/soc/samsung/i2s.c
> @@ -198,7 +198,13 @@ static inline bool is_manager(struct i2s_dai *i2s)
>  /* Read RCLK of I2S (in multiples of LRCLK) */
>  static inline unsigned get_rfs(struct i2s_dai *i2s)
>  {
> -	u32 rfs = (readl(i2s->addr + I2SMOD) >> 3) & 0x3;
> +	u32 rfs;
> +
> +	if (i2s->quirks & QUIRK_SUPPORTS_TDM)
> +		rfs = readl(i2s->addr + I2SMOD) >> EXYNOS5420_MOD_RCLK_SHIFT;
> +	else
> +		rfs = readl(i2s->addr + I2SMOD) >> MOD_RCLK_SHIFT;
> +	rfs &= MOD_RCLK_MASK;
> 
>  	switch (rfs) {
>  	case 3:	return 768;
> @@ -212,21 +218,26 @@ static inline unsigned get_rfs(struct i2s_dai *i2s)
>  static inline void set_rfs(struct i2s_dai *i2s, unsigned rfs)
>  {
>  	u32 mod = readl(i2s->addr + I2SMOD);
> +	int rfs_shift;
> 
> -	mod &= ~MOD_RCLK_MASK;
> +	if (i2s->quirks & QUIRK_SUPPORTS_TDM)
> +		rfs_shift = EXYNOS5420_MOD_RCLK_SHIFT;
> +	else
> +		rfs_shift = MOD_RCLK_SHIFT;
> +	mod &= ~(MOD_RCLK_MASK << rfs_shift);
> 
>  	switch (rfs) {
>  	case 768:
> -		mod |= MOD_RCLK_768FS;
> +		mod |= (MOD_RCLK_768FS << rfs_shift);
>  		break;
>  	case 512:
> -		mod |= MOD_RCLK_512FS;
> +		mod |= (MOD_RCLK_512FS << rfs_shift);
>  		break;
>  	case 384:
> -		mod |= MOD_RCLK_384FS;
> +		mod |= (MOD_RCLK_384FS << rfs_shift);
>  		break;
>  	default:
> -		mod |= MOD_RCLK_256FS;
> +		mod |= (MOD_RCLK_256FS << rfs_shift);
>  		break;
>  	}
> 
> @@ -236,9 +247,22 @@ static inline void set_rfs(struct i2s_dai *i2s,
> unsigned rfs) /* Read Bit-Clock of I2S (in multiples of LRCLK) */
>  static inline unsigned get_bfs(struct i2s_dai *i2s)
>  {
> -	u32 bfs = (readl(i2s->addr + I2SMOD) >> 1) & 0x3;
> +	u32 bfs;
> +
> +	if (i2s->quirks & QUIRK_SUPPORTS_TDM) {
> +		bfs = readl(i2s->addr + I2SMOD) >> EXYNOS5420_MOD_BCLK_SHIFT;
> +		bfs &= EXYNOS5420_MOD_BCLK_MASK;
> +	} else {
> +		bfs = readl(i2s->addr + I2SMOD) >> MOD_BCLK_SHIFT;
> +		bfs &= MOD_BCLK_MASK;
> +	}
> 
>  	switch (bfs) {
> +	case 8: return 256;
> +	case 7: return 192;
> +	case 6: return 128;
> +	case 5: return 96;
> +	case 4: return 64;
>  	case 3: return 24;
>  	case 2: return 16;
>  	case 1:	return 48;
> @@ -250,21 +274,50 @@ static inline unsigned get_bfs(struct i2s_dai *i2s)
>  static inline void set_bfs(struct i2s_dai *i2s, unsigned bfs)
>  {
>  	u32 mod = readl(i2s->addr + I2SMOD);
> +	int bfs_shift;
> +	int tdm = i2s->quirks & QUIRK_SUPPORTS_TDM;
> 
> -	mod &= ~MOD_BCLK_MASK;
> +	if (tdm) {
> +		bfs_shift = EXYNOS5420_MOD_BCLK_SHIFT;
> +		mod &= ~(EXYNOS5420_MOD_BCLK_MASK << bfs_shift);
> +	} else {
> +		bfs_shift = MOD_BCLK_SHIFT;
> +		mod &= ~(MOD_BCLK_MASK << bfs_shift);
> +	}
> +
> +	/* Non-TDM I2S controllers do not support BCLK > 48 * FS */
> +	if (!tdm && bfs > 48) {
> +		dev_err(&i2s->pdev->dev, "Unsupported BCLK divider\n");
> +		return;
> +	}
> 
>  	switch (bfs) {
>  	case 48:
> -		mod |= MOD_BCLK_48FS;
> +		mod |= (MOD_BCLK_48FS << bfs_shift);
>  		break;
>  	case 32:
> -		mod |= MOD_BCLK_32FS;
> +		mod |= (MOD_BCLK_32FS << bfs_shift);
>  		break;
>  	case 24:
> -		mod |= MOD_BCLK_24FS;
> +		mod |= (MOD_BCLK_24FS << bfs_shift);
>  		break;
>  	case 16:
> -		mod |= MOD_BCLK_16FS;
> +		mod |= (MOD_BCLK_16FS << bfs_shift);
> +		break;
> +	case 64:
> +		mod |= (EXYNOS5420_MOD_BCLK_64FS << bfs_shift);
> +		break;
> +	case 96:
> +		mod |= (EXYNOS5420_MOD_BCLK_96FS << bfs_shift);
> +		break;
> +	case 128:
> +		mod |= (EXYNOS5420_MOD_BCLK_128FS << bfs_shift);
> +		break;
> +	case 192:
> +		mod |= (EXYNOS5420_MOD_BCLK_192FS << bfs_shift);
> +		break;
> +	case 256:
> +		mod |= (EXYNOS5420_MOD_BCLK_256FS << bfs_shift);
>  		break;
>  	default:
>  		dev_err(&i2s->pdev->dev, "Wrong BCLK Divider!\n");
> @@ -492,19 +545,31 @@ static int i2s_set_fmt(struct snd_soc_dai *dai,
>  	struct i2s_dai *i2s = to_info(dai);
>  	u32 mod = readl(i2s->addr + I2SMOD);
>  	u32 tmp = 0;
> +	int lrp_shift, sdf_shift, sdf_mask, lrp_rlow;
> +
> +	if (i2s->quirks & QUIRK_SUPPORTS_TDM) {
> +		lrp_shift = EXYNOS5420_MOD_LRP_SHIFT;
> +		sdf_shift = EXYNOS5420_MOD_SDF_SHIFT;
> +	} else {
> +		lrp_shift = MOD_LRP_SHIFT;
> +		sdf_shift = MOD_SDF_SHIFT;
> +	}
> +
> +	sdf_mask = MOD_SDF_MASK << sdf_shift;
> +	lrp_rlow = MOD_LR_RLOW << lrp_shift;
> 
>  	/* Format is priority */
>  	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
>  	case SND_SOC_DAIFMT_RIGHT_J:
> -		tmp |= MOD_LR_RLOW;
> -		tmp |= MOD_SDF_MSB;
> +		tmp |= lrp_rlow;
> +		tmp |= (MOD_SDF_MSB << sdf_shift);
>  		break;
>  	case SND_SOC_DAIFMT_LEFT_J:
> -		tmp |= MOD_LR_RLOW;
> -		tmp |= MOD_SDF_LSB;
> +		tmp |= lrp_rlow;
> +		tmp |= (MOD_SDF_LSB << sdf_shift);
>  		break;
>  	case SND_SOC_DAIFMT_I2S:
> -		tmp |= MOD_SDF_IIS;
> +		tmp |= (MOD_SDF_IIS << sdf_shift);
>  		break;
>  	default:
>  		dev_err(&i2s->pdev->dev, "Format not supported\n");
> @@ -519,10 +584,10 @@ static int i2s_set_fmt(struct snd_soc_dai *dai,
>  	case SND_SOC_DAIFMT_NB_NF:
>  		break;
>  	case SND_SOC_DAIFMT_NB_IF:
> -		if (tmp & MOD_LR_RLOW)
> -			tmp &= ~MOD_LR_RLOW;
> +		if (tmp & lrp_rlow)
> +			tmp &= ~lrp_rlow;
>  		else
> -			tmp |= MOD_LR_RLOW;
> +			tmp |= lrp_rlow;
>  		break;
>  	default:
>  		dev_err(&i2s->pdev->dev, "Polarity not supported\n");
> @@ -544,15 +609,18 @@ static int i2s_set_fmt(struct snd_soc_dai *dai,
>  		return -EINVAL;
>  	}
> 
> +	/*
> +	 * Don't change the I2S mode if any controller is active on this
> +	 * channel.
> +	 */
>  	if (any_active(i2s) &&
> -			((mod & (MOD_SDF_MASK | MOD_LR_RLOW
> -				| MOD_SLAVE)) != tmp)) {
> +	    ((mod & (sdf_mask | lrp_rlow | MOD_SLAVE)) != tmp)) {
>  		dev_err(&i2s->pdev->dev,
>  				"%s:%d Other DAI busy\n", __func__, __LINE__);
>  		return -EAGAIN;
>  	}
> 
> -	mod &= ~(MOD_SDF_MASK | MOD_LR_RLOW | MOD_SLAVE);
> +	mod &= ~(sdf_mask | lrp_rlow | MOD_SLAVE);
>  	mod |= tmp;
>  	writel(mod, i2s->addr + I2SMOD);
> 
> @@ -1170,6 +1238,9 @@ static int samsung_i2s_probe(struct platform_device
> *pdev) if (of_find_property(np, "samsung,supports-rstclr", NULL))
>  			quirks |= QUIRK_NEED_RSTCLR;
> 
> +		if (of_find_property(np, "samsung,supports-tdm", NULL))
> +			quirks |= QUIRK_SUPPORTS_TDM;
> +
>  		if (of_property_read_u32(np, "samsung,idma-addr",
>  					 &idma_addr)) {
>  			if (quirks & QUIRK_SEC_DAI) {
