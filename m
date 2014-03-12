From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 12 Mar 2014 16:03:40 +0000
Subject: [PATCH] ARM64: Kernel managed pages are only flushed
In-Reply-To: <20140312145653.GA9691@mudshark.cambridge.arm.com>
References: <1394018446-16738-1-git-send-email-Bharat.Bhushan@freescale.com>
 <20140306065339.GA2975@localhost>
 <b9ecee11764146c98dd41b811ebc05ae@BN1PR03MB266.namprd03.prod.outlook.com>
 <20140312145653.GA9691@mudshark.cambridge.arm.com>
Message-ID: <20140312160340.GI17083@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 02:56:53PM +0000, Will Deacon wrote:
> On Wed, Mar 12, 2014 at 02:41:31PM +0000, Bharat.Bhushan at freescale.com wrote:
> > Did you get the chance to look into this? What is your take for this patch
> > or you want to suggest some other solution?
> 
> See my reply to Laura here:
> 
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2014-March/238510.html
> 
> We *really* don't want executable device mappings.

/dev/mem mapping use pgprot_noncached() but I think we could generalise
any of the writecombine and dmacoherent mappings to XN like in the patch
below:

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index b524dcd17243..2d3cede62709 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -286,11 +286,11 @@ static inline int has_transparent_hugepage(void)
  * Mark the prot value as uncacheable and unbufferable.
  */
 #define pgprot_noncached(prot) \
-	__pgprot_modify(prot, PTE_ATTRINDX_MASK, PTE_ATTRINDX(MT_DEVICE_nGnRnE))
+	__pgprot_modify(prot, PTE_ATTRINDX_MASK, PTE_ATTRINDX(MT_DEVICE_nGnRnE) | PTE_PXN | PTE_UXN)
 #define pgprot_writecombine(prot) \
-	__pgprot_modify(prot, PTE_ATTRINDX_MASK, PTE_ATTRINDX(MT_NORMAL_NC))
+	__pgprot_modify(prot, PTE_ATTRINDX_MASK, PTE_ATTRINDX(MT_NORMAL_NC) | PTE_PXN | PTE_UXN)
 #define pgprot_dmacoherent(prot) \
-	__pgprot_modify(prot, PTE_ATTRINDX_MASK, PTE_ATTRINDX(MT_NORMAL_NC))
+	__pgprot_modify(prot, PTE_ATTRINDX_MASK, PTE_ATTRINDX(MT_NORMAL_NC) | PTE_PXN | PTE_UXN)
 #define __HAVE_PHYS_MEM_ACCESS_PROT
 struct file;
 extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,

-- 
Catalin
