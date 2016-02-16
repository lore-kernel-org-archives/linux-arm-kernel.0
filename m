From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Tue, 16 Feb 2016 19:18:51 +0000
Subject: [PATCH v2] ARM: vmlinux-xip.lds: assert that ROM and RAM don't
 overlap
In-Reply-To: <1455278803-27679-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1455278803-27679-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <HK2PR06MB05619656241BFD0A9165B6C28AAD0@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 Feb 2016, Ard Biesheuvel wrote:

> When building an XIP kernel, the linker produces two disjoint VMA
> regions, where the first is mapped onto ROM and the second onto RAM.
> For this reason, the linker output pointer '.' is updated halfway
> through the linker script, and set to a value that corresponds with
> the start of the RAM region.
> 
> However, in some cases, the ROM region exceeds the expected size, and
> the assignment of the output pointer results in a decrement rather than
> an increment, causing the virtual addresses of the .data region to
> clash with the .text region. Such a kernel cannot boot normally, but it
> also confuses the hell out of kallsyms, since .data symbols may appear
> inside the [_stext, _etext] or [_sinittext, _einittext] intervals in
> the first pass, but not in the second (or vice versa), resulting in
> inconsistent kallsyms data.
> 
> So let's make sure that the output pointer only advances, and never
> jumps back into the ROM region.
> 
> Cc: Chris Brandt <Chris.Brandt@renesas.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> v2: rebased onto the split off XIP linker script
> 
>  arch/arm/kernel/vmlinux-xip.lds.S | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
> index 40bc4cadb959..07c642cff50e 100644
> --- a/arch/arm/kernel/vmlinux-xip.lds.S
> +++ b/arch/arm/kernel/vmlinux-xip.lds.S
> @@ -213,6 +213,7 @@ SECTIONS
>  
>  	_exiprom = .;			/* End of XIP ROM area */
>  	__data_loc = ALIGN(4);		/* location in binary */
> +	ASSERT(. < PAGE_OFFSET + TEXT_OFFSET, "XIP_KERNEL: ROM and RAM 
> +overlap")
>  	. = PAGE_OFFSET + TEXT_OFFSET;
>  
>  	.data : AT(__data_loc) {
> --
> 2.5.0

This looks fine to me. I see no issues with it.
Of course, this is for systems with a much tighter device memory layout than what I usually use.

Chris
