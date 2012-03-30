From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 30 Mar 2012 16:59:57 -0600
Subject: [PATCH 04/11] gpio: tegra: Iterate over the correct number of banks
In-Reply-To: <1333148404-17691-1-git-send-email-swarren@wwwdotorg.org>
References: <1333148404-17691-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1333148404-17691-5-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

When Tegra30 support was added to the Tegra GPIO driver, a few places
which iterated over all banks were not converted to use the variable
tegra_gpio_bank_count rather than hard-coding the bank count. Fix this.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/gpio/gpio-tegra.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 7d05a34..12f349b 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -436,7 +436,7 @@ static int __devinit tegra_gpio_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	for (i = 0; i < 7; i++) {
+	for (i = 0; i < tegra_gpio_bank_count; i++) {
 		for (j = 0; j < 4; j++) {
 			int gpio = tegra_gpio_compose(i, j, 0);
 			tegra_gpio_writel(0x00, GPIO_INT_ENB(gpio));
@@ -514,7 +514,7 @@ static int dbg_gpio_show(struct seq_file *s, void *unused)
 	int i;
 	int j;
 
-	for (i = 0; i < 7; i++) {
+	for (i = 0; i < tegra_gpio_bank_count; i++) {
 		for (j = 0; j < 4; j++) {
 			int gpio = tegra_gpio_compose(i, j, 0);
 			seq_printf(s,
-- 
1.7.0.4
