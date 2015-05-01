From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 01 May 2015 21:59:55 +0200
Subject: [PATCH v3 0/2] clk: improve handling of orphan clocks
In-Reply-To: <20150501001901.GC32407@codeaurora.org>
References: <1429735986-18592-1-git-send-email-heiko@sntech.de>
 <20150501001901.GC32407@codeaurora.org>
Message-ID: <1981330.kGUrTurMy5@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 30. April 2015, 17:19:01 schrieb Stephen Boyd:
> On 04/22, Heiko Stuebner wrote:
> > Using orphan clocks can introduce strange behaviour as they don't have
> > rate information at all and also of course don't track
> > 
> > This v2/v3 takes into account suggestions from Stephen Boyd to not try to
> > walk the clock tree at runtime but instead keep track of orphan states
> > on clock tree changes and making it mandatory for everybody from the
> > start as orphaned clocks should not be used at all.
> > 
> > 
> > This fixes an issue on most rk3288 platforms, where some soc-clocks
> > are supplied by a 32khz clock from an external i2c-chip which often
> > is only probed later in the boot process and maybe even after the
> > drivers using these soc-clocks like the tsadc temperature sensor.
> > In this case the driver using the clock should of course defer probing
> > until the clock is actually usable.
> > 
> > 
> > As this changes the behaviour for orphan clocks, it would of course
> > benefit from more testing than on my Rockchip boards. To keep the
> > recipent-list reasonable and not spam to much I selected one (the topmost)
> > from the get_maintainer output of each drivers/clk entry.
> > Hopefully some will provide Tested-by-tags :-)
> 
> <grumble> I don't see any Tested-by: tags yet </grumble>. I've
> put these two patches on a separate branch "defer-orphans" and
> pushed it to clk-next so we can give it some more exposure.
> 
> Unfortunately this doesn't solve the orphan problem for non-OF
> providers. What if we did the orphan check in __clk_create_clk()
> instead and returned an error pointer for orphans? I suspect that
> will solve all cases, right?

hmm, clk_register also uses __clk_create_clk, which in turn would prevent
registering orphan-clocks at all, I'd think.
As on my platform I'm dependant on orphan clocks (the soc-level clock gets
registerted as part of the big clock controller way before the i2c-based
supplying clock), I'd rather not touch this :-) .

Instead I guess we could hook it less deep into clk_get_sys, like in the
following patch?


------------ 8< ------------------------- >8 -----------------
From: Heiko Stuebner <heiko@sntech.de>
Date: Fri, 1 May 2015 21:50:46 +0200
Subject: [PATCH] clk: prevent orphan access on non-devicetree platforms too

The orphan-check in __of_clk_get_from_provider only prevents orphan-access
on devicetree platforms. To bring non-dt platforms to the same level of
functionality let clk_get_sys (called from clk_get for non-dt platforms)
also check for orphans and return -EPROBE_DEFER in that case.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/clk.c    | 2 +-
 drivers/clk/clk.h    | 5 +++++
 drivers/clk/clkdev.c | 5 +++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 36d1a01..167d0bf 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2220,7 +2220,7 @@ static inline void clk_debug_unregister(struct clk_core *core)
 }
 #endif
 
-static bool clk_is_orphan(const struct clk *clk)
+bool clk_is_orphan(const struct clk *clk)
 {
 	if (!clk)
 		return false;
diff --git a/drivers/clk/clk.h b/drivers/clk/clk.h
index 00b35a1..b8a6061 100644
--- a/drivers/clk/clk.h
+++ b/drivers/clk/clk.h
@@ -20,6 +20,7 @@ struct clk *__of_clk_get_from_provider(struct of_phandle_args *clkspec,
 struct clk *__clk_create_clk(struct clk_hw *hw, const char *dev_id,
 			     const char *con_id);
 void __clk_free_clk(struct clk *clk);
+bool clk_is_orphan(const struct clk *clk);
 #else
 /* All these casts to avoid ifdefs in clkdev... */
 static inline struct clk *
@@ -32,5 +33,9 @@ static struct clk_hw *__clk_get_hw(struct clk *clk)
 {
 	return (struct clk_hw *)clk;
 }
+static inline bool clk_is_orphan(const struct clk *clk)
+{
+	return false;
+}
 
 #endif
diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 1fcb6ef..ad96775 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -177,6 +177,11 @@ struct clk *clk_get_sys(const char *dev_id, const char *con_id)
 	if (!cl)
 		goto out;
 
+	if (clk_is_orphan(cl->clk)) {
+		clk = ERR_PTR(-EPROBE_DEFER);
+		goto out;
+	}
+
 	clk = __clk_create_clk(__clk_get_hw(cl->clk), dev_id, con_id);
 	if (IS_ERR(clk))
 		goto out;
-- 
2.1.4
