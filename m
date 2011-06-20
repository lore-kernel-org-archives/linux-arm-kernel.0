From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 20 Jun 2011 10:05:55 +0100
Subject: [PATCH] clocksource/arm_smp_twd: handle frequency changes
In-Reply-To: <1308559687-30768-1-git-send-email-linus.walleij@stericsson.com>
References: <1308559687-30768-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4DFF0D73.3080604@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/06/11 09:48, Linus Walleij wrote:
> From: Colin Cross <ccross@android.com>
> 
> First add a clock called "smp_twd" that is used to determine the
> twd frequency, which can also be used at init time to avoid
> calibrating the twd frequency since we already know it.
> 
> Then the localtimer's clock changes with the cpu clock, since the
> block has only one clock input. After a cpufreq transition, update
> the clockevent's frequency and reprogram the next clock event
> so we stay tight on the scheduled timeline.
> 
> Clock changes are based on Rob Herring's work.
> 
> This patch depends on the whole localtimer rewrite and move
> shebang from Marc Zyngier, and that in turn depends on other
> stuff.
> 
> Signed-off-by: Colin Cross <ccross@android.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Rob Herring <rob.herring@calxeda.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> [ifdef:ed CPUfreq stuff - rebased to Marc Z patches]
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Marc, if you're pursuing this series, consider merging this on top,
> it is needed for the new ARM A9 small-form factor reference platform
> whatever it is called.

Thanks Linus. I'll push this on top of my patch stack, with the below fix:

> ---
>  drivers/clocksource/arm_smp_twd.c |   89 ++++++++++++++++++++++++++++++++++---
>  1 files changed, 83 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clocksource/arm_smp_twd.c b/drivers/clocksource/arm_smp_twd.c
> index 5e2e8cc..a18ac0d 100644
> --- a/drivers/clocksource/arm_smp_twd.c
> +++ b/drivers/clocksource/arm_smp_twd.c
> @@ -19,6 +19,10 @@
>  #include <linux/interrupt.h>
>  #include <linux/ioport.h>
>  #include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/cpufreq.h
                           ^^ >

> +#include <linux/err.h>
> +#include <linux/percpu.h>

Cheers,

	M.
-- 
Jazz is not dead. It just smells funny...
