From: olof@lixom.net (Olof Johansson)
Date: Tue, 25 Jun 2013 18:30:31 -0700
Subject: [PATCH] ARM: ux500: check platform in ux500_l2x0_init
Message-ID: <1372210231-22900-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add compatible checks for ux500. This should probably be moved to generic
DT-based probing whenever DT is populated instead, but until then at
least don't panic all non-ux500 multiplatform machines.

Signed-off-by: Olof Johansson <olof@lixom.net>
---

Linus, I'll apply this directly if you ack it, let me know.


-Olof

 arch/arm/mach-ux500/cache-l2x0.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-ux500/cache-l2x0.c b/arch/arm/mach-ux500/cache-l2x0.c
index f58615b..3facc1e 100644
--- a/arch/arm/mach-ux500/cache-l2x0.c
+++ b/arch/arm/mach-ux500/cache-l2x0.c
@@ -39,6 +39,15 @@ static int __init ux500_l2x0_init(void)
 {
 	u32 aux_val = 0x3e000000;
 
+	/* Ick. I wish there was a single compatible value to compare for,
+	 * but there isn't.
+	 */
+	if (!of_machine_is_compatible("st-ericsson,u8500") &&
+	    !of_machine_is_compatible("st-ericsson,u8540") &&
+	    !of_machine_is_compatible("st-ericsson,u9500") &&
+	    !of_machine_is_compatible("st-ericsson,u8540"))
+		return -ENODEV;
+
 	if (cpu_is_u8500_family() || cpu_is_ux540_family())
 		l2x0_base = __io_address(U8500_L2CC_BASE);
 	else
-- 
1.8.1.192.gc4361b8
