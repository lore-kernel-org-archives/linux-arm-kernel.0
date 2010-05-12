From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 12 May 2010 12:18:40 +0100
Subject: arm926_dma_flush_range undefined!
In-Reply-To: <20100511134409.GB27201@n2100.arm.linux.org.uk>
References: <4BE2C013.4040009@atmel.com>
	<1273154831.2094.11.camel@e102109-lin.cambridge.arm.com>
	<20100506175907.GA15797@n2100.arm.linux.org.uk>
	<4BE926B5.7090602@atmel.com>
	<20100511094448.GB18828@n2100.arm.linux.org.uk>
	<4BE95C54.5070008@atmel.com>
	<20100511134409.GB27201@n2100.arm.linux.org.uk>
Message-ID: <1273663120.23818.72.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-05-11 at 14:44 +0100, Russell King - ARM Linux wrote:
> On Tue, May 11, 2010 at 03:32:04PM +0200, Nicolas Ferre wrote:
> > As copy is done between a coherent and a kernel memory buffers, I guess
> > that the flushing routine is not needed?
> 
> The issue of coherency with "PIO" writes to block IO pages is going
> around the same old loops of discussion yet again at the moment; it's
> been a problem for ARM for about the last 10 years or so, and I'm not
> expecting there to suddenly be a major change of heart or political
> will to fix the issue.
> 
> So I think we're stuck with having to have the drivers we really care
> about and have our own control over do the flushing themselves.

For non-aliasing VIPT hardware we still have the option of doing what
the IA-64 and PowerPC guys have done (flushing in set_pte_at with
PG_arch_1 meaning "clean"). It may even work for VIVT caches if we take
care to also flush the kernel alias in set_pte_at.

If you are ok with this approach, I'll prepare some patches (it seems
that trying to get an agreement with other architectures isn't very
productive).

-- 
Catalin
