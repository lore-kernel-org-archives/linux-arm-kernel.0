From: michal.simek@xilinx.com (Michal Simek)
Date: Fri,  3 Jan 2014 11:11:06 +0100
Subject: [PATCH v1 21/24] zynq: Add support to find bootmode
In-Reply-To: <cover.1388743861.git.michal.simek@xilinx.com>
References: <cover.1388743861.git.michal.simek@xilinx.com>
Message-ID: <7f6061d8bf93129365e8a23a33d614a40463db9a.1388743861.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagannadha Sutradharudu Teki <jagannadha.sutradharudu-teki@xilinx.com>

Added support to find the bootmodes by reading
slcr bootmode register. this can be helpful to
autoboot the configurations w.r.t a specified bootmode.

Added this functionality on board_late_init as it's not
needed for normal initializtion part.

Signed-off-by: Jagannadha Sutradharudu Teki <jaganna@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>

---

Changes in v1:
- Remove doc compare to origin Jagan version

 arch/arm/cpu/armv7/zynq/slcr.c             |  6 ++++++
 arch/arm/include/asm/arch-zynq/sys_proto.h |  1 +
 board/xilinx/zynq/board.c                  | 25 +++++++++++++++++++++++++
 include/configs/zynq.h                     |  1 +
 4 files changed, 33 insertions(+)

diff --git a/arch/arm/cpu/armv7/zynq/slcr.c b/arch/arm/cpu/armv7/zynq/slcr.c
index 717ec65..b4c11c3 100644
--- a/arch/arm/cpu/armv7/zynq/slcr.c
+++ b/arch/arm/cpu/armv7/zynq/slcr.c
@@ -101,6 +101,12 @@ void zynq_slcr_devcfg_enable(void)
 	zynq_slcr_lock();
 }

+u32 zynq_slcr_get_boot_mode(void)
+{
+	/* Get the bootmode register value */
+	return readl(&slcr_base->boot_mode);
+}
+
 u32 zynq_slcr_get_idcode(void)
 {
 	return (readl(&slcr_base->pss_idcode) & SLCR_IDCODE_MASK) >>
diff --git a/arch/arm/include/asm/arch-zynq/sys_proto.h b/arch/arm/include/asm/arch-zynq/sys_proto.h
index bb089b6..86e7db5 100644
--- a/arch/arm/include/asm/arch-zynq/sys_proto.h
+++ b/arch/arm/include/asm/arch-zynq/sys_proto.h
@@ -13,6 +13,7 @@ extern void zynq_slcr_cpu_reset(void);
 extern void zynq_slcr_gem_clk_setup(u32 gem_id, u32 rclk, u32 clk);
 extern void zynq_slcr_devcfg_disable(void);
 extern void zynq_slcr_devcfg_enable(void);
+extern u32 zynq_slcr_get_boot_mode(void);
 extern u32 zynq_slcr_get_idcode(void);
 extern void zynq_ddrc_init(void);

diff --git a/board/xilinx/zynq/board.c b/board/xilinx/zynq/board.c
index 6b691f3..6629b20 100644
--- a/board/xilinx/zynq/board.c
+++ b/board/xilinx/zynq/board.c
@@ -13,6 +13,12 @@

 DECLARE_GLOBAL_DATA_PTR;

+/* Bootmode setting values */
+#define ZYNQ_BM_MASK		0x0F
+#define ZYNQ_BM_NOR		0x02
+#define ZYNQ_BM_SD		0x05
+#define ZYNQ_BM_JTAG		0x0
+
 #ifdef CONFIG_FPGA
 Xilinx_desc fpga;

@@ -60,6 +66,25 @@ int board_init(void)
 	return 0;
 }

+int board_late_init(void)
+{
+	switch ((zynq_slcr_get_boot_mode()) & ZYNQ_BM_MASK) {
+	case ZYNQ_BM_NOR:
+		setenv("modeboot", "norboot");
+		break;
+	case ZYNQ_BM_SD:
+		setenv("modeboot", "sdboot");
+		break;
+	case ZYNQ_BM_JTAG:
+		setenv("modeboot", "jtagboot");
+		break;
+	default:
+		setenv("modeboot", "");
+		break;
+	}
+
+	return 0;
+}

 #ifdef CONFIG_CMD_NET
 int board_eth_init(bd_t *bis)
diff --git a/include/configs/zynq.h b/include/configs/zynq.h
index ed7de6c..5e7adc2 100644
--- a/include/configs/zynq.h
+++ b/include/configs/zynq.h
@@ -153,6 +153,7 @@

 #define CONFIG_CMDLINE_EDITING
 #define CONFIG_AUTO_COMPLETE
+#define CONFIG_BOARD_LATE_INIT
 #define CONFIG_SYS_LONGHELP
 #define CONFIG_SYS_MAXARGS		15 /* max number of command args */
 #define CONFIG_SYS_CBSIZE		256 /* Console I/O Buffer Size */
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140103/119dad09/attachment.sig>
