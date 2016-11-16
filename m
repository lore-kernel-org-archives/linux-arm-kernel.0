From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 16 Nov 2016 08:44:38 -0800
Subject: [PATCH] ARM: davinci: PM: fix build when da850 not compiled in
Message-ID: <20161116164438.9881-1-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, suspend/resume support is only available on da850 platforms,
and the platform PM code has dependencies on da850 functions.  However,
CONFIG_SUSPEND might be enabled even when da850 support is not, causing
build failure:

arch/arm/mach-davinci/built-in.o: In function `davinci_pm_init':
pm_domain.c:(.init.text+0x1fb8): undefined reference to `da8xx_get_mem_ctlr'
pm_domain.c:(.init.text+0x20b0): undefined reference to `da8xx_syscfg1_base'

Fix this by only building the PM core when da850 is enabled.

Reported-by: Sekhar Nori <nsekhar@ti.com>
Fixes: aa9aa1ec2df6 ARM: davinci: PM: rework init, remove platform device
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm/mach-davinci/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
index da4c336b4637..0a2e6da45f28 100644
--- a/arch/arm/mach-davinci/Makefile
+++ b/arch/arm/mach-davinci/Makefile
@@ -36,5 +36,7 @@ obj-$(CONFIG_MACH_OMAPL138_HAWKBOARD)	+= board-omapl138-hawk.o
 
 # Power Management
 obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
-obj-$(CONFIG_SUSPEND)			+= pm.o sleep.o
 obj-$(CONFIG_HAVE_CLK)			+= pm_domain.o
+ifeq ($(CONFIG_SUSPEND),y)
+obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= pm.o sleep.o
+endif
-- 
2.9.3
