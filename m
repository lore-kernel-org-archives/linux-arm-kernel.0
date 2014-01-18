From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 18 Jan 2014 18:54:11 -0500
Subject: [PATCH] ARM: kirkwood: kirkwood_pm_init() should return void
In-Reply-To: <1389984731-20220-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1389984731-20220-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20140118235411.GN29184@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 17, 2014 at 03:52:11PM -0300, Ezequiel Garcia wrote:
> This function was originally meant to return void as declared in the
> common.h header. Fix it and include the header to catch these errors
> in the future.
> 
> Reported-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/mach-kirkwood/pm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

merf.  I get the following warning when building kirkwood_defconfig:

arch/arm/mach-kirkwood/pm.c: In function 'kirkwood_pm_init':
arch/arm/mach-kirkwood/pm.c:73:2: warning: 'return' with a value, in function returning void [enabled by default]

I've amended the patch as below and pushed it to mvebu/fixes

thx,

Jason.

--------->8--------------------
commit 77dfdeb41125b6468790fa4c620da262c910cbc9
Author: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Date:   Fri Jan 17 15:52:11 2014 -0300

    ARM: kirkwood: kirkwood_pm_init() should return void
    
    This function was originally meant to return void as declared in the
    common.h header. Fix it and include the header to catch these errors
    in the future.
    
    [jac] removed 'return 0;' to clear this warning:
    
      arch/arm/mach-kirkwood/pm.c: In function 'kirkwood_pm_init':
      arch/arm/mach-kirkwood/pm.c:73:2: warning: 'return' with a value, in function returning void [enabled by default]
    
    Reported-by: Andrew Lunn <andrew@lunn.ch>
    Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
    Acked-by: Andrew Lunn <andrew@lunn.ch>
    Signed-off-by: Jason Cooper <jason@lakedaemon.net>

diff --git a/arch/arm/mach-kirkwood/pm.c b/arch/arm/mach-kirkwood/pm.c
index 8783a7184e73..c6ab8d9303a5 100644
--- a/arch/arm/mach-kirkwood/pm.c
+++ b/arch/arm/mach-kirkwood/pm.c
@@ -18,6 +18,7 @@
 #include <linux/suspend.h>
 #include <linux/io.h>
 #include <mach/bridge-regs.h>
+#include "common.h"
 
 static void __iomem *ddr_operation_base;
 
@@ -65,9 +66,8 @@ static const struct platform_suspend_ops kirkwood_suspend_ops = {
 	.valid = kirkwood_pm_valid_standby,
 };
 
-int __init kirkwood_pm_init(void)
+void __init kirkwood_pm_init(void)
 {
 	ddr_operation_base = ioremap(DDR_OPERATION_BASE, 4);
 	suspend_set_ops(&kirkwood_suspend_ops);
-	return 0;
 }
