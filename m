From: julia@diku.dk (Julia Lawall)
Date: Mon, 24 Jan 2011 20:55:20 +0100
Subject: [PATCH 2/4] arch/arm/mach-at91/clock.c: Add missing IS_ERR test
In-Reply-To: <1295898922-18822-1-git-send-email-julia@diku.dk>
References: <1295898922-18822-1-git-send-email-julia@diku.dk>
Message-ID: <1295898922-18822-3-git-send-email-julia@diku.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Function clk_get, defined just below this code, returns ERR_PTR not NULL in
an error case.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r@
identifier f;
@@
f(...) { ... return ERR_PTR(...); }

@@
identifier r.f, fld;
expression x;
statement S1,S2;
@@
 x = f(...)
 ... when != IS_ERR(x)
(
 if (IS_ERR(x) ||...) S1 else S2
|
*x->fld
)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 arch/arm/mach-at91/clock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/clock.c b/arch/arm/mach-at91/clock.c
index 9113da6..c9ee6d0 100644
--- a/arch/arm/mach-at91/clock.c
+++ b/arch/arm/mach-at91/clock.c
@@ -224,7 +224,7 @@ void __init at91_clock_associate(const char *id, struct device *dev, const char
 {
 	struct clk *clk = clk_get(NULL, id);
 
-	if (!dev || !clk || !IS_ERR(clk_get(dev, func)))
+	if (!dev || IS_ERR(clk) || !IS_ERR(clk_get(dev, func)))
 		return;
 
 	clk->function = func;
