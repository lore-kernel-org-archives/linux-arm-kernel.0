From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 13 Jun 2014 12:11:21 +0200
Subject: [PATCH RFCv2 1/5] ARM: use write allocate by default on ARMv6+
In-Reply-To: <20140530092044.GO3693@n2100.arm.linux.org.uk>
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
 <20140530092044.GO3693@n2100.arm.linux.org.uk>
Message-ID: <20140613121121.7e7dc8e6@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Thanks again for your feedback, and sorry for the delay in replying, I
was busy with other things.

On Fri, 30 May 2014 10:20:44 +0100, Russell King - ARM Linux wrote:

> > Again, have you looked at the PATCH RFCv1 for this patch series? My
> > first version was doing *exactly* what you suggest: only make the few
> > call sites of is_smp() I was interested in to return true for the
> > specific platforms that needed it.
> 
> No, and I don't intend to, because it's probably well buried.

Well, it's not that buried since it only dates back from last month and
is available at
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/256258.html.
I think looking at the prior versions of a patch series is kind of
important to understand the various solutions that have been
discussed/explored, especially when comments made on later versions
reflect back on things that where already proposed in earlier versions.

> > While that would work for Armada 370 and Armada XP, it does not work
> > for Armada 375 and Armada 38x, as far as I can see. Armada 375 and
> > Armada 38x are SMP-capable,
> 
> I'm *not* trying to solve everything here, I'm only solving the problem
> of the C setup code matching what the assembly setup code is doing -
> which is a long standing minor bug for ARMv6+.

Right, understood. Since we have a special proc_info entry for Armada
370/XP (as they are PJ4B and not Cortex-A based), this means we can
ensure the cache policy is write-allocate for both UP and SMP for those
processors.

> > but we want to support hardware I/O
> > coherency in a CONFIG_SMP=n configuration (mainly because Armada 380 is
> > single-core). This means that in proc-v7.S, we would have to define
> > that the page tables should use the write-allocate cache policy, and
> > the shareable attribute, and this for *all* Cortex-A9, because from a
> > MIDR point of view, there is no difference between the Cortex-A9 in
> > Armada 375/38x and other Cortex-A9. And there are Cortex-A9, like the
> > Aegis thing from TI that are *not* SMP-capable, so enabling shareable
> > attributes will break.
> 
> If that's the case, we can't then support IO coherency at all - because
> to have the asm code setup the page tables without the S bit set, and
> then have the C code overwrite them with the S bit set is also a violation
> of the architecture, as Catalin said when he patched the kernel adding
> this restriction:
> 
>         /*
>          * This restriction is partly to do with the way we boot; it is
>          * unpredictable to have memory mapped using two different sets of
>          * memory attributes (shared, type, and cache attribs).  We can not
>          * change these attributes once the initial assembly has setup the
>          * page tables.
>          */
> 
> Whatever the assembly code does in respect to these attributes, the C
> code has to follow.  So, my approach is entirely correct and right.
> 
> What this means is if we can't distinguish Armada's IO coherency at
> assembly time, then we can't setup the page tables without the sharable
> bit set in the asm code, and then set them up with the sharable bit set
> in the C code.

I spoke briefly about this with Albin Tonnerre from ARM, and his
feedback is that it should not cause any problem to set the SMP bit and
the shareable attribute even on non-SMP Cortex-A9 processors such as
the Aegis. If that's correct, then we could do it for all Cortex-A9,
without having to know whether what we have is a SoC from Marvell with
I/O coherency or any other Cortex-A9 based SoC.

Would this be an acceptable solution for you?

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
