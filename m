From: balbi@ti.com (Felipe Balbi)
Date: Fri, 5 Apr 2013 17:29:44 +0300
Subject: [PATCH v3 1/4] ARM: OMAP4+: PM: Consolidate MPU subsystem PM
 code for re-use
In-Reply-To: <20130405141801.GA4270@kahuna>
References: <1365166743-5940-1-git-send-email-santosh.shilimkar@ti.com>
 <1365166743-5940-2-git-send-email-santosh.shilimkar@ti.com>
 <20130405131935.GM11464@arwen.pp.htv.fi>
 <20130405133511.GA4143@kahuna>
 <20130405140420.GB12229@arwen.pp.htv.fi>
 <20130405141801.GA4270@kahuna>
Message-ID: <20130405142944.GC12229@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 05, 2013 at 09:18:02AM -0500, Nishanth Menon wrote:
> On 17:04-20130405, Felipe Balbi wrote:
> > Hi,
> > 
> > On Fri, Apr 05, 2013 at 08:35:11AM -0500, Nishanth Menon wrote:
> > > On 16:19-20130405, Felipe Balbi wrote:
> > > > On Fri, Apr 05, 2013 at 06:29:00PM +0530, Santosh Shilimkar wrote:
> > > > > OMAP5 and future OMAP based SOCs has backward compatible MPUSS
> > > > > IP block with OMAP4. It's programming model is mostly similar.
> > > > 
> > > > s/It's/Its/
> > > > s/mostly //
> > > > 
> > > > (similar already expands to 'almost the same' :-)
> > > > 
> > > > > @@ -355,6 +389,12 @@ int __init omap4_mpuss_init(void)
> > > > >  
> > > > >  	save_l2x0_context();
> > > > >  
> > > > > +	if (cpu_is_omap44xx()) {
> > > > > +		omap_pm_ops.finish_suspend = omap4_finish_suspend;
> > > > > +		omap_pm_ops.resume = omap4_cpu_resume;
> > > > > +		omap_pm_ops.scu_prepare = scu_pwrst_prepare;
> > > > > +	}
> > > > 
> > > > why don't you just rename omap4_* into omap_* and add cpu-based checks
> > > > there in order to handle differences between omap4 and omap5?
> > > > 
> > > > If implementation will be almost the same for both, you might be able to
> > > > save on some more duplication, no ?
> > > Jeez NO! finish_suspend is assembly, further, it is the hottest path in
> > > cpuidle framework - for every WFI we invoke it. we definitely dont want
> > > to add more overhead beyond what is necessary.
> > 
> > alright, settle down ;-) whoever suggested that isn't here anymore
> hehe, Apologies, I was'nt that stressed as the wording might have
> indicated.. We spend tons of time evaluating with Lauterbach tracing to
> weed out hot paths - folks who have been bitten by these tend to feel a
> little defensive I guess and to have surprise regressions are painful to
> find and fix - esp when around not-so-obvious paths ;)

understood ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130405/a00aa6ff/attachment.sig>
