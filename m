From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 17 Feb 2013 18:33:05 -0500
Subject: [GIT PULL] ARM: mvebu: boards for v3.9 (merge and build fix
 against arm-soc/timer/cleanup)
Message-ID: <20130217233305.GM23237@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7649cca52a73c10712b033b4eba908c48d9c0bb7:

  arm: mvebu: update defconfig with ATAG support when using DT (2013-02-16 16:46:28 +0000)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/boards_for_v3.9_round3

for you to fetch changes up to ab7a8e7bc41545625bf1c73cb100b1f9ab0845d1:

  Merge remote-tracking branch 'arm-soc/timer/cleanup' into mvebu/boards (2013-02-17 22:51:56 +0000)

----------------------------------------------------------------

mvebu boards for v3.9 round3

 - Fixed the conflict and the build breakage listed below by merging in
   arm-soc/timer/cleanup.  The fixes are contained in the merge commit.

New Depends for mvebu/boards
 - arm-soc/timer/cleanup

** From previous tag boards_for_v3.9 **
depends on:
 - tags/mvebu_fixes_for_v3.8-rc6
 - tags/cleanup_for_v3.9_round2
 - tags/drivers_for_v3.9
 - mmc/mmc-next up to:
    d293875 mmc: mvsdio: add pinctrl integration

conflicts:
 - arm-soc/for-next
    - arch/arm/mach-dove/common.c
       * remove all DT code (it's now in .../board-dt.c)

build fixes (not merge conflict)
 - arm-soc/for-next
    - arch/arm/mach-dove/board-dt.c
       - .timer no longer used
       * s/.timer = &dove_timer/.init_time = dove_timer_init/ (not valid sed)

----------------------------------------------------------------
Jason Cooper (1):
      Merge remote-tracking branch 'arm-soc/timer/cleanup' into mvebu/boards

I'm open to ideas for how to get a true --stat of what I changed in the
merge commit, below is the most concise output I could generate.

Output of 'git show --oneline':

ab7a8e7 Merge remote-tracking branch 'arm-soc/timer/cleanup' into mvebu/boards

diff --cc arch/arm/mach-dove/board-dt.c
index 2310f55,0000000..f8f891b
mode 100644,000000..100644
--- a/arch/arm/mach-dove/board-dt.c
+++ b/arch/arm/mach-dove/board-dt.c
@@@ -1,102 -1,0 +1,102 @@@
 +/*
 + * arch/arm/mach-dove/board-dt.c
 + *
 + * Marvell Dove 88AP510 System On Chip FDT Board
 + *
 + * This file is licensed under the terms of the GNU General Public
 + * License version 2.  This program is licensed "as is" without any
 + * warranty of any kind, whether express or implied.
 + */
 +
 +#include <linux/init.h>
 +#include <linux/clk-provider.h>
 +#include <linux/clk/mvebu.h>
 +#include <linux/of.h>
 +#include <linux/of_platform.h>
 +#include <linux/platform_data/usb-ehci-orion.h>
 +#include <asm/hardware/cache-tauros2.h>
 +#include <asm/mach/arch.h>
 +#include <mach/pm.h>
 +#include <plat/common.h>
 +#include <plat/irq.h>
 +#include "common.h"
 +
 +/*
 + * There are still devices that doesn't even know about DT,
 + * get clock gates here and add a clock lookup.
 + */
 +static void __init dove_legacy_clk_init(void)
 +{
 +	struct device_node *np = of_find_compatible_node(NULL, NULL,
 +					 "marvell,dove-gating-clock");
 +	struct of_phandle_args clkspec;
 +
 +	clkspec.np = np;
 +	clkspec.args_count = 1;
 +
 +	clkspec.args[0] = CLOCK_GATING_BIT_USB0;
 +	orion_clkdev_add(NULL, "orion-ehci.0",
 +			 of_clk_get_from_provider(&clkspec));
 +
 +	clkspec.args[0] = CLOCK_GATING_BIT_USB1;
 +	orion_clkdev_add(NULL, "orion-ehci.1",
 +			 of_clk_get_from_provider(&clkspec));
 +
 +	clkspec.args[0] = CLOCK_GATING_BIT_GBE;
 +	orion_clkdev_add(NULL, "mv643xx_eth_port.0",
 +			 of_clk_get_from_provider(&clkspec));
 +
 +	clkspec.args[0] = CLOCK_GATING_BIT_PCIE0;
 +	orion_clkdev_add("0", "pcie",
 +			 of_clk_get_from_provider(&clkspec));
 +
 +	clkspec.args[0] = CLOCK_GATING_BIT_PCIE1;
 +	orion_clkdev_add("1", "pcie",
 +			 of_clk_get_from_provider(&clkspec));
 +}
 +
 +static void __init dove_of_clk_init(void)
 +{
 +	mvebu_clocks_init();
 +	dove_legacy_clk_init();
 +}
 +
 +static struct mv643xx_eth_platform_data dove_dt_ge00_data = {
 +	.phy_addr = MV643XX_ETH_PHY_ADDR_DEFAULT,
 +};
 +
 +static void __init dove_dt_init(void)
 +{
 +	pr_info("Dove 88AP510 SoC\n");
 +
 +#ifdef CONFIG_CACHE_TAUROS2
 +	tauros2_init(0);
 +#endif
 +	dove_setup_cpu_mbus();
 +
 +	/* Setup root of clk tree */
 +	dove_of_clk_init();
 +
 +	/* Internal devices not ported to DT yet */
 +	dove_ge00_init(&dove_dt_ge00_data);
 +	dove_ehci0_init();
 +	dove_ehci1_init();
 +	dove_pcie_init(1, 1);
 +
 +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 +}
 +
 +static const char * const dove_dt_board_compat[] = {
 +	"marvell,dove",
 +	NULL
 +};
 +
 +DT_MACHINE_START(DOVE_DT, "Marvell Dove (Flattened Device Tree)")
 +	.map_io		= dove_map_io,
 +	.init_early	= dove_init_early,
 +	.init_irq	= orion_dt_init_irq,
- 	.timer		= &dove_timer,
++	.init_time      = dove_timer_init,
 +	.init_machine	= dove_dt_init,
 +	.restart	= dove_restart,
 +	.dt_compat	= dove_dt_board_compat,
 +MACHINE_END
diff --cc arch/arm/mach-highbank/highbank.c
index 981dc1e,f6ca285..41e254c
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@@ -129,13 -129,9 +129,9 @@@ static void __init highbank_timer_init(
  	arch_timer_sched_clock_init();
  }
  
- static struct sys_timer highbank_timer = {
- 	.init = highbank_timer_init,
- };
- 
  static void highbank_power_off(void)
  {
 -	hignbank_set_pwr_shutdown();
 +	highbank_set_pwr_shutdown();
  
  	while (1)
  		cpu_do_idle();
