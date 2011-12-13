From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 13 Dec 2011 10:54:14 +0530
Subject: [PATCH 3/4] ARM: smp_twd: get the rate from a clock
In-Reply-To: <1323683847-23902-1-git-send-email-linus.walleij@stericsson.com>
References: <1323683847-23902-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4EE6E17E.5040902@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

On Monday 12 December 2011 03:27 PM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This break-out from Colin Cross' cpufreq-aware TWD patch will
> optionally retrieve the clock rate of the TWD from an external
> clock. A variant of this patch has been proposed by Rob Herring
> as well.
> 
> The basic idea is to avoid recalibrating the rate of the clock
> at boot if the platform already know what rate the clock to the
> TWD block has.
> 
> Signed-off-by: Colin Cross <ccross@android.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Rob Herring <rob.herring@calxeda.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> [Broke out of larger SMP TWD patch]
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/kernel/smp_twd.c |   32 +++++++++++++++++++++++++++++++-
>  1 files changed, 31 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
> index 20cce4e..a13e1c0 100644
> --- a/arch/arm/kernel/smp_twd.c
> +++ b/arch/arm/kernel/smp_twd.c
> @@ -10,8 +10,10 @@
>   */
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> +#include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
> +#include <linux/err.h>
>  #include <linux/smp.h>
>  #include <linux/jiffies.h>
>  #include <linux/clockchips.h>
> @@ -26,6 +28,7 @@
>  /* set up by the platform code */
>  void __iomem *twd_base;
>  
> +static struct clk *twd_clk;
>  static unsigned long twd_timer_rate;
>  static DEFINE_PER_CPU(struct clock_event_device *, twd_ce);
>  
> @@ -142,6 +145,27 @@ static irqreturn_t twd_handler(int irq, void *dev_id)
>  	return IRQ_NONE;
>  }
>  
> +static struct clk *twd_get_clock(void)
> +{
> +	struct clk *clk;
> +	int err;
> +
> +	clk = clk_get_sys("smp_twd", NULL);

As noticed by Mike, would be better to use con_id instead
of dev_id here. I mean,
clk = clk_get_sys(NULL, "smp_twd");

The OMAP4 clock node patch thinking you have used
con_id to get the twd clock node.
Let me know your plan to change it or keep it as is.

Regards
Santosh

Let me know if you plan to change as above or
retain
