From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Tue,  1 Feb 2011 20:17:40 +0530
Subject: [PATCH v1 2/9] da850: pruss board specific additions.
In-Reply-To: <1296571667-12049-1-git-send-email-subhasish@mistralsolutions.com>
References: <1296571667-12049-1-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <1296571667-12049-3-git-send-email-subhasish@mistralsolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds board specific initializations and setup routines.

Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>
---
 arch/arm/mach-davinci/board-da850-evm.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 11f986b..7938c6d 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1053,6 +1053,29 @@ static __init int da850_evm_init_cpufreq(void)
 static __init int da850_evm_init_cpufreq(void) { return 0; }
 #endif
 
+static struct da8xx_pruss_devices pruss_devices[] = {
+	{.dev_name = NULL,},
+};
+
+static int __init da8xx_evm_setup_pruss(void)
+{
+	u32 ret = 0;
+	u32 count;
+
+	for (count = 0; count < ARRAY_SIZE(pruss_devices); count++) {
+		if (pruss_devices[count].setup != NULL) {
+			ret = pruss_devices[count].setup();
+			if (ret) {
+				pr_warning("%s: %s init failed: %d\n", __func__,
+					pruss_devices[count].dev_name, ret);
+				return ret;
+			}
+		}
+	}
+
+	return da8xx_register_pruss(pruss_devices);
+}
+
 static __init void da850_evm_init(void)
 {
 	int ret;
@@ -1127,6 +1150,11 @@ static __init void da850_evm_init(void)
 
 	da8xx_register_mcasp(0, &da850_evm_snd_data);
 
+	ret = da8xx_evm_setup_pruss();
+	if (ret)
+		pr_warning("%s: pruss initialization failed: %d\n",
+				__func__, ret);
+
 	ret = davinci_cfg_reg_list(da850_lcdcntl_pins);
 	if (ret)
 		pr_warning("da850_evm_init: lcdcntl mux setup failed: %d\n",
-- 
1.7.2.3
