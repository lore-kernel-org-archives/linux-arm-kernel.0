From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Apr 2011 21:09:01 +0100
Subject: cachepolicy on arm UP/SMP
In-Reply-To: <BANLkTi=6t=iLNcWPCtOoDai50A5N9m08UQ@mail.gmail.com>
References: <163eed8.b6ba.12f1441357c.Coremail.bill_carson@126.com>
	<BANLkTi=6t=iLNcWPCtOoDai50A5N9m08UQ@mail.gmail.com>
Message-ID: <20110427200901.GV17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2011 at 06:10:34PM +0100, Catalin Marinas wrote:
> 2011/4/2 rocky <bill_carson@126.com>:
> > I am a little confused about arm cachepolicy for UP/SMP.
> >
> > in arch/arm/mm/mmu.c
> > for UP , default cache policy is CPOLICY_WRITEBACK;
> > while for SMP, cache policy is overrided with? WRITEALLOC.
> >
> > why does SMP cannot use WRITEBACK?
> > It is about coherency issue?
> 
> Historical reasons I think because ARM11MPCore only supported WBWA
> caches, though even if only WB configuration was set.
> 
> Note that WB or WBWA is just a hint and the processor is allowed to do
> write allocation or ignore it. We could simply make both the same at
> least on ARMv6+ hardware (and I'm more in favour of WBWA).

The WB vs WBWA argument is rather religious.  It really depends a lot on
your workload.

While you can measure things like "ooh, it makes memcpy lots faster",
that alone is not the full story - it may make memcpy faster, but if your
application isn't about copying lots of data, but making random accesses,
it could result in a net performance loss instead.

So, leaving things as-is (being the established status quo) is best.
Those who have applications moving lots of data about without the
benefits of zero copy can easily enable WBWA if they so choose.
