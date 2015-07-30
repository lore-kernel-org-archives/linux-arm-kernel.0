From: mturquette@linaro.org (Michael Turquette)
Date: Thu, 30 Jul 2015 16:35:30 -0700
Subject: [PATCH v7 3/5] clk: Supply the critical clock {init, enable,
 disable} framework
In-Reply-To: <20150730111747.GF14642@x1>
References: <1437570255-21049-1-git-send-email-lee.jones@linaro.org>
 <1437570255-21049-4-git-send-email-lee.jones@linaro.org>
 <20150730010213.642.10831@quantum> <20150730111747.GF14642@x1>
Message-ID: <20150730233530.23791.17746@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Lee Jones (2015-07-30 04:17:47)
> On Wed, 29 Jul 2015, Michael Turquette wrote:
> 
> > Hi Lee,
> > 
> > + linux-clk ml
> > 
> > Quoting Lee Jones (2015-07-22 06:04:13)
> > > These new API calls will firstly provide a mechanisms to tag a clock as
> > > critical and secondly allow any knowledgeable driver to (un)gate clocks,
> > > even if they are marked as critical.
> > > 
> > > Suggested-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  drivers/clk/clk.c            | 45 ++++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/clk-provider.h |  2 ++
> > >  include/linux/clk.h          | 30 +++++++++++++++++++++++++++++
> > >  3 files changed, 77 insertions(+)
> > > 
> > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > index 61c3fc5..486b1da 100644
> > > --- a/drivers/clk/clk.c
> > > +++ b/drivers/clk/clk.c
> > > @@ -46,6 +46,21 @@ static struct clk_core *clk_core_lookup(const char *name);
> > >  
> > >  /***    private data structures    ***/
> > >  
> > > +/**
> > > + * struct critical -   Provides 'play' over critical clocks.  A clock can be
> > > + *                     marked as critical, meaning that it should not be
> > > + *                     disabled.  However, if a driver which is aware of the
> > > + *                     critical behaviour wants to control it, it can do so
> > > + *                     using clk_enable_critical() and clk_disable_critical().
> > > + *
> > > + * @enabled    Is clock critical?  Once set, doesn't change
> > > + * @leave_on   Self explanatory.  Can be disabled by knowledgeable drivers
> > 
> > Not self explanatory. I need this explained to me. What does leave_on
> > do? Better yet, what would happen if leave_on did not exist?
> > 
> > > + */
> > > +struct critical {
> > > +       bool enabled;
> > > +       bool leave_on;
> > > +};
> > > +
> > >  struct clk_core {
> > >         const char              *name;
> > >         const struct clk_ops    *ops;
> > > @@ -75,6 +90,7 @@ struct clk_core {
> > >         struct dentry           *dentry;
> > >  #endif
> > >         struct kref             ref;
> > > +       struct critical         critical;
> > >  };
> > >  
> > >  struct clk {
> > > @@ -995,6 +1011,10 @@ static void clk_core_disable(struct clk_core *clk)
> > >         if (WARN_ON(clk->enable_count == 0))
> > >                 return;
> > >  
> > > +       /* Refuse to turn off a critical clock */
> > > +       if (clk->enable_count == 1 && clk->critical.leave_on)
> > > +               return;
> > 
> > How do we get to this point? clk_enable_critical actually calls
> > clk_enable, thus incrementing the enable_count. The only time that we
> > could hit the above case is if,
> > 
> > a) there is an imbalance in clk_enable and clk_disable calls. If this is
> > the case then the drivers need to be fixed. Or better yet some
> > infrastructure to catch that, now that we have per-user struct clk
> > cookies.
> > 
> > b) a driver knowingly calls clk_enable_critical(foo) and then regular,
> > old clk_disable(foo). But why would a driver do that?
> > 
> > It might be that I am missing the point here, so please feel free to
> > clue me in.
> 
> This check behaves in a very similar to the WARN() above.  It's more
> of a fail-safe.  If all drivers are behaving properly, then it
> shouldn't ever be true.  If they're not, it prevents an incorrectly
> written driver from irrecoverably crippling the system.

Then this check should be replaced with a generic approach that refuses
to honor imbalances anyways. Below are two patches that probably resolve
the issue of badly behaving drivers that cause enable imbalances.

> 
> As I said in the other mail.  We can do without these 3 new wrappers.
> We _could_ just write a driver which only calls clk_enable() _after_
> it calls clk_disable(), a kind of intentional unbalance and it would
> do that same thing.

This naive approach will not work with per-user imbalance tracking.

> However, what we're trying to do here is provide
> a proper API, so we can see at first glance what the 'knowledgeable'
> driver is trying to do and not have someone attempt to submit a 'fix'
> which calls clk_enable() or something.

We'll need some type of api for sure for the handoff.

Regards,
Mike



>From 3599ed206da9ce770bfafcfd95cbb9a03ac44473 Mon Sep 17 00:00:00 2001
From: Michael Turquette <mturquette@baylibre.com>
Date: Wed, 29 Jul 2015 18:22:45 -0700
Subject: [PATCH 1/2] clk: per-user clk prepare & enable ref counts

This patch adds prepare and enable reference counts for the per-user
handles that clock consumers have for a clock node. This patch warns if
an imbalance occurs while trying to disable or unprepare a clock and
aborts, leaving the hardware unaffected.

Signed-off-by: Michael Turquette <mturquette@baylibre.com>
---
 drivers/clk/clk.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 898052e..72feee9 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -84,6 +84,8 @@ struct clk {
 	unsigned long min_rate;
 	unsigned long max_rate;
 	struct hlist_node clks_node;
+	unsigned int enable_count;
+	unsigned int prepare_count;
 };
 
 /***           locking             ***/
@@ -600,6 +602,9 @@ void clk_unprepare(struct clk *clk)
 		return;
 
 	clk_prepare_lock();
+	if (WARN_ON(clk->prepare_count == 0))
+		return;
+	clk->prepare_count--;
 	clk_core_unprepare(clk->core);
 	clk_prepare_unlock();
 }
@@ -657,6 +662,7 @@ int clk_prepare(struct clk *clk)
 		return 0;
 
 	clk_prepare_lock();
+	clk->prepare_count++;
 	ret = clk_core_prepare(clk->core);
 	clk_prepare_unlock();
 
@@ -707,6 +713,9 @@ void clk_disable(struct clk *clk)
 		return;
 
 	flags = clk_enable_lock();
+	if (WARN_ON(clk->enable_count == 0))
+		return;
+	clk->enable_count--;
 	clk_core_disable(clk->core);
 	clk_enable_unlock(flags);
 }
@@ -769,6 +778,7 @@ int clk_enable(struct clk *clk)
 		return 0;
 
 	flags = clk_enable_lock();
+	clk->enable_count++;
 	ret = clk_core_enable(clk->core);
 	clk_enable_unlock(flags);
 
-- 
1.9.1

>From ace76f6ed634a69c499f8440a98d4b5a54d78368 Mon Sep 17 00:00:00 2001
From: Michael Turquette <mturquette@baylibre.com>
Date: Thu, 30 Jul 2015 12:52:26 -0700
Subject: [PATCH 2/2] clk: clk_put WARNs if user has not disabled clk

>From the clk_put kerneldoc in include/linux/clk.h:

"""
Note: drivers must ensure that all clk_enable calls made on this clock
source are balanced by clk_disable calls prior to calling this function.
"""

The common clock framework implementation of the clk.h api has per-user
reference counts for calls to clk_prepare and clk_disable. As such it
can enforce the requirement to properly call clk_disable and
clk_unprepare before calling clk_put.

Because this requirement is probably violated in many places, this patch
starts with a simple warning. Once offending code has been fixed this
check could additionally release the reference counts automatically.

Signed-off-by: Michael Turquette <mturquette@baylibre.com>
---
 drivers/clk/clk.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 72feee9..6ec0f77 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2764,6 +2764,14 @@ void __clk_put(struct clk *clk)
 	    clk->max_rate < clk->core->req_rate)
 		clk_core_set_rate_nolock(clk->core, clk->core->req_rate);
 
+	/*
+	 * before calling clk_put, all calls to clk_prepare and clk_enable from
+	 * a given user must be balanced with calls to clk_disable and
+	 * clk_unprepare by that same user
+	 */
+	WARN_ON(clk->prepare_count);
+	WARN_ON(clk->enable_count);
+
 	owner = clk->core->owner;
 	kref_put(&clk->core->ref, __clk_release);
 
-- 
1.9.1
