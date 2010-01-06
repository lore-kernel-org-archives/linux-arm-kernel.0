From: colin.tuckley@arm.com (Colin Tuckley)
Date: Wed, 06 Jan 2010 14:54:27 +0000
Subject: [PATCH] ARM: Fix the reset logic for ARM RealView boards
Message-ID: <20100106145427.12791.34402.stgit@ARM03585.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend the patch from Philby John to the other "RealView" boards.
Rename the constants and offsets to reflect their actual functions.

Signed-off-by: Colin Tuckley <colin.tuckley@arm.com>
Cc: Philby John <pjohn@in.mvista.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mach-realview/include/mach/board-pb1176.h |    4 ++--
 arch/arm/mach-realview/include/mach/platform.h     |    2 +-
 arch/arm/mach-realview/realview_eb.c               |   15 +++++++++++++++
 arch/arm/mach-realview/realview_pb1176.c           |   10 ++++------
 arch/arm/mach-realview/realview_pb11mp.c           |   11 +++++------
 arch/arm/mach-realview/realview_pba8.c             |   15 +++++++++++++++
 arch/arm/mach-realview/realview_pbx.c              |   15 +++++++++++++++
 7 files changed, 57 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-realview/include/mach/board-pb1176.h b/arch/arm/mach-realview/include/mach/board-pb1176.h
index 34b80b7..2f5ccb2 100644
--- a/arch/arm/mach-realview/include/mach/board-pb1176.h
+++ b/arch/arm/mach-realview/include/mach/board-pb1176.h
@@ -74,8 +74,8 @@
 #define REALVIEW_PB1176_L220_BASE		0x10110000 /* L220 registers */
 
 /*
- * Control register SYS_RESETCTL is set to 1 to force a soft reset
+ * Control register SYS_RESETCTL Bit 8 is set to 1 to force a soft reset
  */
-#define REALVIEW_PB1176_SYS_LOCKVAL_RSTCTL    0x0100
+#define REALVIEW_PB1176_SYS_SOFT_RESET    0x0100
 
 #endif	/* __ASM_ARCH_BOARD_PB1176_H */
diff --git a/arch/arm/mach-realview/include/mach/platform.h b/arch/arm/mach-realview/include/mach/platform.h
index 4f46bf7..86c0c44 100644
--- a/arch/arm/mach-realview/include/mach/platform.h
+++ b/arch/arm/mach-realview/include/mach/platform.h
@@ -140,7 +140,7 @@
  *     SYS_CLD, SYS_BOOTCS
  */
 #define REALVIEW_SYS_LOCK_LOCKED    (1 << 16)
-#define REALVIEW_SYS_LOCKVAL_MASK	0xA05F	       /* Enable write access */
+#define REALVIEW_SYS_LOCK_VAL	0xA05F	       /* Enable write access */
 
 /*
  * REALVIEW_SYS_FLASH
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index 917f8ca..7d857d3 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -381,6 +381,20 @@ static struct sys_timer realview_eb_timer = {
 	.init		= realview_eb_timer_init,
 };
 
+static void realview_eb_reset(char mode)
+{
+	void __iomem *reset_ctrl = __io_address(REALVIEW_SYS_RESETCTL);
+	void __iomem *lock_ctrl = __io_address(REALVIEW_SYS_LOCK);
+
+	/*
+	 * To reset, we hit the on-board reset register
+	 * in the system FPGA
+	 */
+	__raw_writel(REALVIEW_SYS_LOCK_VAL, lock_ctrl);
+	if (core_tile_eb11mp())
+		__raw_writel(0x0008, reset_ctrl);
+}
+
 static void __init realview_eb_init(void)
 {
 	int i;
@@ -408,6 +422,7 @@ static void __init realview_eb_init(void)
 #ifdef CONFIG_LEDS
 	leds_event = realview_leds_event;
 #endif
+	realview_reset = realview_eb_reset;
 }
 
 MACHINE_START(REALVIEW_EB, "ARM-RealView EB")
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index 7fb726d..44392e5 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -292,12 +292,10 @@ static struct sys_timer realview_pb1176_timer = {
 
 static void realview_pb1176_reset(char mode)
 {
-	void __iomem *hdr_ctrl = __io_address(REALVIEW_SYS_BASE) +
-		REALVIEW_SYS_RESETCTL_OFFSET;
-	void __iomem *rst_hdr_ctrl = __io_address(REALVIEW_SYS_BASE) +
-		REALVIEW_SYS_LOCK_OFFSET;
-	__raw_writel(REALVIEW_SYS_LOCKVAL_MASK, rst_hdr_ctrl);
-	__raw_writel(REALVIEW_PB1176_SYS_LOCKVAL_RSTCTL, hdr_ctrl);
+	void __iomem *reset_ctrl = __io_address(REALVIEW_SYS_RESETCTL);
+	void __iomem *lock_ctrl = __io_address(REALVIEW_SYS_LOCK);
+	__raw_writel(REALVIEW_SYS_LOCK_VAL, lock_ctrl);
+	__raw_writel(REALVIEW_PB1176_SYS_SOFT_RESET, reset_ctrl);
 }
 
 static void realview_pb1176_fixup(struct machine_desc *mdesc,
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index 9bbbfc0..3e02731 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -301,17 +301,16 @@ static struct sys_timer realview_pb11mp_timer = {
 
 static void realview_pb11mp_reset(char mode)
 {
-	void __iomem *hdr_ctrl = __io_address(REALVIEW_SYS_BASE) +
-		REALVIEW_SYS_RESETCTL_OFFSET;
-	unsigned int val;
+	void __iomem *reset_ctrl = __io_address(REALVIEW_SYS_RESETCTL);
+	void __iomem *lock_ctrl = __io_address(REALVIEW_SYS_LOCK);
 
 	/*
 	 * To reset, we hit the on-board reset register
 	 * in the system FPGA
 	 */
-	val = __raw_readl(hdr_ctrl);
-	val |= REALVIEW_PB11MP_SYS_CTRL_RESET_CONFIGCLR;
-	__raw_writel(val, hdr_ctrl);
+	__raw_writel(REALVIEW_SYS_LOCK_VAL, lock_ctrl);
+	__raw_writel(0x0000, reset_ctrl);
+	__raw_writel(0x0004, reset_ctrl);
 }
 
 static void __init realview_pb11mp_init(void)
diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index fe861e9..fe4e25c 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -272,6 +272,20 @@ static struct sys_timer realview_pba8_timer = {
 	.init		= realview_pba8_timer_init,
 };
 
+static void realview_pba8_reset(char mode)
+{
+	void __iomem *reset_ctrl = __io_address(REALVIEW_SYS_RESETCTL);
+	void __iomem *lock_ctrl = __io_address(REALVIEW_SYS_LOCK);
+
+	/*
+	 * To reset, we hit the on-board reset register
+	 * in the system FPGA
+	 */
+	__raw_writel(REALVIEW_SYS_LOCK_VAL, lock_ctrl);
+	__raw_writel(0x0000, reset_ctrl);
+	__raw_writel(0x0004, reset_ctrl);
+}
+
 static void __init realview_pba8_init(void)
 {
 	int i;
@@ -291,6 +305,7 @@ static void __init realview_pba8_init(void)
 #ifdef CONFIG_LEDS
 	leds_event = realview_leds_event;
 #endif
+	realview_reset = realview_pba8_reset;
 }
 
 MACHINE_START(REALVIEW_PBA8, "ARM-RealView PB-A8")
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index d0a3d0e..7469ce2 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -324,6 +324,20 @@ static void realview_pbx_fixup(struct machine_desc *mdesc, struct tag *tags,
 #endif
 }
 
+static void realview_pbx_reset(char mode)
+{
+	void __iomem *reset_ctrl = __io_address(REALVIEW_SYS_RESETCTL);
+	void __iomem *lock_ctrl = __io_address(REALVIEW_SYS_LOCK);
+
+	/*
+	 * To reset, we hit the on-board reset register
+	 * in the system FPGA
+	 */
+	__raw_writel(REALVIEW_SYS_LOCK_VAL, lock_ctrl);
+	__raw_writel(0x0000, reset_ctrl);
+	__raw_writel(0x0004, reset_ctrl);
+}
+
 static void __init realview_pbx_init(void)
 {
 	int i;
@@ -358,6 +372,7 @@ static void __init realview_pbx_init(void)
 #ifdef CONFIG_LEDS
 	leds_event = realview_leds_event;
 #endif
+	realview_reset = realview_pbx_reset;
 }
 
 MACHINE_START(REALVIEW_PBX, "ARM-RealView PBX")
