From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Dec 2009 16:16:35 +0000
Subject: [PATCH 5/6] ARMv7: Improved page table format with TRE and AFE
In-Reply-To: <20091214161139.GA16953@n2100.arm.linux.org.uk>
References: <20091207135603.30429.74812.stgit@pc1117.cambridge.arm.com>
	<20091207141404.30429.85379.stgit@pc1117.cambridge.arm.com>
	<20091212112829.GB27020@n2100.arm.linux.org.uk>
	<1260805824.17159.101.camel@pc1117.cambridge.arm.com>
	<20091214161139.GA16953@n2100.arm.linux.org.uk>
Message-ID: <1260807395.17159.112.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-12-14 at 16:11 +0000, Russell King - ARM Linux wrote:
> On Mon, Dec 14, 2009 at 03:50:24PM +0000, Catalin Marinas wrote:
> > > - Kernel reads PTE and modifies it
> >
> > B3.3.5 in the ARM ARM describes the requirements for the Hardware
> > management of the access flag:
> >
> >         Any implementation of hardware management of the access flag
> >         must ensure that any software changes to the translation table
> >         are not lost. The architecture does not require software that
> >         performs translation table changes to use interlocked
> >         operations. The hardware management mechanisms for the access
> >         flag must prevent any loss of data written to translation table
> >         entries that might occur when, for example, a write by another
> >         processor occurs between the read and write phases of a
> >         translation table walk that updates the
> >         access flag.
> >
> > At the hardware level, it could be implemented similar to a LDREX/STREX
> > block.
> >
> > > - Hardware accesses page
> > > -  TLB reads PTE, updates, and writes new back
> > > - Kernel writes PTE back
> >
> > Addressed above. The hardware write should fail if there was an STR from
> > the current or different CPU.
[...]
> The case I was talking about is:
> 
> - Kernel reads PTE
> - Hardware reads PTE
> - Hardware writes PTE
> - Kernel writes PTE
> 
> Since there is no STR between the hardware reading and writing the PTE,
> the hardware can not know that its update has been lost.
> 
> Whether it matters or not is a different kettle of fish.

I was expected this follow-up :-), so I already replied to my post. I
don't think it matters.

-- 
Catalin
