From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 24 Jan 2014 14:04:28 +0100
Subject: [PATCH] ARM: integrator: restore static map on the CP
Message-ID: <1390568668-32270-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 78d1632183454dba46ca8295484a5e7603acdc18 deleted the
static mappings of the core modules, but this static map is
still needed on the Integrator/CP (not the Integrator/AP).

Restore the static map on the Integrator/CP.

Reported-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please apply this fix directly to ARM SoC
if you're OK with it.
---
 arch/arm/mach-integrator/integrator_cp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 5e84149d1790..a3ef961e4a93 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -64,6 +64,7 @@ static void __iomem *intcp_con_base;
 
 /*
  * Logical      Physical
+ * f1000000	10000000	Core module registers
  * f1300000	13000000	Counter/Timer
  * f1400000	14000000	Interrupt controller
  * f1600000	16000000	UART 0
@@ -75,6 +76,11 @@ static void __iomem *intcp_con_base;
 
 static struct map_desc intcp_io_desc[] __initdata __maybe_unused = {
 	{
+		.virtual	= IO_ADDRESS(INTEGRATOR_HDR_BASE),
+		.pfn		= __phys_to_pfn(INTEGRATOR_HDR_BASE),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE
+	}, {
 		.virtual	= IO_ADDRESS(INTEGRATOR_CT_BASE),
 		.pfn		= __phys_to_pfn(INTEGRATOR_CT_BASE),
 		.length		= SZ_4K,
-- 
1.8.4.2
