From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 30 Aug 2013 14:08:30 -0600
Subject: [PATCH v3 1/3] ARM: Introduce atomic MMIO modify
In-Reply-To: <20130830100342.GD62188@MacBook-Pro.local>
References: <1377253445-2842-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1377253445-2842-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130823103802.GO4600@tarshish> <20130823110748.GD2389@localhost>
 <20130823113225.GF2389@localhost> <20130823114805.GF10971@arm.com>
 <20130830090807.GB25628@mudshark.cambridge.arm.com>
 <20130830091534.GA62188@MacBook-Pro.local>
 <20130830092032.GD25628@mudshark.cambridge.arm.com>
 <20130830100342.GD62188@MacBook-Pro.local>
Message-ID: <20130830200830.GB6368@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 30, 2013 at 11:03:42AM +0100, Catalin Marinas wrote:

> > Perhaps we should just bit the bullet and define relaxed accessors for all
> > architectures? It's not difficult to default them to the non-relaxed
> > variants if the architecture doesn't provide an optimised implementation.
> 
> Yes, an asm-generic default relaxed would be good (that's what I
> suggested earlier in this thread and it was discussed in the past). But
> no-one volunteered ;).

Something I've always been confused about..

Do these _relaxed operators on ARM differ from the PCI-X definition of
relaxed ordering, and are they expected to generate a PCI TLP with
the relaxed ordering bit set?

If so, what does writel_relaxed do? RO has no effect on transactions
travelling away from the PCI host bridge, so it is useless for the
CPU to generate RO TLPs.

AFAIK, on x86 read_relaxed is expected to cause the PCI behavior.
Documentation/DocBook/deviceiobook.tmpl seems to confirm this.

It seems important to reconcile the meaning before standardizing these
things :)

Jason
