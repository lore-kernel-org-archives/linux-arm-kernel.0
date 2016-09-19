From: oss@buserror.net (Scott Wood)
Date: Mon, 19 Sep 2016 12:01:29 -0500
Subject: [PATCH v5 3/5] arm64: arch_timer: Work around QorIQ Erratum
 A-008585
In-Reply-To: <20160919165258.GA30584@leverpostej>
References: <1473469413-11019-1-git-send-email-oss@buserror.net>
 <1473469413-11019-3-git-send-email-oss@buserror.net>
 <20160912113615.GA20804@leverpostej>
 <1474260085.15220.17.camel@buserror.net>
 <20160919165258.GA30584@leverpostej>
Message-ID: <1474304489.4283.6.camel@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-09-19 at 17:52 +0100, Mark Rutland wrote:
> > > > 
> > > > +static void fsl_a008585_set_sne(struct clock_event_device *clk)
> > > > +{
> > > > +#ifdef CONFIG_FSL_ERRATUM_A008585
> > > > +	if (!static_branch_unlikely(&arch_timer_read_ool_enabled))
> > > > +		return;
> > > > +
> > > > +	if (arch_timer_uses_ppi == VIRT_PPI)
> > > > +		clk->set_next_event =
> > > > fsl_a008585_set_next_event_virt;
> > > > +	else
> > > > +		clk->set_next_event =
> > > > fsl_a008585_set_next_event_phys;
> > > > +#endif
> > > > +}
> > > > +
> > > I'm not keen on the magic hook to reset the function pointers, and the
> > > additional phys/virt stubs seem pointless. Instead, can we fold this
> > > into the existing set_next_event? e.g. have that do:
> > > 
> > > 	if (needs_fsl_a008585_workaround() {
> > > 		fsl_a008585_set_next_event(access, evt, clk);
> > > 		return;
> > > 	}
> > OK. ?I had been trying to avoid messing with the standard set_next_event,
> > but
> > it doesn't matter as much now that static branches are being used. ?In
> > that
> > case we can avoid duplicating the ctrl code, and only replace the tval
> > write.
> Reconsidering my suggestion, I realise this will also affect the MMIO
> timers, so that doesn't work.
> 
> So for the moment, I guess we have to keep fsl_a008585_set_next_event().

What is the problem with MMIO timers? ?needs_fsl_a008585_workaround() should
always be false for them.

-Scott
