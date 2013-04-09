From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Apr 2013 15:44:32 +0200
Subject: [GIT PULL 3/8] ARM: tegra: cleanup
In-Reply-To: <1365181426-11547-3-git-send-email-swarren@wwwdotorg.org>
References: <1365181426-11547-1-git-send-email-swarren@wwwdotorg.org>
 <1365181426-11547-3-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201304091544.32377.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 April 2013, Stephen Warren wrote:
> This branch includes various cleanup of the core Tegra support.
> 
> * Unification of the separate board-dt-tegra*.c files into a single
>   tegra.c, now that everything is DT-driven and basically identical.
> * Use of_clk_get() in the Tegra clocksource driver so that clocks are
>   described in DT rather than hard-coding clock names.
> * Some cleanup of the PMC-related code, with the aim that the PMC
>   "driver" contains more of the code that touches PMC registers, rather
>   than spreading PMC register accesses through other files.
> * Conversion of the "PMC" driver to acquire resources describe in device
>   tree rather than hard-coding them.
> * Use of common code for the CPU sleep TLB invalidation.
> 

Pulled into next/cleanup branch and resolved the conflict against
an earlier cleanup that was already present there, fixup below.

	Arnd

--- a/drivers/clocksource/tegra20_timer.c
+++ b/drivers/clocksource/tegra20_timer.c
@@@ -218,34 -259,12 +218,34 @@@ static void __init tegra20_init_timer(s
        tegra_clockevent.irq = tegra_timer_irq.irq;
        clockevents_config_and_register(&tegra_clockevent, 1000000,
                                        0x1, 0x1fffffff);
 -#ifdef CONFIG_HAVE_ARM_TWD
 -      twd_local_timer_of_register();
 -#endif
 +}
 +CLOCKSOURCE_OF_DECLARE(tegra20_timer, "nvidia,tegra20-timer", tegra20_init_timer);
 +
 +static void __init tegra20_init_rtc(struct device_node *np)
 +{
 +      struct clk *clk;
 +
 +      rtc_base = of_iomap(np, 0);
 +      if (!rtc_base) {
 +              pr_err("Can't map RTC registers");
 +              BUG();
 +      }
 +
 +      /*
 +       * rtc registers are used by read_persistent_clock, keep the rtc clock
 +       * enabled
 +       */
-       clk = clk_get_sys("rtc-tegra", NULL);
++      clk = of_clk_get(np, 0);
 +      if (IS_ERR(clk))
 +              pr_warn("Unable to get rtc-tegra clock\n");
 +      else
 +              clk_prepare_enable(clk);
 +
 +      of_node_put(np);
 +
        register_persistent_clock(NULL, tegra_read_persistent_clock);
  }
 -CLOCKSOURCE_OF_DECLARE(tegra20, "nvidia,tegra20-timer", tegra20_init_timer);
 +CLOCKSOURCE_OF_DECLARE(tegra20_rtc, "nvidia,tegra20-rtc", tegra20_init_rtc);
  
  #ifdef CONFIG_PM
  static u32 usec_config;
