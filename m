From: pierre-yves.mordret@st.com (Pierre Yves MORDRET)
Date: Thu, 14 Sep 2017 10:11:11 +0200
Subject: [RESEND PATCH v3 3/5] i2c: i2c-stm32f7: add driver
In-Reply-To: <20170913212639.2zyvg24364ovwfxh@ninjato>
References: <1504251255-20469-1-git-send-email-pierre-yves.mordret@st.com>
 <1504251255-20469-4-git-send-email-pierre-yves.mordret@st.com>
 <20170913212639.2zyvg24364ovwfxh@ninjato>
Message-ID: <63ecfac9-990b-e6c5-d9bf-7708bacc10d2@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/13/2017 11:26 PM, Wolfram Sang wrote:
> Hi,
> 
> thanks for this driver!
> 
>> +/**
>> + * struct stm32f7_i2c_spec - private i2c specification timing
>> + * @rate: I2C bus speed (Hz)
>> + * @rate_min: 80% of I2C bus speed (Hz)
>> + * @rate_max: 120% of I2C bus speed (Hz)
> 
> You would generate a clock which is higher than the requested one?
> This is highly unusual. Any special reason?

Well. I allow the clock to be higher than expected.
Looking at I2C spec again it turns out the mode specifies the max: no overshoot
of the clock. I will lock max to 100% then.
Will be fixed

> 
>> + * @fall_max: Max fall time of both SDA and SCL signals (ns)
>> + * @rise_max: Max rise time of both SDA and SCL signals (ns)
>> + * @hddat_min: Min data hold time (ns)
>> + * @vddat_max: Max data valid time (ns)
>> + * @sudat_min: Min data setup time (ns)
>> + * @l_min: Min low period of the SCL clock (ns)
>> + * @h_min: Min high period of the SCL clock (ns)
>> + */
>> +static struct stm32f7_i2c_spec i2c_specs[] = {
>> +	[STM32_I2C_SPEED_STANDARD] = {
>> +		.rate = 100000,
>> +		.rate_min = 8000,
> 
> This is not 80%. Typo?

Yep. This is a typo

> 
>> +		.rate_max = 120000,
>> +		.fall_max = 300,
>> +		.rise_max = 1000,
>> +		.hddat_min = 0,
>> +		.vddat_max = 3450,
>> +		.sudat_min = 250,
>> +		.l_min = 4700,
>> +		.h_min = 4000,
>> +	},
> 
> ...
> 
>> +	/*
>> +	 * Among Prescaler possibilities discovered above figures out SCL Low
>> +	 * and High Period. Provided:
>> +	 * - SCL Low Period has to be higher than Low Period of tehs SCL Clock
> 
> tehs?

Oops.

> 
>> +	 *   defined by I2C Specification. I2C Clock has to be lower than
>> +	 *   (SCL Low Period - Analog/Digital filters) / 4.
>> +	 * - SCL High Period has to be lower than High Period of the SCL Clock
>> +	 *   defined by I2C Specification
>> +	 * - I2C Clock has to be lower than SCL High Period
>> +	 */
> 
> ...
> 
>> +	/* NACK received */
>> +	if (status & STM32F7_I2C_ISR_NACKF) {
>> +		dev_dbg(i2c_dev->dev, "<%s>: Receive NACK\n", __func__);
>> +		writel_relaxed(STM32F7_I2C_ICR_NACKCF, base + STM32F7_I2C_ICR);
>> +		f7_msg->result = -EBADE;
> 
> -ENXIO (see Documentation/i2c/fault-codes)

OK

> 
> ...
> 
>> +	timeout = wait_for_completion_timeout(&i2c_dev->complete,
>> +					      i2c_dev->adap.timeout);
>> +	ret = f7_msg->result;
>> +
>> +	if (!timeout) {
>> +		dev_dbg(i2c_dev->dev, "Access to slave 0x%x timed out\n",
>> +			i2c_dev->msg->addr);
>> +		ret = -ETIMEDOUT;
>> +	}
> 
> Could you rename the variable to time_left? It looks strange, basically:
> 
> 	if (!timeout)
> 		return -ETIMEDOUT
> 

okay

> ...
> 
>> +	adap->retries = 0;
> 
> Why no retries when you check for arbitration lost?
> 
>> +	adap->algo = &stm32f7_i2c_algo;
>> +	adap->dev.parent = &pdev->dev;
>> +	adap->dev.of_node = pdev->dev.of_node;
>> +
>> +	init_completion(&i2c_dev->complete);
>> +
>> +	ret = i2c_add_adapter(adap);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Failed to add adapter\n");
> 
> Please remove, the core will print info when adding fails.
> 

I will

> 
> Rest looks good!

Great !

> 
> Thanks,
> 
>    Wolfram
> 

Thanks
