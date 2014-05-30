From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 30 May 2014 10:08:19 +0200
Subject: [PATCH RFCv2 1/5] ARM: use write allocate by default on ARMv6+
In-Reply-To: <20140528112450.GH3693@n2100.arm.linux.org.uk>
References: <1400600105-3013-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1400600105-3013-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140526162643.GB3693@n2100.arm.linux.org.uk>
 <20140527111542.6a49833f@free-electrons.com>
 <20140527094749.GE3693@n2100.arm.linux.org.uk>
 <20140527135216.7eaf3b3f@free-electrons.com>
 <20140527121806.GF3693@n2100.arm.linux.org.uk>
 <20140527143745.386c77d9@free-electrons.com>
 <20140528112450.GH3693@n2100.arm.linux.org.uk>
Message-ID: <20140530100819.1208149f@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Thanks a lot for working on a new proposal for this topic.

On Wed, 28 May 2014 12:24:50 +0100, Russell King - ARM Linux wrote:

> But the way you go about this is totally silly - you effectively end
> up enabling all the SMP stuff even though you don't need it (which means
> that on a SMP kernel, you end up with a bunch of extra stuff on those
> platforms which aren't SMP, just because you want maybe one or two
> is_smp() sites to return true.

Again, have you looked at the PATCH RFCv1 for this patch series? My
first version was doing *exactly* what you suggest: only make the few
call sites of is_smp() I was interested in to return true for the
specific platforms that needed it.

PATCH RFCv2 was generated after a discussion with Catalin and Rob, who
suggested that we might want to simply always use the SMP capabilities
on SMP-capable processors.

> How about this patch for a start - which incidentally fixes two minor
> bugs where specifying cachepolicy=<anything> on ARMv6 provokes a warning,
> and sets the policy to writeback read-allocate, only to have it overriden
> later.  The second bug is that we "hoped" that is_smp() reflects the asm
> code's page table setup - this patch makes it more explicit by reading
> the PMD flags, finding the appropriate entry in the table, and setting
> the cache policy to that.  I've left the is_smp() check in because we
> really do want to detect if something goes awry there.
> 
> However, the effect of this patch is that the C code now follows how
> the assembly code sets up the page tables, which means that this is now
> controllable via the PMD MMU flags in the assembly procinfo structure.
> This means that for the Armada devices which need write-alloc for
> coherency, you can specify that in the proc-*.S files - yes, it means
> that you need a separate entry.

While that would work for Armada 370 and Armada XP, it does not work
for Armada 375 and Armada 38x, as far as I can see. Armada 375 and
Armada 38x are SMP-capable, but we want to support hardware I/O
coherency in a CONFIG_SMP=n configuration (mainly because Armada 380 is
single-core). This means that in proc-v7.S, we would have to define
that the page tables should use the write-allocate cache policy, and
the shareable attribute, and this for *all* Cortex-A9, because from a
MIDR point of view, there is no difference between the Cortex-A9 in
Armada 375/38x and other Cortex-A9. And there are Cortex-A9, like the
Aegis thing from TI that are *not* SMP-capable, so enabling shareable
attributes will break.

So unless I'm missing something, I don't see how your approach solves
the problem for the Cortex-A9 platforms. What would be your suggestion
to solve this issue?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
