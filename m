From: olof@lixom.net (Olof Johansson)
Date: Thu, 31 Oct 2013 09:49:34 -0700
Subject: [PATCH] clk: fix boot panic with non-dev-associated clocks
Message-ID: <1383238174-14650-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes a panic at boot on many platforms. For example, on imx (wandboard),
I get:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = 80004000
[00000000] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.12.0-rc3+ #14
task: 807f9be0 ti: 807ee000 task.ti: 807ee000
PC is at _clk_register+0x164/0x1d0
LR is at 0x6d6d7564
pc : [<80458560>]    lr : [<6d6d7564>]    psr: 600001d3
sp : 807efe78  ip : 00000000  fp : 807efe9c
r10: 00000000  r9 : 412fc09a  r8 : ef002c40
r7 : 00000000  r6 : ef012180  r5 : ef002c40  r4 : 00000000
r3 : 807efec8  r2 : 00000000  r1 : 8075732e  r0 : ef002c80
Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c53c7d  Table: 1000404a  DAC: 00000017
Process swapper/0 (pid: 0, stack limit = 0x807ee240)
[...]
Backtrace:
[<804583fc>] (_clk_register+0x0/0x1d0) from [<80458608>] (clk_register+0x3c/0x7c)
 r8:1000406a r7:00000030 r6:00000000 r5:ef002c40 r4:ef012180 r3:00000000
[<804585cc>] (clk_register+0x0/0x7c) from [<80459008>] (clk_register_fixed_rate+0x88/0xd8)
 r6:80757328 r5:00000000 r4:ef002c40 r3:807efec8
[<80458f80>] (clk_register_fixed_rate+0x0/0xd8) from [<807ad414>] (imx6q_clocks_init+0x30/0x2d0c)
 r7:81695fc0 r6:807dea48 r5:807e9150 r4:00000000
[<807ad3e4>] (imx6q_clocks_init+0x0/0x2d0c) from [<807cb884>] (of_clk_init+0x44/0x68)
[<807cb840>] (of_clk_init+0x0/0x68) from [<807b01c4>] (imx6q_timer_init+0x14/0x54)
 r5:807f6800 r4:80835d80
[<807b01b0>] (imx6q_timer_init+0x0/0x54) from [<807a012c>] (time_init+0x24/0x34)
[<807a0108>] (time_init+0x0/0x34) from [<8079c9b4>] (start_kernel+0x1b4/0x308)
[<8079c800>] (start_kernel+0x0/0x308) from [<10008074>] (0x10008074)
 r7:807faba8 r6:807dea44 r5:807f68a8 r4:10c53c7d

Fixes: 7c042b5e39c9 ('clk: Allow drivers to pass in a regmap')
Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 drivers/clk/clk.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index b6f87af..5e71f5c 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1839,7 +1839,7 @@ static int _clk_register(struct device *dev, struct clk_hw *hw, struct clk *clk)
 		hw->regmap = hw->init->regmap;
 	else if (dev && dev_get_regmap(dev, NULL))
 		hw->regmap = dev_get_regmap(dev, NULL);
-	else if (dev->parent)
+	else if (dev && dev->parent)
 		hw->regmap = dev_get_regmap(dev->parent, NULL);
 
 	/* allocate local copy in case parent_names is __initdata */
-- 
1.7.10.4
