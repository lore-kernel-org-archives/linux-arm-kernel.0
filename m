From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 18 Apr 2013 12:35:57 -0400 (EDT)
Subject: [PATCH v6 1/4] arm: introduce psci_smp_ops
In-Reply-To: <alpine.DEB.2.02.1304181714560.7254@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1304031239550.5078@kaball.uk.xensource.com>
 <1365167495-18508-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <20130418161341.GB14496@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1304181714560.7254@kaball.uk.xensource.com>
Message-ID: <alpine.LFD.2.03.1304181233580.17375@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Apr 2013, Stefano Stabellini wrote:

> On Thu, 18 Apr 2013, Russell King - ARM Linux wrote:
> > On Fri, Apr 05, 2013 at 02:11:32PM +0100, Stefano Stabellini wrote:
> > > +	psci_init();
> > >  #ifdef CONFIG_SMP
> > >  	if (is_smp()) {
> > > -		smp_set_ops(mdesc->smp);
> > > +		if (mdesc->smp)
> > > +			smp_set_ops(mdesc->smp);
> > > +		else if (psci_smp_available())
> > > +			smp_set_ops(&psci_smp_ops);
> > 
> > So, I have a vague recollection that the ordering of the above got discussed
> > but I can't find it amongst the 21k of messages so far this year.
> > 
> > The above looks weird to me.  Surely this should be:
> > 
> > 		if (psci_smp_available())
> > 			smp_set_ops(&psci_smp_ops);
> > 		else if (mdesc->smp)
> > 			smp_set_ops(mdesc->ops);
> > 
> > This means that if PSCI is available, and provides a set of operations,
> > we override whatever the platform has statically provided.
> > 
> > Remember, we're trying to move away from using "mdesc"s for platform
> > stuff, relying on things like DT and such like.  We really should not
> > be going for mdesc-overriding-newstuff but newstuff-overriding-mdesc.
> 
> That's correct, in fact if you look at the next patch you'll see that it
> changes the order.
> 
> I introduced the mechanism first and changed the priority later - it
> should help bisectability.
> I can fold the two patches into one if you prefer.

Please let's keep the order as we discussed.  Otherwise this is just too 
confusing (Russell's comment is a good example of that).


Nicolas
