From: david@lechnology.com (David Lechner)
Date: Wed, 26 Oct 2016 19:18:18 -0500
Subject: [PATCH v7 4/4] ARM: davinci: da8xx: register USB PHY clocks in the DT
 file
In-Reply-To: <1477527498-21930-1-git-send-email-david@lechnology.com>
References: <1477527498-21930-1-git-send-email-david@lechnology.com>
Message-ID: <1477527498-21930-5-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Axel Haslam <ahaslam@baylibre.com>

The usb20_phy clock needs to be registered for the driver to be able
to get and enable a clock. Currently the usb phy clocks are registered
form board files, which will not be called during a device tree based
boot.

To be able to probe correctly usb form a device tree boot, register
the usb phy clocks form the DT specific init.

Unfortunately, davinci does not have proper clock support on device tree
yet, so by registering the clock form de DT specific file we are
forced to hardcode the parent clock, and cannot select refclkin as
parent for any of the phy clocks of the da850 family.

As none of the current da850 based boards currently in mainline use
refclkin as source. I guess we can live with this limitation until clocks
are correctly represented through CCF/device tree.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
[Added error checking]
Signed-off-by: David Lechner <david@lechnology.com>
---

This patch was recently submitted separately. I added error checking and I am
including it in this series since it is closely related. It could be combined
with the "ARM: davinci: da8xx: add usb phy clocks" patch, but I think it is
good to have a separate commit for the explanation in the commit message.


 arch/arm/mach-davinci/da8xx-dt.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index 75e831d..839f8db 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -49,6 +49,17 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 
 static void __init da850_init_machine(void)
 {
+	int ret;
+
+	ret = da8xx_register_usb20_phy_clk(false);
+	if (ret)
+		pr_warn("%s: registering USB 2.0 PHY clock failed: %d",
+			__func__, ret);
+	ret = da8xx_register_usb11_phy_clk(false);
+	if (ret)
+		pr_warn("%s: registering USB 1.1 PHY clock failed: %d",
+			__func__, ret);
+
 	of_platform_default_populate(NULL, da850_auxdata_lookup, NULL);
 }
 
-- 
2.7.4
