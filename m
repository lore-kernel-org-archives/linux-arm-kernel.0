From: mturquette@linaro.org (Michael Turquette)
Date: Tue, 31 Mar 2015 18:13:02 -0700
Subject: [STLinux Kernel] [PATCH 3/4] clk: Provide always-on clock support
In-Reply-To: <20150302081606.GC31325@x1>
References: <1425071674-16995-1-git-send-email-lee.jones@linaro.org>
 <1425071674-16995-4-git-send-email-lee.jones@linaro.org>
 <54F173B7.9030305@st.com> <20150302081606.GC31325@x1>
Message-ID: <20150401011302.25195.55588@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Lee Jones (2015-03-02 00:16:06)
> On Sat, 28 Feb 2015, Maxime Coquelin wrote:
> 
> > Hi Lee,
> > 
> > On 02/27/2015 10:14 PM, Lee Jones wrote:
> > >Lots of platforms contain clocks which if turned off would prove fatal.
> > >The only way to recover from these catastrophic failures is to restart
> > >the board(s).  Now, when a clock is registered with the framework it is
> > >compared against a list of provided always-on clock names which must be
> > >kept ungated.  If it matches, we enable the existing CLK_IGNORE_UNUSED
> > >flag, which will prevent the common clk framework from attempting to
> > >gate it during the clk_disable_unused() procedure.
> > 
> > Please correct me if I'm wrong, but your patch does not fix the
> > issue you had initially.
> > Let's take an example:
> > A clock is critical for the system, and should never be gated, so
> > you add the CLK_IGNORE_UNUSED
> > flag so that it is not disabled by clk_disable_unused() procedure.
> > The same clock is also used by other IPs, for example spi 0 instance.
> > When starting a spi transfer, clk_enable() is called on this clock,
> > so its usecount becomes 1.
> > Once transfer done, clk_disable() is called, usecount becomes 0 and
> > the clock gets disabled: system freeze.
> 
> You're right.  I also need to extend clk_core_disable() to take notice
> of CLK_IGNORE_UNUSED.

Hi Lee,

I'd like to combine elements of your V3 and this series (V4?). Firstly
let's stay away from modifying the semantics around CLK_IGNORE_UNUSED.
There was discussion around adding a new flag which I'd like to avoid if
possible.

If we're leaving clocks enabled then it would be best to reflect that
reality with the prepare/enable refcounting in the core. The best way to
do this is with clk_prepare_enable(my_alwon_clk). Drivers already do
this today by hacking calls to clk_prepare_enable into their driver's
probe function, and we can support it more explicitly in DT.

Since we already have assigned-clock-rate and assigned-clock-parent in
drivers/clk/clk-conf.c I propose that we add a third property here,
assigned-clock-alwon. I don't really care about the name, so feel free
to change it, so long as your suggestion is Measurably Better.

This property can only be added to clock providers (not consumers),
because if we have a clock consumer then that consumer should just call
clk_prepare_enable. See the pseudo-code below:



diff --git a/drivers/clk/clk-conf.c b/drivers/clk/clk-conf.c
index 48a65b2..19dce89 100644
--- a/drivers/clk/clk-conf.c
+++ b/drivers/clk/clk-conf.c
@@ -115,6 +115,14 @@ static int __set_clk_rates(struct device_node *node, bool clk_supplier)
 	return 0;
 }
 
+static int __set_clk_alwon(struct device_node *node, bool clk_supplier)
+{
+	if (!clk_supplier)
+		return -EINVAL;
+
+	clk_prepare_enable(...);
+}
+
 /**
  * of_clk_set_defaults() - parse and set assigned clocks configuration
  * @node: device node to apply clock settings for
@@ -138,6 +146,10 @@ int of_clk_set_defaults(struct device_node *node, bool clk_supplier)
 	if (rc < 0)
 		return rc;
 
-	return __set_clk_rates(node, clk_supplier);
+	rc = __set_clk_rates(node, clk_supplier);
+	if (rc < 0)
+		return rc;
+
+	return __set_clk_alwon(node, clk_supplier);
 }
 EXPORT_SYMBOL_GPL(of_clk_set_defaults);



Amazing, I know. Is there any aspect of this approach which does not
solve your use case?

We should mark this new property (assigned-clk-alwon) as unstable since
it can (and likely will) grow into more stuff in the future (e.g.
Stephen Boyd mentioned a "hand-off" which tells the core to keep clocks
enabled until the correct driver claims them).

Regards,
Mike
