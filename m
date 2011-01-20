From: john.ogness@linutronix.de (John Ogness)
Date: Thu, 20 Jan 2011 15:29:50 +0100
Subject: [PATCH v2] omap2: fix DPLL_FREQSEL calculation
In-Reply-To: <20110120111645.GB2223@legolas.emea.dhcp.ti.com> (Felipe Balbi's
	message of "Thu\, 20 Jan 2011 13\:16\:45 +0200")
References: <87ei8726wf.fsf@vostro.fn.ogness.net>
	<20110120111645.GB2223@legolas.emea.dhcp.ti.com>
Message-ID: <8739on1wdd.fsf_-_@vostro.fn.ogness.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2011-01-20, Felipe Balbi <balbi@ti.com> wrote:
> scripts/get_maintainer.pl would've helped you getting a better Cc
> list. I'm adding linux-omap and lakml

Thanks.

After investigating the issue further it seems that I had it
backwards. The value of "n" is the value to divide by, not the value
that goes in the register. This means that it is _dpll_test_fint()
that is doing it incorrectly. Here is a new version of the patch to
fix the right function.



This patch fixes the calculation of the internal frequency. The value
of "n" is the actual divider to use.

This patch is against linux-next-20110120.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 arch/arm/mach-omap2/clkt_dpll.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/clkt_dpll.c b/arch/arm/mach-omap2/clkt_dpll.c
index 337392c..acb7ae5 100644
--- a/arch/arm/mach-omap2/clkt_dpll.c
+++ b/arch/arm/mach-omap2/clkt_dpll.c
@@ -77,7 +77,7 @@ static int _dpll_test_fint(struct clk *clk, u8 n)
 	dd = clk->dpll_data;
 
 	/* DPLL divider must result in a valid jitter correction val */
-	fint = clk->parent->rate / (n + 1);
+	fint = clk->parent->rate / n;
 	if (fint < DPLL_FINT_BAND1_MIN) {
 
 		pr_debug("rejecting n=%d due to Fint failure, "
