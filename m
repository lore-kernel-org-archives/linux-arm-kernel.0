From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 22 Feb 2013 18:17:53 +0100
Subject: [PATCH/RFC 3/4] ARM: shmobile: sh73a0: run sh73a0_clock_init() only
 once
In-Reply-To: <1361553474-27022-1-git-send-email-g.liakhovetski@gmx.de>
References: <1361553474-27022-1-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <1361553474-27022-4-git-send-email-g.liakhovetski@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sh73a0_clock_init() is called from sh73a0_earlytimer_init() and
sh73a0_add_standard_devices_dt(), take care to only run it once.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

This patch shouldn't be needed, sh73a0_clock_init() shouldn't be called 
twice. It's here only as an illustration, how I actually was testing.

 arch/arm/mach-shmobile/clock-sh73a0.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index 3170482..f9a015d 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -809,6 +809,9 @@ void __init sh73a0_clock_init(void)
 {
 	int k, ret = 0;
 
+	if (main_clk.parent)
+		return;
+
 	/* Set SDHI clocks to a known state */
 	__raw_writel(0x108, SD0CKCR);
 	__raw_writel(0x108, SD1CKCR);
-- 
1.7.2.5
