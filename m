From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 06 Jan 2010 13:44:19 -0700
Subject: [PATCH 2/5] OMAP2xxx clock: clk2xxx.c doesn't compile if CPUFREQ is
	enabled
In-Reply-To: <20100106204346.15002.89343.stgit@localhost.localdomain>
References: <20100106204346.15002.89343.stgit@localhost.localdomain>
Message-ID: <20100106204418.15002.26107.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felipe Balbi <felipe.balbi@nokia.com>

if we enable CPUFREQ we can't build omap2 for two reasons,
one of them is fixed by the patch below.

It's failing because the __must_be_array() check in
ARRAY_SIZE() is failing and printing the following message:

arch/arm/mach-omap2/clock2xxx.c:453: error: negative width in bit-field '<anonymous>'

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
[paul at pwsan.com: commit message updated; changed rate variable name]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock2xxx.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2xxx.c b/arch/arm/mach-omap2/clock2xxx.c
index d0e3fb7..ce6742f 100644
--- a/arch/arm/mach-omap2/clock2xxx.c
+++ b/arch/arm/mach-omap2/clock2xxx.c
@@ -455,12 +455,15 @@ static struct cpufreq_frequency_table freq_table[ARRAY_SIZE(rate_table)];
 void omap2_clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
 {
 	struct prcm_config *prcm;
+	long sys_ck_rate;
 	int i = 0;
 
+	sys_ck_rate = clk_get_rate(sclk);
+
 	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
 		if (!(prcm->flags & cpu_mask))
 			continue;
-		if (prcm->xtal_speed != sys_ck.rate)
+		if (prcm->xtal_speed != sys_ck_rate)
 			continue;
 
 		/* don't put bypass rates in table */
