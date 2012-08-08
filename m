From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 8 Aug 2012 18:18:20 +0800
Subject: imx6q restart is broken
Message-ID: <20120808101817.GA14718@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Dirk for reporting that imx6q restart (reboot command) is broken.

I tracked down the issue a little bit and found imx6q_restart hangs
on the of_iomap/ioremap call.  The following change, moving the call
somewhere else than imx6q_restart, will just fix the problem.

Does that mean ioremap call is not allowed in platform restart hook?
I'm not sure about that, because I found it works just fine if I build
imx_v6_v7_defconfig with V6 (imx3) platforms excluded (IOW, build a V7
only kernel - imx5 and imx6), which is the case how I tested imx6q
restart feature when I was adding it.

To summarize, the imx6q_restart hangs at ioremap call on a V6 + V7
kernel, while it works fine on a V7 only image.  I need some help to
understand that.

Regards,
Shawn

--8<---

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 5ec0608..01e7489 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -37,14 +37,10 @@
 #include <mach/cpuidle.h>
 #include <mach/hardware.h>

+static void __iomem *wdog_base;

 void imx6q_restart(char mode, const char *cmd)
 {
-       struct device_node *np;
-       void __iomem *wdog_base;
-
-       np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-wdt");
-       wdog_base = of_iomap(np, 0);
        if (!wdog_base)
                goto soft;

@@ -159,6 +155,11 @@ static void __init imx6q_usb_init(void)

 static void __init imx6q_init_machine(void)
 {
+       struct device_node *np;
+
+       np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-wdt");
+       wdog_base = of_iomap(np, 0);
+
        /*
         * This should be removed when all imx6q boards have pinctrl
         * states for devices defined in device tree.
