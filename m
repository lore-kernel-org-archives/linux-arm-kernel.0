From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 16 Nov 2009 06:36:53 -0700
Subject: [PATCH 1/3] OMAP3 clock: Fix the DPLL freqsel computations
In-Reply-To: <20091116133237.14128.39687.stgit@localhost.localdomain>
References: <20091116133237.14128.39687.stgit@localhost.localdomain>
Message-ID: <20091116133649.14128.89383.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajendra Nayak <rnayak@ti.com>

Fix the freqsel value computation. Use n instead of (n+1)

The formula in the TRM uses a zero-based N, hence the (n+1); however
at this point in the clock34xx.c code, N is one-based.

Hayati Bayrakdar <h-bayrakdar@ti.com> and Nishanth Menon <nm@ti.com> helped
track down this bug.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
[paul at pwsan.com: modified commit message]
Cc: Hayati Bayrakdar <h-bayrakdar@ti.com>
Cc: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/clock34xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index c258f87..225c1a7 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -473,7 +473,7 @@ static u16 _omap3_dpll_compute_freqsel(struct clk *clk, u8 n)
 	unsigned long fint;
 	u16 f = 0;
 
-	fint = clk->dpll_data->clk_ref->rate / (n + 1);
+	fint = clk->dpll_data->clk_ref->rate / n;
 
 	pr_debug("clock: fint is %lu\n", fint);
 
