From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 5 Jul 2018 18:43:14 +0900
Subject: [PATCH v2 3/4] efi/arm: map UEFI memory map earlier on boot
In-Reply-To: <CAKv+Gu9_rYYyQ+t89otz46DR0D4GDj-cCjhx9q=p+D8LWFRkgQ@mail.gmail.com>
References: <20180619064424.6642-1-takahiro.akashi@linaro.org>
 <20180619064424.6642-4-takahiro.akashi@linaro.org>
 <20180704170655.GD8370@arm.com>
 <CAKv+Gu9_rYYyQ+t89otz46DR0D4GDj-cCjhx9q=p+D8LWFRkgQ@mail.gmail.com>
Message-ID: <20180705094313.GL28220@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 04, 2018 at 08:49:32PM +0200, Ard Biesheuvel wrote:
> On 4 July 2018 at 19:06, Will Deacon <will.deacon@arm.com> wrote:
> > Hi all,
> >
> > [Ard -- please can you look at the EFI parts of this patch]
> >
> > On Tue, Jun 19, 2018 at 03:44:23PM +0900, AKASHI Takahiro wrote:
> >> Since arm_enter_runtime_services() was modified to always create a virtual
> >> mapping of UEFI memory map in the previous patch, it is now renamed to
> >> efi_enter_virtual_mode() and called earlier before acpi_load_tables()
> >> in acpi_early_init().
> >>
> >> This will allow us to use UEFI memory map in acpi_os_ioremap() to create
> >> mappings of ACPI tables using memory attributes described in UEFI memory
> >> map.
> >>
> >> See a relevant commit:
> >>     arm64: acpi: fix alignment fault in accessing ACPI tables
> >>
> >> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> ---
> >>  drivers/firmware/efi/arm-runtime.c | 15 ++++++---------
> >>  init/main.c                        |  3 +++
> >>  2 files changed, 9 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
> >> index 30ac5c82051e..566ef0a9edb5 100644
> >> --- a/drivers/firmware/efi/arm-runtime.c
> >> +++ b/drivers/firmware/efi/arm-runtime.c
> >> @@ -106,46 +106,43 @@ static bool __init efi_virtmap_init(void)
> >>   * non-early mapping of the UEFI system table and virtual mappings for all
> >>   * EFI_MEMORY_RUNTIME regions.
> >>   */
> >> -static int __init arm_enable_runtime_services(void)
> >> +void __init efi_enter_virtual_mode(void)
> >>  {
> >>       u64 mapsize;
> >>
> >>       if (!efi_enabled(EFI_BOOT)) {
> >>               pr_info("EFI services will not be available.\n");
> >> -             return 0;
> >> +             return;
> >>       }
> >>
> >>       mapsize = efi.memmap.desc_size * efi.memmap.nr_map;
> >>
> >>       if (efi_memmap_init_late(efi.memmap.phys_map, mapsize)) {
> >>               pr_err("Failed to remap EFI memory map\n");
> >> -             return 0;
> >> +             return;
> >>       }
> >>
> >>       if (efi_runtime_disabled()) {
> >>               pr_info("EFI runtime services will be disabled.\n");
> >> -             return 0;
> >> +             return;
> >>       }
> >>
> >>       if (efi_enabled(EFI_RUNTIME_SERVICES)) {
> >>               pr_info("EFI runtime services access via paravirt.\n");
> >> -             return 0;
> >> +             return;
> >>       }
> >>
> >>       pr_info("Remapping and enabling EFI services.\n");
> >>
> >>       if (!efi_virtmap_init()) {
> >>               pr_err("UEFI virtual mapping missing or invalid -- runtime services will not be available\n");
> >> -             return -ENOMEM;
> >> +             return;
> >>       }
> >>
> >>       /* Set up runtime services function pointers */
> >>       efi_native_runtime_setup();
> >>       set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
> >> -
> >> -     return 0;
> >>  }
> >> -early_initcall(arm_enable_runtime_services);
> >>
> >>  void efi_virtmap_load(void)
> >>  {
> >> diff --git a/init/main.c b/init/main.c
> >> index 3b4ada11ed52..532fc0d02353 100644
> >> --- a/init/main.c
> >> +++ b/init/main.c
> >> @@ -694,6 +694,9 @@ asmlinkage __visible void __init start_kernel(void)
> >>       debug_objects_mem_init();
> >>       setup_per_cpu_pageset();
> >>       numa_policy_init();
> >> +     if (IS_ENABLED(CONFIG_EFI) &&
> >> +         (IS_ENABLED(CONFIG_ARM64) || IS_ENABLED(CONFIG_ARM)))
> >> +             efi_enter_virtual_mode();
> >
> > Hmm, this is ugly as hell. Is there nothing else we can piggy-back off?
> > It's also fairly jarring that, on x86, efi_enter_virtual_mode() is called
> > a few lines later, *after* acpi_early_init() has been called.
> >
> 
> Currently, there is a gap where we have already torn down the early
> mapping and haven't created the definitive mapping of the UEFI memory
> map. There are other reasons why this is an issue, and I recently
> proposed [0] myself to address one of them (and I didn't remember this
> particular series, or the fact that I actually suggested this approach
> IIRC)
> 
> Akashi-san, could you please confirm whether the patch below would be
> sufficient for you? Apologies for going back and forth on this, but I
> agree with Will that we should try to avoid warts like the one above
> in generic code.
> 
> [0] https://marc.info/?l=linux-efi&m=152930773507524&w=2

I think that this patch will also work.
Please drop my patch#2 and #3 if you want to pick up my patchset, Will.

Thanks,
-Takahiro AKASHI


> > The rest of the series looks fine to me, but I'm not comfortable taking
> > changes like this via the arm64 tree.
> >
> > Will
