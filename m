From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 14 Sep 2015 12:52:49 -0700
Subject: [PATCH 3/3] ARM: brcmstb: Setup BIU control registers during boot
In-Reply-To: <1442260369-6575-1-git-send-email-f.fainelli@gmail.com>
References: <1442260369-6575-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1442260369-6575-4-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Call brcmstb_biuctrl_init() in brcmstb's init_irq machine descriptor
callback since we need to setup the Bus Interface Unit before SMP in
particular, but we also need to be able to remap registers.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mach-bcm/brcmstb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-bcm/brcmstb.c b/arch/arm/mach-bcm/brcmstb.c
index 3a60f7ee3f0c..99a67cfb7c0d 100644
--- a/arch/arm/mach-bcm/brcmstb.c
+++ b/arch/arm/mach-bcm/brcmstb.c
@@ -12,11 +12,19 @@
  */
 
 #include <linux/init.h>
+#include <linux/irqchip.h>
 #include <linux/of_platform.h>
+#include <linux/soc/brcmstb/brcmstb.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+static void __init brcmstb_init_irq(void)
+{
+	irqchip_init();
+	brcmstb_biuctrl_init();
+}
+
 static const char *const brcmstb_match[] __initconst = {
 	"brcm,bcm7445",
 	"brcm,brcmstb",
@@ -25,4 +33,5 @@ static const char *const brcmstb_match[] __initconst = {
 
 DT_MACHINE_START(BRCMSTB, "Broadcom STB (Flattened Device Tree)")
 	.dt_compat	= brcmstb_match,
+	.init_irq	= brcmstb_init_irq,
 MACHINE_END
-- 
2.1.0
