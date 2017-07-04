From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  4 Jul 2017 17:41:36 +0200
Subject: [PATCH 2/9] ARM: shmobile: rcar-gen2: Obtain jump stub region from DT
In-Reply-To: <1499182903-31339-1-git-send-email-geert+renesas@glider.be>
References: <1499182903-31339-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1499182903-31339-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for obtaining from DT the SRAM region to store the jump stub
for CPU core bringup, according to the renesas,smp-sram DT bindings.

If no region is specified in DT, the code falls back to hardcoded ICRAM1
as before, to maintain backwards compatibility.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/pm-rcar-gen2.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rcar-gen2.c b/arch/arm/mach-shmobile/pm-rcar-gen2.c
index 0178da7ace82dcbd..e5f215c8b218100a 100644
--- a/arch/arm/mach-shmobile/pm-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/pm-rcar-gen2.c
@@ -11,7 +11,9 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/ioport.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/smp.h>
 #include <linux/soc/renesas/rcar-sysc.h>
 #include <asm/io.h>
@@ -69,8 +71,9 @@ void __init rcar_gen2_pm_init(void)
 	struct device_node *np, *cpus;
 	bool has_a7 = false;
 	bool has_a15 = false;
-	phys_addr_t boot_vector_addr = ICRAM1;
+	struct resource res;
 	u32 syscier = 0;
+	int error;
 
 	if (once++)
 		return;
@@ -91,14 +94,38 @@ void __init rcar_gen2_pm_init(void)
 	else if (of_machine_is_compatible("renesas,r8a7791"))
 		syscier = 0x00111003;
 
+	np = of_find_compatible_node(NULL, NULL, "renesas,smp-sram");
+	if (!np) {
+		/* No smp-sram in DT, fall back to hardcoded address */
+		res = (struct resource)DEFINE_RES_MEM(ICRAM1,
+						      shmobile_boot_size);
+		goto map;
+	}
+
+	error = of_address_to_resource(np, 0, &res);
+	if (error) {
+		pr_err("Failed to get smp-sram address: %d\n", error);
+		return;
+	}
+
+map:
 	/* RAM for jump stub, because BAR requires 256KB aligned address */
-	p = ioremap_nocache(boot_vector_addr, shmobile_boot_size);
+	if (res.start & (256 * 1024 - 1) ||
+	    resource_size(&res) < shmobile_boot_size) {
+		pr_err("Invalid smp-sram region\n");
+		return;
+	}
+
+	p = ioremap(res.start, resource_size(&res));
+	if (!p)
+		return;
+
 	memcpy_toio(p, shmobile_boot_vector, shmobile_boot_size);
 	iounmap(p);
 
 	/* setup reset vectors */
 	p = ioremap_nocache(RST, 0x63);
-	bar = phys_to_sbar(boot_vector_addr);
+	bar = phys_to_sbar(res.start);
 	if (has_a15) {
 		writel_relaxed(bar, p + CA15BAR);
 		writel_relaxed(bar | SBAR_BAREN, p + CA15BAR);
-- 
2.7.4
