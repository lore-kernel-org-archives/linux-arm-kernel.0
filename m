From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 18 Mar 2013 15:31:40 +1100
Subject: linux-next: manual merge of the tegra tree with the arm-soc tree
Message-ID: <20130318153140.100bdf364d5614ce31f12eae@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the tegra tree got a conflict in
drivers/clocksource/tegra20_timer.c between commit 1d16cfb3aeba
("clocksource: tegra20: use the device_node pointer passed to init") from
the arm-soc tree and commit 6f88fb8af6c6 ("clocksource: tegra: move to
of_clk_get") from the tegra tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/clocksource/tegra20_timer.c
index 2e4d8a6,bc4b8ad..0000000
--- a/drivers/clocksource/tegra20_timer.c
+++ b/drivers/clocksource/tegra20_timer.c
@@@ -218,34 -259,12 +218,34 @@@ static void __init tegra20_init_timer(s
  	tegra_clockevent.irq = tegra_timer_irq.irq;
  	clockevents_config_and_register(&tegra_clockevent, 1000000,
  					0x1, 0x1fffffff);
 -#ifdef CONFIG_HAVE_ARM_TWD
 -	twd_local_timer_of_register();
 -#endif
 +}
 +CLOCKSOURCE_OF_DECLARE(tegra20_timer, "nvidia,tegra20-timer", tegra20_init_timer);
 +
 +static void __init tegra20_init_rtc(struct device_node *np)
 +{
 +	struct clk *clk;
 +
 +	rtc_base = of_iomap(np, 0);
 +	if (!rtc_base) {
 +		pr_err("Can't map RTC registers");
 +		BUG();
 +	}
 +
 +	/*
 +	 * rtc registers are used by read_persistent_clock, keep the rtc clock
 +	 * enabled
 +	 */
- 	clk = clk_get_sys("rtc-tegra", NULL);
++	clk = of_clk_get(np, 0);
 +	if (IS_ERR(clk))
 +		pr_warn("Unable to get rtc-tegra clock\n");
 +	else
 +		clk_prepare_enable(clk);
 +
 +	of_node_put(np);
 +
  	register_persistent_clock(NULL, tegra_read_persistent_clock);
  }
 -CLOCKSOURCE_OF_DECLARE(tegra20, "nvidia,tegra20-timer", tegra20_init_timer);
 +CLOCKSOURCE_OF_DECLARE(tegra20_rtc, "nvidia,tegra20-rtc", tegra20_init_rtc);
  
  #ifdef CONFIG_PM
  static u32 usec_config;
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130318/cca713cf/attachment-0001.sig>
