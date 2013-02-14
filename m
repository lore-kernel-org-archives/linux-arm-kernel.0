From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Feb 2013 14:49:22 +0100
Subject: [PATCH 06/11] ARM: integrator/versatile: fix NOMMU warnings
In-Reply-To: <1360849767-1463135-1-git-send-email-arnd@arndb.de>
References: <1360849767-1463135-1-git-send-email-arnd@arndb.de>
Message-ID: <1360849767-1463135-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On NOMMU kernels, the io_desc variables are unused
because we don't use the MMU to remap the MMIO
areas.

Marking these variables as __maybe_unused easily
avoids the otherwise harmless warnings like

warning: 'versatile_io_desc' defined but not used

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mach-integrator/integrator_ap.c | 2 +-
 arch/arm/mach-integrator/integrator_cp.c | 2 +-
 arch/arm/mach-versatile/core.c           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index 11e2a41..11b1d21 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -94,7 +94,7 @@ void __iomem *ap_syscon_base;
  * f1b00000	1b000000	GPIO
  */
 
-static struct map_desc ap_io_desc[] __initdata = {
+static struct map_desc ap_io_desc[] __initdata __maybe_unused = {
 	{
 		.virtual	= IO_ADDRESS(INTEGRATOR_HDR_BASE),
 		.pfn		= __phys_to_pfn(INTEGRATOR_HDR_BASE),
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 7322838..01a888d 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -78,7 +78,7 @@ static void __iomem *intcp_con_base;
  * fcb00000	cb000000	CP system control
  */
 
-static struct map_desc intcp_io_desc[] __initdata = {
+static struct map_desc intcp_io_desc[] __initdata __maybe_unused = {
 	{
 		.virtual	= IO_ADDRESS(INTEGRATOR_HDR_BASE),
 		.pfn		= __phys_to_pfn(INTEGRATOR_HDR_BASE),
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 5d59294..60c092c 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -114,7 +114,7 @@ void __init versatile_init_irq(void)
 	writel(PIC_MASK, VA_SIC_BASE + SIC_INT_PIC_ENABLE);
 }
 
-static struct map_desc versatile_io_desc[] __initdata = {
+static struct map_desc versatile_io_desc[] __initdata __maybe_unused = {
 	{
 		.virtual	=  IO_ADDRESS(VERSATILE_SYS_BASE),
 		.pfn		= __phys_to_pfn(VERSATILE_SYS_BASE),
-- 
1.8.1.2
