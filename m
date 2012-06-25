From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 25 Jun 2012 16:14:50 +0300
Subject: [PATCH 05/11] OMAPDSS: add clk_prepare and clk_unprepare
In-Reply-To: <4FE85005.4090303@ti.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
 <1340372890-10091-6-git-send-email-rnayak@ti.com>
 <1340604478.12683.25.camel@lappyti> <4FE80C43.6090802@ti.com>
 <1340611133.3395.3.camel@deskari> <4FE85005.4090303@ti.com>
Message-ID: <1340630090.3395.85.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-06-25 at 17:18 +0530, Rajendra Nayak wrote:
> On Monday 25 June 2012 01:28 PM, Tomi Valkeinen wrote:
> > On Mon, 2012-06-25 at 12:29 +0530, Rajendra Nayak wrote:
> >> On Monday 25 June 2012 11:37 AM, Tomi Valkeinen wrote:
> >>> Hi,
> >>>
> >>> On Fri, 2012-06-22 at 19:18 +0530, Rajendra Nayak wrote:
> >>>> In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
> >>>> and clk_unprepare() for the omapdss clocks.
> >>>
> >>> You used clk_prepare and clk_unprepare instead of clk_prepare_enable and
> >>> clk_disable_unprepare. I didn't check the dss driver yet, but my hunch
> >>> is that the clocks are normally not enabled/disabled from atomic
> >>> context.
> >>>
> >>> What does the prepare/unprepare actually do? Is there any benefit in
> >>> delaying preparing, i.e. is there a difference between prepare right
> >>> after clk_get, or prepare right before clk_enable? (And similarly for
> >>> unprepare)
> >>
> >> clk_prepare/unprepare are useful for clocks which need the 'enable'
> >> logic to be implemented as a slow part (which can sleep) and a fast part
> >> (which does not sleep). For all the dss clocks in question we don't need
> >> a slow part and hence they do not have a .clk_prepare/unprepare
> >> platform hook.
> >>
> >> The framework however still does prepare usecounting (it has a prepare
> >> count and an enable count, and prepare count is expected to be non-zero
> >> while the clock is being enabled) and uses a mutex around to guard it.
> >> So while the dss driver would do multiple clk_enable/disable while its
> >> active, it seems fair to just prepare/unprepare the clocks once just
> >> after clk_get() and before clk_put() in this particular case.
> >
> > But the driver should not presume anything special about the clocks. In
> > this case the dss driver would presume that the clocks it uses do not
> > have prepare and unprepare hooks.
> >
> > If the generally proper way to use prepare/unprepare is in combination
> > of enable/disable, then I think we should try to do that.
> 
> makes sense. Lets see if any of the clk_enable/disable happen in  atomic
> context, if not it would be just a matter of replacing all with a
> clk_prepare_enable/disable_unprepare. Else we might have to find a safe
> place sometime before clk_enable to prepare the clk and after
> clk_disable to unprepare it.
> 
> >
> > I'll check if any of the dss clocks are enabled or disabled in atomic
> > context.

venc and hdmi use clk_enable/disable in runtime PM callbacks (suspend &
resume). If I understand correctly, the callbacks are not called in
atomic context if pm_runtime_irq_safe() has not been used. And it is not
used in omapdss.

dsi uses clk_enable/disable in a different manner, but not in atomic
context.

So as far as I see, clocks are never handled in atomic context. Is
everything related to the base clk stuff already in mainline? Can I take
the clk_prepare/unprepare patch into my omapdss tree?


A question about clk_prepare/unprepare, not directly related: let's say
I have a driver for some HW block. The driver doesn't use clk functions,
but uses runtime PM. The driver also sets pm_runtime_irq_safe().

Now, the driver can call pm_runtime_get_sync() in an atomic context, and
this would lead to the underlying framework (hwmod, omap_device, I don't
know who =) enabling the func clock for that HW. But this would happen
in atomic context, so the underlying framework can't use clk_prepare.

How does the underlying framework handle that case? (sorry if that's a
stupid question =).

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120625/b57df7a5/attachment.sig>
