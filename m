From: arnd@arndb.de (Arnd Bergmann)
Date: Mon,  8 Feb 2016 15:24:57 +0100
Subject: [PATCH] ARM: ks8695: fix __initdata annotation
Message-ID: <1454941509-2773774-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clang complains about the __initdata section attribute being in the
wrong place in two files of ks8695:

arch/arm/mach-ks8695/cpu.c:37:31: error: '__section__' attribute only applies to functions and global variables
arch/arm/mach-ks8695/board-og.c:83:31: error: '__section__' attribute only applies to functions and global variables

This moves the attribute to the correct place.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ks8695/board-og.c | 2 +-
 arch/arm/mach-ks8695/cpu.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ks8695/board-og.c b/arch/arm/mach-ks8695/board-og.c
index 1f4f2f4f25bb..fa1a7c2ca2bb 100644
--- a/arch/arm/mach-ks8695/board-og.c
+++ b/arch/arm/mach-ks8695/board-og.c
@@ -80,7 +80,7 @@ static void __init og_pci_bus_reset(void)
 #define	S8250_VIRT	0xf4000000
 #define	S8250_SIZE	0x00100000
 
-static struct __initdata map_desc og_io_desc[] = {
+static struct map_desc __initdata og_io_desc[] = {
 	{
 		.virtual	= S8250_VIRT,
 		.pfn		= __phys_to_pfn(S8250_PHYS),
diff --git a/arch/arm/mach-ks8695/cpu.c b/arch/arm/mach-ks8695/cpu.c
index 474a050da85b..f56937890e3a 100644
--- a/arch/arm/mach-ks8695/cpu.c
+++ b/arch/arm/mach-ks8695/cpu.c
@@ -34,7 +34,7 @@
 #include <mach/regs-misc.h>
 
 
-static struct __initdata map_desc ks8695_io_desc[] = {
+static struct map_desc __initdata ks8695_io_desc[] = {
 	{
 		.virtual	= (unsigned long)KS8695_IO_VA,
 		.pfn		= __phys_to_pfn(KS8695_IO_PA),
-- 
2.7.0
