From: will.deacon@arm.com (Will Deacon)
Date: Wed, 30 Jan 2013 14:27:49 +0000
Subject: [PATCH 6/6] ARM: integrator: ensure ap_syscon_base is initialised
 when !CONFIG_MMU
In-Reply-To: <1359556069-28289-1-git-send-email-will.deacon@arm.com>
References: <1359556069-28289-1-git-send-email-will.deacon@arm.com>
Message-ID: <1359556069-28289-7-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When running on Integrator/AP using atags, ap_syscon_base is initialised
in ->map_io, which isn't called for !MMU platforms.

Instead, initialise the pointer in ->machine_init, as we do when booting
with device-tree.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-integrator/integrator_ap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index 11e2a41..26762bf 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -613,7 +613,6 @@ static struct map_desc ap_io_desc_atag[] __initdata = {
 static void __init ap_map_io_atag(void)
 {
 	iotable_init(ap_io_desc_atag, ARRAY_SIZE(ap_io_desc_atag));
-	ap_syscon_base = __io_address(INTEGRATOR_SC_BASE);
 	ap_map_io();
 }
 
@@ -685,6 +684,7 @@ static void __init ap_init(void)
 
 	platform_device_register(&cfi_flash_device);
 
+	ap_syscon_base = __io_address(INTEGRATOR_SC_BASE);
 	sc_dec = readl(ap_syscon_base + INTEGRATOR_SC_DEC_OFFSET);
 	for (i = 0; i < 4; i++) {
 		struct lm_device *lmdev;
-- 
1.8.0
