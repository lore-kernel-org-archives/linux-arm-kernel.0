From: matt@grid-net.com (Matt Burtch)
Date: Thu, 20 Oct 2011 14:05:41 -0700
Subject: [ resend PATCH 1/1] ARM: i.MX28: shift frac value in _CLK_SET_RATE
In-Reply-To: <20111019065428.GQ18141@pengutronix.de>
References: <1318868745-19732-1-git-send-email-matt@grid-net.com>
	<20111019065428.GQ18141@pengutronix.de>
Message-ID: <4EA08D25.6090401@grid-net.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thank you Sascha, I'll be sure to double check the formatting next time.

-Matt

On 10/18/2011 11:54 PM, Sascha Hauer wrote:
> On Mon, Oct 17, 2011 at 09:25:45AM -0700, Matt Burtch wrote:
>> Fixed whitespace formatting per Shawn Guo.
>>
>> Noticed when setting SSP0 in clk_set_rate, _CLK_SET_RATE attempts to reset the clock divider for the SSP0 parent clock, in this case IO0FRAC. Bits 24-29 of HW_CLKCTRL_FRAC0 are cleared correctly, but when the new frac value is written the value isn't shifted up to write the correct bit-field.  This results in IO0FRAC being set to 0 and CPUFRAC being corrupted.
>>
> Please linebreak your commit messages at around 70 characters. Fixed
> this myself this time, but please remember for next time.
>
> Sascha
>
>> This should occur when writing IO1FRAC, EMIFRAC in HW_CLKCTRL_FRAC0 and GPMIFRAC, HSADCFRAC in HW_CLKCTRL_FRAC1.
>>
>> Tested on custom i.MX28 board with SSP0 SPI driver.
>>
>> Signed-off-by: Matt Burtch<matt@grid-net.com>
>> ---
>>   arch/arm/mach-mxs/clock-mx28.c |    2 +-
>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
>> index 5dcc59d..ba53227 100644
>> --- a/arch/arm/mach-mxs/clock-mx28.c
>> +++ b/arch/arm/mach-mxs/clock-mx28.c
>> @@ -349,7 +349,7 @@ static int name##_set_rate(struct clk *clk, unsigned long rate)		\
>>   									\
>>   		reg = __raw_readl(CLKCTRL_BASE_ADDR + HW_CLKCTRL_##fr);	\
>>   		reg&= ~BM_CLKCTRL_##fr##_##fs##FRAC;			\
>> -		reg |= frac;						\
>> +		reg |= frac<<  BP_CLKCTRL_##fr##_##fs##FRAC;		\
>>   		__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_##fr);	\
>>   	}								\
>>   									\
>> -- 
>> 1.7.1
>>
>>
