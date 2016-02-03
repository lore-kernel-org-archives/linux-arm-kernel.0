From: joshc@ni.com (Josh Cartwright)
Date: Tue, 2 Feb 2016 20:30:49 -0600
Subject: [PATCH 2/2] ARM: zynq: address L2 cache data corruption
In-Reply-To: <cover.1454465714.git.joshc@ni.com>
References: <cover.1454465714.git.joshc@ni.com>
Message-ID: <9d2012ea9f91ff27f7289fcb9208c10791e4d3a0.1454465714.git.joshc@ni.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Zynq has a bug where the L2 cache will return invalid data in some
circumstances unless the L2C_RAM register is set to 0x00020202 before the first
enabling of the L2 cache.

The Xilinx-recommended solution to this problem is to ensure that early one of
the earlier bootstages correctly initialize L2C_RAM, however, this issue wasn't
discovered and fixed until after their EDK/SDK 14.4 release.  For systems built
prior to that, and which lack field-upgradable bootloaders, this issue still
exists and silent data corruption can be seen in the wild.

Fix these systems by ensuring L2C_RAM is properly initialized at the
earliest convenient moment prior to the L2 being brought up, which is
when the SLCR is first mapped.

The Zynq bug is described in more detail by Xilinx AR# 54190 as quoted
below.

Xilinx AR# 54190
http://www.xilinx.com/support/answers/54190.htm
Captured on 2014-09-24 14:43 -0500

  = Description =
  For proper L2 cache operation, the user code must program the
  slcr.L2C_RAM register (address 0xF800_0A1C) to the value of
  0x0002_0202 before enabling the L2 cache. The reset value
  (0x0001_0101) might cause, very infrequently, the L2 cache to return
  invalid data.

  = Solution =
  It is up to the user code (FSBL or other user code) to set the
  slcr.L2C_RAM register to the value 0x0002_0202 before enabling the L2
  cache.

  Note: The L2 cache is disabled after reset and is not enabled by the
  BootROM.

  Note: The slcr.l2C_RAM register was previously reserved. It is added
  in the Zynq-7000 AP SoC Technical Reference Manual (TRM) v1.5 as
  "Reserved".

Thanks to Jaeden Amero for initial debugging and triage efforts.

Signed-off-by: Josh Cartwright <joshc@ni.com>
---
 arch/arm/mach-zynq/slcr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
index 26320eb..f0292a3 100644
--- a/arch/arm/mach-zynq/slcr.c
+++ b/arch/arm/mach-zynq/slcr.c
@@ -28,6 +28,7 @@
 #define SLCR_A9_CPU_RST_CTRL_OFFSET	0x244 /* CPU Software Reset Control */
 #define SLCR_REBOOT_STATUS_OFFSET	0x258 /* PS Reboot Status */
 #define SLCR_PSS_IDCODE			0x530 /* PS IDCODE */
+#define SLCR_L2C_RAM			0xA1C /* L2C_RAM in AR#54190 */
 
 #define SLCR_UNLOCK_MAGIC		0xDF0D
 #define SLCR_A9_CPU_CLKSTOP		0x10
@@ -227,6 +228,9 @@ int __init zynq_early_slcr_init(void)
 	/* unlock the SLCR so that registers can be changed */
 	zynq_slcr_unlock();
 
+	/* See AR#54190 design advisory */
+	regmap_update_bits(zynq_slcr_regmap, SLCR_L2C_RAM, 0x70707, 0x20202);
+
 	register_restart_handler(&zynq_slcr_restart_nb);
 
 	pr_info("%s mapped to %p\n", np->name, zynq_slcr_base);
-- 
2.7.0
