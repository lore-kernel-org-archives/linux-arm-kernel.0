From: thor.thayer@linux.intel.com (thor.thayer at linux.intel.com)
Date: Tue,  9 Jan 2018 11:25:35 -0600
Subject: [PATCH] ARM: socfpga: Configure l2c_aux_val
Message-ID: <1515518735-10906-1-git-send-email-thor.thayer@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Depending on the execution path, the A10 boot ROM/U-Boot may or
may not set some bits in the l2c aux ctrl register.  Due to this
abiguity, linux must explicitly set the register.  This patch
forces the configuration to match the full boot flow, which
also matches the setting used in the 3.10-ltsi version of the
kernel.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 arch/arm/mach-socfpga/socfpga.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index dde14f7bf2c3..37d28794f7d4 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -121,7 +121,10 @@ static const char *altera_a10_dt_match[] = {
 };
 
 DT_MACHINE_START(SOCFPGA_A10, "Altera SOCFPGA Arria10")
-	.l2c_aux_val	= 0,
+	.l2c_aux_val	= L2C_AUX_CTRL_EVTMON_ENABLE |
+			  L2C_AUX_CTRL_SHARED_OVERRIDE |
+			  L310_AUX_CTRL_INSTR_PREFETCH |
+			  L310_AUX_CTRL_DATA_PREFETCH,
 	.l2c_aux_mask	= ~0,
 	.init_irq	= socfpga_arria10_init_irq,
 	.restart	= socfpga_arria10_restart,
-- 
2.7.4
