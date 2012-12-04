From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 4 Dec 2012 15:44:59 +0000
Subject: [PATCH v2 1/4] ARM: imx: allow timer counter to roll over
In-Reply-To: <1354632915-27134-2-git-send-email-shawn.guo@linaro.org>
References: <1354632915-27134-1-git-send-email-shawn.guo@linaro.org>
 <1354632915-27134-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20121204154459.GG14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 04, 2012 at 10:55:12PM +0800, Shawn Guo wrote:
> The timer is configured in free-run mode.  The counter should be
> allowed to roll over to 0 when reaching 0xffffffff.  Let's do that
> by always returning 0 in set_next_event.

Are you sure this is correct?  It looks wrong to me.

If the time set by the next event has passed, you must return -ETIME
from set_next_event() so that the generic timer code can compensate
for the missed event and recalculate it, otherwise you will end up
having to wait a full count cycle before receiving the next event.

If you find that you're being passed such a small increment that you're
constantly hitting that condition, you need to increase your minimum
waited interval.


> diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
> index f017302..858098c 100644
> --- a/arch/arm/mach-imx/time.c
> +++ b/arch/arm/mach-imx/time.c
> @@ -139,8 +139,7 @@ static int mx1_2_set_next_event(unsigned long evt,
>  
>  	__raw_writel(tcmp, timer_base + MX1_2_TCMP);
>  
> -	return (int)(tcmp - __raw_readl(timer_base + MX1_2_TCN)) < 0 ?
> -				-ETIME : 0;
> +	return 0;

So what this code was doing is: tcmp is the counter value we expect with
the expected event time added.  This may wrap 32-bits.  We subtract the
current timer value after we've set the compare register.  If the current
timer value was larger than the expected event time, we return -ETIME.

That to me sounds 100% correct.  Your replacement code of always returning
zero looks wrong.
