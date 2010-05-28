From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 28 May 2010 23:19:32 +0100
Subject: [PATCH] ARM: fix highmem with VIPT cache and DMA
In-Reply-To: <alpine.LFD.2.00.1005281637290.24526@xanadu.home>
References: <alpine.LFD.2.00.1003251638030.694@xanadu.home>
	<1269610458.807.49.camel@e102109-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1003261144020.694@xanadu.home>
	<alpine.LFD.2.00.1004111033010.7232@xanadu.home>
	<20100528185604.GB5189@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1005281503260.24526@xanadu.home>
	<20100528194501.GC5189@n2100.arm.linux.org.uk>
	<20100528202831.GD5189@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1005281637290.24526@xanadu.home>
Message-ID: <20100528221932.GE5189@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 28, 2010 at 04:49:40PM -0400, Nicolas Pitre wrote:
> One possible suspect might be the optimization in kmap_high_l1_vipt() 
> which I couldn't test on SMP as I have no access to such beast.  Hence 
> this patch might be worth testing as well:

Well, it's turned out that it's probably not your patch, but mmci.c at
fault.  It's kmapping the scatterlist entry, but the scatterlist entry
buffer length if 16K.

Somehow this doesn't cause us to oops when we run off the end of the
kmap_atomic'd buffer, even with highmem debugging on.

Maybe we need a fence between each KM_* like other arches do (see
asm-generic/kmap_types.h).  This probably needs the kmap_high_get()
check in kmap_atomic() to be avoided on non-aliasing VIPT to reliably
make such overruns trigger an oops.
