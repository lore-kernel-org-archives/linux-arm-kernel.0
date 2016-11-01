From: Nicolae_Rosia@mentor.com (Nicolae Rosia)
Date: Tue, 1 Nov 2016 11:49:25 +0200
Subject: [PATCH] ARM: OMAP2+: avoid NULL pointer dereference
Message-ID: <1477993765-9980-1-git-send-email-Nicolae_Rosia@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For OMAP4, volt_data is set in omap44xx_voltagedomains_init.
If the SoC is neither OMAP443X or OMAP446X, we end up with a
NULL in volt_data which causes a kernel oops.
This is the case when booting OMAP4470.

Signed-off-by: Nicolae Rosia <Nicolae_Rosia@mentor.com>
---
 arch/arm/mach-omap2/voltage.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index cba8cad..cd15dbd 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -87,6 +87,12 @@ int voltdm_scale(struct voltagedomain *voltdm,
 		return -ENODATA;
 	}
 
+	if (!voltdm->volt_data) {
+		pr_err("%s: No voltage data defined for vdd_%s\n",
+			__func__, voltdm->name);
+		return -ENODATA;
+	}
+
 	/* Adjust voltage to the exact voltage from the OPP table */
 	for (i = 0; voltdm->volt_data[i].volt_nominal != 0; i++) {
 		if (voltdm->volt_data[i].volt_nominal >= target_volt) {
-- 
2.5.5
