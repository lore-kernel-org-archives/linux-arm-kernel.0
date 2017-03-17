From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 17 Mar 2017 16:18:05 +0000
Subject: [PATCH 1/2] arm: Fix cache inconsistency when using fixmap
In-Reply-To: <1489767002.3063.10.camel@linaro.org>
References: <20170316132958.22227-1-tixy@linaro.org>
 <20170317115321.GB21222@n2100.armlinux.org.uk>
 <1489767002.3063.10.camel@linaro.org>
Message-ID: <CAKv+Gu8hLcfT6t90qbMT2qxzTMoJHiPxaCvHirQEVmKjYDvqBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 March 2017 at 16:10, Jon Medhurst (Tixy) <tixy@linaro.org> wrote:
> On Fri, 2017-03-17 at 11:53 +0000, Russell King - ARM Linux wrote:
>> On Thu, Mar 16, 2017 at 01:29:57PM +0000, Jon Medhurst wrote:
>> > To cope with the variety in ARM architectures and configurations, the
>> > pagetable attributes for kernel memory are generated at runtime to match
>> > the system the kernel finds itself on. This calculated value is stored
>> > in pgprot_kernel.
>> >
>> > However, when early fixmap support was added for arm (commit
>> > a5f4c561b3b1) the attributes used for mappings were hard coded because
>> > pgprot_kernel is not set up early enough. Unfortunately, the values used
>> > didn't include the 'shareable' attribute which means that for later
>> > non-early fixmap use, when multiple CPUs are running, any cache entries
>> > allocated for fixmap memory aren't kept consistent between CPUs. This
>> > can result in different CPUs seeing different memory contents.
>>
>> This also likely causes unpredictable behaviour (aliased attributes).
>>
>> > This issue was discovered on a dual cluster system by failures with
>> > kprobes, which uses fixmap to modify the kernel image if
>> > CONFIG_DEBUG_RODATA is enabled. It will also affect kgdb and jump_labels
>> > which also make use of the same code to modify the kernel, and any other
>> > uses of fixmap after secondary CPUs are brought online.
>> >
>> > To fix this issue, and to help avoid other potential problems where
>> > pagetable attributes are incorrect, we change the fixmap code to use the
>> > same generated value in pgprot_kernel that the rest of the kernel uses,
>> > and only fall back to a hard coded value if this isn't set - which will
>> > be early on in boot before other CPUs are brought online.
>>
>> I'm not happy with this - if we need to create early fixmaps, then
>> we need to know the correct attributes to use, so let's move the
>> attribute initialisation earlier.  This solution feels too much like
>> hacking around the problem.
>
> I must admit to having similar thoughts and plead guilty to ignoring
> them. Not knowing how early fixmaps are being used I let myself think
> 'it must have been originally done this way for a reason'.
>
> It looks to me that build_mem_type_table doesn't have much in the way of
> dependencies so can probably be just called earlier. So, is the correct
> solution to
>
> a) call build_mem_type_table from setup_arch before early_fixmap_init
> b) move call to build_mem_type_table into early_fixmap_init
> c) call build_mem_type_table from early_fixmap_init as well as
> paging_init and have a test in build_mem_type_table so it only exectutes
> once
> d) something else
>
> a) seems simplest, b) seems wrong, c) seems over the top
>
> Anyway, below is an alternative to $subject patch that works for my
> kprobes test cases. Note, the removal of FIXMAP_PAGE_{NORMAL,RO} means
> the generic fixmap code will define these from PAGE_KERNEL{,_RO}.
>
> Not knowing how early fixmap is used, I hope Stefan and/or Ard have
> testcases they could run.
>

The early UEFI boot code maps firmware tables using early_ioremap(),
which is layered on top of early_fixmap(). This code executes after
early_ioremap_init(), so moving build_mem_type_table() before that
sounds like the obvious fix to me. The other use case is earlycon,
which uses early_fixmap() directly, but afaict, the same applies there
as well.

In terms of code changes, there is a d) option where the call sequence
build_mem_type/early_fixmap_init/early_ioremap_init is grouped into a
new function in mm/mmu.c, which you can call from setup_arch(). That
would be the cleanest approach imo.

> I'm also wondering if the existing definition of FIXMAP_PAGE_IO is
> correc
> t and should not also be based on some platform specific value
> calculated
>  in build_mem_type_table?
>
>
> diff --git a/arch/arm/include/asm/fixmap.h
> b/arch/arm/include/asm/fixmap.h
> index 5c17d2dec777..30871fb269f0 100644
> --- a/arch/arm/include/asm/fixmap.h
> +++ b/arch/arm/include/asm/fixmap.h
> @@ -41,9 +41,6 @@ static const enum fixed_addresses
> __end_of_fixed_addresses =
>
>  #define FIXMAP_PAGE_COMMON     (L_PTE_YOUNG | L_PTE_PRESENT |
> L_PTE_XN | L_PTE_DIRTY)
>
> -#define FIXMAP_PAGE_NORMAL     (FIXMAP_PAGE_COMMON |
> L_PTE_MT_WRITEBACK)
> -#define FIXMAP_PAGE_RO         (FIXMAP_PAGE_NORMAL |
> L_PTE_RDONLY)
> -
>  /* Used by set_fixmap_(io|nocache), both meant for mapping a device */
>  #define FIXMAP_PAGE_IO         (FIXMAP_PAGE_COMMON |
> L_PTE_MT_DEV_SHARED | L_PTE_SHARED)
>  #define FIXMAP_PAGE_NOCACHE    FIXMAP_PAGE_IO
> diff --git a/arch/arm/include/asm/pgtable.h
> b/arch/arm/include/asm/pgtable.h
> index 1c462381c225..6a98856a8fa9 100644
> --- a/arch/arm/include/asm/pgtable.h
> +++ b/arch/arm/include/asm/pgtable.h
> @@ -98,6 +98,7 @@ extern pgprot_t               pgprot_s2_device;
>  #define PAGE_READONLY_EXEC     _MOD_PROT(pgprot_user, L_PTE_USER |
> L_PTE_RDONLY)
>  #define PAGE_KERNEL            _MOD_PROT(pgprot_kernel, L_PTE_XN)
>  #define PAGE_KERNEL_EXEC       pgprot_kernel
> +#define PAGE_KERNEL_RO         _MOD_PROT(pgprot_kernel, L_PTE_XN
> | L_PTE_RDONLY)
>  #define PAGE_HYP               _MOD_PROT(pgprot_kernel, L_PTE_HYP |
> L_PTE_XN)
>  #define PAGE_HYP_EXEC          _MOD_PROT(pgprot_kernel, L_PTE_HYP
> | L_PTE_RDONLY)
>  #define PAGE_HYP_RO            _MOD_PROT(pgprot_kernel, L_PTE_HYP |
> L_PTE_RDONLY | L_PTE_XN)
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index f4e54503afa9..fc4782fa5071 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -79,6 +79,7 @@ __setup("fpe=", fpe_setup);
>  #endif
>
>  extern void init_default_cache_policy(unsigned long);
> +extern void build_mem_type_table(void);
>  extern void paging_init(const struct machine_desc *desc);
>  extern void early_paging_init(const struct machine_desc *);
>  extern void adjust_lowmem_bounds(void);
> @@ -1082,6 +1083,8 @@ void __init setup_arch(char **cmdline_p)
>         strlcpy(cmd_line, boot_command_line, COMMAND_LINE_SIZE);
>         *cmdline_p = cmd_line;
>
> +       build_mem_type_table();
> +
>         early_fixmap_init();
>         early_ioremap_init();
>
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 4e016d7f37b3..c8e1de3ceb02 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -425,7 +425,7 @@ void __set_fixmap(enum fixed_addresses idx,
> phys_addr_t phys, pgprot_t prot)
>  /*
>   * Adjust the PMD section entries according to the CPU in use.
>   */
> -static void __init build_mem_type_table(void)
> +void __init build_mem_type_table(void)
>  {
>         struct cachepolicy *cp;
>         unsigned int cr = get_cr();
> @@ -1616,7 +1616,6 @@ void __init paging_init(const struct machine_desc
> *mdesc)
>  {
>         void *zero_page;
>
> -       build_mem_type_table();
>         prepare_page_table();
>         map_lowmem();
>         memblock_set_current_limit(arm_lowmem_limit);
> --
> 2.11.0
>
>
