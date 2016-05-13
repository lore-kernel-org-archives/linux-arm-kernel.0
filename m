From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 13 May 2016 09:50:00 +0200
Subject: [PATCH 01/16] clk: fix critical clock locking
In-Reply-To: <20160509221146.GS3492@codeaurora.org>
References: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
 <1462737711-10017-2-git-send-email-maxime.ripard@free-electrons.com>
 <20160509221146.GS3492@codeaurora.org>
Message-ID: <20160513075000.GB3733@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Mon, May 09, 2016 at 03:11:46PM -0700, Stephen Boyd wrote:
> On 05/08, Maxime Ripard wrote:
> > The critical clock handling in __clk_core_init isn't taking the enable lock
> > before calling clk_core_enable, which in turns triggers the warning in the
> > lockdep_assert_held call in that function when lockep is enabled.
> > 
> > Add the calls to clk_enable_lock/unlock to make sure it doesn't happen.
> > 
> > Fixes: 32b9b1096186 ("clk: Allow clocks to be marked as CRITICAL")
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> 
> Why is this patch hiding in this series?

Sorry, I discovered it while working on this, and somehow it slipped
in there. I'll resend it separately.

> 
> >  drivers/clk/clk.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index ce39add5a258..16a38df3c688 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -2404,8 +2404,15 @@ static int __clk_core_init(struct clk_core *core)
> >  		core->ops->init(core->hw);
> >  
> >  	if (core->flags & CLK_IS_CRITICAL) {
> > +		unsigned long flags;
> > +
> > +		clk_prepare_lock();
> >  		clk_core_prepare(core);
> > +		clk_prepare_unlock();
> 
> It looks like we already hold the prepare lock at this point.

You're right. I thought I removed it, but obviously I didn't.

I'll send a v2.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160513/b4592f8e/attachment.sig>
