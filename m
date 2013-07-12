From: monstr@monstr.eu (Michal Simek)
Date: Fri, 12 Jul 2013 14:08:10 +0200
Subject: [PATCH v2 2/2] clocksource/cadence_ttc: Reuse clocksource as
 sched_clock
In-Reply-To: <1373302298-27957-3-git-send-email-soren.brinkmann@xilinx.com>
References: <1373302298-27957-1-git-send-email-soren.brinkmann@xilinx.com>
 <1373302298-27957-3-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <51DFF1AA.8080407@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/2013 06:51 PM, Soren Brinkmann wrote:
> Reuse the TTC clocksource timer as sched clock provider.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
> v2:
>  - #include linux/sched_clock.h instead of asm/sched_clock.h
>  - remove Kconfig options and #ifdefs around sched_clock related code
>     The reasons for having those are obsolete, since ARM deprecated its
>     custom sched_clock framework and migrated to the common one.
> 
>  drivers/clocksource/cadence_ttc_timer.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/clocksource/cadence_ttc_timer.c b/drivers/clocksource/cadence_ttc_timer.c
> index 0eefc8d..b2bb3a4b 100644
> --- a/drivers/clocksource/cadence_ttc_timer.c
> +++ b/drivers/clocksource/cadence_ttc_timer.c
> @@ -21,6 +21,7 @@
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  #include <linux/slab.h>
> +#include <linux/sched_clock.h>
>  
>  /*
>   * This driver configures the 2 16-bit count-up timers as follows:
> @@ -94,6 +95,8 @@ struct ttc_timer_clockevent {
>  #define to_ttc_timer_clkevent(x) \
>  		container_of(x, struct ttc_timer_clockevent, ce)
>  
> +static void __iomem *ttc_sched_clock_val_reg;
> +
>  /**
>   * ttc_set_interval - Set the timer interval value
>   *
> @@ -155,6 +158,11 @@ static cycle_t __ttc_clocksource_read(struct clocksource *cs)
>  				TTC_COUNT_VAL_OFFSET);
>  }
>  
> +static u32 notrace ttc_sched_clock_read(void)
> +{
> +	return __raw_readl(ttc_sched_clock_val_reg);
> +}
> +
>  /**
>   * ttc_set_next_event - Sets the time interval for next event
>   *
> @@ -296,6 +304,10 @@ static void __init ttc_setup_clocksource(struct clk *clk, void __iomem *base)
>  		kfree(ttccs);
>  		return;
>  	}
> +
> +	ttc_sched_clock_val_reg = base + TTC_COUNT_VAL_OFFSET;
> +	setup_sched_clock(ttc_sched_clock_read, 16,
> +			clk_get_rate(ttccs->ttc.clk) / PRESCALE);
>  }
>  
>  static int ttc_rate_change_clockevent_cb(struct notifier_block *nb,
> 

Acked-by: Michal Simek <monstr@monstr.eu>

Thomas, John: Can you please add this patch to your queue?
IRC all these timer patches should go through your trees.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130712/bdcd7113/attachment.sig>
