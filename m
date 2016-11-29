From: andy.gross@linaro.org (Andy Gross)
Date: Tue, 29 Nov 2016 01:44:22 -0600
Subject: [PATCH 1/2] arm: kernel: Add SMC structure parameter
In-Reply-To: <1480405463-23165-1-git-send-email-andy.gross@linaro.org>
References: <1480405463-23165-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1480405463-23165-2-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a quirk parameter to the arm_smccc_smc call.  The quirk
structure allows for specialized SMC operations due to SoC specific
requirements.

This patch also fixes up all the current users of the arm_smccc_smc API.

This patch and partial implementation was suggested by Will Deacon.

Signed-off-by: Andy Gross <andy.gross@linaro.org>
---
 arch/arm/kernel/smccc-call.S         |  3 ++-
 arch/arm/mach-artpec/board-artpec6.c |  2 +-
 arch/arm64/kernel/asm-offsets.c      |  7 +++++--
 arch/arm64/kernel/smccc-call.S       |  3 ++-
 drivers/clk/rockchip/clk-ddr.c       |  6 +++---
 drivers/devfreq/rk3399_dmc.c         |  6 +++---
 drivers/firmware/meson/meson_sm.c    |  2 +-
 drivers/firmware/psci.c              |  2 +-
 drivers/firmware/qcom_scm-64.c       |  4 ++--
 drivers/gpu/drm/mediatek/mtk_hdmi.c  |  2 +-
 include/linux/arm-smccc.h            | 18 ++++++++++++++++--
 11 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/arch/arm/kernel/smccc-call.S b/arch/arm/kernel/smccc-call.S
index 37669e7..e77950a 100644
--- a/arch/arm/kernel/smccc-call.S
+++ b/arch/arm/kernel/smccc-call.S
@@ -47,7 +47,8 @@ UNWIND(	.fnend)
 /*
  * void smccc_smc(unsigned long a0, unsigned long a1, unsigned long a2,
  *		  unsigned long a3, unsigned long a4, unsigned long a5,
- *		  unsigned long a6, unsigned long a7, struct arm_smccc_res *res)
+ *		  unsigned long a6, unsigned long a7, struct arm_smccc_res *res,
+ *		  struct arm_smccc_quirk *quirk)
  */
 ENTRY(arm_smccc_smc)
 	SMCCC SMCCC_SMC
diff --git a/arch/arm/mach-artpec/board-artpec6.c b/arch/arm/mach-artpec/board-artpec6.c
index a0b1979..3a4d330 100644
--- a/arch/arm/mach-artpec/board-artpec6.c
+++ b/arch/arm/mach-artpec/board-artpec6.c
@@ -50,7 +50,7 @@ static void artpec6_l2c310_write_sec(unsigned long val, unsigned reg)
 	struct arm_smccc_res res;
 
 	arm_smccc_smc(SECURE_OP_L2C_WRITEREG, reg, val, 0,
-		      0, 0, 0, 0, &res);
+		      0, 0, 0, 0, &res, NULL);
 
 	WARN_ON(res.a0);
 }
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 4a2f0f0..c58ddf8 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -140,8 +140,11 @@ int main(void)
   DEFINE(SLEEP_STACK_DATA_SYSTEM_REGS,	offsetof(struct sleep_stack_data, system_regs));
   DEFINE(SLEEP_STACK_DATA_CALLEE_REGS,	offsetof(struct sleep_stack_data, callee_saved_regs));
 #endif
-  DEFINE(ARM_SMCCC_RES_X0_OFFS,	offsetof(struct arm_smccc_res, a0));
-  DEFINE(ARM_SMCCC_RES_X2_OFFS,	offsetof(struct arm_smccc_res, a2));
+  DEFINE(ARM_SMCCC_RES_X0_OFFS,		offsetof(struct arm_smccc_res, a0));
+  DEFINE(ARM_SMCCC_RES_X2_OFFS,		offsetof(struct arm_smccc_res, a2));
+  DEFINE(ARM_SMCCC_QUIRK_ID_OFFS,	offsetof(struct arm_smccc_quirk, id));
+  DEFINE(ARM_SMCCC_QUIRK_STATE_OFFS,	offsetof(struct arm_smccc_quirk, state));
+
   BLANK();
   DEFINE(HIBERN_PBE_ORIG,	offsetof(struct pbe, orig_address));
   DEFINE(HIBERN_PBE_ADDR,	offsetof(struct pbe, address));
diff --git a/arch/arm64/kernel/smccc-call.S b/arch/arm64/kernel/smccc-call.S
index ae0496f..7b0b3f6 100644
--- a/arch/arm64/kernel/smccc-call.S
+++ b/arch/arm64/kernel/smccc-call.S
@@ -27,7 +27,8 @@
 /*
  * void arm_smccc_smc(unsigned long a0, unsigned long a1, unsigned long a2,
  *		  unsigned long a3, unsigned long a4, unsigned long a5,
- *		  unsigned long a6, unsigned long a7, struct arm_smccc_res *res)
+ *		  unsigned long a6, unsigned long a7, struct arm_smccc_res *res,
+ *		  struct arm_smccc_quirk *quirk)
  */
 ENTRY(arm_smccc_smc)
 	SMCCC	smc
diff --git a/drivers/clk/rockchip/clk-ddr.c b/drivers/clk/rockchip/clk-ddr.c
index 8feba93..cbdc0f8 100644
--- a/drivers/clk/rockchip/clk-ddr.c
+++ b/drivers/clk/rockchip/clk-ddr.c
@@ -45,7 +45,7 @@ static int rockchip_ddrclk_sip_set_rate(struct clk_hw *hw, unsigned long drate,
 	spin_lock_irqsave(ddrclk->lock, flags);
 	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, drate, 0,
 		      ROCKCHIP_SIP_CONFIG_DRAM_SET_RATE,
-		      0, 0, 0, 0, &res);
+		      0, 0, 0, 0, &res, NULL);
 	spin_unlock_irqrestore(ddrclk->lock, flags);
 
 	return res.a0;
@@ -59,7 +59,7 @@ static int rockchip_ddrclk_sip_set_rate(struct clk_hw *hw, unsigned long drate,
 
 	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, 0, 0,
 		      ROCKCHIP_SIP_CONFIG_DRAM_GET_RATE,
-		      0, 0, 0, 0, &res);
+		      0, 0, 0, 0, &res, NULL);
 
 	return res.a0;
 }
@@ -72,7 +72,7 @@ static long rockchip_ddrclk_sip_round_rate(struct clk_hw *hw,
 
 	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, rate, 0,
 		      ROCKCHIP_SIP_CONFIG_DRAM_ROUND_RATE,
-		      0, 0, 0, 0, &res);
+		      0, 0, 0, 0, &res, NULL);
 
 	return res.a0;
 }
diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index e24b73d..a2e1f4c 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -258,7 +258,7 @@ static irqreturn_t rk3399_dmc_irq(int irq, void *dev_id)
 	/* Clear the DCF interrupt */
 	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, 0, 0,
 		      ROCKCHIP_SIP_CONFIG_DRAM_CLR_IRQ,
-		      0, 0, 0, 0, &res);
+		      0, 0, 0, 0, &res, NULL);
 
 	return IRQ_HANDLED;
 }
@@ -395,7 +395,7 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 		for (index = 0; index < size; index++) {
 			arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, *timing++, index,
 				      ROCKCHIP_SIP_CONFIG_DRAM_SET_PARAM,
-				      0, 0, 0, 0, &res);
+				      0, 0, 0, 0, &res, NULL);
 			if (res.a0) {
 				dev_err(dev, "Failed to set dram param: %ld\n",
 					res.a0);
@@ -406,7 +406,7 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 
 	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, 0, 0,
 		      ROCKCHIP_SIP_CONFIG_DRAM_INIT,
-		      0, 0, 0, 0, &res);
+		      0, 0, 0, 0, &res, NULL);
 
 	/*
 	 * We add a devfreq driver to our parent since it has a device tree node
diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
index b0d2549..8863637 100644
--- a/drivers/firmware/meson/meson_sm.c
+++ b/drivers/firmware/meson/meson_sm.c
@@ -74,7 +74,7 @@ static u32 __meson_sm_call(u32 cmd, u32 arg0, u32 arg1, u32 arg2,
 {
 	struct arm_smccc_res res;
 
-	arm_smccc_smc(cmd, arg0, arg1, arg2, arg3, arg4, 0, 0, &res);
+	arm_smccc_smc(cmd, arg0, arg1, arg2, arg3, arg4, 0, 0, &res, NULL);
 	return res.a0;
 }
 
diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 8263429..130c50f 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -126,7 +126,7 @@ static unsigned long __invoke_psci_fn_smc(unsigned long function_id,
 {
 	struct arm_smccc_res res;
 
-	arm_smccc_smc(function_id, arg0, arg1, arg2, 0, 0, 0, 0, &res);
+	arm_smccc_smc(function_id, arg0, arg1, arg2, 0, 0, 0, 0, &res, NULL);
 	return res.a0;
 }
 
diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-64.c
index 4a0f5ea..d164a9b 100644
--- a/drivers/firmware/qcom_scm-64.c
+++ b/drivers/firmware/qcom_scm-64.c
@@ -134,7 +134,7 @@ static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
 		do {
 			arm_smccc_smc(cmd, desc->arginfo, desc->args[0],
 				      desc->args[1], desc->args[2], x5, 0, 0,
-				      res);
+				      res, NULL);
 		} while (res->a0 == QCOM_SCM_INTERRUPTED);
 
 		mutex_unlock(&qcom_scm_lock);
@@ -253,7 +253,7 @@ void __qcom_scm_init(void)
 				 ARM_SMCCC_OWNER_SIP, function);
 
 	arm_smccc_smc(cmd, QCOM_SCM_ARGS(1), cmd & (~BIT(ARM_SMCCC_TYPE_SHIFT)),
-		      0, 0, 0, 0, 0, &res);
+		      0, 0, 0, 0, 0, &res, NULL);
 
 	if (!res.a0 && res.a1)
 		qcom_smccc_convention = ARM_SMCCC_SMC_64;
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 71227de..073f3845 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -240,7 +240,7 @@ static void mtk_hdmi_hw_make_reg_writable(struct mtk_hdmi *hdmi, bool enable)
 	 * this control bit to enable HDMI output in supervisor mode.
 	 */
 	arm_smccc_smc(MTK_SIP_SET_AUTHORIZED_SECURE_REG, 0x14000904, 0x80000000,
-		      0, 0, 0, 0, 0, &res);
+		      0, 0, 0, 0, 0, &res, NULL);
 
 	regmap_update_bits(hdmi->sys_regmap, hdmi->sys_offset + HDMI_SYS_CFG20,
 			   HDMI_PCLK_FREE_RUN, enable ? HDMI_PCLK_FREE_RUN : 0);
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index b5abfda..74231b4c 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -72,19 +72,33 @@ struct arm_smccc_res {
 };
 
 /**
+ * struct arm_smccc_quirk - Contains quirk information
+ * id contains quirk identification
+ * state contains the quirk specific information
+ */
+struct arm_smccc_quirk {
+	int	id;
+	union {
+		unsigned long a6;
+	} state;
+};
+
+/**
  * arm_smccc_smc() - make SMC calls
  * @a0-a7: arguments passed in registers 0 to 7
  * @res: result values from registers 0 to 3
+ * @quirk: optional quirk structure
  *
  * This function is used to make SMC calls following SMC Calling Convention.
  * The content of the supplied param are copied to registers 0 to 7 prior
  * to the SMC instruction. The return values are updated with the content
- * from register 0 to 3 on return from the SMC instruction.
+ * from register 0 to 3 on return from the SMC instruction.  An optional
+ * quirk structure provides vendor specific behavior.
  */
 asmlinkage void arm_smccc_smc(unsigned long a0, unsigned long a1,
 			unsigned long a2, unsigned long a3, unsigned long a4,
 			unsigned long a5, unsigned long a6, unsigned long a7,
-			struct arm_smccc_res *res);
+			struct arm_smccc_res *res, struct arm_smccc_quirk *quirk);
 
 /**
  * arm_smccc_hvc() - make HVC calls
-- 
1.9.1
