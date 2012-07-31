From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 31 Jul 2012 14:39:02 +0100
Subject: [PATCH 08/19] ARM: ux500: Fork MSP platform registration for
 step-by-step DT enablement
In-Reply-To: <1343741953-17828-1-git-send-email-lee.jones@linaro.org>
References: <1343741953-17828-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1343741953-17828-9-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We've done this before and it worked well last time. Here we're
duplicating a complex registration function to ease the process
of enabling it for Device Tree. As there are quite a few steps
taken during the registration process, it makes sense to break
them up into more manageable chunks. This patch will aid us.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-msp.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/mach-ux500/board-mop500-msp.c b/arch/arm/mach-ux500/board-mop500-msp.c
index 573d912..7dd997a 100644
--- a/arch/arm/mach-ux500/board-mop500-msp.c
+++ b/arch/arm/mach-ux500/board-mop500-msp.c
@@ -172,6 +172,26 @@ static struct msp_i2s_platform_data msp3_platform_data = {
 	.msp_i2s_dma_tx	= NULL,
 };
 
+/* Due for removal once the MSP driver has been fully DT:ed. */
+void mop500_of_msp_init(struct device *parent)
+{
+	pr_info("%s: Register platform-device 'snd-soc-u8500'.\n", __func__);
+	platform_device_register(&snd_soc_mop500);
+
+	pr_info("Initialize MSP I2S-devices.\n");
+	db8500_add_msp_i2s(parent, 0, U8500_MSP0_BASE, IRQ_DB8500_MSP0,
+			   &msp0_platform_data);
+	db8500_add_msp_i2s(parent, 1, U8500_MSP1_BASE, IRQ_DB8500_MSP1,
+			   &msp1_platform_data);
+	db8500_add_msp_i2s(parent, 2, U8500_MSP2_BASE, IRQ_DB8500_MSP2,
+			   &msp2_platform_data);
+	db8500_add_msp_i2s(parent, 3, U8500_MSP3_BASE, IRQ_DB8500_MSP1,
+			   &msp3_platform_data);
+
+	pr_info("%s: Register platform-device 'ux500-pcm'\n", __func__);
+	platform_device_register(&ux500_pcm);
+}
+
 void mop500_msp_init(struct device *parent)
 {
 	pr_info("%s: Register platform-device 'snd-soc-u8500'.\n", __func__);
-- 
1.7.9.5
