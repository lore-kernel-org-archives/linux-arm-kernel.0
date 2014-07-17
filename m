From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 17 Jul 2014 10:45:12 +0200
Subject: [PATCH 0/3] ARM: mvebu: disable I/O coherency on !SMP
In-Reply-To: <20140717083342.GS21766@n2100.arm.linux.org.uk>
References: <1404318070-8503-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140702164147.GQ32514@n2100.arm.linux.org.uk>
 <20140717102425.34fe0181@free-electrons.com>
 <20140717083342.GS21766@n2100.arm.linux.org.uk>
Message-ID: <20140717104512.5d134904@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Thu, 17 Jul 2014 09:33:42 +0100, Russell King - ARM Linux wrote:

> > So wouldn't it be possible to keep the early
> > assembly code as it is today, and then later, in C code, once we have
> > identified the platform on which we're running, modify the page tables
> > to switch to the appropriate page attributes (write allocate cache
> > policy, shareable attribute, etc.) ?
> 
> No - the problem is that we're running from the page table in question
> with global mappings, and we need to switch all these mappings, including
> the ones we're currently using to execute from.
> 
> We can't even create a new page table and switch to it because the
> mappings in question are global mappings.
> 
> The only way to do that safely from an architectural point of view would
> be to turn the MMU off, and drop back to assembly code to change the
> page tables, and re-enable the MMU.  For something as obscure as Marvell's
> coherency stuff, that's not something I want to see in core code.

That's indeed tricky. But then, if we don't find solutions to support
in mainline the features of those SoCs, why are we asking all those SoC
vendors to push their code mainline?

As far as I can see, the conclusion of this discussion seems to be that
there is no solution that looks acceptable to you to support the
hardware I/O coherency functionality in mainline. I am trying hard to
get Marvell to stop using their evil vendor tree as much as possible,
but the message we're sending here is basically exactly the opposite:
we're telling them that there's no way to properly support hardware
I/O coherency in mainline and that the only solution for them is to keep
their evil vendor tree. Is this really what we want?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
