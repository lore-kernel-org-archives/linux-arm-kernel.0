From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Oct 2015 15:14:05 +0200
Subject: [PATCH] rtc: davinci: remove incorrect reference to probe function
Message-ID: <5677325.oZsHpDNL2Z@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The davinci rtc driver uses the module_platform_driver_probe()
helper to call the probe function and mark it as __init, but
it also puts a reference into its davinci_rtc_driver function.

This will crash if we ever get a deferred probe and the probe
function is called again after the init section has been removed.
kbuild warns about this:

WARNING: vmlinux.o(.data+0x1aa2b4): Section mismatch in reference from the variable davinci_rtc_driver to the function .init.text:davinci_rtc_probe()
The variable davinci_rtc_driver references
the function __init davinci_rtc_probe()

This patch removes the .probe callback from the platform driver,
which avoids those problems.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/rtc/rtc-davinci.c b/drivers/rtc/rtc-davinci.c
index c84f46168a52..c5432bf64e1c 100644
--- a/drivers/rtc/rtc-davinci.c
+++ b/drivers/rtc/rtc-davinci.c
@@ -546,7 +546,6 @@ static int __exit davinci_rtc_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver davinci_rtc_driver = {
-	.probe		= davinci_rtc_probe,
 	.remove		= __exit_p(davinci_rtc_remove),
 	.driver		= {
 		.name = "rtc_davinci",
