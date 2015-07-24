From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 24 Jul 2015 11:59:31 +0100
Subject: [PATCH] arm64/efi: prefer AllocatePages() over efi_low_alloc()
 for vmlinux
In-Reply-To: <CAKv+Gu_wAKcpkghnUrp1nxV0HEO-h_BNavkRjCWpk65GTyhO_w@mail.gmail.com>
References: <1437730913-18077-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150724104904.GB4348@leverpostej>
 <CAKv+Gu_wAKcpkghnUrp1nxV0HEO-h_BNavkRjCWpk65GTyhO_w@mail.gmail.com>
Message-ID: <20150724105931.GD4348@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 11:54:47AM +0100, Ard Biesheuvel wrote:
> On 24 July 2015 at 12:49, Mark Rutland <mark.rutland@arm.com> wrote:
> > Hi Ard,
> >
> > On Fri, Jul 24, 2015 at 10:41:53AM +0100, Ard Biesheuvel wrote:
> >> When allocating memory for the kernel image, try the AllocatePages()
> >> boot service to obtain memory at the preferred offset of
> >> 'dram_base + TEXT_OFFSET', and only revert to efi_low_alloc() if that
> >> fails. This is the only way to allocate at the base of DRAM if DRAM
> >> starts at 0x0, since efi_low_alloc() refuses to allocate at 0x0.
> >>
> >> Tested-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> ---
> >>  arch/arm64/kernel/efi-stub.c | 47 ++++++++++++++++++++++++++++++++++++--------
> >>  1 file changed, 39 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/arch/arm64/kernel/efi-stub.c b/arch/arm64/kernel/efi-stub.c
> >> index f5374065ad53..c8df74d14368 100644
> >> --- a/arch/arm64/kernel/efi-stub.c
> >> +++ b/arch/arm64/kernel/efi-stub.c
> >> @@ -13,7 +13,7 @@
> >>  #include <asm/efi.h>
> >>  #include <asm/sections.h>
> >>
> >> -efi_status_t __init handle_kernel_image(efi_system_table_t *sys_table,
> >> +efi_status_t __init handle_kernel_image(efi_system_table_t *sys_table_arg,
> >
> > Any reason for the _arg addition?
> >
> 
> Yes. Unfortunately, the efi_call_early() macro has a hidden
> 'efi_system_table_t *' parameter which it refers to by the name
> 'sys_table_arg'

Eww...

Ok, no worry.

> >> +             *reserve_addr = dram_base + TEXT_OFFSET;
> >> +             nr_pages = round_up(kernel_memsize, EFI_ALLOC_ALIGN) /
> >> +                        EFI_PAGE_SIZE;
> >> +             status = efi_call_early(allocate_pages, EFI_ALLOCATE_ADDRESS,
> >> +                                     EFI_LOADER_DATA, nr_pages,
> >> +                                     (efi_physical_addr_t *)reserve_addr);
> >> +             if (status == EFI_SUCCESS) {
> >> +                     memcpy((void *)*reserve_addr, (void *)*image_addr,
> >> +                            kernel_size);
> >> +                     *image_addr = *reserve_addr;
> >> +                     *reserve_size = kernel_memsize;
> >> +             } else {
> >> +                     status = efi_low_alloc(sys_table_arg,
> >> +                                            kernel_memsize + TEXT_OFFSET,
> >> +                                            SZ_2M, reserve_addr);
> >> +
> >> +                     if (status == EFI_SUCCESS) {
> >> +                             memcpy((void *)*reserve_addr + TEXT_OFFSET,
> >> +                                    (void *)*image_addr,
> >> +                                    kernel_size);
> >> +                             *image_addr = *reserve_addr + TEXT_OFFSET;
> >> +                             *reserve_size = kernel_memsize + TEXT_OFFSET;
> >> +                     }
> >> +             }
> >>               if (status != EFI_SUCCESS) {
> >> -                     pr_efi_err(sys_table, "Failed to relocate kernel\n");
> >> +                     pr_efi_err(sys_table_arg, "Failed to relocate kernel\n");
> >>                       return status;
> >>               }
> >> -             memcpy((void *)*reserve_addr + TEXT_OFFSET, (void *)*image_addr,
> >> -                    kernel_size);
> >
> > Could we have a new_image_addr assigned in each case, and keep the
> > common memcpy here, followed by assignment to *image_addr? That would
> > save a couple of lines and guarantee the two cases stay in sync.
> >
> 
> Well, the memcpy() occurs before the assignment of *image_addr, which
> is also used as the src arg. So I could record the value of
> *image_addr in a temp, I suppose. I will do that in the next version.

Yup, I suggested the name new_image_addr for said temporary ;)

Thanks,
Mark.
