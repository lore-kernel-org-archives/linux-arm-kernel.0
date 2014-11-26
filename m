From: cernekee@gmail.com (Kevin Cernekee)
Date: Tue, 25 Nov 2014 16:49:48 -0800
Subject: [PATCH 3/9] power/reset: brcmstb: Add support for old 65nm chips
In-Reply-To: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
References: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
Message-ID: <1416962994-27095-4-git-send-email-cernekee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The register bit fields are a little different, so add an entry and a
compatible string to accommodate them.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 Documentation/devicetree/bindings/arm/brcm-brcmstb.txt | 4 +++-
 drivers/power/reset/brcmstb-reboot.c                   | 6 ++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/brcm-brcmstb.txt b/Documentation/devicetree/bindings/arm/brcm-brcmstb.txt
index 3c436cc..430608e 100644
--- a/Documentation/devicetree/bindings/arm/brcm-brcmstb.txt
+++ b/Documentation/devicetree/bindings/arm/brcm-brcmstb.txt
@@ -79,7 +79,9 @@ reboot
 Required properties
 
     - compatible
-        The string property "brcm,brcmstb-reboot".
+        The string property "brcm,brcmstb-reboot" for 40nm/28nm chips with
+        the new SYS_CTRL interface, or "brcm,bcm7038-reboot" for 65nm
+        chips with the old SUN_TOP_CTRL interface.
 
     - syscon
         A phandle / integer array that points to the syscon node which describes
diff --git a/drivers/power/reset/brcmstb-reboot.c b/drivers/power/reset/brcmstb-reboot.c
index 4e61c3f..33af4f3 100644
--- a/drivers/power/reset/brcmstb-reboot.c
+++ b/drivers/power/reset/brcmstb-reboot.c
@@ -88,8 +88,14 @@ static const struct reset_reg_mask reset_bits_40nm = {
 	.sw_mstr_rst_mask = BIT(0),
 };
 
+static const struct reset_reg_mask reset_bits_65nm = {
+	.rst_src_en_mask = BIT(3),
+	.sw_mstr_rst_mask = BIT(31),
+};
+
 static const struct of_device_id of_match[] = {
 	{ .compatible = "brcm,brcmstb-reboot", .data = &reset_bits_40nm },
+	{ .compatible = "brcm,bcm7038-reboot", .data = &reset_bits_65nm },
 	{},
 };
 
-- 
2.1.0
