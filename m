From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Oct 2010 18:10:55 +0200
Subject: [PATCH 5/7] arm/realview: fix building PB-A8 and PBX with CONFIG_PCI
In-Reply-To: <1287072657-32477-1-git-send-email-arnd@arndb.de>
References: <1287072657-32477-1-git-send-email-arnd@arndb.de>
Message-ID: <1287072657-32477-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In a multi-board kernel configuration with multiple realview
boards enabled, you can have CONFIG_PCI enabled on these,
which results in a build failure because of unresolved symbols.

Use the same symbol as on the other boards instead to work
around this.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-realview/realview_pba8.c |    2 +-
 arch/arm/mach-realview/realview_pbx.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index 6c37621..6c8c89e 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -79,7 +79,7 @@ static struct map_desc realview_pba8_io_desc[] __initdata = {
 	},
 #ifdef CONFIG_PCI
 	{
-		.virtual	= PCIX_UNIT_BASE,
+		.virtual	= (unsigned long)REALVIEW_PCI_VIRT_BASE,
 		.pfn		= __phys_to_pfn(REALVIEW_PBA8_PCI_BASE),
 		.length		= REALVIEW_PBA8_PCI_BASE_SIZE,
 		.type		= MT_DEVICE
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index 9428eff..07f3647 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -80,7 +80,7 @@ static struct map_desc realview_pbx_io_desc[] __initdata = {
 	},
 #ifdef CONFIG_PCI
 	{
-		.virtual	= PCIX_UNIT_BASE,
+		.virtual	= (unsigned long)REALVIEW_PCI_VIRT_BASE,
 		.pfn		= __phys_to_pfn(REALVIEW_PBX_PCI_BASE),
 		.length		= REALVIEW_PBX_PCI_BASE_SIZE,
 		.type		= MT_DEVICE,
-- 
1.7.1
