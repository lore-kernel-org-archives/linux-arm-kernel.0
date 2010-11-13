From: jason.chagas@marvell.com (Jason Chagas)
Date: Sat, 13 Nov 2010 00:01:44 -0500
Subject: [PATCH] ARM: fix some trivial compiler warnings
Message-ID: <mailman.16.1289627318.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/kernel/ptrace.c: In function 'get_branch_address':
arch/arm/kernel/ptrace.c:429: warning: comparison between pointer and
integer
arch/arm/kernel/ptrace.c:429: warning: comparison between pointer and
integer

arch/arm/mach-mmp/mmp2.c:127: warning: 'clk_rtc' defined but not used

drivers/i2c/busses/i2c-pxa.c: In function 'i2c_pxa_probe':
drivers/i2c/busses/i2c-pxa.c:1004: warning: initialization discards
qualifiers from pointer target type

Signed-off-by: Jason Chagas <jason.chagas@marvell.com>
---
 arch/arm/kernel/ptrace.c     |    2 +-
 arch/arm/mach-mmp/mmp2.c     |    1 -
 drivers/i2c/busses/i2c-pxa.c |    2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index cf16bca..7bb9a88 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -426,7 +426,7 @@ get_branch_address(struct task_struct *child,
unsigned long pc, unsigned long in
 	    break;
 	}
 
-	if (alt >= (void*)CONFIG_VECTORS_BASE && alt <
(void*)CONFIG_VECTORS_BASE + PAGE_SIZE)
+	if (alt >= CONFIG_VECTORS_BASE && alt < CONFIG_VECTORS_BASE +
PAGE_SIZE)
 		alt = get_user_reg(child, REG_LR);
 
 	return alt;
diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index 7f5eb05..3028bb7 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -124,7 +124,6 @@ static APBC_CLK(twsi3, MMP2_TWSI3, 0, 26000000);
 static APBC_CLK(twsi4, MMP2_TWSI4, 0, 26000000);
 static APBC_CLK(twsi5, MMP2_TWSI5, 0, 26000000);
 static APBC_CLK(twsi6, MMP2_TWSI6, 0, 26000000);
-static APBC_CLK(rtc, MMP2_RTC, 0, 32768);
 
 static APMU_CLK(nand, NAND, 0xbf, 100000000);
 
diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 020ff23..c94e51b 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1001,7 +1001,7 @@ static int i2c_pxa_probe(struct platform_device
*dev)
 	struct pxa_i2c *i2c;
 	struct resource *res;
 	struct i2c_pxa_platform_data *plat = dev->dev.platform_data;
-	struct platform_device_id *id = platform_get_device_id(dev);
+	const struct platform_device_id *id = platform_get_device_id(dev);
 	int ret;
 	int irq;
 
-- 
1.7.2.3
