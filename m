From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed,  6 Jan 2010 10:31:44 -0800
Subject: [PATCH 02/35] davinci: move PLL wait time values to clock.h
In-Reply-To: <1262802737-6601-2-git-send-email-khilman@deeprootsystems.com>
References: <1262802737-6601-1-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-2-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1262802737-6601-3-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

As suspend support is added, the code supporting
the suspend operation needs to bypass PLLs and
needs to access the same wait time values as the
PLL code in clock.c.

To facilitate this, move the PLL wait times to
clock.h where they can be accessed by suspend code.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/clock.c |   15 +++------------
 arch/arm/mach-davinci/clock.h |   15 +++++++++++++++
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index baece65..0fa68c5 100644
--- a/arch/arm/mach-davinci/clock.c
+++ b/arch/arm/mach-davinci/clock.c
@@ -376,7 +376,7 @@ int davinci_set_pllrate(struct pll_data *pll, unsigned int prediv,
 		locktime = ((2000 * prediv) / 100);
 		prediv = (prediv - 1) | PLLDIV_EN;
 	} else {
-		locktime = 20;
+		locktime = PLL_LOCK_TIME;
 	}
 	if (postdiv)
 		postdiv = (postdiv - 1) | PLLDIV_EN;
@@ -389,12 +389,7 @@ int davinci_set_pllrate(struct pll_data *pll, unsigned int prediv,
 	ctrl &= ~(PLLCTL_PLLENSRC | PLLCTL_PLLEN);
 	__raw_writel(ctrl, pll->base + PLLCTL);
 
-	/*
-	 * Wait for 4 OSCIN/CLKIN cycles to ensure that the PLLC has switched
-	 * to bypass mode. Delay of 1us ensures we are good for all > 4MHz
-	 * OSCIN/CLKIN inputs. Typically the input is ~25MHz.
-	 */
-	udelay(1);
+	udelay(PLL_BYPASS_TIME);
 
 	/* Reset and enable PLL */
 	ctrl &= ~(PLLCTL_PLLRST | PLLCTL_PLLDIS);
@@ -408,11 +403,7 @@ int davinci_set_pllrate(struct pll_data *pll, unsigned int prediv,
 	if (pll->flags & PLL_HAS_POSTDIV)
 		__raw_writel(postdiv, pll->base + POSTDIV);
 
-	/*
-	 * Wait for PLL to reset properly, OMAP-L138 datasheet says
-	 * 'min' time = 125ns
-	 */
-	udelay(1);
+	udelay(PLL_RESET_TIME);
 
 	/* Bring PLL out of reset */
 	ctrl |= PLLCTL_PLLRST;
diff --git a/arch/arm/mach-davinci/clock.h b/arch/arm/mach-davinci/clock.h
index c92d77a..eca4d99 100644
--- a/arch/arm/mach-davinci/clock.h
+++ b/arch/arm/mach-davinci/clock.h
@@ -53,6 +53,21 @@
 #define PLLDIV_EN       BIT(15)
 #define PLLDIV_RATIO_MASK 0x1f
 
+/*
+ * OMAP-L138 system reference guide recommends a wait for 4 OSCIN/CLKIN
+ * cycles to ensure that the PLLC has switched to bypass mode. Delay of 1us
+ * ensures we are good for all > 4MHz OSCIN/CLKIN inputs. Typically the input
+ * is ~25MHz. Units are micro seconds.
+ */
+#define PLL_BYPASS_TIME		1
+/* From OMAP-L138 datasheet table 6-4. Units are micro seconds */
+#define PLL_RESET_TIME		1
+/*
+ * From OMAP-L138 datasheet table 6-4; assuming prediv = 1, sqrt(pllm) = 4
+ * Units are micro seconds.
+ */
+#define PLL_LOCK_TIME		20
+
 struct pll_data {
 	u32 phys_base;
 	void __iomem *base;
-- 
1.6.6.rc2.1.g42108
