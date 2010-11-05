From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri,  5 Nov 2010 10:46:10 +0100
Subject: [PATCH 6/7] ARM i.MX51: return gracefully on different socs
In-Reply-To: <1288950371-1552-1-git-send-email-s.hauer@pengutronix.de>
References: <1288950371-1552-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1288950371-1552-7-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Code called from an initcall can be maybe called for
machines it's not intended for. So check for valid
machines and return gracefully if an incompatible machine
is found.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx5/cpu.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/cpu.c b/arch/arm/mach-mx5/cpu.c
index eaacb6e..061ab70 100644
--- a/arch/arm/mach-mx5/cpu.c
+++ b/arch/arm/mach-mx5/cpu.c
@@ -79,6 +79,9 @@ EXPORT_SYMBOL(mx51_revision);
  */
 static int __init mx51_neon_fixup(void)
 {
+	if (!cpu_is_mx51())
+		return 0;
+
 	if (mx51_revision() < MX51_CHIP_REV_3_0 && (elf_hwcap & HWCAP_NEON)) {
 		elf_hwcap &= ~HWCAP_NEON;
 		pr_info("Turning off NEON support, detected broken NEON implementation\n");
-- 
1.7.2.3
