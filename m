From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 20 Nov 2014 10:14:46 -0800
Subject: [PATCH arm-soc/next/soc] bus: brcmstb_gisb: resolve section mismatch
Message-ID: <1416507286-14083-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit f1bee783dd37 moved the call to hook_fault_code in
brcmstb_gisb_arb_probe() which now calls a function annotated with __init, so
this one must also be annotated with __init.

In order to avoid introducing another section mismatch, call
platform_driver_probe() manually and remove the .probe assignment from
brcmstb_gisb_arb_driver, this is very similar to what
drivers/pci/host/pci-imx6.c does since we basically have the same constraints
here.

Fixes: f1bee783dd37 ("bus: brcmstb_gisb: register the fault code hook")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Arnd, Olof,

This patch resolves a section mismatch found in the arm-soc tree in the
next/soc branch which merged my two previous GISB patches.

Thanks!

 drivers/bus/brcmstb_gisb.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index e7ccd21..27c319d 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -188,7 +188,7 @@ static struct attribute_group gisb_arb_sysfs_attr_group = {
 	.attrs = gisb_arb_sysfs_attrs,
 };
 
-static int brcmstb_gisb_arb_probe(struct platform_device *pdev)
+static int __init brcmstb_gisb_arb_probe(struct platform_device *pdev)
 {
 	struct device_node *dn = pdev->dev.of_node;
 	struct brcmstb_gisb_arb_device *gdev;
@@ -305,7 +305,6 @@ static const struct of_device_id brcmstb_gisb_arb_of_match[] = {
 };
 
 static struct platform_driver brcmstb_gisb_arb_driver = {
-	.probe	= brcmstb_gisb_arb_probe,
 	.driver = {
 		.name	= "brcm-gisb-arb",
 		.owner	= THIS_MODULE,
@@ -316,7 +315,8 @@ static struct platform_driver brcmstb_gisb_arb_driver = {
 
 static int __init brcm_gisb_driver_init(void)
 {
-	return platform_driver_register(&brcmstb_gisb_arb_driver);
+	return platform_driver_probe(&brcmstb_gisb_arb_driver,
+				     brcmstb_gisb_arb_probe);
 }
 
 module_init(brcm_gisb_driver_init);
-- 
1.7.1
