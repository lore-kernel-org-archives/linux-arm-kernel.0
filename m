From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 30 Jul 2013 17:07:53 +0800
Subject: [PATCH 2/2] arm: prima2: pm: drop redundant postcore_initcall
In-Reply-To: <1375175273-14067-1-git-send-email-Baohua.Song@csr.com>
References: <1375175273-14067-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <1375175273-14067-2-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will delete some redundant calling of sirfsoc_of_pwrc_init() and
sirfsoc_memc_init() for non-CSR platforms if we use multi-platform.

Cc: Srinivas Kandagatla <srinivas.kandagatla@st.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-prima2/pm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-prima2/pm.c b/arch/arm/mach-prima2/pm.c
index 3a944ed..c4525a8 100644
--- a/arch/arm/mach-prima2/pm.c
+++ b/arch/arm/mach-prima2/pm.c
@@ -88,12 +88,6 @@ static const struct platform_suspend_ops sirfsoc_pm_ops = {
 	.valid = suspend_valid_only_mem,
 };
 
-int __init sirfsoc_pm_init(void)
-{
-	suspend_set_ops(&sirfsoc_pm_ops);
-	return 0;
-}
-
 static const struct of_device_id pwrc_ids[] = {
 	{ .compatible = "sirf,prima2-pwrc" },
 	{}
@@ -121,7 +115,6 @@ static int __init sirfsoc_of_pwrc_init(void)
 
 	return 0;
 }
-postcore_initcall(sirfsoc_of_pwrc_init);
 
 static const struct of_device_id memc_ids[] = {
 	{ .compatible = "sirf,prima2-memc" },
@@ -152,4 +145,11 @@ static int __init sirfsoc_memc_init(void)
 {
 	return platform_driver_register(&sirfsoc_memc_driver);
 }
-postcore_initcall(sirfsoc_memc_init);
+
+int __init sirfsoc_pm_init(void)
+{
+	sirfsoc_of_pwrc_init();
+	sirfsoc_memc_init();
+	suspend_set_ops(&sirfsoc_pm_ops);
+	return 0;
+}
-- 
1.8.2.3
