From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 14 Apr 2016 14:07:58 +0300
Subject: [PATCHv2 09/28] ARM: AM33xx: fix module_wait_ready without clkctrl
 register
In-Reply-To: <1460632097-25727-1-git-send-email-t-kristo@ti.com>
References: <1460632097-25727-1-git-send-email-t-kristo@ti.com>
Message-ID: <1460632097-25727-10-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the module has no clkctrl register defined, module_wait_ready should
not try to access this. This can potentially cause an illegal register
access, and result in bad idle reporting also.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm33xx.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
index 7b181f9..c073fb5 100644
--- a/arch/arm/mach-omap2/cm33xx.c
+++ b/arch/arm/mach-omap2/cm33xx.c
@@ -220,6 +220,9 @@ static int am33xx_cm_wait_module_ready(u8 part, s16 inst, u16 clkctrl_offs,
 {
 	int i = 0;
 
+	if (!clkctrl_offs)
+		return 0;
+
 	omap_test_timeout(_is_module_ready(inst, clkctrl_offs),
 			  MAX_MODULE_READY_TIME, i);
 
-- 
1.7.9.5
