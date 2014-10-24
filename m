From: grant.likely@linaro.org (Grant Likely)
Date: Fri, 24 Oct 2014 14:39:23 +0100
Subject: [PATCH 4/6] arm64/efi: move SetVirtualAddressMap() to UEFI stub
In-Reply-To: <1414154384-15385-5-git-send-email-ard.biesheuvel@linaro.org>
References: <1414154384-15385-1-git-send-email-ard.biesheuvel@linaro.org>
 <1414154384-15385-5-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CACxGe6uDQ5t1mQf2L2wPQ3qLN0RxR_VyUF1hEEKnOgC__Qb4Gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 24, 2014 at 1:39 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> In order to support kexec, the kernel needs to be able to deal with the
> state of the UEFI firmware after SetVirtualAddressMap() has been called.
> To avoid having separate code paths for non-kexec and kexec, let's move
> the call to SetVirtualAddressMap() to the stub: this will guarantee us
> that it will only be called once (since the stub is not executed during
> kexec), and ensures that the UEFI state is identical between kexec and
> normal boot.
>
> This implies that the layout of the virtual mapping needs to be created
> by the stub as well. All regions are rounded up to a naturally aligned
> multiple of 64 KB (for compatibility with 64k pages kernels) and recorded
> in the UEFI memory map. The kernel proper reads those values and installs
> the mappings in a dedicated set of page tables that are swapped in during
> UEFI Runtime Services calls.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

A questions grounded in my ignorance below...

> ---
>  arch/arm64/include/asm/efi.h       |  19 +++-
>  arch/arm64/kernel/efi.c            | 205 +++++++++++++++++++------------------
>  drivers/firmware/efi/libstub/fdt.c | 104 ++++++++++++++++++-
>  3 files changed, 224 insertions(+), 104 deletions(-)
>
> @@ -69,9 +74,36 @@ static void __init efi_setup_idmap(void)
>         }
>  }
>
> +/*
> + * Translate a EFI virtual address into a physical address: this is necessary,
> + * as some data members of the EFI system table are virtually remapped after
> + * SetVirtualAddressMap() has been called.
> + */
> +static phys_addr_t __init efi_to_phys(unsigned long addr)
> +{
> +       efi_memory_desc_t *md;
> +
> +       for_each_efi_memory_desc(&memmap, md) {
> +               if (!(md->attribute & EFI_MEMORY_RUNTIME))
> +                       continue;
> +               if (md->virt_addr == 0)
> +                       /* no virtual mapping has been installed by the stub */
> +                       break;
> +               if (md->virt_addr < addr &&
> +                   (addr - md->virt_addr) < (md->num_pages << EFI_PAGE_SHIFT))
> +                       return md->phys_addr + addr - md->virt_addr;
> +       }
> +
> +       WARN_ONCE(1, "UEFI virtual mapping incomplete or missing -- no entry found for 0x%lx\n",
> +                 addr);
> +       return addr;
> +}
> +

Is function applicable to all EFI implementations? Should it be in the
common EFI code?

How much of this patch series is (theoretically) applicable to aarch32?

g.
