From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 13 Apr 2016 17:19:13 -0700
Subject: [PATCH] ARM: dts: r8a7791: Don't disable referenced optional
 clocks
In-Reply-To: <1460112654.31245.20.camel@collabora.co.uk>
References: <1459947173-6664-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <CAMuHMdUtPhBT0_+hSk_t5osHC8TssyGMFo+YOWetTGBkbpB4PQ@mail.gmail.com>
 <1459949826.23936.19.camel@collabora.co.uk>
 <20160407232155.GH18567@codeaurora.org>
 <1460112654.31245.20.camel@collabora.co.uk>
Message-ID: <20160414001913.GG14441@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08, Sjoerd Simons wrote:
> On Thu, 2016-04-07 at 16:21 -0700, Stephen Boyd wrote:
> > On 04/06, Sjoerd Simons wrote:
> > > 
> > > Though even so I'm not sure what the convention is for clocks like
> > > these, the r8a7791.dtsi is inconsistent, as some are disabled while
> > > others (e.g. the audio clocks) are 0hz. Would be good to get some
> > > input
> > > on that regardless.
> > > 
> > What's the question here?
> 
> So the question is how to model unconnected external clocks in device-
> tree.
> 
> The dtsi we're loooking at has (in pseudo dt):
> 
> device {
> ? clock-names = "internal", "external";
> ? clocks = <&internal, &external>
> };
> 
> external {
> ? compatible = "fixed-clock";
> ? clock-frequency = <12345>;
> ? status = "disabled";
> };
> 
> Before?3e5dd6f6e690048d ("clk: Ignore?disabled DT?clock providers")
> this apparently worked. Afterwards drivers getting all the clocks would
> fail to probe with -EPROBE_DEFER.
> 
> Judging by your comment I assume this way of modelling it is broken
> (and the behaviour caused by the patch is correct)??
> 
> And as a follow-up, is modelling unconnected clocks as enabled with a
> frequency of 0hz as my proposed patch does seen as the right way of
> doing things?
> 

Right. In the case where the external clk is populated, I imagine
there would be a DT node describing it with the clock-frequency
property if it's a fixed rate clk. If the clk is not populated on
the board, then we would have a "ground" clk node that has a
frequency of 0. This way, if we have some mux clk that is default
connected to the external clk but can switch to some internal clk
it isn't orphaned forever. This is actually a problem for orphan
clk deferral right now.

My head starts to spin when we consider something like expansion
boards that have clk pins on them though. Hopefully for things
like that, we can populate clks with DT overlays and then change
the root hierarchy of the clk tree by swapping out the "ground"
clk for some real clk on the expansion board. The usage of
strings to describe the clk tree is probably going to get us here
though. Fun!

If we can't do this DT design because of backwards compatibility
concerns, then perhaps we need to expand the core to return a
fixed rate of 0 clk whenever clk_get() is called on a provider
that's status = "disabled"? Here's an untested patch to show that
idea.

---8<----
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index fb74dc1f7520..19c3777b1cea 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3085,6 +3085,17 @@ int of_clk_parent_fill(struct device_node *np, const char **parents,
 }
 EXPORT_SYMBOL_GPL(of_clk_parent_fill);
 
+static void init_disabled_clk_provider(struct device_node *np)
+{
+	struct clk *clk;
+
+	clk = clk_register_fixed_rate(NULL, of_node_full_name(np), NULL, 0, 0);
+	if (IS_ERR(clk))
+		return;
+
+	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+}
+
 struct clock_provider {
 	of_clk_init_cb_t clk_init_cb;
 	struct device_node *np;
@@ -3150,9 +3161,6 @@ void __init of_clk_init(const struct of_device_id *matches)
 	for_each_matching_node_and_match(np, matches, &match) {
 		struct clock_provider *parent;
 
-		if (!of_device_is_available(np))
-			continue;
-
 		parent = kzalloc(sizeof(*parent), GFP_KERNEL);
 		if (!parent) {
 			list_for_each_entry_safe(clk_provider, next,
@@ -3165,7 +3173,18 @@ void __init of_clk_init(const struct of_device_id *matches)
 			return;
 		}
 
-		parent->clk_init_cb = match->data;
+		/*
+		 * Sometimes DT nodes are status = "disabled" but they're used
+		 * by other clk providers. In that case we make the disabled
+		 * provider return fixed rate clks with a frequency of 0 so
+		 * that nothing is orphaned and drivers can still get all
+		 * their clks.
+		 */
+		if (!of_device_is_available(np)) {
+			parent->clk_init_cb = init_disabled_clk_provider;
+		} else {
+			parent->clk_init_cb = match->data;
+		}
 		parent->np = of_node_get(np);
 		list_add_tail(&parent->node, &clk_provider_list);
 	}
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
