From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 May 2014 10:20:44 +0100
Subject: [PATCH RFCv2 1/5] ARM: use write allocate by default on ARMv6+
In-Reply-To: <20140530100819.1208149f@free-electrons.com>
References: <1400600105-3013-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1400600105-3013-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140526162643.GB3693@n2100.arm.linux.org.uk>
 <20140527111542.6a49833f@free-electrons.com>
 <20140527094749.GE3693@n2100.arm.linux.org.uk>
 <20140527135216.7eaf3b3f@free-electrons.com>
 <20140527121806.GF3693@n2100.arm.linux.org.uk>
 <20140527143745.386c77d9@free-electrons.com>
 <20140528112450.GH3693@n2100.arm.linux.org.uk>
 <20140530100819.1208149f@free-electrons.com>
Message-ID: <20140530092044.GO3693@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 30, 2014 at 10:08:19AM +0200, Thomas Petazzoni wrote:
> Russell,
> 
> Thanks a lot for working on a new proposal for this topic.
> 
> On Wed, 28 May 2014 12:24:50 +0100, Russell King - ARM Linux wrote:
> 
> > But the way you go about this is totally silly - you effectively end
> > up enabling all the SMP stuff even though you don't need it (which means
> > that on a SMP kernel, you end up with a bunch of extra stuff on those
> > platforms which aren't SMP, just because you want maybe one or two
> > is_smp() sites to return true.
> 
> Again, have you looked at the PATCH RFCv1 for this patch series? My
> first version was doing *exactly* what you suggest: only make the few
> call sites of is_smp() I was interested in to return true for the
> specific platforms that needed it.

No, and I don't intend to, because it's probably well buried.

> PATCH RFCv2 was generated after a discussion with Catalin and Rob, who
> suggested that we might want to simply always use the SMP capabilities
> on SMP-capable processors.

Frankly, they are both wrong if they suggested the approach in your v2
patch for all the reasons I've raised as objections against v2.

> > How about this patch for a start - which incidentally fixes two minor
> > bugs where specifying cachepolicy=<anything> on ARMv6 provokes a warning,
> > and sets the policy to writeback read-allocate, only to have it overriden
> > later.  The second bug is that we "hoped" that is_smp() reflects the asm
> > code's page table setup - this patch makes it more explicit by reading
> > the PMD flags, finding the appropriate entry in the table, and setting
> > the cache policy to that.  I've left the is_smp() check in because we
> > really do want to detect if something goes awry there.
> > 
> > However, the effect of this patch is that the C code now follows how
> > the assembly code sets up the page tables, which means that this is now
> > controllable via the PMD MMU flags in the assembly procinfo structure.
> > This means that for the Armada devices which need write-alloc for
> > coherency, you can specify that in the proc-*.S files - yes, it means
> > that you need a separate entry.
> 
> While that would work for Armada 370 and Armada XP, it does not work
> for Armada 375 and Armada 38x, as far as I can see. Armada 375 and
> Armada 38x are SMP-capable,

I'm *not* trying to solve everything here, I'm only solving the problem
of the C setup code matching what the assembly setup code is doing -
which is a long standing minor bug for ARMv6+.

> but we want to support hardware I/O
> coherency in a CONFIG_SMP=n configuration (mainly because Armada 380 is
> single-core). This means that in proc-v7.S, we would have to define
> that the page tables should use the write-allocate cache policy, and
> the shareable attribute, and this for *all* Cortex-A9, because from a
> MIDR point of view, there is no difference between the Cortex-A9 in
> Armada 375/38x and other Cortex-A9. And there are Cortex-A9, like the
> Aegis thing from TI that are *not* SMP-capable, so enabling shareable
> attributes will break.

If that's the case, we can't then support IO coherency at all - because
to have the asm code setup the page tables without the S bit set, and
then have the C code overwrite them with the S bit set is also a violation
of the architecture, as Catalin said when he patched the kernel adding
this restriction:

        /*
         * This restriction is partly to do with the way we boot; it is
         * unpredictable to have memory mapped using two different sets of
         * memory attributes (shared, type, and cache attribs).  We can not
         * change these attributes once the initial assembly has setup the
         * page tables.
         */

Whatever the assembly code does in respect to these attributes, the C
code has to follow.  So, my approach is entirely correct and right.

What this means is if we can't distinguish Armada's IO coherency at
assembly time, then we can't setup the page tables without the sharable
bit set in the asm code, and then set them up with the sharable bit set
in the C code.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
