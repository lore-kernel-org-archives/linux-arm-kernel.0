From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 13 Jun 2014 13:34:37 +0200
Subject: [PATCH RFCv2 1/5] ARM: use write allocate by default on ARMv6+
In-Reply-To: <20140613102019.GQ23430@n2100.arm.linux.org.uk>
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
 <20140613102019.GQ23430@n2100.arm.linux.org.uk>
Message-ID: <20140613133437.1a85f287@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Fri, 13 Jun 2014 11:20:19 +0100, Russell King - ARM Linux wrote:

> > I spoke briefly about this with Albin Tonnerre from ARM, and his
> > feedback is that it should not cause any problem to set the SMP bit and
> > the shareable attribute even on non-SMP Cortex-A9 processors such as
> > the Aegis. If that's correct, then we could do it for all Cortex-A9,
> > without having to know whether what we have is a SoC from Marvell with
> > I/O coherency or any other Cortex-A9 based SoC.
> 
> Setting the sharable attribute is not really a good idea - implementations
> are permitted to treat a writeback sharable mapping as uncacheable, which
> would be a severe performance degredation to single core CPUs.

Then maybe we could set the shareable attribute on SMP-capable
processors even if CONFIG_SMP is disabled? This way, those single core
CPUs that are really not SMP capable continue to run without the
shareable attribute, while all SMP-capable processors run with the
shareable attribute, regardless of whether the kernel is configured
CONFIG_SMP or not.

> The patches I sent during this thread are now merged into mainline.  The
> setting of the shared bit, and the memory cache policy are now both
> derived from the proc_info structures, specifically the __cpu_mm_mmu_flags
> member.

Right. So for Armada 370/XP, I'll update the proc_info structure. We
still have to find the right solution/compromise for the Armada 375/38x
though.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
