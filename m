From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 13 Apr 2017 10:53:00 +1000
Subject: [PATCH v3 00/32] PCI: fix config and I/O Address space memory
 mappings
In-Reply-To: <20170412224555.GB17774@n2100.armlinux.org.uk>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
 <1491917906.7236.7.camel@kernel.crashing.org>
 <20170411140857.GA6821@red-moon>
 <1491952371.7236.22.camel@kernel.crashing.org>
 <20170412113124.GZ17774@n2100.armlinux.org.uk>
 <1492005119.7236.62.camel@kernel.crashing.org>
 <20170412141654.GA17774@n2100.armlinux.org.uk>
 <20170412144109.GB6842@red-moon>
 <1492036240.7236.80.camel@kernel.crashing.org>
 <20170412224555.GB17774@n2100.armlinux.org.uk>
Message-ID: <1492044780.7236.87.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-04-12 at 23:45 +0100, Russell King - ARM Linux wrote:
> On Thu, Apr 13, 2017 at 08:30:40AM +1000, Benjamin Herrenschmidt wrote:
> > My point with nopost() is that it's never ok to silently downgrade it.
> > Code written with the assumption that there is no posting will be
> > *incorrect* if posting happens. We do live with that "bug" today indeed
> > but once we have that accessors we might start growing more code that
> > relies on the specific attribute that things aren't posted and will be
> > wrong on all the archs providing the default implementation.
> > 
> > This is why I insist that pgprot_nopost() if it exists globally, should
> > return NULL when the semantic cannot be provided.
> 
> Now you're not talking sense.??pgprot_nopost() does _not_ return a pointer.
> You're talking here as if you're still talking about ioremap_nopost().
> So, I think you're confused.

Nah, just "typo", I meant ioremap_nopost.

> > > > Just like the proposed ioremap_nopost(), pgprot_nonposted() is given a
> > > > default implementation that uses pgprot_noncached().? Maybe we should
> > > > also make pci_remap_iospace() fail if pgprot_nonposted() is not defined
> > > > by the architecture?
> > 
> > Or we *document* that mmap of IO space can result in something that is
> > partially non-posted.
> 
> Oh, so we _can_ provide an interface that has weaker semantics than it
> should provided we document it.
> 
> It's insane to have different behaviours from these two interfaces, yet
> you seem to have said exactly that in your reply.
>
> It's actually worse than that - what you've just said is that it's okay
> for userspace to map IO space with weaker semantics than the PCI
> specification states, but it's not okay for kernel space to do that.

That is not what I'm saying. What I'm saying is that it's not ok to
provide a generic mapping attribute that silently happens to be weaker
than documented on some architectures.

The PCI part is orthogonal. How do you handle PCI in absence of that
attribute is a separate problem (which is probably a matter of just
documenting things).

BTW. Is config space also non-posted on Intel with mmconfig ? I didn't
think they could do non posted MMIO stores, but maybe I'm wrong.

> Especially as userspace can't know what semantics its going to end up
> with, this seems to be a very strange stance to take.

That's why we document that the userspace interface for *PCI* is
relaxed.

> I'd say that if we can't offer the no-posting behaviour that PCI
> specifies, then we shouldn't be exposing IO mappings to userspace.

I strongly disagree. We've been doing it for decades and it works
fine in pretty much all cases.

Note also that some platforms (including some powerpc afaik) do provide
the non-posted behaviour, simply not as a mapping attribute. Internal
fabrics aren't necessarily doing posted writes and some bridges will
hold the response for non-posted requests.

Anyway, I don't object to trying to improve compliance with the spec
on arch that have such a mapping attribute. But I do object to having
a generic mapping attribute (that isn't fundamentally a PCI thing) that
silently downgrades to something weaker.

Ben.
