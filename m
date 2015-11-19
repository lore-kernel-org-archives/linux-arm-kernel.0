From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 19 Nov 2015 19:08:53 +0100
Subject: [PATCH] arm64: efi: correctly align vaddr for runtime maps
In-Reply-To: <1447954656-10435-1-git-send-email-mark.rutland@arm.com>
References: <1447954656-10435-1-git-send-email-mark.rutland@arm.com>
Message-ID: <CAKv+Gu9OoRmV5hDsN9MrnKEVV85EFPpN_tW7S1WoFMxNxoY73Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 November 2015 at 18:37, Mark Rutland <mark.rutland@arm.com> wrote:
> The kernel may use a page granularity of 4K, 16K, or 64K depending on
> configuration.
>
> When mapping EFI runtime regions, we use memrange_efi_to_native to round
> the physical base address of a region down to a granule-aligned
> boundary, and round the size up to a granule-aligned boundary. However,
> we fail to similarly round the virtual base address down to a
> granule-aligned boundary.
>

Actually, __create_mapping() (which is called by create_pgd_mapping())
does the following

"""
static void  __create_mapping(struct mm_struct *mm, pgd_t *pgd,
                                    phys_addr_t phys, unsigned long virt,
                                    phys_addr_t size, pgprot_t prot,
                                    void *(*alloc)(unsigned long size))
{
        unsigned long addr, length, end, next;

        addr = virt & PAGE_MASK;
        length = PAGE_ALIGN(size + (virt & ~PAGE_MASK));
"""

so it does the rounding of the virtual address for us, but we are
rounding up the length twice.
I'd rather simply get rid of memrange_efi_to_native() instead, as it
is obviously redundant.

> The virtual base address may be up to PAGE_SIZE - 4K above what it
> should be, and in create_pgd_mapping, we may erroneously map an
> additional page at the end of any region which does not have a
> granule-aligned virtual base address.
>
> Depending on the memory map, this page may be in a region we are not
> intended/permitted to map, or may clash with a different region that we
> wich to map.
>
> Prevent this issue by rounding the virtual base address down to the
> kernel page granularity, matching what we do for the physical base
> address.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Leif Lindholm <leif.lindholm@linaro.org>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/efi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> I spotted this by playing with Will's break-before-make checker [1], which
> detected an erroneously created PTE being overwritten with a different output
> address.
>
> It looks like the VA bug was introduced in commit f3cdfd239da56a4c ("arm64/efi:
> move SetVirtualAddressMap() to UEFI stub").
>
> Prior to commit 60305db9884515ca ("arm64/efi: move virtmap init to early
> initcall") so manual fixup is required, but the logic fix is the same.
>

I don't follow

Thanks,
Ard/
