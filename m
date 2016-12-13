From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 13 Dec 2016 10:20:31 +0100
Subject: [PATCH v6 2/5] i2c: Add STM32F4 I2C driver
In-Reply-To: <1481559342-6106-3-git-send-email-cedric.madianga@gmail.com>
References: <1481559342-6106-1-git-send-email-cedric.madianga@gmail.com>
 <1481559342-6106-3-git-send-email-cedric.madianga@gmail.com>
Message-ID: <20161213092031.d2ax2pnpzzicriel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Dec 12, 2016 at 05:15:39PM +0100, M'boumba Cedric Madianga wrote:
> This patch adds support for the STM32F4 I2C controller.
> 
> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> ---
>  drivers/i2c/busses/Kconfig       |  10 +
>  drivers/i2c/busses/Makefile      |   1 +
>  drivers/i2c/busses/i2c-stm32f4.c | 849 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 860 insertions(+)
>  create mode 100644 drivers/i2c/busses/i2c-stm32f4.c
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 0cdc844..2719208 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -886,6 +886,16 @@ config I2C_ST
>  	  This driver can also be built as module. If so, the module
>  	  will be called i2c-st.
>  
> +config I2C_STM32F4
> +	tristate "STMicroelectronics STM32F4 I2C support"
> +	depends on ARCH_STM32 || COMPILE_TEST
> +	help
> +	  Enable this option to add support for STM32 I2C controller embedded
> +	  in STM32F4 SoCs.
> +
> +	  This driver can also be built as module. If so, the module
> +	  will be called i2c-stm32f4.
> +
>  config I2C_STU300
>  	tristate "ST Microelectronics DDC I2C interface"
>  	depends on MACH_U300
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 1c1bac8..a2c6ff5 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -85,6 +85,7 @@ obj-$(CONFIG_I2C_SH_MOBILE)	+= i2c-sh_mobile.o
>  obj-$(CONFIG_I2C_SIMTEC)	+= i2c-simtec.o
>  obj-$(CONFIG_I2C_SIRF)		+= i2c-sirf.o
>  obj-$(CONFIG_I2C_ST)		+= i2c-st.o
> +obj-$(CONFIG_I2C_STM32F4)	+= i2c-stm32f4.o
>  obj-$(CONFIG_I2C_STU300)	+= i2c-stu300.o
>  obj-$(CONFIG_I2C_SUN6I_P2WI)	+= i2c-sun6i-p2wi.o
>  obj-$(CONFIG_I2C_TEGRA)		+= i2c-tegra.o
> diff --git a/drivers/i2c/busses/i2c-stm32f4.c b/drivers/i2c/busses/i2c-stm32f4.c
> new file mode 100644
> index 0000000..89ad579
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-stm32f4.c
> @@ -0,0 +1,849 @@
> +/*
> + * Driver for STMicroelectronics STM32 I2C controller
> + *
> + * Copyright (C) M'boumba Cedric Madianga 2015
> + * Author: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> + *
> + * This driver is based on i2c-st.c
> + *
> + * License terms:  GNU General Public License (GPL), version 2
> + */

If there is a public description available for the device, a link here
would be great.

> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +
> +/* STM32F4 I2C offset registers */
> +#define STM32F4_I2C_CR1			0x00
> +#define STM32F4_I2C_CR2			0x04
> +#define STM32F4_I2C_DR			0x10
> +#define STM32F4_I2C_SR1			0x14
> +#define STM32F4_I2C_SR2			0x18
> +#define STM32F4_I2C_CCR			0x1C
> +#define STM32F4_I2C_TRISE		0x20
> +#define STM32F4_I2C_FLTR		0x24
> +
> +/* STM32F4 I2C control 1*/
> +#define STM32F4_I2C_CR1_SWRST		BIT(15)
> +#define STM32F4_I2C_CR1_POS		BIT(11)
> +#define STM32F4_I2C_CR1_ACK		BIT(10)
> +#define STM32F4_I2C_CR1_STOP		BIT(9)
> +#define STM32F4_I2C_CR1_START		BIT(8)
> +#define STM32F4_I2C_CR1_PE		BIT(0)
> +
> +/* STM32F4 I2C control 2 */
> +#define STM32F4_I2C_CR2_FREQ_MASK	GENMASK(5, 0)
> +#define STM32F4_I2C_CR2_FREQ(n)		((n & STM32F4_I2C_CR2_FREQ_MASK))

This should better be ((n) & STM32F4_I2C_CR2_FREQ_MASK). There a few
more constants that need the same fix.

> +#define STM32F4_I2C_CR2_ITBUFEN		BIT(10)
> +#define STM32F4_I2C_CR2_ITEVTEN		BIT(9)
> +#define STM32F4_I2C_CR2_ITERREN		BIT(8)
> +#define STM32F4_I2C_CR2_IRQ_MASK	(STM32F4_I2C_CR2_ITBUFEN \
> +					| STM32F4_I2C_CR2_ITEVTEN \
> +					| STM32F4_I2C_CR2_ITERREN)

I'd layout this like:

	#define STM32F4_I2C_CR2_IRQ_MASK	(STM32F4_I2C_CR2_ITBUFEN | \
						 STM32F4_I2C_CR2_ITEVTEN | \
						 STM32F4_I2C_CR2_ITERREN)
		
which is more usual I think.

> +/* STM32F4 I2C Status 1 */
> +#define STM32F4_I2C_SR1_AF		BIT(10)
> +#define STM32F4_I2C_SR1_ARLO		BIT(9)
> +#define STM32F4_I2C_SR1_BERR		BIT(8)
> +#define STM32F4_I2C_SR1_TXE		BIT(7)
> +#define STM32F4_I2C_SR1_RXNE		BIT(6)
> +#define STM32F4_I2C_SR1_BTF		BIT(2)
> +#define STM32F4_I2C_SR1_ADDR		BIT(1)
> +#define STM32F4_I2C_SR1_SB		BIT(0)
> +#define STM32F4_I2C_SR1_ITEVTEN_MASK	(STM32F4_I2C_SR1_BTF \
> +					| STM32F4_I2C_SR1_ADDR \
> +					| STM32F4_I2C_SR1_SB)
> +#define STM32F4_I2C_SR1_ITBUFEN_MASK	(STM32F4_I2C_SR1_TXE \
> +					| STM32F4_I2C_SR1_RXNE)
> +#define STM32F4_I2C_SR1_ITERREN_MASK	(STM32F4_I2C_SR1_AF \
> +					| STM32F4_I2C_SR1_ARLO \
> +					| STM32F4_I2C_SR1_BERR)
> +
> +/* STM32F4 I2C Status 2 */
> +#define STM32F4_I2C_SR2_BUSY		BIT(1)
> +
> +/* STM32F4 I2C Control Clock */
> +#define STM32F4_I2C_CCR_CCR_MASK	GENMASK(11, 0)
> +#define STM32F4_I2C_CCR_CCR(n)		((n & STM32F4_I2C_CCR_CCR_MASK))
> +#define STM32F4_I2C_CCR_FS		BIT(15)
> +#define STM32F4_I2C_CCR_DUTY		BIT(14)
> +
> +/* STM32F4 I2C Trise */
> +#define STM32F4_I2C_TRISE_VALUE_MASK	GENMASK(5, 0)
> +#define STM32F4_I2C_TRISE_VALUE(n)	((n & STM32F4_I2C_TRISE_VALUE_MASK))
> +
> +/* STM32F4 I2C Filter */
> +#define STM32F4_I2C_FLTR_DNF_MASK	GENMASK(3, 0)
> +#define STM32F4_I2C_FLTR_DNF(n)		((n & STM32F4_I2C_FLTR_DNF_MASK))
> +#define STM32F4_I2C_FLTR_ANOFF		BIT(4)
> +
> +#define STM32F4_I2C_MIN_FREQ		2U
> +#define STM32F4_I2C_MAX_FREQ		42U
> +#define FAST_MODE_MAX_RISE_TIME		1000
> +#define STD_MODE_MAX_RISE_TIME		300

Are these supposed to be the values "rise time of both SDA and SCL
signals" from the i2c specification? If so, you got it wrong, fast mode
has the smaller value.
Maybe these constants could get a home in a more central place?
Also I'd add /* ns */ to the definition.

> +#define MHZ_TO_HZ			1000000
> +
> +enum stm32f4_i2c_speed {
> +	STM32F4_I2C_SPEED_STANDARD, /* 100 kHz */
> +	STM32F4_I2C_SPEED_FAST, /* 400 kHz */
> +	STM32F4_I2C_SPEED_END,
> +};
> +
> +/**
> + * struct stm32f4_i2c_timings - per-Mode tuning parameters
> + * @duty: Fast mode duty cycle
> + * @mul_ccr: Value to be multiplied to CCR to reach 100Khz/400Khz SCL frequency
> + * @min_ccr: Minimum clock ctrl reg value to reach 100Khz/400Khz SCL frequency
> + */
> +struct stm32f4_i2c_timings {
> +	u32 rate;

rate is undocumented and unused.

> +	u32 duty;
> +	u32 mul_ccr;
> +	u32 min_ccr;
> +};
> +
> +/**
> + * struct stm32f4_i2c_msg - client specific data
> + * @addr: 8-bit slave addr, including r/w bit
> + * @count: number of bytes to be transferred
> + * @buf: data buffer
> + * @result: result of the transfer
> + * @stop: last I2C msg to be sent, i.e. STOP to be generated
> + */
> +struct stm32f4_i2c_msg {
> +	u8	addr;
> +	u32	count;
> +	u8	*buf;
> +	int	result;
> +	bool	stop;
> +};
> +
> +/**
> + * struct stm32f4_i2c_dev - private data of the controller
> + * @adap: I2C adapter for this controller
> + * @dev: device for this controller
> + * @base: virtual memory area
> + * @complete: completion of I2C message
> + * @irq_event: interrupt event line for the controller
> + * @irq_error: interrupt error line for the controller
> + * @clk: hw i2c clock
> + * speed: I2C clock frequency of the controller. Standard or Fast only supported
> + * @msg: I2C transfer information
> + */
> +struct stm32f4_i2c_dev {
> +	struct i2c_adapter		adap;
> +	struct device			*dev;
> +	void __iomem			*base;
> +	struct completion		complete;
> +	int				irq_event;
> +	int				irq_error;

You only use irq_event in the probe function. So there is no need to
remember this one and you could use a local variable instead.

> +	struct clk			*clk;
> +	int				speed;
> +	struct stm32f4_i2c_msg		msg;
> +};
> +
> +static struct stm32f4_i2c_timings i2c_timings[] = {
> +	[STM32F4_I2C_SPEED_STANDARD] = {
> +		.mul_ccr		= 1,
> +		.min_ccr		= 4,
> +		.duty			= 0,
> +	},
> +	[STM32F4_I2C_SPEED_FAST] = {
> +		.mul_ccr		= 16,
> +		.min_ccr		= 1,
> +		.duty			= 1,
> +	},

Are these values from the datasheet?

> +};
> +
> +static inline void stm32f4_i2c_set_bits(void __iomem *reg, u32 mask)
> +{
> +	writel_relaxed(readl_relaxed(reg) | mask, reg);
> +}
> +
> +static inline void stm32f4_i2c_clr_bits(void __iomem *reg, u32 mask)
> +{
> +	writel_relaxed(readl_relaxed(reg) & ~mask, reg);
> +}
> +
> +static void stm32f4_i2c_soft_reset(struct stm32f4_i2c_dev *i2c_dev)
> +{
> +	void __iomem *reg = i2c_dev->base + STM32F4_I2C_CR1;
> +
> +	stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_SWRST);
> +	stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR1_SWRST);

Not very critical, but you're doing an unneeded register access here
because the register is read twice.

Also I think readability would improve if you dropped
stm32f4_i2c_{set,clr}_bits and do their logic explicitly in the callers. 

	stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_SWRST);
	stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR1_SWRST);

vs

	val = readl_relaxed(reg);
	writel_relaxed(val | STM32F4_I2C_CR1_SWRST, reg);
	writel_relaxed(val, reg);

> +}
> +
> +static void stm32f4_i2c_disable_it(struct stm32f4_i2c_dev *i2c_dev)

What is "it"? If it stands for "interrupt" the more usual abbrev is
"irq".

> +{
> +	void __iomem *reg = i2c_dev->base + STM32F4_I2C_CR2;
> +
> +	stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR2_IRQ_MASK);
> +}
> +
> +static void stm32f4_i2c_set_periph_clk_freq(struct stm32f4_i2c_dev *i2c_dev)
> +{
> +	u32 clk_rate, cr2, freq;
> +
> +	cr2 = readl_relaxed(i2c_dev->base + STM32F4_I2C_CR2);
> +	cr2 &= ~STM32F4_I2C_CR2_FREQ_MASK;
> +	clk_rate = clk_get_rate(i2c_dev->clk);
> +	freq = clk_rate / MHZ_TO_HZ;
> +	freq = clamp(freq, STM32F4_I2C_MIN_FREQ, STM32F4_I2C_MAX_FREQ);
> +	cr2 |= STM32F4_I2C_CR2_FREQ(freq);
> +	writel_relaxed(cr2, i2c_dev->base + STM32F4_I2C_CR2);

Can you quote the data sheet enough in a comment here to make it obvious
that your calculation is right?

Would it be more sensible to error out if clk_rate / MHZ_TO_HZ isn't in
the interval [STM32F4_I2C_MIN_FREQ, STM32F4_I2C_MAX_FREQ]?

Usually I would expect that you need to use
DIV_ROUND_UP(clk_rate, MHZ_TO_HZ) instead of a plain division.

> +}
> +
> +static void stm32f4_i2c_set_rise_time(struct stm32f4_i2c_dev *i2c_dev)
> +{
> +	u32 trise, freq, cr2, val;
> +
> +	cr2 = readl_relaxed(i2c_dev->base + STM32F4_I2C_CR2);
> +	freq = cr2 & STM32F4_I2C_CR2_FREQ_MASK;
> +
> +	trise = readl_relaxed(i2c_dev->base + STM32F4_I2C_TRISE);
> +	trise &= ~STM32F4_I2C_TRISE_VALUE_MASK;

Are you required to use rmw for STM32F4_I2C_TRISE? I'd prefer

	writel_relaxed(STM32F4_I2C_TRISE_VALUE(..), i2c_dev->base + STM32F4_I2C_TRISE);

unless the datasheet requires rmw.

> +	/* Maximum rise time computation */
> +	if (i2c_dev->speed == STM32F4_I2C_SPEED_STANDARD) {
> +		trise |= STM32F4_I2C_TRISE_VALUE((freq + 1));

A single pair of parenthesis is enough when you fix
STM32F4_I2C_TRISE_VALUE as suggested above.

> +	} else {
> +		val = freq * FAST_MODE_MAX_RISE_TIME / STD_MODE_MAX_RISE_TIME;
> +		trise |= STM32F4_I2C_TRISE_VALUE((val + 1));

val could be local to this branch.

Or make it shorter using:

	freq = cr2 & STM32F4_I2C_CR2_FREQ_MASK;
	if (i2c_dev->speed == STM32F4_I2C_SPEED_FAST)
		freq = freq * FAST_MODE_MAX_RISE_TIME / STD_MODE_MAX_RISE_TIME;

	writel_relaxed(STM32F4_I2C_TRISE_VALUE(freq + 1), ...);

A quote from the data sheet about the algorithm would be good here, too.

> +	}
> +
> +	writel_relaxed(trise, i2c_dev->base + STM32F4_I2C_TRISE);
> +}
> +
> +static void stm32f4_i2c_set_speed_mode(struct stm32f4_i2c_dev *i2c_dev)
> +{
> +	struct stm32f4_i2c_timings *t = &i2c_timings[i2c_dev->speed];
> +	u32 ccr, clk_rate;
> +	int val;
> +
> +	ccr = readl_relaxed(i2c_dev->base + STM32F4_I2C_CCR);
> +	ccr &= ~(STM32F4_I2C_CCR_FS | STM32F4_I2C_CCR_DUTY |
> +		 STM32F4_I2C_CCR_CCR_MASK);
> +
> +	clk_rate = clk_get_rate(i2c_dev->clk);
> +	val = clk_rate / MHZ_TO_HZ * t->mul_ccr;

Is the rounding done right? Again please describe the hardware in a
comment.

> +	if (val < t->min_ccr)
> +		val = t->min_ccr;
> +	ccr |= STM32F4_I2C_CCR_CCR(val);
> +
> +	if (t->duty)
> +		ccr |= STM32F4_I2C_CCR_FS | STM32F4_I2C_CCR_DUTY;
> +
> +	writel_relaxed(ccr, i2c_dev->base + STM32F4_I2C_CCR);
> +}
> +[...]
> +
> +static int stm32f4_i2c_wait_free_bus(struct stm32f4_i2c_dev *i2c_dev)
> +{
> +	u32 status;
> +	int ret;
> +
> +	ret = readl_relaxed_poll_timeout(i2c_dev->base + STM32F4_I2C_SR2,
> +					 status,
> +					 !(status & STM32F4_I2C_SR2_BUSY),
> +					 10, 1000);
> +	if (ret) {
> +		dev_err(i2c_dev->dev, "bus not free\n");
> +		ret = -EBUSY;

I'm not sure if "bus not free" deserves an error message. Wolfram?

> +	}
> +
> +	return ret;
> +}
> +
> +[...]
> +static void stm32f4_i2c_read_msg(struct stm32f4_i2c_dev *i2c_dev)
> +{
> +	struct stm32f4_i2c_msg *msg = &i2c_dev->msg;
> +	u32 rbuf;
> +
> +	rbuf = readl_relaxed(i2c_dev->base + STM32F4_I2C_DR);
> +	*msg->buf++ = (u8)rbuf & 0xff;

unneeded cast (or unneeded & 0xff).

> +	msg->count--;
> +}
> +
> +[...]
> +/**
> + * stm32f4_i2c_handle_read() - Handle FIFO empty interrupt in case of read
> + * @i2c_dev: Controller's private data
> + */
> +static void stm32f4_i2c_handle_read(struct stm32f4_i2c_dev *i2c_dev)
> +{
> +	struct stm32f4_i2c_msg *msg = &i2c_dev->msg;
> +	void __iomem *reg = i2c_dev->base + STM32F4_I2C_CR2;
> +
> +	switch (msg->count) {
> +	case 1:
> +		stm32f4_i2c_disable_it(i2c_dev);
> +		stm32f4_i2c_read_msg(i2c_dev);
> +		complete(&i2c_dev->complete);
> +		break;
> +	case 2:
> +	case 3:
> +		stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR2_ITBUFEN);
> +		break;
> +	default:
> +		stm32f4_i2c_read_msg(i2c_dev);
> +	}

It looks wrong that you don't call stm32f4_i2c_read_msg if msg->count is
2 or 3. I guess that's because these cases are handled in
stm32f4_i2c_handle_rx_btf? Maybe you can simplify the logic a bit?

> +}
> +
> +/**
> + * stm32f4_i2c_handle_rx_btf() - Handle byte transfer finished interrupt
> + * in case of read
> + * @i2c_dev: Controller's private data
> + */
> +static void stm32f4_i2c_handle_rx_btf(struct stm32f4_i2c_dev *i2c_dev)
> +{
> +	struct stm32f4_i2c_msg *msg = &i2c_dev->msg;
> +	void __iomem *reg;
> +	u32 mask;
> +	int i;
> +
> +	switch (msg->count) {

I don't understand why the handling depends on the number of messages.

> +	case 2:
> +		reg = i2c_dev->base + STM32F4_I2C_CR1;
> +		/* Generate STOP or REPSTART */

I stumbled about "REPSTART" and would spell it out as "repeated Start".

> +		if (msg->stop)
> +			stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_STOP);
> +		else
> +			stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_START);
> +
> +		/* Read two last data bytes */
> +		for (i = 2; i > 0; i--)
> +			stm32f4_i2c_read_msg(i2c_dev);
> +
> +		/* Disable EVT and ERR interrupt */
> +		reg = i2c_dev->base + STM32F4_I2C_CR2;
> +		mask = STM32F4_I2C_CR2_ITEVTEN | STM32F4_I2C_CR2_ITERREN;
> +		stm32f4_i2c_clr_bits(reg, mask);
> +
> +		complete(&i2c_dev->complete);
> +		break;
> +	case 3:
> +		/* Enable ACK and read data */
> +		reg = i2c_dev->base + STM32F4_I2C_CR1;
> +		stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR1_ACK);
> +		stm32f4_i2c_read_msg(i2c_dev);
> +		break;
> +	default:
> +		stm32f4_i2c_read_msg(i2c_dev);
> +	}
> +}
> +
> +/**
> + * stm32f4_i2c_handle_rx_addr() - Handle address matched interrupt in case of
> + * master receiver
> + * @i2c_dev: Controller's private data
> + */
> +static void stm32f4_i2c_handle_rx_addr(struct stm32f4_i2c_dev *i2c_dev)
> +{
> +	struct stm32f4_i2c_msg *msg = &i2c_dev->msg;
> +	void __iomem *reg;
> +
> +	switch (msg->count) {
> +	case 0:
> +		stm32f4_i2c_terminate_xfer(i2c_dev);
> +		/* Clear ADDR flag */
> +		readl_relaxed(i2c_dev->base + STM32F4_I2C_SR2);
> +		break;
> +	case 1:
> +		/*
> +		 * Single byte reception:
> +		 * Enable NACK, clear ADDR flag and generate STOP or RepSTART
> +		 */
> +		reg = i2c_dev->base + STM32F4_I2C_CR1;
> +		stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR1_ACK);
> +		if (msg->stop)
> +			stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_STOP);
> +		else
> +			stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_START);
> +		break;
> +	case 2:
> +		/*
> +		 * 2-byte reception:
> +		 * Enable NACK and PEC Position Ack and clear ADDR flag

What is PEC?

> +		 */
> +		reg = i2c_dev->base + STM32F4_I2C_CR1;
> +		stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR1_ACK);
> +		stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_POS);
> +		readl_relaxed(i2c_dev->base + STM32F4_I2C_SR2);
> +		break;
> +
> +	default:
> +		/* N-byte reception: Enable ACK and clear ADDR flag */
> +		reg = i2c_dev->base + STM32F4_I2C_CR1;
> +		stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_ACK);
> +		readl_relaxed(i2c_dev->base + STM32F4_I2C_SR2);
> +		break;
> +	}
> +}
> +
> +/**
> + * stm32f4_i2c_isr_event() - Interrupt routine for I2C bus event
> + * @irq: interrupt number
> + * @data: Controller's private data
> + */
> +static irqreturn_t stm32f4_i2c_isr_event(int irq, void *data)
> +{
> +[...]
> +	real_status = readl_relaxed(i2c_dev->base + STM32F4_I2C_SR1);

s/real_status/status/ ?

> +
> +	if (!(real_status & possible_status)) {
> +		dev_dbg(i2c_dev->dev,
> +			"spurious evt it (status=0x%08x, ien=0x%08x)\n",
> +			real_status, ien);

s/it/irq/

> +		return IRQ_NONE;
> +	}
> +
> +	/* Use __fls() to check error bits first */
> +	flag = __fls(real_status & possible_status);

If you get several events reported you only handle a single one. Is this
effective?

> +	switch (1 << flag) {
> +	case STM32F4_I2C_SR1_SB:
> +		stm32f4_i2c_write_byte(i2c_dev, msg->addr);
> +		break;
> +
> +	case STM32F4_I2C_SR1_ADDR:
> +		if (msg->addr & I2C_M_RD)
> +			stm32f4_i2c_handle_rx_addr(i2c_dev);
> +		else
> +			readl_relaxed(i2c_dev->base + STM32F4_I2C_SR2);
> +
> +		/* Enable ITBUF interrupts */

What is ITBUF?

> +		reg = i2c_dev->base + STM32F4_I2C_CR2;
> +		stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR2_ITBUFEN);
> +		break;
> +
> +	case STM32F4_I2C_SR1_BTF:
> +		if (msg->addr & I2C_M_RD)
> +			stm32f4_i2c_handle_rx_btf(i2c_dev);
> +		else
> +			stm32f4_i2c_handle_write(i2c_dev);
> +		break;
> +
> +	case STM32F4_I2C_SR1_TXE:
> +		stm32f4_i2c_handle_write(i2c_dev);
> +		break;
> +
> +	case STM32F4_I2C_SR1_RXNE:
> +		stm32f4_i2c_handle_read(i2c_dev);
> +		break;
> +
> +	default:
> +		dev_err(i2c_dev->dev,
> +			"evt it unhandled: status=0x%08x)\n", real_status);

s/it/irq/

> +		return IRQ_NONE;
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +[...]
> +static int stm32f4_i2c_xfer_msg(struct stm32f4_i2c_dev *i2c_dev,
> +				struct i2c_msg *msg, bool is_first,
> +				bool is_last)
> +{
> +[...]
> +	/* Enable ITEVT and ITERR interrupts */

This comment isn't helpful. Mentioning their meaning would be great
instead.

> +[...]
> +static int stm32f4_i2c_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[],
> +			    int num)
> +{
> +	struct stm32f4_i2c_dev *i2c_dev = i2c_get_adapdata(i2c_adap);
> +	int ret, i;
> +
> +	ret = clk_enable(i2c_dev->clk);
> +	if (ret) {
> +		dev_err(i2c_dev->dev, "Failed to enable clock\n");
> +		return ret;
> +	}
> +
> +	stm32f4_i2c_hw_config(i2c_dev);
> +
> +	for (i = 0; i < num && !ret; i++)
> +		ret = stm32f4_i2c_xfer_msg(i2c_dev, &msgs[i], i == 0,
> +					   i == num - 1);
> +
> +	clk_disable(i2c_dev->clk);
> +
> +	return (ret < 0) ? ret : i;

using num instead of i would be a bit more obvious.

> +static int stm32f4_i2c_probe(struct platform_device *pdev)
> +{
> +[...]
> +	i2c_dev->speed = STM32F4_I2C_SPEED_STANDARD;
> +	ret = of_property_read_u32(np, "clock-frequency", &clk_rate);
> +	if ((!ret) && (clk_rate == 400000))
> +		i2c_dev->speed = STM32F4_I2C_SPEED_FAST;

I'd use

	if (!ret && clk_rate >= 400000)
		i2c_dev->speed = STM32F4_I2C_SPEED_FAST;

. That's less parenthesis and a more robust selection of the bus
frequency.

> +
> +	i2c_dev->dev = &pdev->dev;
> +
> +	ret = devm_request_threaded_irq(&pdev->dev, i2c_dev->irq_event,
> +					NULL, stm32f4_i2c_isr_event,
> +					IRQF_ONESHOT, pdev->name, i2c_dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to request irq %i\n",
> +			i2c_dev->irq_error);

That's wrong. Requesting irq_event failed.

> +		goto clk_free;
> +	}
> +
> +	ret = devm_request_threaded_irq(&pdev->dev, i2c_dev->irq_error,
> +					NULL, stm32f4_i2c_isr_error,
> +					IRQF_ONESHOT, pdev->name, i2c_dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to request irq %i\n",
> +			i2c_dev->irq_error);
> +		goto clk_free;

It would also be nice to know for which type of irq this failed. I.e.
please point out if this is the error irq or the event irq in the
message. Ditto for checking the return type of irq_of_parse_and_map.

> +	}
> +
> +	adap = &i2c_dev->adap;
> +	i2c_set_adapdata(adap, i2c_dev);
> +	snprintf(adap->name, sizeof(adap->name), "STM32 I2C(%pa)", &res->start);
> +	adap->owner = THIS_MODULE;
> +	adap->timeout = 2 * HZ;
> +	adap->retries = 0;
> +	adap->algo = &stm32f4_i2c_algo;
> +	adap->dev.parent = &pdev->dev;
> +	adap->dev.of_node = pdev->dev.of_node;
> +
> +	init_completion(&i2c_dev->complete);
> +
> +	ret = i2c_add_adapter(adap);
> +	if (ret)
> +		goto clk_free;
> +
> +	platform_set_drvdata(pdev, i2c_dev);
> +
> +	dev_info(i2c_dev->dev, "STM32F4 I2C driver initialized\n");

This is wrong. The driver is bound now to a device, not initialized.

> +static const struct of_device_id stm32f4_i2c_match[] = {
> +	{ .compatible = "st,stm32f4-i2c", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, stm32f4_i2c_match);
> +
> +static struct platform_driver stm32f4_i2c_driver = {
> +	.driver = {
> +		.name = "stm32f4-i2c",
> +		.of_match_table = stm32f4_i2c_match,

Is this needed?

> +	},
> +	.probe = stm32f4_i2c_probe,
> +	.remove = stm32f4_i2c_remove,
> +};

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
