From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Apr 2013 15:20:55 +0100
Subject: [PATCH v6 1/4] arm: introduce psci_smp_ops
In-Reply-To: <alpine.LFD.2.03.1304181233580.17375@syhkavp.arg>
References: <alpine.DEB.2.02.1304031239550.5078@kaball.uk.xensource.com>
 <1365167495-18508-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <20130418161341.GB14496@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1304181714560.7254@kaball.uk.xensource.com>
 <alpine.LFD.2.03.1304181233580.17375@syhkavp.arg>
Message-ID: <20130422142055.GK14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 12:35:57PM -0400, Nicolas Pitre wrote:
> On Thu, 18 Apr 2013, Stefano Stabellini wrote:
> 
> > On Thu, 18 Apr 2013, Russell King - ARM Linux wrote:
> > > On Fri, Apr 05, 2013 at 02:11:32PM +0100, Stefano Stabellini wrote:
> > > > +	psci_init();
> > > >  #ifdef CONFIG_SMP
> > > >  	if (is_smp()) {
> > > > -		smp_set_ops(mdesc->smp);
> > > > +		if (mdesc->smp)
> > > > +			smp_set_ops(mdesc->smp);
> > > > +		else if (psci_smp_available())
> > > > +			smp_set_ops(&psci_smp_ops);
> > > 
> > > So, I have a vague recollection that the ordering of the above got discussed
> > > but I can't find it amongst the 21k of messages so far this year.
> > > 
> > > The above looks weird to me.  Surely this should be:
> > > 
> > > 		if (psci_smp_available())
> > > 			smp_set_ops(&psci_smp_ops);
> > > 		else if (mdesc->smp)
> > > 			smp_set_ops(mdesc->ops);
> > > 
> > > This means that if PSCI is available, and provides a set of operations,
> > > we override whatever the platform has statically provided.
> > > 
> > > Remember, we're trying to move away from using "mdesc"s for platform
> > > stuff, relying on things like DT and such like.  We really should not
> > > be going for mdesc-overriding-newstuff but newstuff-overriding-mdesc.
> > 
> > That's correct, in fact if you look at the next patch you'll see that it
> > changes the order.
> > 
> > I introduced the mechanism first and changed the priority later - it
> > should help bisectability.
> > I can fold the two patches into one if you prefer.
> 
> Please let's keep the order as we discussed.  Otherwise this is just too 
> confusing (Russell's comment is a good example of that).

My comment is based on the code which I had read and quoted.  Things
had moved on from that point, but, because I had 2000 odd messages to
get through, there was no way to know at that point that there had been
further discussion.

This is why catching up is such a problem - not only the amount of time
it takes (I'm _still_ reading messages - I've only just read your reply
above, so I'm still back in Thursday's email...)

I don't think there's any confusion though - the order I suggested seems
to be the order which I recall later patches adopted.
