From: j-keerthy@ti.com (Keerthy)
Date: Fri, 19 Feb 2016 10:08:55 +0530
Subject: [PATCH v2 2/2] ARM: AM43XX: HWMOD: Add rtc hwmod
In-Reply-To: <1455856735-11515-1-git-send-email-j-keerthy@ti.com>
References: <1455856735-11515-1-git-send-email-j-keerthy@ti.com>
Message-ID: <1455856735-11515-3-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch adds rtc hwmod. RTC module The RTC module is physically
present on the AM438x SoC used on AM43X-EPOS-EVM, but it is permanently
disabled. A secure RTC is used instead on these devices, where needed.
. Hence adding it selectively using a seprate list to get RTC Module
functional on the other am43x SoCs used on am437x-gp-evm and
am437x-sk-evm.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in v2:

Inverted the checking logic to accommodate registering for all
the SoCs compatible to am4372 and removed the negating am438x logic
to register rtc hwmods as suggested by Paul.

 arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
index e97a894..97fd399 100644
--- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
@@ -1020,9 +1020,21 @@ static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
 	NULL,
 };
 
+static struct omap_hwmod_ocp_if *am43xx_rtc_hwmod_ocp_ifs[] __initdata = {
+	&am33xx_l4_wkup__rtc,
+	NULL,
+};
+
 int __init am43xx_hwmod_init(void)
 {
+	int ret;
+
 	omap_hwmod_am43xx_reg();
 	omap_hwmod_init();
-	return omap_hwmod_register_links(am43xx_hwmod_ocp_ifs);
+	ret = omap_hwmod_register_links(am43xx_hwmod_ocp_ifs);
+
+	if (!ret && of_machine_is_compatible("ti,am4372"))
+		ret = omap_hwmod_register_links(am43xx_rtc_hwmod_ocp_ifs);
+
+	return ret;
 }
-- 
1.9.1
