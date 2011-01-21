From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Jan 2011 21:42:33 +0000
Subject: [PATCH] mmc: msm: fix dma usage not to use internal APIs
In-Reply-To: <0db2f2bf1ef87fbbedecece6ae2c8d33.squirrel@www.codeaurora.org>
References: <1295391805-15251-1-git-send-email-dwalker@codeaurora.org>
	<1295522421.4366.34.camel@m0nster>
	<20110120130246.GA23941@n2100.arm.linux.org.uk>
	<20110120131239.GB23941@n2100.arm.linux.org.uk>
	<1295536094.9236.11.camel@m0nster>
	<ff5d6c73aa50329b025bfe69297a92d9.squirrel@www.codeaurora.org>
	<20110121192854.GB23151@n2100.arm.linux.org.uk>
	<8yaaaiuot1l.fsf@huya.qualcomm.com>
	<0db2f2bf1ef87fbbedecece6ae2c8d33.squirrel@www.codeaurora.org>
Message-ID: <20110121214233.GC23151@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 21, 2011 at 01:37:15PM -0800, Brent DeGraaf wrote:
> Russell,
> 
> Thanks for your comments. Yes, reverting is OK. The writel's are doing the
> controller write after the barrier so even though it'll be a little
> slower, it will be correct.
> 
> Regarding the "unnecessary" pre-invalidate, yeah, I misspoke.  I meant
> unnecessary POST-invalidates for non-speculative cpus.  I just checked and
> it looks like someone's already put a "FIXME" in the current 2.6.37 source
> for those.

We don't do post-invalidates either.  We may call into the processor
specific code, but the sum of what they do for pre-ARMv6 CPUs is as
follows:

arch/arm/mm/proc-arm1020e.S:ENTRY(arm1020e_dma_unmap_area)
arch/arm/mm/proc-arm1020e.S-    mov     pc, lr
arch/arm/mm/proc-arm1020e.S-ENDPROC(arm1020e_dma_unmap_area)
--
arch/arm/mm/proc-arm1020.S:ENTRY(arm1020_dma_unmap_area)
arch/arm/mm/proc-arm1020.S-     mov     pc, lr
arch/arm/mm/proc-arm1020.S-ENDPROC(arm1020_dma_unmap_area)
--
arch/arm/mm/proc-arm1022.S:ENTRY(arm1022_dma_unmap_area)
arch/arm/mm/proc-arm1022.S-     mov     pc, lr
arch/arm/mm/proc-arm1022.S-ENDPROC(arm1022_dma_unmap_area)
--
arch/arm/mm/proc-arm1026.S:ENTRY(arm1026_dma_unmap_area)
arch/arm/mm/proc-arm1026.S-     mov     pc, lr
arch/arm/mm/proc-arm1026.S-ENDPROC(arm1026_dma_unmap_area)
--
arch/arm/mm/proc-arm920.S:ENTRY(arm920_dma_unmap_area)
arch/arm/mm/proc-arm920.S-      mov     pc, lr
arch/arm/mm/proc-arm920.S-ENDPROC(arm920_dma_unmap_area)
--
arch/arm/mm/proc-arm922.S:ENTRY(arm922_dma_unmap_area)
arch/arm/mm/proc-arm922.S-      mov     pc, lr
arch/arm/mm/proc-arm922.S-ENDPROC(arm922_dma_unmap_area)
--
arch/arm/mm/proc-arm925.S:ENTRY(arm925_dma_unmap_area)
arch/arm/mm/proc-arm925.S-      mov     pc, lr
arch/arm/mm/proc-arm925.S-ENDPROC(arm925_dma_unmap_area)
--
arch/arm/mm/proc-arm926.S:ENTRY(arm926_dma_unmap_area)
arch/arm/mm/proc-arm926.S-      mov     pc, lr
arch/arm/mm/proc-arm926.S-ENDPROC(arm926_dma_unmap_area)
--
arch/arm/mm/proc-arm940.S:ENTRY(arm940_dma_unmap_area)
arch/arm/mm/proc-arm940.S-      mov     pc, lr
arch/arm/mm/proc-arm940.S-ENDPROC(arm940_dma_unmap_area)
--
arch/arm/mm/proc-arm946.S:ENTRY(arm946_dma_unmap_area)
arch/arm/mm/proc-arm946.S-      mov     pc, lr
arch/arm/mm/proc-arm946.S-ENDPROC(arm946_dma_unmap_area)
--
arch/arm/mm/proc-feroceon.S:ENTRY(feroceon_dma_unmap_area)
arch/arm/mm/proc-feroceon.S-    mov     pc, lr
arch/arm/mm/proc-feroceon.S-ENDPROC(feroceon_dma_unmap_area)
--
arch/arm/mm/proc-mohawk.S:ENTRY(mohawk_dma_unmap_area)
arch/arm/mm/proc-mohawk.S-      mov     pc, lr
arch/arm/mm/proc-mohawk.S-ENDPROC(mohawk_dma_unmap_area)
--
arch/arm/mm/proc-xsc3.S:ENTRY(xsc3_dma_unmap_area)
arch/arm/mm/proc-xsc3.S-        mov     pc, lr
arch/arm/mm/proc-xsc3.S-ENDPROC(xsc3_dma_unmap_area)
--
arch/arm/mm/proc-xscale.S:ENTRY(xscale_dma_unmap_area)
arch/arm/mm/proc-xscale.S-      mov     pc, lr
arch/arm/mm/proc-xscale.S-ENDPROC(xscale_dma_unmap_area)

So we don't do anything for non-speculative prefetching CPUs on unmap.
