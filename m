From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue, 26 Dec 2017 15:32:53 +0200
Subject: [PATCH] ARM: pxa: ulpi: fix ulpi timeout and slowpath warn
Message-ID: <20171226133253.11653-1-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both cm-x300 and pxa3xx-ulpi use the plain clk_{en,dis}able() API.
With the new clocking framework this results in warnings of type:
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:714 clk_core_enable+0x90/0x9c
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 4.15.0-rc5-cm-x300+ #15
Hardware name: CM-X300 module
[<c001007c>] (unwind_backtrace) from [<c000df94>] (show_stack+0x10/0x14)
[<c000df94>] (show_stack) from [<c00199a8>] (__warn+0xd8/0x100)
[<c00199a8>] (__warn) from [<c0019a0c>] (warn_slowpath_null+0x3c/0x48)
[<c0019a0c>] (warn_slowpath_null) from [<c024e8c0>] (clk_core_enable+0x90/0x9c)
[<c024e8c0>] (clk_core_enable) from [<c024ea54>] (clk_core_enable_lock+0x18/0x2c)
[<c024ea54>] (clk_core_enable_lock) from [<c0016994>] (cm_x300_u2d_init+0x4c/0xe8)
[<c0016994>] (cm_x300_u2d_init) from [<c00163e0>] (pxa3xx_u2d_probe+0xe0/0x244)
[<c00163e0>] (pxa3xx_u2d_probe) from [<c0283de0>] (platform_drv_probe+0x38/0x88)
...
------------[ cut here ]------------
and alike...

And finally, it results in:
------------[ cut here ]------------
pxa310_ulpi_poll: ULPI access timed out!
OTG transceiver init failed
------------[ cut here ]------------

It might be that disabling the warning in kernel config would also do
the job, but IMO a better solution would be to switch to
clk_prepare_enable() and clk_disable_unprepare() APIs.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-pxa/cm-x300.c     | 4 ++--
 arch/arm/mach-pxa/pxa3xx-ulpi.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index 912e905a6af6..9ccfb10a9e0f 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -521,7 +521,7 @@ static int cm_x300_u2d_init(struct device *dev)
 			pr_err("failed to get CLK_POUT: %d\n", err);
 			return err;
 		}
-		clk_enable(pout_clk);
+		clk_prepare_enable(pout_clk);
 
 		err = cm_x300_ulpi_phy_reset();
 		if (err) {
@@ -536,7 +536,7 @@ static int cm_x300_u2d_init(struct device *dev)
 static void cm_x300_u2d_exit(struct device *dev)
 {
 	if (cpu_is_pxa310()) {
-		clk_disable(pout_clk);
+		clk_disable_unprepare(pout_clk);
 		clk_put(pout_clk);
 	}
 }
diff --git a/arch/arm/mach-pxa/pxa3xx-ulpi.c b/arch/arm/mach-pxa/pxa3xx-ulpi.c
index c00450764352..b3e2016f24b1 100644
--- a/arch/arm/mach-pxa/pxa3xx-ulpi.c
+++ b/arch/arm/mach-pxa/pxa3xx-ulpi.c
@@ -256,7 +256,7 @@ int pxa3xx_u2d_start_hc(struct usb_bus *host)
 	if (!u2d)
 		return 0;
 
-	clk_enable(u2d->clk);
+	clk_prepare_enable(u2d->clk);
 
 	if (cpu_is_pxa310()) {
 		pxa310_u2d_setup_otg_hc();
@@ -276,7 +276,7 @@ void pxa3xx_u2d_stop_hc(struct usb_bus *host)
 	if (cpu_is_pxa310())
 		pxa310_stop_otg_hc();
 
-	clk_disable(u2d->clk);
+	clk_disable_unprepare(u2d->clk);
 }
 EXPORT_SYMBOL_GPL(pxa3xx_u2d_stop_hc);
 
-- 
2.13.6
