From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 26 Sep 2013 15:29:37 -0300
Subject: [PATCH 1/5] clk: mvebu: Add core-divider clock
In-Reply-To: <20130926082404.GA18244@lunn.ch>
References: <1380144502-24109-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130925213730.GA19371@localhost> <20130926082404.GA18244@lunn.ch>
Message-ID: <20130926182936.GA7772@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Andrew,

On Thu, Sep 26, 2013 at 10:24:04AM +0200, Andrew Lunn wrote:
> 
> +   /*
> +    * Wait for clocks to settle down, and then clear all the
> +     * ratios request and the reload request.
> +      */
> +      udelay(1000);
> +      reg &= ~(CORE_CLOCK_DIVIDER_RATIO_MASK | CORE_CLOCK_DIVIDER_RATIO_RELOAD);
> +      writel(reg, corediv->reg);
> +      udelay(1000);
> 
> 
> Documentation/timers/timers-howto.txt says: 
> 
>        SLEEPING FOR ~USECS OR SMALL MSECS ( 10us - 20ms):
>        		* Use usleep_range
> 

Given the set_rate should be protected by spinlocks (as you pointed out),
I guess we can't afford using usleep_range (the context is now non-atomic).

Now, according to arch/arm/include/asm/delay.h this is the suggestion
for udelay and friends:

 * Use only for very small delays ( < 2 msec).  Should probably use a
 * lookup table, really, as the multiplications take much too long with
 * short delays.  This is a "reasonable" implementation, though (and
 * the first constant multiplications gets optimized away if the delay is
 * a constant)  

Which means we could just use udelay(1000) without much trouble.

On the other side, since we know the rate the clock is running, we could
use __delay() just as drivers/clk/sunxi/clk-factors.c is doing.
__delay() has a much simpler implementation, which feels correct in
this case of "wait until the clock settles".

Therefore, I'm currently going to try that option.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
