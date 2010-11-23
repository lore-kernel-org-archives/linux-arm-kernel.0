From: gbean@codeaurora.org (Gregory Bean)
Date: Tue, 23 Nov 2010 15:08:05 -0800 (PST)
Subject: [PATCH v4 2/2] msm: gpio: Add irq support to v2 gpiolib.
In-Reply-To: <1290534717.4165.43.camel@m0nster>
References: <1290109970-26752-1-git-send-email-gbean@codeaurora.org>
	<1290109970-26752-2-git-send-email-gbean@codeaurora.org>
	<1290534717.4165.43.camel@m0nster>
Message-ID: <alpine.DEB.2.00.1011231456380.17082@gbean-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> +static inline void set_gpio_bits(unsigned n, void __iomem *reg)
>> +{
>> +	writel(readl(reg) | n, reg);
>> +}
>> +
>> +static inline void clr_gpio_bits(unsigned n, void __iomem *reg)
>> +{
>> +	writel(readl(reg) & ~n, reg);
>> +}
>
> It seems these functions actually accept output from BIT(). It would be
> safer to force these to accept the bit number then use BIT() inside this
> function to translate. That way you wouldn't use "unsigned n" for the
> argument you would use a named enum for the argument.

I don't think that will work well, because there are cases where we want
to set or clear more than one bit at a time.  Making these functions
take a bit number as an argument would restrict them to setting or clearing
only one bit at a time, forcing users to call them multiple times to set
or clear more than one bit, meaning lots of readl & writel calls for
compount bit-changes.

>> +static struct msm_gpio_dev msm_gpio = {
>> +	.gpio_chip = {
>> +		.base             = 0,
>
> I guess it's fine to do "offset - chip->base" if base is always zero,
> but why do subtraction at all.

If the chip is ever moved, not accounting for the base would produce an error.
I know that 'speculative coding' is frowned upon, but isn't removing an 
addition (as you pointed out, the subtraction is a bug) because this instance
of the chip is at offset zero a little over the top?

>> +	set_gpio_bits(INTR_RAW_STATUS_EN | INTR_ENABLE, GPIO_INTR_CFG(gpio));
>
> I's just break this into two calls, or make another helper that to set
> that accepts the mask and have set_gpio_bits call that. This here you
> would just use the other helper. like set_gpio_bits calls
> set_gpio_bits_mask() and you call the mask version here.

Why make two readl/writel call pairs, or have one version of a helper which
can set a single bit and another version which can set more than one
at a time?  That seems really complicated.

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
