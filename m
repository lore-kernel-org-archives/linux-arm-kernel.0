From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed,  6 Jan 2010 10:32:02 -0800
Subject: [PATCH 20/35] davinci: clock: Check CLK_PSC flag before disabling PSC
In-Reply-To: <1262802737-6601-20-git-send-email-khilman@deeprootsystems.com>
References: <1262802737-6601-1-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-2-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-3-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-4-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-5-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-6-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-7-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-8-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-9-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-10-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-11-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-12-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-13-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-14-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-15-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-16-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-17-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-18-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-19-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-20-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1262802737-6601-21-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chaithrika U S <chaithrika@ti.com>

Some modules do not have PSC to control their clocks.
The 'lpsc' field in the clk structure is 0 for such clocks.

In the clock disable function check for CLK PSC flag before
disabling the PSC. If this is not taken care of then it may
so happen that module controlled by LPSC 0 is erroneously disabled.

Signed-off-by: Chaithrika U S <chaithrika@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/clock.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index e46a643..f097f8d 100644
--- a/arch/arm/mach-davinci/clock.c
+++ b/arch/arm/mach-davinci/clock.c
@@ -49,7 +49,8 @@ static void __clk_disable(struct clk *clk)
 {
 	if (WARN_ON(atomic_read(&clk->usecount) == 0))
 		return;
-	if (atomic_dec_and_test(&clk->usecount) && !(clk->flags & CLK_PLL))
+	if (atomic_dec_and_test(&clk->usecount) && !(clk->flags & CLK_PLL)
+						&& (clk->flags & CLK_PSC))
 		davinci_psc_config(psc_domain(clk), clk->gpsc, clk->lpsc, 0);
 	if (clk->parent)
 		__clk_disable(clk->parent);
-- 
1.6.6.rc2.1.g42108
