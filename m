From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 14 Feb 2011 17:53:49 +0530
Subject: [PATCH v2 3/7] omap: clock: Add allow_idle/deny_idle support in
	clkops
In-Reply-To: <alpine.DEB.2.00.1102121643250.21991@utopia.booyaka.com>
References: <1297329400-5936-1-git-send-email-rnayak@ti.com>
	<1297329400-5936-2-git-send-email-rnayak@ti.com>
	<1297329400-5936-3-git-send-email-rnayak@ti.com>
	<1297329400-5936-4-git-send-email-rnayak@ti.com>
	<alpine.DEB.2.00.1102121643250.21991@utopia.booyaka.com>
Message-ID: <ab30a208ca55e9295e25b8c3495dfa31@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul at pwsan.com]
> Sent: Sunday, February 13, 2011 5:35 AM
> To: Rajendra Nayak
> Cc: linux-omap at vger.kernel.org; b-cousson at ti.com; khilman at ti.com;
santosh.shilimkar at ti.com; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v2 3/7] omap: clock: Add allow_idle/deny_idle
support in clkops
>
> Hi Rajendra
>
> On Thu, 10 Feb 2011, Rajendra Nayak wrote:
>
> > diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
> > index fc62fb5..6889c5a 100644
> > --- a/arch/arm/plat-omap/clock.c
> > +++ b/arch/arm/plat-omap/clock.c
> > @@ -335,6 +335,32 @@ struct clk *omap_clk_get_by_name(const char
*name)
> >  	return ret;
> >  }
> >
> > +void omap_clk_enable_autoidle(void)
> > +{
> > +	struct clk *c;
> > +
> > +	mutex_lock(&clocks_mutex);
>
> With the current OMAP clock code, it isn't sufficient to use a mutex
here.
> Your underlying functions have to read, modify, and write a register
that
> is also touched by clock functions like clk_set_rate(), which take the
> clockfw spinlock and not the mutex.  This is potentially racy and could
> result in inconsistencies between the internal clock tree data and the
> hardware settings.
>
> While it is true that these functions are currently only called during
PM
> init, I'd rather not commit code that is subject to known races into the
> tree.
>
> So, before applying this patch, the mutexes have been converted into
> spinlocks.  I would appreciate it if you could help test this.  Updated
> patch follows, which has been queued for 2.6.39 as part of the
> 'clk_autoidle_a_2.6.39' branch of git://git.pwsan.com/linux-2.6.

I used the clk_autoidle_a_2.6.39 branch and tested OFF mode
in suspend on 3430sdp.
I also tested CORE ret in suspend (using some out of tree patches)
on 4430sdp.

A couple of issues on the clk_autoidle_a_2.6.39 branch:
-1- There seems to be a missing fix which causes an abort
at boot on omap4
http://marc.info/?l=linux-omap&m=129768574027232&w=2
-2- There is a trivial fix (Patch below) needed which otherwise
breaks build

----
