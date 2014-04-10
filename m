From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 10 Apr 2014 14:20:47 +0200
Subject: [PATCH V3 04/19] mmc: mmci: Add DT bindings for signal direction
In-Reply-To: <1397132462-8005-1-git-send-email-ulf.hansson@linaro.org>
References: <1397132462-8005-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1397132462-8005-5-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some variants have support for indicating the bus signal directions,
which currently are configured through platform data.

Add corresponding DT bindings to enable us to move away from using the
platform data.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/mmc/mmci.txt |   11 ++++++++++-
 drivers/mmc/host/mmci.c                        |   11 +++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmci.txt b/Documentation/devicetree/bindings/mmc/mmci.txt
index ff233d1..9bd2ffa 100644
--- a/Documentation/devicetree/bindings/mmc/mmci.txt
+++ b/Documentation/devicetree/bindings/mmc/mmci.txt
@@ -4,7 +4,8 @@ The ARM PrimeCell MMCI PL180 and PL181 provides an interface for
 reading and writing to MultiMedia and SD cards alike.
 
 This file documents differences between the core properties described
-by mmc.txt and the properties used by the mmci driver.
+by mmc.txt and the properties used by the mmci driver. Using "st" as
+the prefix for a property, indicates support by the ST Micro variant.
 
 Required properties:
 - compatible             : contains "arm,pl18x", "arm,primecell".
@@ -18,6 +19,11 @@ Optional properties:
 - mmc-cap-sd-highspeed   : indicates whether SD is high speed capable.
 - vqmmc-supply           : phandle to the regulator device tree node, mentioned
                            as the VCCQ/VDD_IO supply in the eMMC/SD specs.
+- st,sig-dir-dat0        : bus signal direction pin used for DAT[0].
+- st,sig-dir-dat2        : bus signal direction pin used for DAT[2].
+- st,sig-dir-dat31       : bus signal direction pin used for DAT[3] and DAT[1].
+- st,sig-dir-dat74       : bus signal direction pin used for DAT[4] to DAT[7].
+- st,sig-dir-cmd         : cmd signal direction pin used for CMD.
 
 Example:
 
@@ -38,6 +44,9 @@ sdi0_per1 at 80126000 {
 	mmc-cap-sd-highspeed;
 	mmc-cap-mmc-highspeed;
 	cd-gpios  = <&gpio2 31 0x4>; // 95
+	st,sig-dir-dat0;
+	st,sig-dir-dat2;
+	st,sig-dir-cmd;
 
 	vmmc-supply = <&ab8500_ldo_aux3_reg>;
 	vqmmc-supply = <&vmmci>;
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 93b1b10..2766e5c 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1392,6 +1392,17 @@ static void mmci_dt_populate_generic_pdata(struct device_node *np,
 {
 	int bus_width = 0;
 
+	if (of_get_property(np, "st,sig-dir-dat0", NULL))
+		pdata->sigdir |= MCI_ST_DATA0DIREN;
+	if (of_get_property(np, "st,sig-dir-dat2", NULL))
+		pdata->sigdir |= MCI_ST_DATA2DIREN;
+	if (of_get_property(np, "st,sig-dir-dat31", NULL))
+		pdata->sigdir |= MCI_ST_DATA31DIREN;
+	if (of_get_property(np, "st,sig-dir-dat74", NULL))
+		pdata->sigdir |= MCI_ST_DATA74DIREN;
+	if (of_get_property(np, "st,sig-dir-cmd", NULL))
+		pdata->sigdir |= MCI_ST_CMDDIREN;
+
 	pdata->gpio_wp = of_get_named_gpio(np, "wp-gpios", 0);
 	pdata->gpio_cd = of_get_named_gpio(np, "cd-gpios", 0);
 
-- 
1.7.9.5
