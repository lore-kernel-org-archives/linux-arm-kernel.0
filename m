From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 27 Sep 2009 21:37:22 -0400 (EDT)
Subject: Disable highmem with SMP if no h/w TLB broadcasting
In-Reply-To: <20090927202937.GA26521@n2100.arm.linux.org.uk>
References: <20090927202937.GA26521@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.0909272029030.4997@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 27 Sep 2009, Russell King - ARM Linux wrote:

> We suffer an unfortunate combination of "features" which makes highmem
> support on platforms without hardware TLB maintainence broadcast difficult:
> 
> - we need kmap_high_get() support for DMA cache coherence
> - this requires kmap_high() to take a spinlock with IRQs disabled
> - kmap_high() occasionally calls flush_all_zero_pkmaps() to clear
>   out old mappings

Hmmm...  I guess there could be a way to work around this limitation by 
replacing flush_tlb_kernel_range() with something that would set a per 
CPU flag on all CPUs to schedule TLB flushing the next time they call 
kmap_high().


Nicolas
