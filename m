From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 9 Aug 2011 16:57:03 -0500
Subject: [PATCH] ep93xx: clock.c: fix all checkpatch.pl issues
In-Reply-To: <4E41AAE1.7010008@gmail.com>
References: <201108091411.32479.hartleys@visionengravers.com>
	<4E41AAE1.7010008@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F38838949F@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, August 09, 2011 2:47 PM, Ryan Mallon wrote:
> On 10/08/11 07:11, H Hartley Sweeten wrote:
>> This fixes all the checkpatch.pl errors and warnings found in this file.
>>
>>   #201: ERROR: space required after that ',' (ctx:VxV)
>>   #201: ERROR: space required after that ',' (ctx:VxV)
>>   #250: WARNING: line over 80 characters
>>   #281: WARNING: line over 80 characters
>>   #361: WARNING: line over 80 characters
>>   #435: ERROR: trailing whitespace
>>   #438: ERROR: trailing whitespace
>>   #449: ERROR: trailing whitespace
>>   #451: ERROR: trailing whitespace
>>
>>   total: 6 errors, 3 warnings, 562 lines checked
>>
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>> Cc: Ryan Mallon <rmallon@gmail.com>
>>
>> ---
>>
>> diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
>> index ca4de71..14dba95 100644
>> --- a/arch/arm/mach-ep93xx/clock.c
>> +++ b/arch/arm/mach-ep93xx/clock.c
>> @@ -198,7 +198,7 @@ static struct clk clk_m2m1 = {
>>  	.enable_mask	= EP93XX_SYSCON_PWRCNT_DMA_M2M1,
>>  };
>>  
>> -#define INIT_CK(dev,con,ck)					\
>> +#define INIT_CK(dev, con, ck)					\
>>  	{ .dev_id = dev, .con_id = con, .clk = ck }
>
> Okay.

OK.

>
>>  
>>  static struct clk_lookup clocks[] = {
>> @@ -247,7 +247,8 @@ static void __clk_enable(struct clk *clk)
>>  			v = __raw_readl(clk->enable_reg);
>>  			v |= clk->enable_mask;
>>  			if (clk->sw_locked)
>> -				ep93xx_syscon_swlocked_write(v, clk->enable_reg);
>> +				ep93xx_syscon_swlocked_write(v,
>> +
>
> I think this makes the code arguably less readable. The line only just
> extends over 80 characters.

See the comment below.

>> 						clk->enable_reg);
>>  			else
>>  				__raw_writel(v, clk->enable_reg);
>>  		}
>> @@ -278,7 +279,8 @@ static void __clk_disable(struct clk *clk)
>>  			v = __raw_readl(clk->enable_reg);
>>  			v &= ~clk->enable_mask;
>>  			if (clk->sw_locked)
>> -				ep93xx_syscon_swlocked_write(v, clk->enable_reg);
>> +				ep93xx_syscon_swlocked_write(v,
>> +						clk->enable_reg);
>
> Same here.

The other way to fix both of these is to add a return on the clk->users check
preceding the set/clear of the enable register.

Currently they are coded like this:

static void __clk_enable(struct clk *clk)
{
	if (!clk->users++) {
		...
	}
}

static void __clk_disable(struct clk *clk)
{
	if (!--clk->users) {
		...
	}
}

Both the over 80 character lines could be brought back a full tab by doing:

static void __clk_enable(struct clk *clk)
{
	if (clk->users++)
		return;

	...
}

static void __clk_disable(struct clk *clk)
{
	if (--clk->users)
		return;

	...
}

Are you ok with that change or should I just leave the over 80 char lines?

>>  			else
>>  				__raw_writel(v, clk->enable_reg);
>>  		}
>> @@ -358,7 +360,7 @@ static int calc_clk_div(struct clk *clk, unsigned long rate,
>>  	int i, found = 0, __div = 0, __pdiv = 0;
>>  
>>  	/* Don't exceed the maximum rate */
>> -	max_rate = max3(clk_pll1.rate / 4, clk_pll2.rate / 4, clk_xtali.rate / 4);
>> +	max_rate = max3(clk_pll1.rate/4, clk_pll2.rate/4, clk_xtali.rate/4);
>
> Don't delete the spaces around the operators. Again, this line is only
> just over 80 characters. I think its okay as is. If you must fix it,
> break on one of the commas instead.

I'll break the line at a comma.  I'm really trying to get ep93xx checkpatch clean.

>>  	rate = min(rate, max_rate);
>>  
>>  	/*
>> @@ -432,35 +434,32 @@ static int set_i2s_sclk_rate(struct clk *clk, unsigned long rate)
>>  	unsigned val = __raw_readl(clk->enable_reg);
>>  
>>  	if (rate == clk_i2s_mclk.rate / 2)
>> -		ep93xx_syscon_swlocked_write(val & ~EP93XX_I2SCLKDIV_SDIV, 
>> -					     clk->enable_reg);
>> +		val &= ~EP93XX_I2SCLKDIV_SDIV;
>>  	else if (rate == clk_i2s_mclk.rate / 4)
>> -		ep93xx_syscon_swlocked_write(val | EP93XX_I2SCLKDIV_SDIV, 
>> -					     clk->enable_reg);
>> +		val |= EP93XX_I2SCLKDIV_SDIV;
>>  	else
>>  		return -EINVAL;
>>  
>> +	ep93xx_syscon_swlocked_write(val, clk->enable_reg);
>>  	clk_i2s_sclk.rate = rate;
>>  	return 0;
>
> This change is good.

OK.

>>  }
>>  
>>  static int set_i2s_lrclk_rate(struct clk *clk, unsigned long rate)
>>  {
>> -	unsigned val = __raw_readl(clk->enable_reg) & 
>> +	unsigned val = __raw_readl(clk->enable_reg) &
>>  		~EP93XX_I2SCLKDIV_LRDIV_MASK;
>> -	
>> +
>>  	if (rate == clk_i2s_sclk.rate / 32)
>> -		ep93xx_syscon_swlocked_write(val | EP93XX_I2SCLKDIV_LRDIV32,
>> -					     clk->enable_reg);
>> +		val |= EP93XX_I2SCLKDIV_LRDIV32;
>>  	else if (rate == clk_i2s_sclk.rate / 64)
>> -		ep93xx_syscon_swlocked_write(val | EP93XX_I2SCLKDIV_LRDIV64,
>> -					     clk->enable_reg);
>> +		val |= EP93XX_I2SCLKDIV_LRDIV64;
>>  	else if (rate == clk_i2s_sclk.rate / 128)
>> -		ep93xx_syscon_swlocked_write(val | EP93XX_I2SCLKDIV_LRDIV128,
>> -					     clk->enable_reg);
>> +		val |= EP93XX_I2SCLKDIV_LRDIV128;
>>  	else
>>  		return -EINVAL;
>>  
>> +	ep93xx_syscon_swlocked_write(val, clk->enable_reg);
>>  	clk_i2s_lrclk.rate = rate;
>>  	return 0;
>>  }
> This is good too.

OK.

Thanks,
Hartley
