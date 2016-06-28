From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Tue, 28 Jun 2016 11:40:37 +0200
Subject: [PATCH] ARM: sti: Implement dummy L2 cache's write_sec
Message-ID: <1467106837-20996-1-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

This patch implements the write_sec callback that handle PL310
secure registers writes.
This callback is just a stub for now, to avoid system crash.
Later, it could handle SMC calls so that TZ handles the needed writes.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/mach-sti/board-dt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-sti/board-dt.c b/arch/arm/mach-sti/board-dt.c
index cfee0ef..e04cd1b 100644
--- a/arch/arm/mach-sti/board-dt.c
+++ b/arch/arm/mach-sti/board-dt.c
@@ -23,6 +23,14 @@ static const char *const stih41x_dt_match[] __initconst = {
 	NULL
 };
 
+static void sti_l2_write_sec(unsigned long val, unsigned reg)
+{
+	/*
+	 * We can't write to secure registers as we are in non-secure
+	 * mode, until we have some SMI service available.
+	 */
+}
+
 DT_MACHINE_START(STM, "STi SoC with Flattened Device Tree")
 	.dt_compat	= stih41x_dt_match,
 	.l2c_aux_val	= L2C_AUX_CTRL_SHARED_OVERRIDE |
@@ -31,4 +39,5 @@ DT_MACHINE_START(STM, "STi SoC with Flattened Device Tree")
 			  L2C_AUX_CTRL_WAY_SIZE(4),
 	.l2c_aux_mask	= 0xc0000fff,
 	.smp		= smp_ops(sti_smp_ops),
+	.l2c_write_sec	= sti_l2_write_sec,
 MACHINE_END
-- 
1.9.1
