From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 21 Oct 2015 16:48:10 -0700
Subject: [PATCH v3 03/10] clk: iproc: Add PWRCTRL support
In-Reply-To: <1444938513-10758-4-git-send-email-jonmason@broadcom.com>
References: <1444938513-10758-1-git-send-email-jonmason@broadcom.com>
 <1444938513-10758-4-git-send-email-jonmason@broadcom.com>
Message-ID: <20151021234810.GP19782@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15, Jon Mason wrote:
> Some iProc SoC clocks use a different way to control clock power, via
> the PWRDWN bit in the PLL control register.  Since the PLL control
> register is used to access the PWRDWN bit, there is no need for the
> pwr_base when this is being used.  A new flag, IPROC_CLK_EMBED_PWRCTRL,
> has been added to identify this usage.  We can use the AON interface to
> write the values to enable/disable PWRDOWN.
> 
> Signed-off-by: Jon Mason <jonmason@broadcom.com>
> ---

Applied to clk-next + 

---8<----
diff --git a/drivers/clk/bcm/clk-iproc-pll.c b/drivers/clk/bcm/clk-iproc-pll.c
index 61b49ba24602..fb1e6b1d0df6 100644
--- a/drivers/clk/bcm/clk-iproc-pll.c
+++ b/drivers/clk/bcm/clk-iproc-pll.c
@@ -150,7 +150,7 @@ static void __pll_disable(struct iproc_pll *pll)
 
 	if (ctrl->flags & IPROC_CLK_EMBED_PWRCTRL) {
 		val = readl(pll->pll_base + ctrl->aon.offset);
-		val |= (bit_mask(ctrl->aon.pwr_width) << ctrl->aon.pwr_shift);
+		val |= bit_mask(ctrl->aon.pwr_width) << ctrl->aon.pwr_shift;
 		writel(val, pll->pll_base + ctrl->aon.offset);
 
 		if (unlikely(ctrl->flags & IPROC_CLK_NEEDS_READ_BACK))
@@ -160,7 +160,7 @@ static void __pll_disable(struct iproc_pll *pll)
 	if (pll->pwr_base) {
 		/* latch input value so core power can be shut down */
 		val = readl(pll->pwr_base + ctrl->aon.offset);
-		val |= (1 << ctrl->aon.iso_shift);
+		val |= 1 << ctrl->aon.iso_shift;
 		writel(val, pll->pwr_base + ctrl->aon.offset);
 
 		/* power down the core */
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
