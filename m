From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 24 Oct 2011 14:58:07 +0200
Subject: [PATCH 12/12] ARM: imx: move special idle code to proper
	out-of-line pm_idle hooks
In-Reply-To: <1319449801-12367-13-git-send-email-nico@fluxnic.net>
References: <1319449801-12367-1-git-send-email-nico@fluxnic.net>
	<1319449801-12367-13-git-send-email-nico@fluxnic.net>
Message-ID: <20111024125807.GA2263@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nico,

On Mon, Oct 24, 2011 at 05:50:01AM -0400, Nicolas Pitre wrote:
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> ---
>  arch/arm/mach-imx/Makefile              |    4 +-
>  arch/arm/mach-imx/idle-mx3.c            |   31 +++++++++++++++++++++++++++++
>  arch/arm/mach-imx/mm-imx31.c            |    1 +
>  arch/arm/mach-imx/mm-imx35.c            |    1 +
>  arch/arm/mach-mx5/clock-mx51-mx53.c     |    7 ++++++
>  arch/arm/plat-mxc/include/mach/system.h |   33 +------------------------------
>  6 files changed, 43 insertions(+), 34 deletions(-)
>  create mode 100644 arch/arm/mach-imx/idle-mx3.c

Please fold the following in this patch. It fixes the compile errors
in mx3_defconfig and mx51_defconfig. Also, we implemented
arch_idle and now with your patch pm_idle, thus we have to call
local_irq_enable().

With this:

Tested-by: Sascha Hauer <s.hauer@pengutronix.de>

on i.MX35, i.MX51 and i.MX27


commit 380c365d85af17d7c4bac5f0db961986fbb7f40d
Author: Sascha Hauer <s.hauer@pengutronix.de>
Date:   Mon Oct 24 14:26:20 2011 +0200

    Fix compile and runtime errors introduced with last commit
    
    Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

diff --git a/arch/arm/mach-imx/idle-mx3.c b/arch/arm/mach-imx/idle-mx3.c
index 580b407..ac0d655 100644
--- a/arch/arm/mach-imx/idle-mx3.c
+++ b/arch/arm/mach-imx/idle-mx3.c
@@ -28,4 +28,6 @@ void mx3_idle(void)
 	"orr %0, %0, #0x00000004\n"
 	"mcr p15, 0, %0, c1, c0, 0\n"
 	: "=r" (reg));
+
+	local_irq_enable();
 }
diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index c57bd92..63dc037 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -15,12 +15,14 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/clkdev.h>
+#include <linux/pm.h>
 
 #include <asm/div64.h>
 
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/clock.h>
+#include <mach/system.h>
 
 #include "crm_regs.h"
 
@@ -1532,6 +1534,8 @@ static void clk_tree_init(void)
 static void mx51_idle(void)
 {
 	mx5_cpu_lp_set(WAIT_UNCLOCKED_POWER_OFF);
+
+	local_irq_enable();
 }
 
 int __init mx51_clocks_init(unsigned long ckil, unsigned long osc,
diff --git a/arch/arm/plat-mxc/include/mach/mx3x.h b/arch/arm/plat-mxc/include/mach/mx3x.h
index 388a407..24e61e4 100644
--- a/arch/arm/plat-mxc/include/mach/mx3x.h
+++ b/arch/arm/plat-mxc/include/mach/mx3x.h
@@ -203,6 +203,9 @@ static inline int mx35_revision(void)
 {
 	return mx35_cpu_rev;
 }
+
+void mx3_idle(void);
+
 #endif
 
 #endif /* ifndef __MACH_MX3x_H__ */
diff --git a/arch/arm/plat-mxc/include/mach/system.h b/arch/arm/plat-mxc/include/mach/system.h
index 89d08c5..9875cc0 100644
--- a/arch/arm/plat-mxc/include/mach/system.h
+++ b/arch/arm/plat-mxc/include/mach/system.h
@@ -20,6 +20,8 @@
 #include <mach/hardware.h>
 #include <mach/common.h>
 
+extern void mx5_cpu_lp_set(enum mxc_cpu_pwr_mode mode);
+
 static inline void arch_idle(void)
 {
 	cpu_do_idle();

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
