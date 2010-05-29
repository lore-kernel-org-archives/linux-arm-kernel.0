From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 28 May 2010 20:00:34 -0400 (EDT)
Subject: [PATCH] ARM: fix highmem with VIPT cache and DMA
In-Reply-To: <20100528221932.GE5189@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1003251638030.694@xanadu.home>
	<1269610458.807.49.camel@e102109-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1003261144020.694@xanadu.home>
	<alpine.LFD.2.00.1004111033010.7232@xanadu.home>
	<20100528185604.GB5189@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1005281503260.24526@xanadu.home>
	<20100528194501.GC5189@n2100.arm.linux.org.uk>
	<20100528202831.GD5189@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1005281637290.24526@xanadu.home>
	<20100528221932.GE5189@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1005281903380.24526@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 28 May 2010, Russell King - ARM Linux wrote:

> On Fri, May 28, 2010 at 04:49:40PM -0400, Nicolas Pitre wrote:
> > One possible suspect might be the optimization in kmap_high_l1_vipt() 
> > which I couldn't test on SMP as I have no access to such beast.  Hence 
> > this patch might be worth testing as well:
> 
> Well, it's turned out that it's probably not your patch, but mmci.c at
> fault.  It's kmapping the scatterlist entry, but the scatterlist entry
> buffer length if 16K.

Ah.

> Somehow this doesn't cause us to oops when we run off the end of the
> kmap_atomic'd buffer, even with highmem debugging on.

That's strange.  It uses KM_BIO_SRC_IRQ, and the following kmap is 
KM_BIO_DST_IRQ.  In the whole source tree, only 
drivers/mmc/host/tifm_sd.c appears to be using KM_BIO_DST_IRQ.  So in 
your case it must never have been set to any valid mapping. In that case 
the readsl() to follow should have oopsed.

And when highmem debugging is active, all atomic kmaps are always 
cleared upon kmap_atomic(), effectively creating a big fence around the 
kmap_atomic'd buffer.

> Maybe we need a fence between each KM_* like other arches do (see
> asm-generic/kmap_types.h).  This probably needs the kmap_high_get()
> check in kmap_atomic() to be avoided on non-aliasing VIPT to reliably
> make such overruns trigger an oops.

Oh, right.  The non-atomic mappings that we opportunistically reuse are 
lazily unmapped... and the probability to find a following mapped entry 
is quite high.  So I think all that is needed is this:

diff --git a/arch/arm/mm/highmem.c b/arch/arm/mm/highmem.c
index 77b030f..086816b 100644
--- a/arch/arm/mm/highmem.c
+++ b/arch/arm/mm/highmem.c
@@ -48,7 +48,16 @@ void *kmap_atomic(struct page *page, enum km_type type)
 
 	debug_kmap_atomic(type);
 
-	kmap = kmap_high_get(page);
+#ifdef CONFIG_DEBUG_HIGHMEM
+	/*
+	 * There is no cache coherency issue when non VIVT, so force the
+	 * dedicated kmap usage for better debugging purposes in that case.
+	 */
+	if (!cache_is_vivt())
+		kmap = NULL;
+	else
+#endif
+		kmap = kmap_high_get(page);
 	if (kmap)
 		return kmap;
 

If you can confirm that this actually traps the mmci bug then I'll 
submit that to the patch system with an appropriate description.


Nicolas
