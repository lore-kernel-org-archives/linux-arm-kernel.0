From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 17 Jan 2017 20:37:52 +0100
Subject: [PATCH v9 2/5] i2c: Add STM32F4 I2C driver
In-Reply-To: <1484666821-20551-3-git-send-email-cedric.madianga@gmail.com>
References: <1484666821-20551-1-git-send-email-cedric.madianga@gmail.com>
 <1484666821-20551-3-git-send-email-cedric.madianga@gmail.com>
Message-ID: <20170117193752.e6hju25w74bb4i4z@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Jan 17, 2017 at 04:26:58PM +0100, M'boumba Cedric Madianga wrote:
> +static void stm32f4_i2c_set_rise_time(struct stm32f4_i2c_dev *i2c_dev)
> +{
> +	u32 freq = DIV_ROUND_UP(i2c_dev->parent_rate, HZ_TO_MHZ);
> +	u32 trise;
> +
> +	/*
> +	 * These bits must be programmed with the maximum SCL rise time given in
> +	 * the I2C bus specification, incremented by 1.
> +	 *
> +	 * In standard mode, the maximum allowed SCL rise time is 1000 ns.
> +	 * If, in the I2C_CR2 register, the value of FREQ[5:0] bits is equal to
> +	 * 0x08 so period = 125 ns therefore the TRISE[5:0] bits must be
> +	 * programmed with 09h.(1000 ns / 125 ns = 8 + 1)

	* programmed with 0x9. (1000 ns / 125 ns = 8)

> +	 * So, for I2C standard mode TRISE = FREQ[5:0] + 1
> +	 *
> +	 * In fast mode, the maximum allowed SCL rise time is 300 ns.
> +	 * If, in the I2C_CR2 register, the value of FREQ[5:0] bits is equal to
> +	 * 0x08 so period = 125 ns therefore the TRISE[5:0] bits must be
> +	 * programmed with 03h.(300 ns / 125 ns = 2 + 1)

as above s/03h/0x3/; s/.(/. (/; s/+ 1//;

> +	 * So, for I2C fast mode TRISE = FREQ[5:0] * 300 / 1000 + 1
> +	 */
> +	if (i2c_dev->speed == STM32F4_I2C_SPEED_STANDARD)
> +		trise = freq + 1;
> +	else
> +		trise = freq * 300 / 1000 + 1;

I'd use

	* 3 / 10

without downside and lesser chance to overflow.

> +
> +	writel_relaxed(STM32F4_I2C_TRISE_VALUE(trise),
> +		       i2c_dev->base + STM32F4_I2C_TRISE);
> +}
> +
> +static void stm32f4_i2c_set_speed_mode(struct stm32f4_i2c_dev *i2c_dev)
> +{
> +	u32 val;
> +	u32 ccr = 0;
> +
> +	if (i2c_dev->speed == STM32F4_I2C_SPEED_STANDARD) {
> +		/*
> +		 * In standard mode:
> +		 * t_scl_high = t_scl_low = CCR * I2C parent clk period
> +		 * So to reach 100 kHz, we have:
> +		 * CCR = I2C parent rate / 100 kHz >> 1
> +		 *
> +		 * For example with parent rate = 2 MHz:
> +		 * CCR = 2000000 / (100000 << 1) = 10
> +		 * t_scl_high = t_scl_low = 10 * (1 / 2000000) = 5000 ns
> +		 * t_scl_high + t_scl_low = 10000 ns so 100 kHz is reached
> +		 */
> +		val = i2c_dev->parent_rate / (100000 << 1);
> +	} else {
> +		/*
> +		 * In fast mode, we compute CCR with duty = 0 as with low
> +		 * frequencies we are not able to reach 400 kHz.
> +		 * In that case:
> +		 * t_scl_high = CCR * I2C parent clk period
> +		 * t_scl_low = 2 * CCR * I2C parent clk period
> +		 * So, CCR = I2C parent rate / (400 kHz * 3)
> +		 *
> +		 * For example with parent rate = 6 MHz:
> +		 * CCR = 6000000 / (400000 * 3) = 5
> +		 * t_scl_high = 5 * (1 / 6000000) = 833 ns > 600 ns
> +		 * t_scl_low = 2 * 5 * (1 / 6000000) = 1667 ns > 1300 ns
> +		 * t_scl_high + t_scl_low = 2500 ns so 400 kHz is reached
> +		 */

Huh, that's surprising. So you don't use DUTY any more. I found two
hints in the manual that contradict here:

	f_{PCLK1} must be at least 2 MHz to achieve Sm mode I2C
	frequencies. It must be at least 4 MHz to achieve Fm mode I2C
	frequencies. It must be a multiple of 10MHz to reach the
	400 kHz maximum I2C Fm mode clock.

and

	[...]
	If DUTY = 1: (to reach 400 kHz)

Strange.

> +		val = DIV_ROUND_UP(i2c_dev->parent_rate, 400000 * 3);

the manual reads:

	The minimum allowed value is 0x04, except in FAST DUTY mode
	where the minimum allowed value is 0x01

You don't check for that, right?
CCR is 11 bits wide. A comment confirming that this cannot overflow
would be nice.

+		/* select Fast Mode */
> +		ccr |= STM32F4_I2C_CCR_FS;

I didn't check the rest of the code, so let's assume it's good :-)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
