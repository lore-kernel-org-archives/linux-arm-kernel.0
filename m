From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Jun 2014 11:20:19 +0100
Subject: [PATCH RFCv2 1/5] ARM: use write allocate by default on ARMv6+
In-Reply-To: <20140613121121.7e7dc8e6@free-electrons.com>
References: <20140526162643.GB3693@n2100.arm.linux.org.uk>
 <20140527111542.6a49833f@free-electrons.com>
 <20140527094749.GE3693@n2100.arm.linux.org.uk>
 <20140527135216.7eaf3b3f@free-electrons.com>
 <20140527121806.GF3693@n2100.arm.linux.org.uk>
 <20140527143745.386c77d9@free-electrons.com>
 <20140528112450.GH3693@n2100.arm.linux.org.uk>
 <20140530100819.1208149f@free-electrons.com>
 <20140530092044.GO3693@n2100.arm.linux.org.uk>
 <20140613121121.7e7dc8e6@free-electrons.com>
Message-ID: <20140613102019.GQ23430@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 13, 2014 at 12:11:21PM +0200, Thomas Petazzoni wrote:
> On Fri, 30 May 2014 10:20:44 +0100, Russell King - ARM Linux wrote:
> > > Again, have you looked at the PATCH RFCv1 for this patch series? My
> > > first version was doing *exactly* what you suggest: only make the few
> > > call sites of is_smp() I was interested in to return true for the
> > > specific platforms that needed it.
> > 
> > No, and I don't intend to, because it's probably well buried.
> 
> Well, it's not that buried since it only dates back from last month and
> is available at
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/256258.html.
> I think looking at the prior versions of a patch series is kind of
> important to understand the various solutions that have been
> discussed/explored, especially when comments made on later versions
> reflect back on things that where already proposed in earlier versions.

For me, "last month" is as good as buried.  With already 2300 messages
this month alone, I'm not going to be looking back through last months
8297 messages.  If it wasn't sent during the last week, it's buried.

> Right, understood. Since we have a special proc_info entry for Armada
> 370/XP (as they are PJ4B and not Cortex-A based), this means we can
> ensure the cache policy is write-allocate for both UP and SMP for those
> processors.

Yep.

> I spoke briefly about this with Albin Tonnerre from ARM, and his
> feedback is that it should not cause any problem to set the SMP bit and
> the shareable attribute even on non-SMP Cortex-A9 processors such as
> the Aegis. If that's correct, then we could do it for all Cortex-A9,
> without having to know whether what we have is a SoC from Marvell with
> I/O coherency or any other Cortex-A9 based SoC.

Setting the sharable attribute is not really a good idea - implementations
are permitted to treat a writeback sharable mapping as uncacheable, which
would be a severe performance degredation to single core CPUs.

The patches I sent during this thread are now merged into mainline.  The
setting of the shared bit, and the memory cache policy are now both
derived from the proc_info structures, specifically the __cpu_mm_mmu_flags
member.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
