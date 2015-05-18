From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 18 May 2015 20:43:00 +0200
Subject: [PATCH v8 2/3] I2C: mediatek: Add driver for MediaTek I2C
 controller
In-Reply-To: <1431967209-5261-3-git-send-email-eddie.huang@mediatek.com>
References: <1431967209-5261-1-git-send-email-eddie.huang@mediatek.com>
 <1431967209-5261-3-git-send-email-eddie.huang@mediatek.com>
Message-ID: <20150518184300.GB28888@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, May 19, 2015 at 12:40:08AM +0800, Eddie Huang wrote:
> From: Xudong Chen <xudong.chen@mediatek.com>
> 
> The mediatek SoCs have I2C controller that handle I2C transfer.
> This patch include common I2C bus driver.
> This driver is compatible with I2C controller on mt65xx/mt81xx.
> 
> Signed-off-by: Xudong Chen <xudong.chen@mediatek.com>
> Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/i2c/busses/Kconfig      |   9 +
>  drivers/i2c/busses/Makefile     |   1 +
>  drivers/i2c/busses/i2c-mt65xx.c | 675 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 685 insertions(+)
>  create mode 100644 drivers/i2c/busses/i2c-mt65xx.c
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 2255af2..14c7266 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -620,6 +620,15 @@ config I2C_MPC
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-mpc.
>  
> +config I2C_MT65XX
> +	tristate "MediaTek I2C adapter"
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	help
> +	  This selects the MediaTek(R) Integrated Inter Circuit bus driver
> +	  for MT65xx and MT81xx.
> +	  If you want to use MediaTek(R) I2C interface, say Y or M here.
> +	  If unsure, say N.
> +
>  config I2C_MV64XXX
>  	tristate "Marvell mv64xxx I2C Controller"
>  	depends on MV64X60 || PLAT_ORION || ARCH_SUNXI
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index cdf941d..abbf422 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -60,6 +60,7 @@ obj-$(CONFIG_I2C_JZ4780)	+= i2c-jz4780.o
>  obj-$(CONFIG_I2C_KEMPLD)	+= i2c-kempld.o
>  obj-$(CONFIG_I2C_MESON)		+= i2c-meson.o
>  obj-$(CONFIG_I2C_MPC)		+= i2c-mpc.o
> +obj-$(CONFIG_I2C_MT65XX)	+= i2c-mt65xx.o
>  obj-$(CONFIG_I2C_MV64XXX)	+= i2c-mv64xxx.o
>  obj-$(CONFIG_I2C_MXS)		+= i2c-mxs.o
>  obj-$(CONFIG_I2C_NOMADIK)	+= i2c-nomadik.o
> diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
> new file mode 100644
> index 0000000..7462f05
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-mt65xx.c
> @@ -0,0 +1,675 @@
> +/*
> + * Copyright (c) 2014 MediaTek Inc.
> + * Author: Xudong.chen <xudong.chen@mediatek.com>
s/Xudong.chen/Xudong Chen/

> +#define I2C_DRV_NAME		"mt-i2c"
i2c-mt65xx ?

> +}
> +
> +/* calculate i2c port speed */
It would be nice to summarize the clock frequency settings here.
Something like:

	/*
	 * The input clock is divided by the value specified in the
	 * device tree as clock-div. The actual bus speed is then
	 * derived from this frequency by the following formula:
	 *  ....

This would make it possible to verify your calculations below.

> +static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int clk_src_in_hz)
> +{
> +	unsigned int khz;
> +	unsigned int step_cnt;
> +	unsigned int sample_cnt;
> +	unsigned int sclk;
> +	unsigned int hclk;
> +	unsigned int max_step_cnt;
> +	unsigned int sample_div = MAX_SAMPLE_CNT_DIV;
> +	unsigned int step_div;
> +	unsigned int min_div;
> +	unsigned int best_mul;
> +	unsigned int cnt_mul;
> +
> +	if (i2c->speed_hz > MAX_HS_MODE_SPEED)
> +		return -EINVAL;
> +	else if (i2c->speed_hz > MAX_FS_MODE_SPEED)
> +		max_step_cnt = MAX_HS_STEP_CNT_DIV;
> +	else
> +		max_step_cnt = MAX_STEP_CNT_DIV;
> +
> +	step_div = max_step_cnt;
> +	/* Find the best combination */
> +	khz = i2c->speed_hz / 1000;
> +	hclk = clk_src_in_hz / 1000;
> +	min_div = ((hclk >> 1) + khz - 1) / khz;
This is DIV_ROUND_UP(hclk >> 1, khz).

> +	best_mul = MAX_SAMPLE_CNT_DIV * max_step_cnt;
> +
> +	for (sample_cnt = 1; sample_cnt <= MAX_SAMPLE_CNT_DIV; sample_cnt++) {
> +		step_cnt = (min_div + sample_cnt - 1) / sample_cnt;
> +		cnt_mul = step_cnt * sample_cnt;
> +		if (step_cnt > max_step_cnt)
> +			continue;
> +
> +		if (cnt_mul < best_mul) {
> +			best_mul = cnt_mul;
> +			sample_div = sample_cnt;
> +			step_div = step_cnt;
> +			if (best_mul == min_div)
> +				break;
> +		}
> +	}
> +
> +	sample_cnt = sample_div;
> +	step_cnt = step_div;
> +	sclk = hclk / (2 * sample_cnt * step_cnt);
> +	if (sclk > khz) {
> +		dev_dbg(i2c->dev, "%s mode: unsupported speed (%ldkhz)\n",
> +			(i2c->speed_hz > MAX_HS_MODE_SPEED) ? "HS" : "ST/FT",
> +			(long int)khz);
> +		return -EINVAL;
> +	}
> +
> +	step_cnt--;
> +	sample_cnt--;
> +
> +	if (i2c->speed_hz > MAX_FS_MODE_SPEED) {
> +		/* Set the hign speed mode register */
> +		i2c->timing_reg = I2C_FS_TIME_INIT_VALUE;
> +		i2c->high_speed_reg = I2C_TIME_DEFAULT_VALUE |
> +			(sample_cnt & I2C_TIMING_SAMPLE_COUNT_MASK) << 12 |
> +			(step_cnt & I2C_TIMING_SAMPLE_COUNT_MASK) << 8;
> +	} else {
> +		i2c->timing_reg =
> +			(sample_cnt & I2C_TIMING_SAMPLE_COUNT_MASK) << 8 |
> +			(step_cnt & I2C_TIMING_STEP_DIV_MASK) << 0;
> +		/* Disable the high speed transaction */
> +		i2c->high_speed_reg = I2C_TIME_CLR_VALUE;
Can it happen that sample_cnt & I2C_TIMING_SAMPLE_COUNT_MASK !=
sample_cnt? If yes, what is the influence on correctness? Same question
for step_cnt.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
