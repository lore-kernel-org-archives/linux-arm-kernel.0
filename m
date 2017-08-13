From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 13 Aug 2017 22:18:53 +0800
Subject: [PATCH] clk: bulk: call of_clk_get() when id is NULL
In-Reply-To: <20170809173318.GD2146@codeaurora.org>
References: <1502243442-28055-1-git-send-email-shawnguo@kernel.org>
 <20170809173318.GD2146@codeaurora.org>
Message-ID: <20170813141851.GD31819@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Wed, Aug 09, 2017 at 10:33:18AM -0700, Stephen Boyd wrote:
> > diff --git a/drivers/clk/clk-bulk.c b/drivers/clk/clk-bulk.c
> > index c834f5abfc49..65cee595a67e 100644
> > --- a/drivers/clk/clk-bulk.c
> > +++ b/drivers/clk/clk-bulk.c
> > @@ -39,7 +39,10 @@ int __must_check clk_bulk_get(struct device *dev, int num_clks,
> >  		clks[i].clk = NULL;
> >  
> >  	for (i = 0; i < num_clks; i++) {
> > -		clks[i].clk = clk_get(dev, clks[i].id);
> > +		if (clks[i].id)
> > +			clks[i].clk = clk_get(dev, clks[i].id);
> > +		else if (dev->of_node)
> > +			clks[i].clk = of_clk_get(dev->of_node, i);
> 
> This seems a little too magical. The omission of an id in an
> array of clks would mean that only that one clk is acquired
> through of_clk_get(). We could have a mixture of ids and no ids
> for some device, and then do very odd things.
> 
> How about we add a flag to clk_bulk_data that indicates we want
> it to use of_clk_get() instead of clk_get() for all of the clks?
> Then the id is ignored for the entire function.

I have sent v2 to add a flag to clk_bulk_data to address your comments.
But I just found it might not be what you want exactly, because the
current bulk clk APIs defines clk_bulk_data in a different way from what
you are asking here.

It seems that you think clk_bulk_data represents all the clocks that
bulk APIs manage, but actually it only represents one of the multiple
clocks.  Callers need to prepare an array of clk_bulk_data to represent
multiple clocks.  That said, the flag we add to clk_bulk_data only
affects one clock instead of all clocks.

I feel this is something we can improve.  clk_bulk_data can be used to
represent all clocks, something like below.  In this case, bulk clk APIs
do not need to take num_clks as a separate parameter, and callers do not
need to maintain multiple clk_bulk_data instances.  Since we do not have
any in tree users of bulk clk APIs yet, we can make this semantic change
quickly.  Thoughts?

diff --git a/include/linux/clk.h b/include/linux/clk.h
index 31fee2e8d4a2..ddc4812758f6 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -80,8 +80,10 @@ struct clk_notifier_data {
 /**
  * struct clk_bulk_data - Data used for bulk clk operations.
  *
- * @id: clock consumer ID
- * @clk: struct clk * to store the associated clock
+ * @ids: array of clock consumer IDs which should be provided by caller.
+ * @clks: array of struct clk * to store the associated clocks, which will be
+ *     allocated by clk_bulk_get() and freed by clk_bulk_put().
+ * @num_clks: number of clocks that caller wants bulk API to manage.
  * @flags: bulk clk operation flags
  *
  * The CLK APIs provide a series of clk_bulk_() API calls as
@@ -93,8 +95,9 @@ struct clk_notifier_data {
  *     clk_bulk_get() API will call of_clk_get() to find clock by index.
  */
 struct clk_bulk_data {
-       const char              *id;
-       struct clk              *clk;
+       const char              **ids;
+       struct clk              **clks;
+       unsigned int            num_clks;
        unsigned long           flags;
 };
