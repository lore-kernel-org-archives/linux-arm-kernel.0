From: tony@atomide.com (Tony Lindgren)
Date: Fri, 30 Apr 2010 13:33:57 -0700
Subject: [PATCH 05/11] omap4: Fix multiboot with CONFIG_PM and
	CONFIG_ARCH_OMAP3 selected
In-Reply-To: <20100430202603.25812.41834.stgit@baageli.muru.com>
References: <20100430202603.25812.41834.stgit@baageli.muru.com>
Message-ID: <20100430203357.25812.11600.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We cannot use the omap34xx_sram_init(). It needs to be implemented
for omap4. Otherwise we get an error and the system won't boot:

Unhandled fault: imprecise external abort (0x1406) at 0xea963e94
...

Fix this by adding a dummy omap44xx_sram_init().

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/sram.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 51f4dfb..226b2e8 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -437,6 +437,20 @@ static inline int omap34xx_sram_init(void)
 }
 #endif
 
+#ifdef CONFIG_ARCH_OMAP4
+int __init omap44xx_sram_init(void)
+{
+	printk(KERN_ERR "FIXME: %s not implemented\n", __func__);
+
+	return -ENODEV;
+}
+#else
+static inline int omap44xx_sram_init(void)
+{
+	return 0;
+}
+#endif
+
 int __init omap_sram_init(void)
 {
 	omap_detect_sram();
@@ -451,7 +465,7 @@ int __init omap_sram_init(void)
 	else if (cpu_is_omap34xx())
 		omap34xx_sram_init();
 	else if (cpu_is_omap44xx())
-		omap34xx_sram_init(); /* FIXME: */
+		omap44xx_sram_init();
 
 	return 0;
 }
