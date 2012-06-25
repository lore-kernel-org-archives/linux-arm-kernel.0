From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 25 Jun 2012 10:58:53 +0300
Subject: [PATCH 05/11] OMAPDSS: add clk_prepare and clk_unprepare
In-Reply-To: <4FE80C43.6090802@ti.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
 <1340372890-10091-6-git-send-email-rnayak@ti.com>
 <1340604478.12683.25.camel@lappyti> <4FE80C43.6090802@ti.com>
Message-ID: <1340611133.3395.3.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-06-25 at 12:29 +0530, Rajendra Nayak wrote:
> On Monday 25 June 2012 11:37 AM, Tomi Valkeinen wrote:
> > Hi,
> >
> > On Fri, 2012-06-22 at 19:18 +0530, Rajendra Nayak wrote:
> >> In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
> >> and clk_unprepare() for the omapdss clocks.
> >
> > You used clk_prepare and clk_unprepare instead of clk_prepare_enable and
> > clk_disable_unprepare. I didn't check the dss driver yet, but my hunch
> > is that the clocks are normally not enabled/disabled from atomic
> > context.
> >
> > What does the prepare/unprepare actually do? Is there any benefit in
> > delaying preparing, i.e. is there a difference between prepare right
> > after clk_get, or prepare right before clk_enable? (And similarly for
> > unprepare)
> 
> clk_prepare/unprepare are useful for clocks which need the 'enable'
> logic to be implemented as a slow part (which can sleep) and a fast part
> (which does not sleep). For all the dss clocks in question we don't need
> a slow part and hence they do not have a .clk_prepare/unprepare
> platform hook.
> 
> The framework however still does prepare usecounting (it has a prepare
> count and an enable count, and prepare count is expected to be non-zero
> while the clock is being enabled) and uses a mutex around to guard it.
> So while the dss driver would do multiple clk_enable/disable while its
> active, it seems fair to just prepare/unprepare the clocks once just
> after clk_get() and before clk_put() in this particular case.

But the driver should not presume anything special about the clocks. In
this case the dss driver would presume that the clocks it uses do not
have prepare and unprepare hooks.

If the generally proper way to use prepare/unprepare is in combination
of enable/disable, then I think we should try to do that.

I'll check if any of the dss clocks are enabled or disabled in atomic
context.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120625/85453955/attachment.sig>
