From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 2 Apr 2015 16:16:26 +0200
Subject: [PATCH] ARM: mvebu: use 0xf1000000 as internal registers on
 Armada 370 DB
In-Reply-To: <2515980.d69ggAvHPo@wuerfel>
References: <1427966184-8288-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <2321040.CmsL1gluUd@wuerfel>
 <20150402153650.2cc9c3d7@free-electrons.com>
 <2515980.d69ggAvHPo@wuerfel>
Message-ID: <20150402161626.182e267d@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On Thu, 02 Apr 2015 16:09:03 +0200, Arnd Bergmann wrote:

> This device has 1GB, doing an incompatible change to an existing machine
> is completely moronic. How hard can it be to special-case this board
> in u-boot?

The device has a DIMM slot for RAM. 1 GB in the DT is just an example,
and it gets updated through ATAGS, or directly by the bootloader with
the real amount of RAM that you have, which can go up to 4 GB.

> > Also, the proposed change is exactly the same we've done on several
> > Marvell evaluation boards in the past:
> > 
> >   http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/arch/arm/boot/dts/armada-xp-gp.dts?id=91ed32200e6ea1df19df01355c5c7747f9014102
> >   http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/arch/arm/boot/dts/armada-xp-db.dts?id=82066bdb5a759ec00c18f9667853c4fe8840e83d
> 
> I'm aware of those, I just wish they would learn from their mistakes.

There was no mistake at all. You have no idea what the history of this
problem is, and you're giving lessons.

As Andrew Lunn said, on *all* Marvell EBU platforms the internal
registers have always been remapped at 0xf1000000. Look at Kirkwood,
Orion, Dove.

Marvell wanted to do exactly the same for Armada 370 and XP, which is
perfectly sane: keep the same behavior.

Except that the very early steppings of Armada 370 and Armada XP had a
bug, which prevented from changing the internal register base address,
so they had no other choice but to keep it at 0xd0000000. And then,
once those early steppings were replaced by real production steppings,
the bug was fixed, and they migrated to 0xf1000000, and the situation
was back to normal.

> Find a different name then, but don't change the value in the existing
> file. It's been around for too long now. The other ones were changed
> shortly after being introduced, but anybody who is using

Not at all. The others were also changed long after the board was
introduced in the kernel. Not as long as for the Armada 370 DB, because
I only recently put my hand on an eval board which has a production
stepping of the SoC.

> armada-370-db.dts today obviously has the old boot loader and cannot
> update the bootloader without breaking their kernels, but they should
> at least be able to update their kernels without changing the
> scripts.

All customers have evaluation boards with a production stepping of the
silicon, and for all of them the current kernel is *not* working.

The patch I'm proposing is what makes the kernel work for them.

Arnd, please don't get in the way of platform maintainers for such very
platform-specific issues for which you don't have the background about
what happened and why we're doing this change. It's the responsibility
of the platform maintainers to decide how and when they want to keep or
break the compatibility.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
