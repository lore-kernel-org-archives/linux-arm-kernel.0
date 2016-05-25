From: dennis.chen@arm.com (Dennis Chen)
Date: Wed, 25 May 2016 19:16:14 +0800
Subject: [PATCH] arm64:efi fix the format of debug message from efi
Message-ID: <1464174974-4733-1-git-send-email-dennis.chen@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When enable debug of efi and memblock with 'efi=debug memblock=debug' appended
to the kernel command line, the debug message output for earyly_con looks like:
[    0.000000] efi:   0x0000e1050000-0x0000e105ffff [Memory Mapped I/O  |RUN|  |  |  |  |  |  |   |  |  |  |UC]
[    0.000000] efi:   0x0000e1300000-0x0000e1300fff [Memory Mapped I/O  |RUN|  |  |  |  |  |  |   |  |  |  |UC]
[    0.000000] efi:   0x0000e8200000-0x0000e827ffff [Memory Mapped I/O  |RUN|  |  |  |  |  |  |   |  |  |  |UC]
[    0.000000] efi:   0x008000000000-0x008001e7ffff [Runtime Data       |RUN|  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] memblock_add: [0x00008000000000-0x00008001e7ffff] flags 0x0 early_init_dt_add_memory_arch+0x54/0x5c
[    0.000000] *
...
This patch is trying to fix the above output messed up by memblock_add(), so we can get below debug mesg looks
more formally after applied:
[    0.000000] efi:   0x0000e1050000-0x0000e105ffff [Memory Mapped I/O  |RUN|  |  |  |  |  |  |   |  |  |  |UC]
[    0.000000] efi:   0x0000e1300000-0x0000e1300fff [Memory Mapped I/O  |RUN|  |  |  |  |  |  |   |  |  |  |UC]
[    0.000000] efi:   0x0000e8200000-0x0000e827ffff [Memory Mapped I/O  |RUN|  |  |  |  |  |  |   |  |  |  |UC]
[    0.000000] efi:   0x008000000000-0x008001e7ffff [Runtime Data       |RUN|  |  |  |  |  |  |   |WB|WT|WC|UC]*
[    0.000000] memblock_add: [0x00008000000000-0x00008001e7ffff] flags 0x0 early_init_dt_add_memory_arch+0x54/0x5c
...

Signed-off-by: Dennis Chen <dennis.chen@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Steve Capper <steve.capper@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 drivers/firmware/efi/arm-init.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
index a850cbc..272f674 100644
--- a/drivers/firmware/efi/arm-init.c
+++ b/drivers/firmware/efi/arm-init.c
@@ -174,6 +174,7 @@ static __init void reserve_regions(void)
 {
        efi_memory_desc_t *md;
        u64 paddr, npages, size;
+       int resv;

        if (efi_enabled(EFI_DBG))
                pr_info("Processing EFI memory map:\n");
@@ -190,12 +191,16 @@ static __init void reserve_regions(void)
                paddr = md->phys_addr;
                npages = md->num_pages;

+               resv = is_reserve_region(md);
                if (efi_enabled(EFI_DBG)) {
                        char buf[64];

                        pr_info("  0x%012llx-0x%012llx %s%s",
                                paddr, paddr + (npages << EFI_PAGE_SHIFT) - 1,
-                               efi_md_typeattr_format(buf, sizeof(buf), md));
+                               efi_md_typeattr_format(buf, sizeof(buf), md),
+                               resv ? "*" : "");
+
+                       pr_cont("\n");
                }

                memrange_efi_to_native(&paddr, &npages);
@@ -204,14 +209,9 @@ static __init void reserve_regions(void)
                if (is_normal_ram(md))
                        early_init_dt_add_memory_arch(paddr, size);

-               if (is_reserve_region(md)) {
+               if (resv)
                        memblock_mark_nomap(paddr, size);
-                       if (efi_enabled(EFI_DBG))
-                               pr_cont("*");
-               }

-               if (efi_enabled(EFI_DBG))
-                       pr_cont("\n");
        }

        set_bit(EFI_MEMMAP, &efi.flags);
--
2.7.4

IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
