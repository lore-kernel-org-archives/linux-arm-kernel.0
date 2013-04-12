From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 12 Apr 2013 15:22:31 +0100
Subject: hypervisor/firmware calling conventions (Was: Re: [Xen-devel]
 [PATCH 1/4] xen/arm: basic PSCI support,	implement cpu_on)
In-Reply-To: <1365765378.15783.23.camel@zakaz.uk.xensource.com>
References: <alpine.DEB.2.02.1303211837140.5135@kaball.uk.xensource.com>
 <1363891353-13827-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <1365515874.10725.33.camel@zakaz.uk.xensource.com>
 <1365687148.8036.140.camel@zakaz.uk.xensource.com>
 <20130411170959.GA2239@linaro.org>
 <1365765378.15783.23.camel@zakaz.uk.xensource.com>
Message-ID: <20130412142231.GA2992@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 12, 2013 at 12:16:18PM +0100, Ian Campbell wrote:
> On Thu, 2013-04-11 at 18:10 +0100, Dave Martin wrote:
> > On Thu, Apr 11, 2013 at 02:32:28PM +0100, Ian Campbell wrote:
> > > Adding Charles and the l-a-k list which I hadn't noticed wasn't CC'd
> > > before. Are there other lists which would be useful to include?
> > > 
> > > On Tue, 2013-04-09 at 14:57 +0100, Ian Campbell wrote:
> > > > > +        if ( !hsr.iss )
> > > > > +            return do_trap_psci(regs);
> > 
> > Have you seen this work?
> 
> I presume Stefano has.
> 
> > Reading the specs, I thought that the SMC immediate is not available in
> > the HSR in ARMv7, or when the caller is AArch32.  ARMv7 specifies these
> > bits as UNK/SBZP, and the A15 TRM doesn't seem seem to specify any
> > extra information.
> 
> I trimmed the context so you probably don't know but this is handling
> PSCI via an HVC call not SMC, Linux lets you specify which to use in the
> DTB.
> 
> I didn't know that about SMC though -- think my eye confused it with
> SVC when I scanned the docs. Kind of a lame limitation...

Ah, OK (I'm remembering previous threads now).  Yes, I think the comment
field is guaranteed to appear in HSR.ISS for HVCs.


SMC pre-dates the existence of exception syndrome registers, so software
should in general not have been relying on the immediate for that anyway
(but what software should do and what it actually does do are of course not
always the same).


> > Otherwise, you would need to go examine the trapped instruction in
> > guest memory.  This is even less easy than it sounds.
> 
> Right, luckily we avoid it by using hvc.
> 
> > > > Ugh, using ISS==0 for this interface is a bit unfortunate, who
> > > > arbitrates this namespace?
> > 
> > Nobody, officially.  ARM is working to promulgate some standards in
> > this area, but there is plenty of pre-existing firmware and software
> > out there with non-standardised interfaces and it's hard to predict
> > adoption timescales.  I believe nothing is published relating to this
> > just yet.
> > 
> > > Xen chose to use a non-0 immediate for its hypercalls so we are lucky
> > > that we don't have to play tricks to distinguish PSCI calls from
> > > hypercalls but it seems to me that either there needs to be some
> > > semi-formal registry for smv/hvc immediates to avoid clashes or that
> > > interfaces need to pick a random non-zero number to try and minimise the
> > > chances of a clash.
> > > 
> > > Or maybe it gets pushed down a layer and the registry is of r0/x0
> > > function ids and the immediate argument is generally ignored?
> > > 
> > > But in general we need some way for interfaces provided by hypervisors
> > > and secure mode monitors to safely co-exist, I think, both for the case
> > > where the hypervisor is implementing a shim for a secure mode interface
> > > (i.e. implementing PSCI with hvc) and for the case where there are
> > > multiple interfaces at each layer (e.g. hypervisors sometimes want to
> > > implement foreign hypervisor interfaces and I can easily imagine other
> > > firmware level interfaces than PSCI coming into existence in the
> > > future).
> > 
> > For PSCI and similar firmware functionality, we envisage multiplexing
> > all interfaces based on a function number in r0, with arguments and
> > results constrained to r0-r7.  For PSCI, we specify SMC #0/HVC #0 as the
> > call mechanism.
> > 
> > For now, there is no global management of the r0 namespace, which
> > is why for PSCI we don't make static assumptions about the numbers
> > on the client side.  Instead, the function number for each PSCI function
> > is passed in the DT.  This means that the firmware or hypervisor can
> > allocate the numbers as appropriate to avoid clashes.
> > 
> > In general, this is likely to be the best approach for Linux until a
> > standard probing interface exists.
> 
> Yes, this is as good a scheme as we can hope for right now I think.
>  
> > In theory we could define a Xen-specific call mechanism for PSCI, but
> > that should be avoided unless it is absolutely unavoidable.  It sounds
> > like the different SMC comment field means that we don't need to
> > worry for Xen/PSCI coexistence specifically, assuming that the hypervisor
> > can read it reliably.
> 
> I think we've got the Xen side in hand, I was more bringing it up as a
> general issue.

OK, sounds good.

The PSCI bindings make it possible for the firmware or hypervisor to
manage the function ID namespace, so we should encourage people to
follow a similar approach for anything new, at least until there is
a better standard.

> > > In the specific case of PSCI I couldn't actually find the calling
> > > convention (i.e. the specific registers to use). I suspect I'm just
> > > looking at an old version of the spec...
> > 
> > This is indeed vague in the existing draft.  An update should appear
> > soon -- Charles can comment on the current status.
 
Cheers
---Dave
