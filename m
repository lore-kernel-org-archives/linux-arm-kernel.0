From: jamesjj.liao@mediatek.com (James Liao)
Date: Tue, 9 Aug 2016 13:39:43 +0800
Subject: [PATCH v9 01/10] clk: fix initial state of critical clock's
 parents
In-Reply-To: <1470203182.17063.3.camel@mtksdaap41>
References: <1466581229-2342-1-git-send-email-erin.lo@mediatek.com>
 <1466581229-2342-2-git-send-email-erin.lo@mediatek.com>
 <20160702012140.GB17071@codeaurora.org>
 <1467604308.26485.4.camel@mtksdaap41>
 <146802073038.73491.6675612765998057903@resonance>
 <1468225452.31247.7.camel@mtksdaap41> <1470203182.17063.3.camel@mtksdaap41>
Message-ID: <1470721183.8551.6.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-08-03 at 13:46 +0800, James Liao wrote:
> On Mon, 2016-07-11 at 16:24 +0800, James Liao wrote:
> > Hi Mike,
> > 
> > On Fri, 2016-07-08 at 16:32 -0700, Michael Turquette wrote:
> > > Hi James,
> > > 
> > > Quoting James Liao (2016-07-03 20:51:48)
> > > > On Fri, 2016-07-01 at 18:21 -0700, Stephen Boyd wrote:
> > > > > (Resending to everyone)
> > > > > 
> > > > > On 06/22, Erin Lo wrote:
> > > > > > From: James Liao <jamesjj.liao@mediatek.com>
> > > > > > 
> > > > > > This patch fixed wrong state of parent clocks if they are registered
> > > > > > after critical clocks.
> > > > > > 
> > > > > > Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> > > > > > Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> > > > > 
> > > > > It would be nice if you included the information about the
> > > > > problem from James' previous mail. This says what it does, but
> > > > > doesn't explain what the problem is and how it is fixing it.
> > > > > 
> > > > > > ---
> > > > > >  drivers/clk/clk.c | 9 ++++++++-
> > > > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > > > > index d584004..e9f5f89 100644
> > > > > > --- a/drivers/clk/clk.c
> > > > > > +++ b/drivers/clk/clk.c
> > > > > > @@ -2388,8 +2388,15 @@ static int __clk_core_init(struct clk_core *core)
> > > > > >     hlist_for_each_entry_safe(orphan, tmp2, &clk_orphan_list, child_node) {
> > > > > >             struct clk_core *parent = __clk_init_parent(orphan);
> > > > > >  
> > > > > > -           if (parent)
> > > > > > +           if (parent) {
> > > > > >                     clk_core_reparent(orphan, parent);
> > > > > > +
> > > > > > +                   if (orphan->prepare_count)
> > > > > > +                           clk_core_prepare(parent);
> > > > > > +
> > > > > > +                   if (orphan->enable_count)
> > > > > > +                           clk_core_enable(parent);
> > > > > > +           }
> > > > > >     }
> > > > > 
> > > > > I'm pretty sure I pointed this problem out to Mike when the
> > > > > critical clk patches were being pushed. I can't recall what the
> > > > > plan was though to fix the problem. I'm pretty sure he said that
> > > > > clk_core_reparent() would take care of it, but obviously it is
> > > > > not doing that. Or perhaps it was that clk handoff should figure
> > > > > out that the parents of a critical clk are also on and thus keep
> > > > > them on.
> > > > 
> > > > Hi Mike
> > > > 
> > > > Is there any other patch to fix this issue? Or did I misuse critical
> > > > clock flag?
> > > 
> > > There is no fix yes. Your fix is basically correct. I was mistaken back
> > > when I told you and Stephen that the framework already took care of
> > > this.
> > > 
> > > However, instead of "open coding" this solution, I would rather re-use
> > > the __clk_set_parent_{before,after} helpers instead. Can you review/test
> > > the following patch and let me know what you think?
> > > 
> > > Thanks,
> > > Mike
> > > 
> > > 
> > > 
> > > From c0163b3f719b1e219b28ad425f94f9ef54a25a8f Mon Sep 17 00:00:00 2001
> > > From: Michael Turquette <mturquette@baylibre.com>
> > > Date: Fri, 8 Jul 2016 16:05:22 -0700
> > > Subject: [PATCH] clk: migrate ref counts when orphans are reunited
> > > 
> > > It's always nice to see families reunited, and this is equally true when
> > > talking about parent clocks and their children. However, if the orphan
> > > clk had a positive prepare_count or enable_count, then we would not
> > > migrate those counts up the parent chain correctly.
> > > 
> > > This has manifested with the recent critical clocks feature, which often
> > > enables clocks very early, before their parents have been registered.
> > > 
> > > Fixed by replacing the call to clk_core_reparent with calls to
> > > __clk_set_parent_{before,after}.
> > > 
> > > Cc: James Liao <jamesjj.liao@mediatek.com>
> > > Cc: Erin Lo <erin.lo@mediatek.com>
> > > Signed-off-by: Michael Turquette <mturquette@baylibre.com>
> > > ---
> > >  drivers/clk/clk.c | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > index 820a939fb6bb..70efe4c4e0cc 100644
> > > --- a/drivers/clk/clk.c
> > > +++ b/drivers/clk/clk.c
> > > @@ -2449,8 +2449,14 @@ static int __clk_core_init(struct clk_core *core)
> > >  	hlist_for_each_entry_safe(orphan, tmp2, &clk_orphan_list, child_node) {
> > >  		struct clk_core *parent = __clk_init_parent(orphan);
> > >  
> > > -		if (parent)
> > > -			clk_core_reparent(orphan, parent);
> > 
> > Is it correct to remove clk_core_reparent()? It lacks
> > __clk_recalc_accuracies() and __clk_recalc_rates(), so the new parent's
> > rate will not propagate correctly.
> > 
> > For example, I set vdec_sel as a critical clock. Without your patch, the
> > result was:
> > 
> >     vdecpll         0            0   338000000
> >        vdecpll_ck   1            1   338000000
> >           vdec_sel  1            1   338000000
> > 
> > With your patch, it became:
> > 
> >     vdecpll         1            1   338000000
> >        vdecpll_ck   1            1           0
> >           vdec_sel  1            1           0
> > 
> > The prepare_count and enable_count are correct with your patch, but the
> > rates of vdecpll_ck and vdec_sel become incorrect.
> > 
> > 
> > > +		/*
> > > +		 * we could call __clk_set_parent, but that would result in a
> > > +		 * reducant call to the .set_rate op, if it exists
> > > +		 */
> > > +		if (parent) {
> > > +			__clk_set_parent_before(orphan, parent);
> > > +			__clk_set_parent_after(orphan, parent, NULL);
> > > +		}
> > >  	}
> > >  
> > >  	/*
> > 
> 
> Hi Mike,
> 
> Do you have new patches to fix new clock parents? If not, I think we can
> use my patch first. Is it okay?
> 

Hi Stephen,

Do you have comments for the bug fixing? I prefer to use my patch (clk:
fix initial state of critical clock's parents). How do you think?


Best regards,

James
