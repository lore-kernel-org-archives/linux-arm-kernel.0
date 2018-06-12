From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 12 Jun 2018 08:53:29 +0200
Subject: [PATCH] arm64/mm: Introduce a variable to hold base address of
 linear region
In-Reply-To: <1528785361-24477-1-git-send-email-bhsharma@redhat.com>
References: <1528785361-24477-1-git-send-email-bhsharma@redhat.com>
Message-ID: <CAKv+Gu8Hs+CArdkAWoBPbr_p-nq5+0oPwOPg0NsJDRMkE_bM9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 June 2018 at 08:36, Bhupesh Sharma <bhsharma@redhat.com> wrote:
> The start of the linear region map on a KASLR enabled ARM64 machine -
> which supports a compatible EFI firmware (with EFI_RNG_PROTOCOL
> support), is no longer correctly represented by the PAGE_OFFSET macro,
> since it is defined as:
>
>     (UL(1) << (VA_BITS - 1)) + 1)
>

PAGE_OFFSET is the VA of the start of the linear map. The linear map
can be sparsely populated with actual memory, regardless of whether
KASLR is in effect or not. The only difference in the presence of
KASLR is that there may be such a hole at the beginning, but that does
not mean the linear map has moved, or that the value of PAGE_OFFSET is
now wrong.

> So taking an example of a platform with VA_BITS=48, this gives a static
> value of:
> PAGE_OFFSET = 0xffff800000000000
>
> However, for the KASLR case, we use the 'memstart_offset_seed'
> to randomize the linear region - since 'memstart_addr' indicates the
> start of physical RAM, we randomize the same on basis
> of 'memstart_offset_seed' value.
>
> As the PAGE_OFFSET value is used presently by several user space
> tools (for e.g. makedumpfile and crash tools) to determine the start
> of linear region and hence to read addresses (like PT_NOTE fields) from
> '/proc/kcore' for the non-KASLR boot cases, so it would be better to
> use 'memblock_start_of_DRAM()' value (converted to virtual) as
> the start of linear region for the KASLR cases and default to
> the PAGE_OFFSET value for non-KASLR cases to indicate the start of
> linear region.
>

Userland code that assumes that the linear map cannot have a hole at
the beginning should be fixed.

> I tested this on my qualcomm (which supports EFI_RNG_PROTOCOL)
> and apm mustang (which does not support EFI_RNG_PROTOCOL) arm64 boards
> and was able to use a modified user space utility (like kexec-tools and
> makedumpfile) to determine the start of linear region correctly for
> both the KASLR and non-KASLR boot cases.
>

Can you explain the nature of the changes to the userland code?

> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: James Morse <james.morse@arm.com>
> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> ---
>  arch/arm64/include/asm/memory.h | 3 +++
>  arch/arm64/kernel/arm64ksyms.c  | 1 +
>  arch/arm64/mm/init.c            | 3 +++
>  3 files changed, 7 insertions(+)
>
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 49d99214f43c..bfd0915ecaf8 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -178,6 +178,9 @@ extern s64                  memstart_addr;
>  /* PHYS_OFFSET - the physical address of the start of memory. */
>  #define PHYS_OFFSET            ({ VM_BUG_ON(memstart_addr & 1); memstart_addr; })
>
> +/* the virtual base of the linear region. */
> +extern s64                     linear_reg_start_addr;
> +
>  /* the virtual base of the kernel image (minus TEXT_OFFSET) */
>  extern u64                     kimage_vaddr;
>
> diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.c
> index d894a20b70b2..a92238ea45ff 100644
> --- a/arch/arm64/kernel/arm64ksyms.c
> +++ b/arch/arm64/kernel/arm64ksyms.c
> @@ -42,6 +42,7 @@ EXPORT_SYMBOL(__arch_copy_in_user);
>
>         /* physical memory */
>  EXPORT_SYMBOL(memstart_addr);
> +EXPORT_SYMBOL(linear_reg_start_addr);
>
>         /* string / mem functions */
>  EXPORT_SYMBOL(strchr);
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 325cfb3b858a..29447adb0eef 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -60,6 +60,7 @@
>   * that cannot be mistaken for a real physical address.
>   */
>  s64 memstart_addr __ro_after_init = -1;
> +s64 linear_reg_start_addr __ro_after_init = PAGE_OFFSET;
>  phys_addr_t arm64_dma_phys_limit __ro_after_init;
>
>  #ifdef CONFIG_BLK_DEV_INITRD
> @@ -452,6 +453,8 @@ void __init arm64_memblock_init(void)
>                 }
>         }
>
> +       linear_reg_start_addr = __phys_to_virt(memblock_start_of_DRAM());
> +
>         /*
>          * Register the kernel text, kernel data, initrd, and initial
>          * pagetables with memblock.
> --
> 2.7.4
>
