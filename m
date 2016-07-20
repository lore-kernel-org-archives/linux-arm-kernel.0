From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Wed, 20 Jul 2016 00:13:32 -0400
Subject: [PATCH 3/3] ARM: pxa: add module.h for spitz symbol_get/symbol_put
 usage
In-Reply-To: <20160720041332.30789-1-paul.gortmaker@windriver.com>
References: <20160720041332.30789-1-paul.gortmaker@windriver.com>
Message-ID: <20160720041332.30789-4-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During unrelated work, attempting to remove an include of the
linux/module.h in favour of "struct module;" in order to reduce
header entanglement, we found doing so caused a build failure in
this file.

mach-pxa/spitz.c: In function 'spitz_bl_kick_battery':
mach-pxa/spitz.c:524:2: error: implicit declaration of function 'symbol_get' [-Werror=implicit-function-declaration]
mach-pxa/spitz.c:524:12: warning: assignment makes pointer from integer without a cast [enabled by default]
mach-pxa/spitz.c:527:3: error: implicit declaration of function 'symbol_put' [-Werror=implicit-function-declaration]

It turns out this file uses symbol_get/symbol_put which live in the
module.h header, but it wasn't including module.h -- which was
being masked by the module.h in include/linux/gpio/driver.h - the
one we want to remove/replace.

With ARM and GPIO being different subsystems, we'll need to get
this in ARM 1st, and then wait a release before changing the GPIO
header, otherwise we'll risk triggering build failures.

Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: linux-omap at vger.kernel.org
Cc: linux-gpio at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/arm/mach-pxa/spitz.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index b410698808ca..8078e3cdb6c8 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/module.h>	/* symbol_get ; symbol_put */
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/gpio_keys.h>
-- 
2.8.4
