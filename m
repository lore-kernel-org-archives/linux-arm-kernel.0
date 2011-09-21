From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 21 Sep 2011 13:09:28 -0400 (EDT)
Subject: [PATCH 0/19] removal of mach/vmalloc.h and generic optimizations
In-Reply-To: <alpine.LFD.2.00.1109202047400.12663@xanadu.home>
References: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
	<3319383.WZQsqr8ND4@wuerfel>
	<alpine.LFD.2.00.1109172238070.20358@xanadu.home>
	<1933895.GJBlYra9yP@wuerfel>
	<alpine.LFD.2.00.1109202047400.12663@xanadu.home>
Message-ID: <alpine.LFD.2.00.1109211303060.12663@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 Sep 2011, Nicolas Pitre wrote:

> On Sun, 18 Sep 2011, Arnd Bergmann wrote:
> 
> > No, I couldn't find anything in the code or the changelog why this was
> > done.
> 
> I found that drivers/video/sh_mobile_lcdcfb.c appears to be a heavy user 
> of dma_alloc_coherent():
> 
>                 buf = dma_alloc_coherent(&pdev->dev, info->fix.smem_len,
>                                          &ch->dma_handle, GFP_KERNEL);
> 
> So for this particular hypothetical case: 1920 * 1080 * 2 * 32 / 8 = 16MB
> 
> We are far from the 158MB figure.  Furthermore, the highest allowed 
> amount is 14MB according to the available documentation, and none of the 
> other ARM targets use more than that either.

For the record, here's the patch I'm including in my series:

From: Nicolas Pitre <nicolas.pitre@linaro.org>
Date: Mon, 19 Sep 2011 00:28:45 -0400
Subject: [PATCH] ARM: move VMALLOC_END down temporarily for shmobile

THIS IS A TEMPORARY HACK.  The purpose of this is _only_ to avoid a
regression on an existing machine while a better fix is implemented.

On shmobile the consistent DMA memory area was set to 158MB in commit
28f0721a79 with no explanation.  The documented size for this area should
vary between 2MB and 14MB, and none of the other ARM targets exceed that.

The included #warning is therefore meant to be noisy on purpose to get
shmobile maintainers attention and this commit reverted once this
consistent DMA size conflict is resolved.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Magnus Damm <damm@opensource.se>
Cc: Paul Mundt <lethal@linux-sh.org>

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 950dee3ce2..35eb517a21 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -35,6 +35,13 @@
 #define VMALLOC_START		(((unsigned long)high_memory + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1))
 #define VMALLOC_END		0xff000000UL
 
+/* This is a temporary hack until shmobile's DMA area size is sorted out */
+#ifdef CONFIG_ARCH_SHMOBILE
+#warning "SH-Mobile's consistent DMA size conflicts with VMALLOC_END by 144MB"
+#undef VMALLOC_END
+#define VMALLOC_END		0xF6000000UL
+#endif
+
 /*
  * Hardware-wise, we have a two level page table structure, where the first
  * level has 4096 entries, and the second level has 256 entries.  Each entry


Nicolas
