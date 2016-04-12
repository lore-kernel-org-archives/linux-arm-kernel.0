From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 12 Apr 2016 17:06:49 +0300
Subject: [RFC 0/1] ARM: mm: cache shareability tweak
In-Reply-To: <20160412132505.GG28057@leverpostej>
References: <1460448880-5677-1-git-send-email-t-kristo@ti.com>
 <20160412132505.GG28057@leverpostej>
Message-ID: <570D00F9.4070406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/12/2016 04:25 PM, Mark Rutland wrote:
> On Tue, Apr 12, 2016 at 11:14:39AM +0300, Tero Kristo wrote:
>> Hi,
>>
>> This RFC patch attempts to implement support for specifying cache
>> shareability setting via kernel cmdline. This is required at least
>> for TI keystone2 generation SoCs, where DMA masters are snooping on
>> the cache maintenance messages to maintain coherency. Currently we
>> are carrying an internal hack that modifies the macros via #ifdefs,
>> this is obviously bad as the same kernel image can only work with
>> keystone2 (or at least might be causing problems with other SoCs.)
>
> The de-facto semantics (which we should codify) for dma-coherent with
> ARMv7 is that a device makes accesses which are coherent with Normal,
> Inner Shareable, Inner Write-Back, Outer Write-Back.
>
> In arch/arm/boot/dts/keystone.dtsi I see that /soc/usb at 2680000 has a
> dma-coherent flag. Is that device coherent today with upstream? Or is
> that misleading currently?

Good question, Murali, can you comment on this? What peripherals are 
actually requiring the DMA coherency on K2?

>
> If the device isn't coherent with that, then dma-coherent isn't strictly
> true (and should go), and we need additional properties to correctly
> describe this case.
>
>> It would be very much preferred to replace this hardcoded
>> implementation with a runtime solution.
>>
>> Some obvious holes in this implementation:
>>
>> 1) during execution of arch/arm/kernel/head.S, the tweaked MMU shareability
>>     settings are not in place. However, I am not too sure how much that
>>     matters, as I am not sure what is mapped at this point. Kernel image
>>     mapping should not matter at least, as we typically should not be doing
>>     any DMA transfers from the kernel image.
>
> Strictly speaking, changing the shareability can result in a loss of
> coherency, even if all accesses are made by the same CPU. See
> "Mismatched memory attributes" in section A3.5.7 of the ARMv7-AR
> Reference Manual (ARM DDI 0406C.c).

Basically we are not attempting to change shareability in-the-fly, but 
instead configure a different shareability value that is going to be 
used always.

>
> It's not just DMA that matters. I believe we may have page tables as
> part of the kernel image, for instance, and those need to be accessed
> with consistent attributes by the MMU when doing page table walks.
>
> You can avoid issues so long as you have appropriate cache maintenance,
> but that's both expensive (all memory previously mapped must be
> Clean+Invalidated by VA) and painful (as you can't reliably use any of
> said memory until after the maintenance).

The hack we have internally just maps all the DMA pages as outer 
shareable. I think maybe adding the original hack might help 
understanding the issue, so added inline in the end as reference. We 
just attempt to change the shareability value from 3 (the current) to 2.

>
>>     I would like some comments on this, if handling during head.S
>>     should be fixed also, how can this be done? Some hack under
>>     compressed/keystone-head.S?
>
> If you need to do this, you need consistent attributes from the outset,
> or you need to disable the MMU, perform cache maintenance, and re-enter
> the kernel.
>
>> 2) the cmdline parameter could be something more descriptive
>>
>> 3) The single RFC patch should probably be split up a bit
>
> 4) It isn't possible to use dma-coherent to describe this without
>     weakening the semantics so as to be meaningless in general. So if we
>     go for this approach we need a mechanism to accurately describe the
>     coherency guarantees of masters in the system beyond a boolean.
>
> Thanks,
> Mark.
>


diff --git a/arch/arm/include/asm/pgtable-3level-hwdef.h 
b/arch/arm/include/asm/pgtable-3level-hwdef.h
index f8f1cff..62adf21 100644
--- a/arch/arm/include/asm/pgtable-3level-hwdef.h
+++ b/arch/arm/include/asm/pgtable-3level-hwdef.h
@@ -44,7 +44,11 @@
  #define PMD_SECT_CACHEABLE	(_AT(pmdval_t, 1) << 3)
  #define PMD_SECT_USER		(_AT(pmdval_t, 1) << 6)		/* AP[1] */
  #define PMD_SECT_AP2		(_AT(pmdval_t, 1) << 7)		/* read only */
+#ifdef CONFIG_KEYSTONE2_DMA_COHERENT
+#define PMD_SECT_S		(_AT(pmdval_t, 2) << 8)
+#else
  #define PMD_SECT_S		(_AT(pmdval_t, 3) << 8)
+#endif
  #define PMD_SECT_AF		(_AT(pmdval_t, 1) << 10)
  #define PMD_SECT_nG		(_AT(pmdval_t, 1) << 11)
  #define PMD_SECT_PXN		(_AT(pmdval_t, 1) << 53)
@@ -73,7 +77,12 @@
  #define PTE_BUFFERABLE		(_AT(pteval_t, 1) << 2)		/* AttrIndx[0] */
  #define PTE_CACHEABLE		(_AT(pteval_t, 1) << 3)		/* AttrIndx[1] */
  #define PTE_AP2			(_AT(pteval_t, 1) << 7)		/* AP[2] */
+#ifdef CONFIG_KEYSTONE2_DMA_COHERENT
+/* SH[1:0], outer shareable */
+#define PTE_EXT_SHARED		(_AT(pteval_t, 2) << 8)
+#else
  #define PTE_EXT_SHARED		(_AT(pteval_t, 3) << 8)		/* SH[1:0], inner 
shareable */
+#endif
  #define PTE_EXT_AF		(_AT(pteval_t, 1) << 10)	/* Access Flag */
  #define PTE_EXT_NG		(_AT(pteval_t, 1) << 11)	/* nG */
  #define PTE_EXT_PXN		(_AT(pteval_t, 1) << 53)	/* PXN */
diff --git a/arch/arm/include/asm/pgtable-3level.h 
b/arch/arm/include/asm/pgtable-3level.h
index a745a2a..b4090b1 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -78,7 +78,12 @@
  #define L_PTE_VALID		(_AT(pteval_t, 1) << 0)		/* Valid */
  #define L_PTE_PRESENT		(_AT(pteval_t, 3) << 0)		/* Present */
  #define L_PTE_USER		(_AT(pteval_t, 1) << 6)		/* AP[1] */
+#ifdef CONFIG_KEYSTONE2_DMA_COHERENT
+/* SH[1:0], outer shareable */
+#define L_PTE_SHARED		(_AT(pteval_t, 2) << 8)
+#else
  #define L_PTE_SHARED		(_AT(pteval_t, 3) << 8)		/* SH[1:0], inner 
shareable */
+#endif
  #define L_PTE_YOUNG		(_AT(pteval_t, 1) << 10)	/* AF */
  #define L_PTE_XN		(_AT(pteval_t, 1) << 54)	/* XN */
  #define L_PTE_DIRTY		(_AT(pteval_t, 1) << 55)
diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
index ea955f6db..558385e 100644
--- a/arch/arm/mach-keystone/Kconfig
+++ b/arch/arm/mach-keystone/Kconfig
@@ -11,6 +11,10 @@ config ARCH_KEYSTONE
  	select ZONE_DMA if ARM_LPAE
  	select MIGHT_HAVE_PCI
  	select PCI_DOMAINS if PCI
+	select KEYSTONE2_DMA_COHERENT
  	help
  	  Support for boards based on the Texas Instruments Keystone family of
  	  SoCs.
+
+config KEYSTONE2_DMA_COHERENT
+	bool
