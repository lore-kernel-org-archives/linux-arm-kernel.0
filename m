From: mike@compulab.co.il (Mike Rapoport)
Date: Tue, 15 Dec 2009 18:28:27 +0200
Subject: [PATCH] [ARM] pxa/cm-x300: fix build breakage caused by missing
	'select CPU_PXA310'
Message-ID: <4B27B92B.9020306@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric,
Apparently Igor's patches for CM-X300 were not applied properly. Somehow
commit db205463fd24c0972ad2c4e4fafb1c76e51b4380
([ARM] pxa/cm-x300: add PWM backlight support) introduced 'select HAVE_PWM'
to MACH_COLIBRY300 rather than CM-X300. I suspect that the same happened with
the patch that added 'select CPU_PXA310' to MACH_CM_X300. I'm not certain about
removing PWM support in Colibri, but MACH_CM_X300 need to get fixed.

---
Build of cm_x300_defconfig produces a bunch of errors:
  CC      arch/arm/mach-pxa/cm-x300.o
arch/arm/mach-pxa/cm-x300.c:186: error: 'ULPI_STP' undeclared here (not in a function)
arch/arm/mach-pxa/cm-x300.c:187: error: 'ULPI_NXT' undeclared here (not in a function)
arch/arm/mach-pxa/cm-x300.c:188: error: 'ULPI_DIR' undeclared here (not in a function)
arch/arm/mach-pxa/cm-x300.c:196: error: 'GPIO37_ULPI_DATA_OUT_7' undeclared here (not in a function)
arch/arm/mach-pxa/cm-x300.c:197: error: 'GPIO38_ULPI_CLK' undeclared here (not in a function)
make[1]: *** [arch/arm/mach-pxa/cm-x300.o] Error 1
make: *** [arch/arm/mach-pxa] Error 2
The missing defines are available when CONFIG_CPU_PXA310=y. Adding
'select CPU_PXA310' fixes the build

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-pxa/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index e6d8e10..4668d4b 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -110,6 +110,8 @@ config MACH_CM_X300
 	bool "CompuLab CM-X300 modules"
 	select PXA3xx
 	select CPU_PXA300
+	select CPU_PXA310
+	select HAVE_PWM

 config ARCH_GUMSTIX
 	bool "Gumstix XScale 255 boards"
-- 
1.6.0.6


-- 
Sincerely yours,
Mike.
