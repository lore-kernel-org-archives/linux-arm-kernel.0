From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 01 May 2015 13:52:47 -0700
Subject: [PATCH v3 0/2] clk: improve handling of orphan clocks
In-Reply-To: <1981330.kGUrTurMy5@diego>
References: <1429735986-18592-1-git-send-email-heiko@sntech.de>
 <20150501001901.GC32407@codeaurora.org> <1981330.kGUrTurMy5@diego>
Message-ID: <5543E79F.2080400@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/01/15 12:59, Heiko St?bner wrote:
> Am Donnerstag, 30. April 2015, 17:19:01 schrieb Stephen Boyd:
>> On 04/22, Heiko Stuebner wrote:
>>> Using orphan clocks can introduce strange behaviour as they don't have
>>> rate information at all and also of course don't track
>>>
>>> This v2/v3 takes into account suggestions from Stephen Boyd to not try to
>>> walk the clock tree at runtime but instead keep track of orphan states
>>> on clock tree changes and making it mandatory for everybody from the
>>> start as orphaned clocks should not be used at all.
>>>
>>>
>>> This fixes an issue on most rk3288 platforms, where some soc-clocks
>>> are supplied by a 32khz clock from an external i2c-chip which often
>>> is only probed later in the boot process and maybe even after the
>>> drivers using these soc-clocks like the tsadc temperature sensor.
>>> In this case the driver using the clock should of course defer probing
>>> until the clock is actually usable.
>>>
>>>
>>> As this changes the behaviour for orphan clocks, it would of course
>>> benefit from more testing than on my Rockchip boards. To keep the
>>> recipent-list reasonable and not spam to much I selected one (the topmost)
>>> from the get_maintainer output of each drivers/clk entry.
>>> Hopefully some will provide Tested-by-tags :-)
>> <grumble> I don't see any Tested-by: tags yet </grumble>. I've
>> put these two patches on a separate branch "defer-orphans" and
>> pushed it to clk-next so we can give it some more exposure.
>>
>> Unfortunately this doesn't solve the orphan problem for non-OF
>> providers. What if we did the orphan check in __clk_create_clk()
>> instead and returned an error pointer for orphans? I suspect that
>> will solve all cases, right?
> hmm, clk_register also uses __clk_create_clk, which in turn would prevent
> registering orphan-clocks at all, I'd think.
> As on my platform I'm dependant on orphan clocks (the soc-level clock gets
> registerted as part of the big clock controller way before the i2c-based
> supplying clock), I'd rather not touch this :-) .

Have no fear! We should just change clk_register() to call a
__clk_create_clk() type function that doesn't check for orphan status.

>
> Instead I guess we could hook it less deep into clk_get_sys, like in the
> following patch?

It looks like it will work at least, but still I'd prefer to keep the
orphan check contained to clk.c. How about this compile tested only patch?

This also brings up an existing problem with clk_unregister() where
orphaned clocks are sitting out there useable by drivers when their
parent is unregistered. That code could use some work to atomically
switch all the orphaned clocks over to use the nodrv_ops.

----8<-----

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 30d45c657a07..1d23daa42dd2 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2221,14 +2221,6 @@ static inline void clk_debug_unregister(struct clk_core *core)
 }
 #endif
 
-static bool clk_is_orphan(const struct clk *clk)
-{
-	if (!clk)
-		return false;
-
-	return clk->core->orphan;
-}
-
 /**
  * __clk_init - initialize the data structures in a struct clk
  * @dev:	device initializing this clk, placeholder for now
@@ -2420,15 +2412,11 @@ out:
 	return ret;
 }
 
-struct clk *__clk_create_clk(struct clk_hw *hw, const char *dev_id,
-			     const char *con_id)
+static struct clk *clk_hw_create_clk(struct clk_hw *hw, const char *dev_id,
+				     const char *con_id)
 {
 	struct clk *clk;
 
-	/* This is to allow this function to be chained to others */
-	if (!hw || IS_ERR(hw))
-		return (struct clk *) hw;
-
 	clk = kzalloc(sizeof(*clk), GFP_KERNEL);
 	if (!clk)
 		return ERR_PTR(-ENOMEM);
@@ -2445,6 +2433,19 @@ struct clk *__clk_create_clk(struct clk_hw *hw, const char *dev_id,
 	return clk;
 }
 
+struct clk *__clk_create_clk(struct clk_hw *hw, const char *dev_id,
+			     const char *con_id)
+{
+	/* This is to allow this function to be chained to others */
+	if (!hw || IS_ERR(hw))
+		return (struct clk *) hw;
+
+	if (hw->core->orphan)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	return clk_hw_create_clk(hw, dev_id, con_id);
+}
+
 void __clk_free_clk(struct clk *clk)
 {
 	clk_prepare_lock();
@@ -2511,7 +2512,7 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
 
 	INIT_HLIST_HEAD(&core->clks);
 
-	hw->clk = __clk_create_clk(hw, NULL, NULL);
+	hw->clk = clk_hw_create_clk(hw, NULL, NULL);
 	if (IS_ERR(hw->clk)) {
 		ret = PTR_ERR(hw->clk);
 		goto fail_parent_names_copy;
@@ -2958,10 +2959,6 @@ struct clk *__of_clk_get_from_provider(struct of_phandle_args *clkspec,
 		if (provider->node == clkspec->np)
 			clk = provider->get(clkspec, provider->data);
 		if (!IS_ERR(clk)) {
-			if (clk_is_orphan(clk)) {
-				clk = ERR_PTR(-EPROBE_DEFER);
-				break;
-			}
 
 			clk = __clk_create_clk(__clk_get_hw(clk), dev_id,
 					       con_id);


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
