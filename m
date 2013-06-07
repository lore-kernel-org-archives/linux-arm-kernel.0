From: john.stultz@linaro.org (John Stultz)
Date: Fri, 07 Jun 2013 09:47:26 -0700
Subject: [PATCH 1/1] ARM: imx: clk-pllv3: change wait method for PLL lock
In-Reply-To: <20130606121647.GR23140@pengutronix.de>
References: <1370501726-7421-1-git-send-email-peter.chen@freescale.com>
 <20130606121647.GR23140@pengutronix.de>
Message-ID: <51B20E9E.8070507@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2013 05:16 AM, Uwe Kleine-K?nig wrote:
> Hello
>
> [added jstultz to Cc:]
>
> On Thu, Jun 06, 2013 at 02:55:26PM +0800, Peter Chen wrote:
>> For tickless system, the jiffies may be updated long time (>20ms).
> ... may not be updated for a long time ... ?
>
>> At high loading system, the current waiting method will cause waiting
>> timeout, and cause a kernel dump at below case.
>> After timeout = jiffies + msecs_to_jiffies(10),
>> the timer interrupt occurs, it updates jiffies (eg,  + 2 jiffies),
>> then return back from interrupt, the time between above operations
>> are tiny, the PLL is still not locked, but the timeout condition is satisfied.
> Hmm, I admit I didn't follow the tickless stuff, but still I wonder if
> the analysis is right. I thought on tickless jiffies are updated as
> before by the boot cpu that cannot run in tickless mode?
>
> Anyhow, this only affects the commit log, not the problem.
>   
>> Signed-off-by: Peter Chen <peter.chen@freescale.com>
>> ---
>>   arch/arm/mach-imx/clk-pllv3.c |    9 ++++++---
>>   1 files changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-imx/clk-pllv3.c b/arch/arm/mach-imx/clk-pllv3.c
>> index 36aac94..eefc6c2 100644
>> --- a/arch/arm/mach-imx/clk-pllv3.c
>> +++ b/arch/arm/mach-imx/clk-pllv3.c
>> @@ -16,6 +16,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/jiffies.h>
>>   #include <linux/err.h>
>> +#include <linux/delay.h>
>>   #include "clk.h"
>>   
>>   #define PLL_NUM_OFFSET		0x10
>> @@ -50,7 +51,7 @@ struct clk_pllv3 {
>>   static int clk_pllv3_prepare(struct clk_hw *hw)
>>   {
>>   	struct clk_pllv3 *pll = to_clk_pllv3(hw);
>> -	unsigned long timeout = jiffies + msecs_to_jiffies(10);
>> +	int count = 100;
>>   	u32 val;
>>   
>>   	val = readl_relaxed(pll->base);
>> @@ -62,9 +63,11 @@ static int clk_pllv3_prepare(struct clk_hw *hw)
>>   	writel_relaxed(val, pll->base);
>>   
>>   	/* Wait for PLL to lock */
>> -	while (!(readl_relaxed(pll->base) & BM_PLL_LOCK))
>> -		if (time_after(jiffies, timeout))
>> +	while (!(readl_relaxed(pll->base) & BM_PLL_LOCK)) {
>> +		udelay(100);
>> +		if (--count == 0)
>>   			return -ETIMEDOUT;
>> +	}
> Maybe it's enough to do timeout = jiffies + msecs_to_jiffies(10); just
> after the pll is reprogrammed? i.e.
>
> diff --git a/arch/arm/mach-imx/clk-pllv3.c b/arch/arm/mach-imx/clk-pllv3.c
> index d09bc3d..37f734e 100644
> --- a/arch/arm/mach-imx/clk-pllv3.c
> +++ b/arch/arm/mach-imx/clk-pllv3.c
> @@ -48,7 +48,7 @@ struct clk_pllv3 {
>   static int clk_pllv3_prepare(struct clk_hw *hw)
>   {
>   	struct clk_pllv3 *pll = to_clk_pllv3(hw);
> -	unsigned long timeout = jiffies + msecs_to_jiffies(10);
> +	unsigned long timeout;
>   	u32 val;
>   
>   	val = readl_relaxed(pll->base);
> @@ -59,6 +59,8 @@ static int clk_pllv3_prepare(struct clk_hw *hw)
>   		val &= ~BM_PLL_POWER;
>   	writel_relaxed(val, pll->base);
>   
> +	timeout = jiffies + msecs_to_jiffies(10);
> +
>   	/* Wait for PLL to lock */
>   	while (!(readl_relaxed(pll->base) & BM_PLL_LOCK))
>   		if (time_after(jiffies, timeout))
>
> Then at least the pll tries to look while the process is interrupted.
>
> What is msecs_to_jiffies(10) for you? John, would you expect the problem
> here that Peter describes?

No, I'm not sure I see how being tickless would cause such a problem 
(Adding Frederic here in case he spots something).

The only issues that pop up for me right away is:
1) The one Uwe noted, where jiffies may be incremented from the early 
timeout assignment to before the wait loop begins.

2) That at HZ=100, msecs_to_jiffies(10) is just 1, so if you were to 
catch jiffies right before it was updated, you would end up waiting only 
10ms before timing out. That's still seems like plenty of time, but I 
don't know the hardware details here.

thanks
-john
