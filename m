From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Oct 2017 11:44:32 +0100
Subject: ARM: pxa/corgi: armv5te kernel 4.12 fails to decompress compiled
 with gcc7
In-Reply-To: <443102ff-9793-a938-1392-9baca727cb98@gmail.com>
References: <87a83zsiid.fsf@belgarion.home>
 <CAAQYJAtEmJMc766kUx+bhFCNQKmwK53nSDNL0nFz-9UXSUO5CQ@mail.gmail.com>
 <20171014215042.kfrhb2kjhm7wb7vb@darkstar.musicnaut.iki.fi>
 <87mv4txuid.fsf@belgarion.home>
 <20171015104640.hazujjkbqyik7fgg@darkstar.musicnaut.iki.fi>
 <f1631768-b26e-62ae-db1f-65686cd0c4de@gmail.com>
 <CAAQYJAsmOr2qnykO=rWH1N43q3+d27aHMAyXHTXMYpPQ1=9ikA@mail.gmail.com>
 <26e751ec-7fc7-475a-5603-2fac4e0700cb@gmail.com>
 <CAAQYJAuxMHGiyMCFqryYa6QGrXd1JHZnTG60VSGnG6hu9zhitA@mail.gmail.com>
 <443102ff-9793-a938-1392-9baca727cb98@gmail.com>
Message-ID: <20171018104432.GR20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 18, 2017 at 12:39:13PM +0200, Petr Cvek wrote:
> 
> 
> Dne 17.10.2017 v 10:18 Andrea Adami napsal(a):
> >On Tue, Oct 17, 2017 at 10:10 AM, Petr Cvek <petrcvekcz@gmail.com> wrote:
> >>If it is a problem with gcc (as Russell said before), there is no way you
> >>can fix it in the kernel. Only compiling it with an older gcc version can
> >>help.
> >>
> 
> BTW you could add "alignment=2" (same as /proc/cpu/alignment) in your kernel
> parameters and kernel should check it even before you boot userspace.
> 
> But it will be *extra* slow as there will be many exceptions in the kernel
> and an emulation of the unaligned instructions. It is not a real permanent
> fix.

That's wrong.

Alignment exceptions are always fixed up in the kernel.  The parameter
(and what you set by writing /proc/cpu/alignment) sets the behaviour of
_userspace_ alignment exceptions.

> It should be possible to use up to march=armv5t as I elaborated it in the
> other mail.

If you're building for PXA, it's an ARMv5 architecture.  The kernel will
use -march=armv5te for all ARMv5 architectures.  Moreover, because one
of the PXA2* symbols should also be selected, CPU_XSCALE will also be
enabled, which means we will pass -mtune=xscale to the compiler.

The exception is if CPU_FEROCEON is enabled, in which case we will pass
-mtune=marvell-f to the kernel if supported by the compiler.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
