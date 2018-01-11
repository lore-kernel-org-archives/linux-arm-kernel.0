From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 11 Jan 2018 20:32:03 +0900
Subject: [PATCH] arm64: kdump: retain reserved memory regions
In-Reply-To: <CAKv+Gu9QX-r7Q5Dsze6MYRb8hbRyq=C__3BsZTBvvSyv1Y-KMg@mail.gmail.com>
References: <20180110100943.6082-1-takahiro.akashi@linaro.org>
 <CAKv+Gu9QX-r7Q5Dsze6MYRb8hbRyq=C__3BsZTBvvSyv1Y-KMg@mail.gmail.com>
Message-ID: <20180111113202.GE18820@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 10, 2018 at 11:09:32AM +0000, Ard Biesheuvel wrote:
> On 10 January 2018 at 10:09, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> > This is a fix against the issue that crash dump kernel may hang up
> > during booting, which can happen on any ACPI-based system with "ACPI
> > Reclaim Memory."
> >
> >         <kicking off kdump after panic>
> >         Bye!
> >            (snip...)
> >         ACPI: Core revision 20170728
> >         pud=000000002e7d0003, *pmd=000000002e7c0003, *pte=00e8000039710707
> >         Internal error: Oops: 96000021 [#1] SMP
> >         Modules linked in:
> >         CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.14.0-rc6 #1
> >         task: ffff000008d05180 task.stack: ffff000008cc0000
> >         PC is at acpi_ns_lookup+0x25c/0x3c0
> >         LR is at acpi_ds_load1_begin_op+0xa4/0x294
> >            (snip...)
> >         Process swapper/0 (pid: 0, stack limit = 0xffff000008cc0000)
> >         Call trace:
> >            (snip...)
> >         [<ffff0000084a6764>] acpi_ns_lookup+0x25c/0x3c0
> >         [<ffff00000849b4f8>] acpi_ds_load1_begin_op+0xa4/0x294
> >         [<ffff0000084ad4ac>] acpi_ps_build_named_op+0xc4/0x198
> >         [<ffff0000084ad6cc>] acpi_ps_create_op+0x14c/0x270
> >         [<ffff0000084acfa8>] acpi_ps_parse_loop+0x188/0x5c8
> >         [<ffff0000084ae048>] acpi_ps_parse_aml+0xb0/0x2b8
> >         [<ffff0000084a8e10>] acpi_ns_one_complete_parse+0x144/0x184
> >         [<ffff0000084a8e98>] acpi_ns_parse_table+0x48/0x68
> >         [<ffff0000084a82cc>] acpi_ns_load_table+0x4c/0xdc
> >         [<ffff0000084b32f8>] acpi_tb_load_namespace+0xe4/0x264
> >         [<ffff000008baf9b4>] acpi_load_tables+0x48/0xc0
> >         [<ffff000008badc20>] acpi_early_init+0x9c/0xd0
> >         [<ffff000008b70d50>] start_kernel+0x3b4/0x43c
> >         Code: b9008fb9 2a000318 36380054 32190318 (b94002c0)
> >         ---[ end trace c46ed37f9651c58e ]---
> >         Kernel panic - not syncing: Fatal exception
> >         Rebooting in 10 seconds..
> >
> > (diagnosis)
> > * This fault is a data abort, alignment fault (ESR=0x96000021)
> >   during reading out ACPI table.
> > * Initial ACPI tables are normally stored in system ram and marked as
> >   "ACPI Reclaim memory" by the firmware.
> > * After the commit f56ab9a5b73c ("efi/arm: Don't mark ACPI reclaim
> >   memory as MEMBLOCK_NOMAP"), those regions' attribute were changed
> >   removing NOMAP bit and they are instead "memblock-reserved".
> > * When crash dump kernel boots up, it tries to accesses ACPI tables by
> >   ioremap'ing them (through acpi_os_ioremap()).
> > * Since those regions are not included in device tree's
> >   "usable-memory-range" and so not recognized as part of crash dump
> >   kernel's system ram, ioremap() will create a non-cacheable mapping here.
> > * ACPI accessor/helper functions are compiled in without unaligned access
> >   support (ACPI_MISALIGNMENT_NOT_SUPPORTED), eventually ending up a fatal
> >   panic when accessing ACPI tables.
> >
> > With this patch, all the reserved memory regions, as well as NOMAP-
> > attributed ones which are presumably ACPI runtime code and data, are set
> > to be retained in system ram even if they are outside of usable memory
> > range specified by device tree blob. Accordingly, ACPI tables are mapped
> > as cacheable and can be safely accessed without causing unaligned access
> > faults.
> >
> > Reported-by: Bhupesh Sharma <bhsharma@redhat.com>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  arch/arm64/mm/init.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index 2d5a443b205c..e4a8b64a09b1 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -352,11 +352,23 @@ static void __init fdt_enforce_memory_region(void)
> >         struct memblock_region reg = {
> >                 .size = 0,
> >         };
> > +       u64 idx;
> > +       phys_addr_t start, end;
> >
> >         of_scan_flat_dt(early_init_dt_scan_usablemem, &reg);
> >
> > -       if (reg.size)
> > -               memblock_cap_memory_range(reg.base, reg.size);
> 
> Given that memblock_cap_memory_range() was introduced by you for
> kdump, is there any way to handle it there?

Indeed, but I'm not sure that the new semantics of this function
is quite generic.

> If not, should we remove it?

I prefer to remove it.

Thanks,
-Takahiro AKASHI

> > +       if (reg.size) {
> > +retry:
> > +               /* exclude usable & !reserved memory */
> > +               for_each_free_mem_range(idx, NUMA_NO_NODE, MEMBLOCK_NONE,
> > +                                       &start, &end, NULL) {
> > +                       memblock_remove(start, end - start);
> > +                       goto retry;
> > +               }
> > +
> > +               /* add back fdt's usable memory */
> > +               memblock_add(reg.base, reg.size);
> > +       }
> >  }
> >
> >  void __init arm64_memblock_init(void)
> > --
> > 2.15.1
> >
