From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Jul 2010 23:34:18 +0100
Subject: [patch 071/149] ARM: 6166/1: Proper prefetch abort handling on
	pre-ARMv6
In-Reply-To: <20100707085601.GA18732@shutemov.name>
References: <20100701173212.785441106@clark.site>
	<20100701221420.GA10481@shutemov.name>
	<20100701221728.GA12187@suse.de>
	<20100701222541.GB10481@shutemov.name>
	<20100701224837.GA27389@flint.arm.linux.org.uk>
	<20100701225911.GC10481@shutemov.name>
	<20100701231207.GB27389@flint.arm.linux.org.uk>
	<20100706130618.GA14177@shutemov.name>
	<20100706225815.GA21834@flint.arm.linux.org.uk>
	<20100707085601.GA18732@shutemov.name>
Message-ID: <20100707223417.GA22673@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 07, 2010 at 11:56:01AM +0300, Kirill A. Shutemov wrote:
> But it seems that the problem is more global. Potentially, any of
> pmd_none() check may produce false results. I don't see an easy way to fix
> it.

It isn't.  We normally guarantee that we always fill on both L1 entries.
The only exception is for the mappings specified via create_mapping()
which is used for the static platform mappings.

> Does Linux VM still expect one PTE table per page?

Yes, and as far as I can see probably always will.  Hence why we need
to put two L1 entries in one page and lie to the kernel about the sizes
of the hardware entries.
