From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Thu, 20 Nov 2014 23:04:40 -0600
Subject: [PATCH 2/2] arm: socfpga: Set share override bit of the l2 cache
 controller
In-Reply-To: <1416546280-12068-1-git-send-email-dinguyen@opensource.altera.com>
References: <1416546280-12068-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <1416546280-12068-2-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

By not having bit 22 set in the PL310 Auxiliary Control register (shared
attribute override enable) has the side effect of transforming Normal
Shared Non-cacheable reads into Cacheable no-allocate reads.

Coherent DMA buffers in Linux always have a Cacheable alias via the
kernel linear mapping and the processor can speculatively load cache
lines into the PL310 controller. With bit 22 cleared, Non-cacheable
reads would unexpectedly hit such cache lines leading to buffer
corruption.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/mach-socfpga/socfpga.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index 13b1858..afc009f 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -105,7 +105,8 @@ static const char *altera_dt_match[] = {
 
 DT_MACHINE_START(SOCFPGA, "Altera SOCFPGA")
 	.l2c_aux_val	= L310_AUX_CTRL_DATA_PREFETCH |
-			  L310_AUX_CTRL_INSTR_PREFETCH,
+			  L310_AUX_CTRL_INSTR_PREFETCH |
+			  L2C_AUX_CTRL_SHARED_OVERRIDE,
 	.l2c_aux_mask	= ~0,
 	.smp		= smp_ops(socfpga_smp_ops),
 	.map_io		= socfpga_map_io,
-- 
2.0.3
