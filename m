From: gururaja.hebbar@ti.com (Hebbar Gururaja)
Date: Fri, 31 May 2013 12:03:24 +0530
Subject: [PATCH 1/2] rtc: omap: add option to indicate wakeup support through
 DT
In-Reply-To: <1369982005-8572-1-git-send-email-gururaja.hebbar@ti.com>
References: <1369982005-8572-1-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <1369982005-8572-2-git-send-email-gururaja.hebbar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even though RTC-IP is wakeup capable, Not all Boards support it.

For example
The rtc alarm wakeup is available in rtc-ip since omap1 days but alarm
was not wired properly in previous ompa1 boards.

	commit fa5b07820fe3a0fc06ac368516e71f10a59b9539
	Author: Sekhar Nori <nsekhar@ti.com>
	Date:   Wed Oct 27 15:33:05 2010 -0700

	rtc: omap: let device wakeup capability be configured from chip
	init logic

	The rtc-omap driver currently hardcodes the RTC wakeup
	capability to be "not capable".  While this seems to be true for
	existing OMAP1 boards which are not wired for this, the
	DA850/OMAP-L138 SoC, the RTC can always be wake up source from
	its "deep sleep" mode.

Current rtc-omap driver expects the rtc module wake-up capabilities to
be set up by board specific code. However, in case of DT, this is not
possible.

So, add a DT property "ti,wakeup_capable" to indicate that the module is
wake-up capable.

Signed-off-by: Hebbar Gururaja <gururaja.hebbar@ti.com>
---
:100644 100644 b47aa41... 108a629... M	Documentation/devicetree/bindings/rtc/rtc-omap.txt
:100644 100644 b0ba3fc... 000a02f... M	drivers/rtc/rtc-omap.c
 Documentation/devicetree/bindings/rtc/rtc-omap.txt |    4 ++++
 drivers/rtc/rtc-omap.c                             |    5 +++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/rtc-omap.txt b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
index b47aa41..108a629 100644
--- a/Documentation/devicetree/bindings/rtc/rtc-omap.txt
+++ b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
@@ -6,6 +6,10 @@ Required properties:
 - interrupts: rtc timer, alarm interrupts in order
 - interrupt-parent: phandle for the interrupt controller
 
+Optional properties:
+- ti,wakeup_capable: Inform the rtc driver that this module is wake-up
+  capable so that rtcwake and suspend tests can work.
+
 Example:
 
 rtc at 1c23000 {
diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index b0ba3fc..000a02f 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -423,6 +423,11 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
 	 *    is write-only, and always reads as zero...)
 	 */
 
+	/* Fixup wakeup-enable feature based on the device tree */
+	if (of_id && of_find_property(pdev->dev.of_node,
+				      "ti,wakeup_capable", NULL))
+		device_init_wakeup(&pdev->dev, 1);
+
 	if (new_ctrl & (u8) OMAP_RTC_CTRL_SPLIT)
 		pr_info("%s: split power mode\n", pdev->name);
 
-- 
1.7.9.5
