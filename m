From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue, 08 Jun 2010 10:21:53 +1200
Subject: [RFC PATCH v3 1/3] ep93xx i2s core support
In-Reply-To: <0D753D10438DA54287A00B0270842697636F83B425@AUSP01VMBX24.collaborationhost.net>
References: <1275628285-12642-1-git-send-email-ryan@bluewatersys.com>
	<1275628285-12642-2-git-send-email-ryan@bluewatersys.com>
	<0D753D10438DA54287A00B0270842697636F83B425@AUSP01VMBX24.collaborationhost.net>
Message-ID: <4C0D7101.6030506@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H Hartley Sweeten wrote:
> On Thursday, June 03, 2010 10:11 PM, Ryan Mallon wrote:
>> Add ep93xx core support for i2s audio
>>
>> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
>> ---
>>  arch/arm/mach-ep93xx/clock.c                    |   69 ++++++++++++++++++++++-
>>  arch/arm/mach-ep93xx/core.c                     |   31 ++++++++++
>>  arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |   10 +++
>>  arch/arm/mach-ep93xx/include/mach/platform.h    |    1 +
>>  4 files changed, 110 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
>> index 5f80092..503d430 100644
>> --- a/arch/arm/mach-ep93xx/clock.c
>> +++ b/arch/arm/mach-ep93xx/clock.c
>> @@ -43,7 +43,8 @@ static unsigned long get_uart_rate(struct clk *clk);
>>  
>>  static int set_keytchclk_rate(struct clk *clk, unsigned long rate);
>>  static int set_div_rate(struct clk *clk, unsigned long rate);
>> -
>> +static int set_i2s_sclk_rate(struct clk *clk, unsigned long rate);
>> +static int set_i2s_lrclk_rate(struct clk *clk, unsigned long rate);
>>  
>>  static struct clk clk_xtali = {
>>  	.rate		= EP93XX_EXT_CLK_RATE,
>> @@ -108,6 +109,31 @@ static struct clk clk_video = {
>>  	.set_rate	= set_div_rate,
>>  };
>>  
>> +static struct clk clk_i2s_mclk = {
>> +	.sw_locked	= 1,
>> +	.enable_reg	= EP93XX_SYSCON_I2SCLKDIV,
>> +	.enable_mask	= (EP93XX_SYSCON_CLKDIV_ENABLE  |
>> +			   EP93XX_SYSCON_I2SCLKDIV_SPOL |
>> +			   EP93XX_SYSCON_I2SCLKDIV_ORIDE),
> 
> Setting the SPOL and ORIDE bits here might cause problems in the future.
> Granted, your i2s driver is currently the only user so its probably ok
> for now.
> 
> But, you might want to move the setting of those two bits along with the
> SLAVE and DROP bits to the core registration function.  The clock support
> should only be enabling/disabling and setting the rates for the clocks.

Okay, sounds sensible. Possibly I should add acquire/release functions
in addition to the register, something like:

void __init ep93xx_register_i2s(void)
{
	platform_device_register(&ep93xx_i2s_device);
}

int ep93xx_i2s_acquire(unsigned pins, int override, int sclk_falling)
{
	unsigned set_bits = pins,
		 clear_bits = EP93XX_SYSCON_DEVCFG_I2SONSSP |
			      EP93XX_SYSCON_DEVCFG_I2SONAC97;

	if (pins != EP93XX_SYSCON_DEVCFG_I2SONSSP &&
	    pins != EP93XX_SYSCON_DEVCFG_I2SONAC97)
		return -EINVAL;

	if (override)
		set_bits |= EP93XX_SYSCON_I2SCLKDIV_ORIDE;
	else
		clear_bits |= EP93XX_SYSCON_I2SCLKDIV_ORIDE;

	if (sclk_falling)
		set_bits |= EP93XX_SYSCON_I2SCLKDIV_SPOL;
	else
		clear_bits |= EP93XX_SYSCON_I2SCLKDIV_SPOL;

	ep93xx_devcfg_clear_bits(clear_bits);
	ep93xx_devcfg_set_bits(set_bits);
	return 0;
}

>> +	.set_rate	= set_div_rate,
> 
> By calling the set_div_rate routine your only updating the master clock
> rate.  Should the new rate be pushed down to the children?  Actually the
> new rates for the children will be established automatically when the
> master clock rate is changed.  But a clk_get_rate for the children will
> return an incorrect value.  Maybe just add a get_rate method for the
> children?

The code basically assumes that the clocks will always be set in the
order: mclk, sclk, lrclk. Since the i2s driver is the only user, this
should be a valid assumption. Possibly a comment should be put in to
state that this assumption is made.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
