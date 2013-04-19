From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 19 Apr 2013 17:27:53 +1000
Subject: linux-next: manual merge of the clk tree with the arm-soc tree
Message-ID: <20130419172753.0e604e9bad0b7a26a8b52787@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Today's linux-next merge of the clk tree got a conflict in
arch/arm/mach-vexpress/v2m.c between commit dabfd8fb84ab ("ARM: vexpress:
remove sp804 OF init") from the arm-soc tree and commit 6e973d2c4385
("clk: vexpress: Add separate SP810 driver") from the clk tree.

I fixed it up (I thnk - see below) and can carry the fix as necessary (no
action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-vexpress/v2m.c
index d8e2954,c5e20b5..0000000
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@@ -23,9 -21,13 +23,11 @@@
  #include <linux/regulator/fixed.h>
  #include <linux/regulator/machine.h>
  #include <linux/vexpress.h>
+ #include <linux/clk-provider.h>
+ #include <linux/clkdev.h>
  
 -#include <asm/arch_timer.h>
  #include <asm/mach-types.h>
  #include <asm/sizes.h>
 -#include <asm/smp_twd.h>
  #include <asm/mach/arch.h>
  #include <asm/mach/map.h>
  #include <asm/mach/time.h>
@@@ -425,11 -433,29 +427,11 @@@ void __init v2m_dt_init_early(void
  
  static void __init v2m_dt_timer_init(void)
  {
- 	vexpress_clk_of_init();
 -	struct device_node *node = NULL;
 -
+ 	of_clk_init(NULL);
  
 -	do {
 -		node = of_find_compatible_node(node, NULL, "arm,sp804");
 -	} while (node && vexpress_get_site_by_node(node) != VEXPRESS_SITE_MB);
 -	if (node) {
 -		pr_info("Using SP804 '%s' as a clock & events source\n",
 -				node->full_name);
 -		WARN_ON(clk_register_clkdev(of_clk_get_by_name(node,
 -				"timclken1"), "v2m-timer0", "sp804"));
 -		WARN_ON(clk_register_clkdev(of_clk_get_by_name(node,
 -				"timclken2"), "v2m-timer1", "sp804"));
 -		v2m_sp804_init(of_iomap(node, 0),
 -				irq_of_parse_and_map(node, 0));
 -	}
 -
 -	if (arch_timer_of_register() != 0)
 -		twd_local_timer_of_register();
 +	clocksource_of_init();
  
 -	if (arch_timer_sched_clock_init() != 0)
 -		versatile_sched_clock_init(vexpress_get_24mhz_clock_base(),
 +	versatile_sched_clock_init(vexpress_get_24mhz_clock_base(),
  				24000000);
  }
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130419/72b3722a/attachment.sig>
