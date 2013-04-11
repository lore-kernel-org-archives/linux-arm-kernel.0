From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Thu, 11 Apr 2013 14:32:28 +0100
Subject: hypervisor/firmware calling conventions (Was: Re: [Xen-devel]
 [PATCH 1/4] xen/arm: basic PSCI support,	implement cpu_on)
In-Reply-To: <1365515874.10725.33.camel@zakaz.uk.xensource.com>
References: <alpine.DEB.2.02.1303211837140.5135@kaball.uk.xensource.com>
 <1363891353-13827-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <1365515874.10725.33.camel@zakaz.uk.xensource.com>
Message-ID: <1365687148.8036.140.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding Charles and the l-a-k list which I hadn't noticed wasn't CC'd
before. Are there other lists which would be useful to include?

On Tue, 2013-04-09 at 14:57 +0100, Ian Campbell wrote:
> > +        if ( !hsr.iss )
> > +            return do_trap_psci(regs);
> 
> Ugh, using ISS==0 for this interface is a bit unfortunate, who
> arbitrates this namespace?

Xen chose to use a non-0 immediate for its hypercalls so we are lucky
that we don't have to play tricks to distinguish PSCI calls from
hypercalls but it seems to me that either there needs to be some
semi-formal registry for smv/hvc immediates to avoid clashes or that
interfaces need to pick a random non-zero number to try and minimise the
chances of a clash.

Or maybe it gets pushed down a layer and the registry is of r0/x0
function ids and the immediate argument is generally ignored?

But in general we need some way for interfaces provided by hypervisors
and secure mode monitors to safely co-exist, I think, both for the case
where the hypervisor is implementing a shim for a secure mode interface
(i.e. implementing PSCI with hvc) and for the case where there are
multiple interfaces at each layer (e.g. hypervisors sometimes want to
implement foreign hypervisor interfaces and I can easily imagine other
firmware level interfaces than PSCI coming into existence in the
future).

In the specific case of PSCI I couldn't actually find the calling
convention (i.e. the specific registers to use). I suspect I'm just
looking at an old version of the spec...

Ian.
