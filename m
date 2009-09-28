From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Sep 2009 11:11:15 +0100
Subject: Disable highmem with SMP if no h/w TLB broadcasting
In-Reply-To: <alpine.LFD.2.00.0909272029030.4997@xanadu.home>
References: <20090927202937.GA26521@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0909272029030.4997@xanadu.home>
Message-ID: <20090928101115.GF6715@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 27, 2009 at 09:37:22PM -0400, Nicolas Pitre wrote:
> On Sun, 27 Sep 2009, Russell King - ARM Linux wrote:
> 
> > We suffer an unfortunate combination of "features" which makes highmem
> > support on platforms without hardware TLB maintainence broadcast difficult:
> > 
> > - we need kmap_high_get() support for DMA cache coherence
> > - this requires kmap_high() to take a spinlock with IRQs disabled
> > - kmap_high() occasionally calls flush_all_zero_pkmaps() to clear
> >   out old mappings
> 
> Hmmm...  I guess there could be a way to work around this limitation by 
> replacing flush_tlb_kernel_range() with something that would set a per 
> CPU flag on all CPUs to schedule TLB flushing the next time they call 
> kmap_high().

Until we have a solution that's acceptable to everyone, I suggest that
the patch I attached is merged.
