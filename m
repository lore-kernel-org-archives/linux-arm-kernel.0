From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 18 May 2010 20:19:04 -0600
Subject: [PATCH 22/22] OMAP2 clock: fix recursive spinlock attempt when
	CONFIG_CPU_FREQ=y
In-Reply-To: <20100519021800.19716.8938.stgit@localhost.localdomain>
References: <20100519021800.19716.8938.stgit@localhost.localdomain>
Message-ID: <20100519021902.19716.41518.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OMAP2 MPU virtual clock node code attempted to call clk_get_rate()
while the clockfw_lock spinlock was held.  Fix by reading the sys_ck
rate directly.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |   17 ++++-------------
 1 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
index e60ca4e..aef6291 100644
--- a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
+++ b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
@@ -68,16 +68,13 @@ long omap2_round_to_table_rate(struct clk *clk, unsigned long rate)
 {
 	const struct prcm_config *ptr;
 	long highest_rate;
-	long sys_ck_rate;
-
-	sys_ck_rate = clk_get_rate(sclk);
 
 	highest_rate = -EINVAL;
 
 	for (ptr = rate_table; ptr->mpu_speed; ptr++) {
 		if (!(ptr->flags & cpu_mask))
 			continue;
-		if (ptr->xtal_speed != sys_ck_rate)
+		if (ptr->xtal_speed != sclk->rate)
 			continue;
 
 		highest_rate = ptr->mpu_speed;
@@ -96,15 +93,12 @@ int omap2_select_table_rate(struct clk *clk, unsigned long rate)
 	const struct prcm_config *prcm;
 	unsigned long found_speed = 0;
 	unsigned long flags;
-	long sys_ck_rate;
-
-	sys_ck_rate = clk_get_rate(sclk);
 
 	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
 		if (!(prcm->flags & cpu_mask))
 			continue;
 
-		if (prcm->xtal_speed != sys_ck_rate)
+		if (prcm->xtal_speed != sclk->rate)
 			continue;
 
 		if (prcm->mpu_speed <= rate) {
@@ -181,19 +175,16 @@ static struct cpufreq_frequency_table *freq_table;
 void omap2_clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
 {
 	const struct prcm_config *prcm;
-	long sys_ck_rate;
 	int i = 0;
 	int tbl_sz = 0;
 
 	if (!cpu_is_omap24xx())
 		return;
 
-	sys_ck_rate = clk_get_rate(sclk);
-
 	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
 		if (!(prcm->flags & cpu_mask))
 			continue;
-		if (prcm->xtal_speed != sys_ck_rate)
+		if (prcm->xtal_speed != sclk->rate)
 			continue;
 
 		/* don't put bypass rates in table */
@@ -226,7 +217,7 @@ void omap2_clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
 	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
 		if (!(prcm->flags & cpu_mask))
 			continue;
-		if (prcm->xtal_speed != sys_ck_rate)
+		if (prcm->xtal_speed != sclk->rate)
 			continue;
 
 		/* don't put bypass rates in table */
