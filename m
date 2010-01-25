From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 25 Jan 2010 12:58:20 +0200
Subject: [PATCH 2/4] mx25: properly initialize clocks
In-Reply-To: <20100125105439.GE6724@jasper.tkos.co.il>
References: <20100125105439.GE6724@jasper.tkos.co.il>
Message-ID: <5e4894af4009cbc44b69fb5eef925f98a2f44eb4.1264416923.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch disables all unnecessary clock in mx25_clocks_init() to make a clean
start, the same as is being done for the rest of the i.MX chips.

This patch was tested on i.MX25 PDK.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/mach-mx25/clock.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx25/clock.c b/arch/arm/mach-mx25/clock.c
index abd303b..08aaa38 100644
--- a/arch/arm/mach-mx25/clock.c
+++ b/arch/arm/mach-mx25/clock.c
@@ -218,6 +218,14 @@ int __init mx25_clocks_init(void)
 	for (i = 0; i < ARRAY_SIZE(lookups); i++)
 		clkdev_add(&lookups[i]);
 
+	/* Turn off all clocks except the ones we need to survive, namely:
+	 * EMI, GPIO1-3 (CCM_CGCR1[18:16]), GPT1, IOMUXC (CCM_CGCR1[27]), IIM,
+	 * SCC
+	 */
+	__raw_writel((1 << 19), CRM_BASE + CCM_CGCR0);
+	__raw_writel((0xf << 16) | (3 << 26), CRM_BASE + CCM_CGCR1);
+	__raw_writel((1 << 5), CRM_BASE + CCM_CGCR2);
+
 	mxc_timer_init(&gpt_clk, MX25_IO_ADDRESS(MX25_GPT1_BASE_ADDR), 54);
 
 	return 0;
-- 
1.6.5
