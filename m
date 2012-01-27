From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 26 Jan 2012 18:12:23 -0700
Subject: [PATCH] ARM: tegra: Fix EMC pdata initialization from registers
Message-ID: <1327626743-32478-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit d91eeb0 "ARM: tegra: emc: device tree support" modified the EMC
driver to create an EMC table from existing register settings when none
was provided through platform data or device tree. This code wrote the
wrong clock rate into the table; the actual rate in Hz, rather than the
expected half-rate in KHz. This caused the BUG_ON in
tegra2_emc_clk_round_rate() to fire, since that enormous rate could not
be generated.

Fixes:

[    2.425921] kernel BUG at arch/arm/mach-tegra/tegra2_clocks.c:1158!
...
[    2.618766] [<c001c0e8>] (tegra2_emc_clk_round_rate+0x58/0x70) from [<c00198b4>] (clk_round_rate+0x48/0x68)
[    2.628494] [<c00198b4>] (clk_round_rate+0x48/0x68) from [<c0019cc0>] (clk_set_rate_locked+0x40/0x68)
[    2.637707] [<c0019cc0>] (clk_set_rate_locked+0x40/0x68) from [<c0019d10>] (clk_set_rate+0x28/0x40)
[    2.646754] [<c0019d10>] (clk_set_rate+0x28/0x40) from [<c001ffc8>] (tegra_update_cpu_speed+0x54/0x144)
[    2.656144] [<c001ffc8>] (tegra_update_cpu_speed+0x54/0x144) from [<c002016c>] (tegra_target+0xb4/0xe0)
[    2.665538] [<c002016c>] (tegra_target+0xb4/0xe0) from [<c01a96c0>] (__cpufreq_driver_target+0x88/0xa4)
[    2.674931] [<c01a96c0>] (__cpufreq_driver_target+0x88/0xa4) from [<c01ac9d0>] (dbs_check_cpu+0x324/0x340)
[    2.684582] [<c01ac9d0>] (dbs_check_cpu+0x324/0x340) from [<c01aca40>] (do_dbs_timer+0x54/0xf4)
[    2.693277] [<c01aca40>] (do_dbs_timer+0x54/0xf4) from [<c00369a8>] (process_one_work+0x1d4/0x320)
[    2.702225] [<c00369a8>] (process_one_work+0x1d4/0x320) from [<c0036f34>] (worker_thread+0x134/0x230)
[    2.711437] [<c0036f34>] (worker_thread+0x134/0x230) from [<c003add0>] (kthread+0x80/0x8c)
[    2.719700] [<c003add0>] (kthread+0x80/0x8c) from [<c000ebf4>] (kernel_thread_exit+0x0/0x8)

Reported-by: Marc Dietrich <marvin24@gmx.de>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/tegra2_emc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra2_emc.c b/arch/arm/mach-tegra/tegra2_emc.c
index 52df6ca..4e8a14b 100644
--- a/arch/arm/mach-tegra/tegra2_emc.c
+++ b/arch/arm/mach-tegra/tegra2_emc.c
@@ -284,14 +284,14 @@ static struct tegra_emc_pdata __devinit *tegra_emc_fill_pdata(struct platform_de
 	pdata->tables = devm_kzalloc(&pdev->dev, sizeof(*pdata->tables),
 				     GFP_KERNEL);
 
-	pdata->tables[0].rate = clk_get_rate(c);
+	pdata->tables[0].rate = clk_get_rate(c) / 2 / 1000;
 
 	for (i = 0; i < TEGRA_EMC_NUM_REGS; i++)
 		pdata->tables[0].regs[i] = emc_readl(emc_reg_addr[i]);
 
 	pdata->num_tables = 1;
 
-	khz = pdata->tables[0].rate / 1000;
+	khz = pdata->tables[0].rate * 2 * 1000;
 	dev_info(&pdev->dev, "no tables provided, using %ld kHz emc, "
 		 "%ld kHz mem\n", khz, khz/2);
 
-- 
1.7.0.4
