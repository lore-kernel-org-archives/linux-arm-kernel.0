From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 24 Nov 2011 08:30:46 +0800
Subject: [RFC V1 1/8] clk: support static parent
In-Reply-To: <CAPtuhThVr8si2wRpx0i32=PQCC=4h1GZr6HkRsCLHbfXBef4XA@mail.gmail.com>
References: <1322046755-13511-1-git-send-email-richard.zhao@linaro.org>
 <1322046755-13511-2-git-send-email-richard.zhao@linaro.org>
 <CAPtuhThVr8si2wRpx0i32=PQCC=4h1GZr6HkRsCLHbfXBef4XA@mail.gmail.com>
Message-ID: <20111124003044.GA15876@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2011 at 02:11:40PM -0800, Mike Turquette wrote:
> Hi Richard,
> 
> Thanks for porting your platform so quickly!
My pleasure!
> 
> On Wed, Nov 23, 2011 at 3:12 AM, Richard Zhao <richard.zhao@linaro.org> wrote:
> > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > ---
> > ?drivers/clk/clk.c | ? 10 ++++------
> > ?1 files changed, 4 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index 85dabdb31..ed557c9 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -519,13 +519,11 @@ void clk_init(struct device *dev, struct clk *clk)
> >
> > ? ? ? ?mutex_lock(&prepare_lock);
> >
> > - ? ? ? if (clk->ops->get_parent) {
> > + ? ? ? if (clk->ops->get_parent)
> > ? ? ? ? ? ? ? ?clk->parent = clk->ops->get_parent(clk);
If it has .get_parent, we use .get_parent to get parent.
> > - ? ? ? ? ? ? ? if (clk->parent)
> > - ? ? ? ? ? ? ? ? ? ? ? hlist_add_head(&clk->child_node,
> > - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? &clk->parent->children);
> > - ? ? ? } else
> > - ? ? ? ? ? ? ? clk->parent = NULL;
> > + ? ? ? if (clk->parent)
I assume .parent is set to zero when struct clk alloc memory. So the
value .parent is either get from .get_parent or a fixed parent.
> > + ? ? ? ? ? ? ? hlist_add_head(&clk->child_node,
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? &clk->parent->children);
> 
> I'll have to NACK this.  I don't think we should trust .parent in
> struct clk for initialization.
> 
> Rather, if your clk has a fixed parent then I would prefer for you to
> put that parent inside your struct clk_hw_whatever and have your
> .get_parent callback return clk_hw_whatever->fixed_parent.
Yes, It's what I did on your v2 patch, which struct clk is allocated by
the framework. But now we don't have to repeat the work clk by clk.
> 
> The reason for this is that some folks with mux clks might be tempted
> to populate .parent statically, but maybe the bootloader changed it
> and now it can't be trusted.  I'd prefer to rule out this possibility
> entirely by always relying on a .get_parent function.
This patch didn't remove .get_parent call. We trust .get_parent most.
If .get_parent must not be NULL, clocks without mux have to duplicate
the redundant get_parent function.

Thanks
Richard
> 
> Check out the way that the simple fixed-rate clk and simple gateable
> clk does this in drivers/clk/clk-basic.c
> 
> Regards,
> Mike
> 
> >
> > ? ? ? ?if (clk->ops->recalc_rate)
> > ? ? ? ? ? ? ? ?clk->rate = clk->ops->recalc_rate(clk);
> > --
> > 1.7.5.4
> >
> >
> >
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
