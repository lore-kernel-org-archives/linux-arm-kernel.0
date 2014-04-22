From: monstr@monstr.eu (Michal Simek)
Date: Tue, 22 Apr 2014 16:50:12 +0200
Subject: [Qemu-devel] Change of TEXT_OFFSET for multi_v7_defconfig
In-Reply-To: <20140417203521.GB22411@obsidianresearch.com>
References: <534D0D91.8020406@linaro.org> <534EAD6C.3040502@codeaurora.org>
 <alpine.LFD.2.11.1404161428280.980@knanqh.ubzr>
 <534EF153.5050603@codeaurora.org>
 <alpine.LFD.2.11.1404161853530.980@knanqh.ubzr>
 <53501E87.6070307@codeaurora.org>
 <20140417203521.GB22411@obsidianresearch.com>
Message-ID: <535681A4.1080402@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/17/2014 10:35 PM, Jason Gunthorpe wrote:
> On Thu, Apr 17, 2014 at 02:33:43PM -0400, Christopher Covington wrote:
>> On 04/16/2014 07:21 PM, Nicolas Pitre wrote:
>>> On Wed, 16 Apr 2014, Christopher Covington wrote:
>>
>>>> Thank you for the suggestion. This approach also came to mind, but it would
>>>> require new documentation and tooling in the JTAG scripts or simulator
>>>> equivalent. That's another aspect of the ELF-based approaches that I
>>>> like--hopefully existing documentation and tool support could be reused.
>>>
>>> The above is useful for loading the raw uncompressed Image without 
>>> carrying the full ELF baggage.
>>
>> What exactly is the full ELF baggage? Aren't there existing mechanisms to omit
>> debugging symbols, for example, if size is of concern?
> 
> FWIW, it is a small non-intrusive change to produce ELFs with the
> proper LMA, if it is useful for specialized tooling, here is the 3.14
> version of the patch I created (I see it needs a bit of cleanup..)
> You must also force PATCH_PHYS_VIRT off.
> 
> The ELF also has the correct entry point address, so ELF tooling can
> just jump into it, after setting the proper register values according
> to the boot protocol.
> 
> From ca9763668eed2eaaf0c0c2640f1502c22b68a739 Mon Sep 17 00:00:00 2001
> From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> Date: Fri, 14 Sep 2012 11:27:17 -0600
> Subject: [PATCH] [ARM] Use AT() in the linker script to create correct program
>  headers
> 
> The standard linux asm-generic/vmlinux.lds.h already supports this,
> and it seems other architectures do as well.
> 
> The goal is to create an ELF file that has correct program headers. We
> want to see the VirtAddr be the runtime address of the kernel with the
> MMU turned on, and PhysAddr be the physical load address for the section
> with no MMU.
> 
> This allows ELF based boot loaders to properly load vmlinux:
> 
> $ readelf -l vmlinux
> Entry point 0x8000
>   Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
>   LOAD           0x008000 0xc0008000 0x00008000 0x372244 0x3a4310 RWE 0x8000
> 
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> ---
>  arch/arm/include/asm/memory.h |  2 +-
>  arch/arm/kernel/vmlinux.lds.S | 51 +++++++++++++++++++++++++------------------
>  2 files changed, 31 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> index 8756e4b..551e971 100644
> --- a/arch/arm/include/asm/memory.h
> +++ b/arch/arm/include/asm/memory.h
> @@ -350,7 +350,7 @@ static inline __deprecated void *bus_to_virt(unsigned long x)
>  #define virt_addr_valid(kaddr)	(((unsigned long)(kaddr) >= PAGE_OFFSET && (unsigned long)(kaddr) < (unsigned long)high_memory) \
>  					&& pfn_valid(__pa(kaddr) >> PAGE_SHIFT) )
>  
> -#endif
> +#endif /* __ASSEMBLY__ */


This is unrelated change.

>  
>  #include <asm-generic/memory_model.h>
>  
> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> index 7bcee5c..15353d2 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -3,6 +3,13 @@
>   * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>
>   */
>  
> +/* If we have a known, fixed physical load address then set LOAD_OFFSET
> +   and generate an ELF that has the physical load address in the program
> +   headers. */
> +#ifndef CONFIG_ARM_PATCH_PHYS_VIRT
> +#define LOAD_OFFSET (PAGE_OFFSET - PLAT_PHYS_OFFSET)
> +#endif
> +
>  #include <asm-generic/vmlinux.lds.h>
>  #include <asm/cache.h>
>  #include <asm/thread_info.h>
> @@ -43,7 +50,7 @@
>  #endif
>  
>  OUTPUT_ARCH(arm)
> -ENTRY(stext)
> +ENTRY(phys_start)
>  
>  #ifndef __ARMEB__
>  jiffies = jiffies_64;
> @@ -86,11 +93,13 @@ SECTIONS
>  #else
>  	. = PAGE_OFFSET + TEXT_OFFSET;
>  #endif
> -	.head.text : {
> +	.head.text : AT(ADDR(.head.text) - LOAD_OFFSET) {
>  		_text = .;
> +		phys_start = . - LOAD_OFFSET;
>  		HEAD_TEXT
>  	}

I am not quite about these changes above but Russell can comment it.

> -	.text : {			/* Real text segment		*/
> +	/* Real text segment */
> +	.text :  AT(ADDR(.text) - LOAD_OFFSET) {

The rest is just fine. It is exactly what I have written some months
ago when I want to get ELF with correct addresses for qemu.
It is the same what it is written in asm-generic/vmlinux.lds.h
and ARM should also use it.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140422/d9f7cc61/attachment.sig>
