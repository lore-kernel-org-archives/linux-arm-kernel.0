From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 29 Jan 2010 10:38:59 +0000
Subject: [PATCH 3/3] ARM: Select CPU_32v6K for CPU_V7 only if
	ARCH_OMAP2 isnot selected
In-Reply-To: <20100128183303.GA30029@shareable.org>
References: <20100128183303.GA30029@shareable.org>
Message-ID: <1264761539.4242.25.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-01-28 at 18:33 +0000, Jamie Lokier wrote:
> Catalin Marinas wrote:
> > > Hmm, but then we can't compile in SMP for single core systems and
> > > keep it bootable on single core v6?
> >
> > Not with the current kernel since it hardcodes the shareability bit in
> > the page tables and the LDREX/STREX operations don't work as expected on
> > uniprocessor hardware.
> 
> My understanding of LDREX/STREX is that it's allowed to be quite
> different on uniprocessors (and CPU-local activity on SMP), but if
> it's used properly it still works ok.
> 
> Can you say a bit more about assumptions made by the kernel using
> LDREX/STREX that fail on uniprocessor hardware?
> 
> Is it just the shareability bit in page tables having the wrong value?

The kernel doesn't make any assumptions. It's the CPU that behaved
differently when the page was marked as shareable in a UP system. I
tried in the past and it looked like STREX was expecting some kind of
global exclusive monitor and it was always failing.

Anyway, it is possible that I don't recall correctly and it may have
been just an ARM11MPCore but with the SMP/nAMP mode disabled but the
STREX had already implemented with other expectations.

It's worth giving it a try though.

-- 
Catalin
