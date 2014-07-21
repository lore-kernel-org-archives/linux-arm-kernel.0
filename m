From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon, 21 Jul 2014 15:47:20 +0100
Subject: [PATCH RFC 9/9] arm: imx: non-secure aliased mapping of GIC registers
In-Reply-To: <1405954040-30399-1-git-send-email-daniel.thompson@linaro.org>
References: <1405954040-30399-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1405954040-30399-10-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm/mach-imx/mach-imx6q.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index e60456d..192d268 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -381,10 +381,21 @@ static void __init imx6q_init_late(void)
 	}
 }
 
+static struct map_desc gic_cpu_io_desc __initdata = {
+		.virtual        = 0xff000000,
+		.pfn            = __phys_to_pfn(0x00a00000),
+		.length         = SZ_1M,
+		.type           = MT_DEVICE_NS,
+};
+
 static void __init imx6q_map_io(void)
 {
 	debug_ll_io_init();
 	imx_scu_map_io();
+	/* TODO: Need to check we are running without a secure monitor before
+	 *       setting up this mapping.
+	 */
+	iotable_init(&gic_cpu_io_desc, 1);
 }
 
 static void __init imx6q_init_irq(void)
-- 
1.9.3
