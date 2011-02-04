From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Feb 2011 13:20:40 +0000
Subject: Locking in the clk API, part 2: clk_prepare/clk_unprepare
In-Reply-To: <20110204124534.GA2597@richard-laptop>
References: <201102011711.31258.jeremy.kerr@canonical.com>
	<20110204124534.GA2597@richard-laptop>
Message-ID: <20110204132040.GI14627@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 04, 2011 at 08:45:34PM +0800, Richard Zhao wrote:
> > == Implementation ==
> > 
> > Basically:
> > 
> > struct clk {
> > 	const struct clk_ops *ops
> > 	int                  enable_count;
> > 	spinlock_t           enable_lock;
> > 	int                  prepare_count;
> > 	struct mutex         prepare_lock;
> > };
> > 
> > int clk_enable(struct clk *clk)
> > {
> > 	int ret = 0;
> > 
> > 	spin_lock(&clk->enable_lock);
> > 	if (!clk->enable_count)
> > 		ret = clk->ops->enable(clk);
> > 
> > 	if (!ret)
> > 		clk->enable_count++;
> > 	spin_unlock(&clk->enable_lock);
> > 
> > 	return ret;
> > }
> Why do we not call parent's clk_enable in this function? For flexible? How many
> different cases is causing us to move the effert to platform clock driver?

You may notice that struct clk above doesn't have a parent.
