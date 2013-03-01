From: zonque@gmail.com (Daniel Mack)
Date: Fri, 01 Mar 2013 16:01:27 +0100
Subject: [PATCH] clk: add si5351 i2c common clock driver
In-Reply-To: <CABJ1b_TaQ=AXCM9KKW-hJ0Rgdd+759ia+9P=bdnYbA_HcHP1wQ@mail.gmail.com>
References: <1360414772-12232-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <5123CF5B.9060804@gmail.com>
 <CABJ1b_TaQ=AXCM9KKW-hJ0Rgdd+759ia+9P=bdnYbA_HcHP1wQ@mail.gmail.com>
Message-ID: <5130C2C7.30400@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On 27.02.2013 11:01, Sebastian Hesselbarth wrote:
> first of all sorry for the late answer but thanks for testing the driver.
> 
> On 2/19/13, Daniel Mack <zonque@gmail.com> wrote:
>> Hi Sebastian,
>>
>> I did some more tests today and it took me a while to dig for the root
>> cause why things were not working for me in the first place - see below.
>>
>>
>> On 09.02.2013 13:59, Sebastian Hesselbarth wrote:
>>
>>> +==Example==
>>> +
>>> +/* 25MHz reference crystal */
>>> +ref25: ref25M {
>>> +	compatible = "fixed-clock";
>>> +	#clock-cells = <0>;
>>> +	clock-frequency = <25000000>;
>>> +};
>>> +
>>> +i2c-master-node {
>>> +
>>> +	/* Si5351a msop10 i2c clock generator */
>>> +	si5351a: clock-generator at 60 {
>>> +		compatible = "silabs,si5351a-msop";
>>> +		reg = <0x60>;
>>> +		#address-cells = <1>;
>>> +		#size-cells = <0>;
>>> +		#clock-cells = <1>;
>>> +
>>> +		/* connect xtal input to 25MHz reference */
>>> +		clocks = <&ref25>;
>>
>> As referred to in another thread, registering the ref25M clock that way
>> didn't suffice for me on my platform - but that's a different story.
> 
> I guess "fixed-clock" isn't registered by OMAP's clock init code? I had
> to do this on dove, too. Actually, I will come back to clock initialization for
> dove later and was hoping that there will be some global way of registering
> core common clock drivers (or at least fixed-clock) until then.
> 
>>> +static void si5351_read_parameters(struct si5351_driver_data *drvdata,
>>> +	unsigned char reg, struct si5351_parameters *params)
>>> +{
>>> +	unsigned char buf[SI5351_PARAMETERS_LENGTH];
>>
>> On a general note, I think you can use u8 instead of unsigned char all
>> over the place here, which will save you some indentation trouble.
> 
> Ok, I guess I was deriving "unsigned char" usage from other clock drivers
> and never went to u8. But I ll reconsider using u8 when all issues are
> worked out.
> 
>>> +static inline int _si5351_clkout_reparent(struct si5351_driver_data
>>> *drvdata,
>>> +				  unsigned char num, unsigned char parent)
>>> +{
>>> +	struct clk *pclk;
>>> +
>>> +	if (num > 8 ||
>>> +	    (drvdata->variant == SI5351_VARIANT_A3 && num > 3))
>>> +		return -EINVAL;
>>> +
>>> +	switch (parent) {
>>> +	case 0:
>>> +		pclk = drvdata->msynth[num].hw.clk;
>>> +		break;
>>> +	case 1:
>>> +		pclk = drvdata->msynth[0].hw.clk;
>>> +		if (num >= 4)
>>> +			pclk = drvdata->msynth[4].hw.clk;
>>> +		break;
>>> +	case 2:
>>> +		pclk = drvdata->xtal.clk;
>>> +		break;
>>> +	case 3:
>>> +		if (drvdata->variant != SI5351_VARIANT_C)
>>> +			return -EINVAL;
>>> +		pclk = drvdata->clkin.clk;
>>> +		break;
>>> +	default:
>>> +		return -EINVAL;
>>> +	}
>>> +	return clk_set_parent(drvdata->clkout[num].hw.clk, pclk);
>>> +}
>>
>> [...]
>>
>>> +static int si5351_clkout_set_parent(struct clk_hw *hw, u8 index)
>>> +{
>>> +	struct si5351_hw_data *hwdata =
>>> +		container_of(hw, struct si5351_hw_data, hw);
>>> +	unsigned val;
>>> +
>>> +	val = 0;
>>> +	hw->clk->flags &= ~CLK_SET_RATE_PARENT;
>>> +	switch (index) {
>>> +	case 0:
>>> +		hw->clk->flags |= CLK_SET_RATE_PARENT;
>>> +		val = SI5351_CLK_INPUT_MULTISYNTH_N;
>>> +		break;
>>
>> I fugured that _si5351_clkout_reparent() wouldn't actually call
>> ->set_parent() on the clock, which leads to the fact that
>> CLK_SET_RATE_PARENT is not set in the flags. That way, only the clkout
>> end leaf is actually supplied with a new rate, which leads to incorrect
>> effective clocks, depending on the current multisynth/pll configuration.
> 
> Yeah, true. Unfortunately, _clkout_reparent() is more like a dirty hack to
> allow to reparent the clock output. At registration internal configuration of
> si5351 is not known and when I parse the DT for clock configuration I might
> have been already assigned to the same parent clk that you later explicitly
> configure.

Hmm, but then we need to either set the configuration on the chip to
match the internal state of the driver, or tell the clock framework that
the current state is not currently known (don't know if that's possible).

> What I basically want for si5351 (or any other eeprom based programmable
> clock gen) is that stored configuration is not touched. But it can be changed
> after eeprom contents have been copied into device's sram - and this _is_
> mandatory for the si5351 that I use on CuBox where there is no useful config
> stored at all.

Yes, same here. We set up the si5351 from the bootloader with some
binary blob via i2c to bring some components to live before the kernel
boots.

> Anyway, there still seem to be some more issues with doing it right on current
> common clk framwork - thanks for pointing it out.

I'd be happy to test more versions if you have any.

FWIW, attached is a patch for caching the 'prepared' states of the
clocks. This fixes the 'scheduling while atomic' bug I described earlier
in this thread. You can squash it into your patch if you want.



Thanks,
Daniel
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-si5351-cache-prepared-bits-of-clocks.patch
Type: text/x-patch
Size: 4908 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130301/a0e2ee23/attachment.bin>
