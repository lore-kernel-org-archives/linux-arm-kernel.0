From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Fri, 22 Apr 2011 17:38:22 +0530
Subject: [PATCH v4 04/11] da850: pruss board specific additions.
In-Reply-To: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <1303474109-6212-5-git-send-email-subhasish@mistralsolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds board specific initializations and setup routines.

Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>
---
 arch/arm/mach-davinci/board-da850-evm.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index a7b41bf..0b6b948 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1117,6 +1117,15 @@ static __init int da850_evm_init_cpufreq(void)
 static __init int da850_evm_init_cpufreq(void) { return 0; }
 #endif
 
+static struct mfd_cell cell[] = {
+	{.name = NULL,},
+};
+
+static int __init da8xx_evm_setup_pruss(void)
+{
+	return da8xx_register_pruss_mfd(cell);
+}
+
 static __init void da850_evm_init(void)
 {
 	int ret;
@@ -1191,6 +1200,11 @@ static __init void da850_evm_init(void)
 
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
