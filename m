From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 20 Feb 2016 11:44:22 +0100
Subject: [PATCH v11 00/10] arm64,
 numa: Add numa support for arm64 platforms
In-Reply-To: <20160220103959.GC4914@rric.localdomain>
References: <1455930799-5371-1-git-send-email-ddaney.cavm@gmail.com>
 <CAKv+Gu8FRdif_WDZPqs7gHxXMu=6SqDd6A54dQc1KWuGwxpf0w@mail.gmail.com>
 <20160220103959.GC4914@rric.localdomain>
Message-ID: <CAKv+Gu_1gRa2VW-C54sXfGP6+azE8aCLxDr8=YZVAkz0QxURpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 February 2016 at 11:39, Robert Richter
<robert.richter@caviumnetworks.com> wrote:
> On 20.02.16 09:20:05, Ard Biesheuvel wrote:
>> On 20 February 2016 at 02:13, David Daney <ddaney.cavm@gmail.com> wrote:
>> > From: David Daney <david.daney@cavium.com>
>> >
>> > v11:
>> >         - Dropped cleanup patches for other architectures, they will be
>> >           submitted as a separate set after more testing.
>> >
>> >         - Added patch set from Ard Biesheuvel that are needed to make
>> >           the whole thing actually work.  Previously this was a
>> >           separate set.
>> >
>>
>> This series is out of date, unfortunately. The EFI init code is now
>> (as of v4.5-rc1) shared between ARM and arm64, which means that any
>> changes you make must be made on both sides. This applies to the split
>> between parsing the EFI dt nodes and performing the actual EFI init,
>> but also to the early_init_dt_add_memory_arch() changes. I am happy to
>> have a go at this, but first I need a clear statement from whoever
>> maintains that area that keeping memory nodes *just* for the
>> annotations (and otherwise ignore them) is the way forward (Rob?
>> Grant?)
>
> Wasn't there the approach to check for consistency between efi tables
> and devicetree? Thus, DT is actually not ignored but rather checked if
> it is in sync with efi tables.
>

I proposed such an approach for the /reserved-memory node, but not for
the memory nodes themselves.

But thinking about this a bit more, I think we can replace the whole 6
piece series with the following patch
(apologies for the mangled whitespace). The reason is that, if we
decide to keep the memory nodes, we might just as well parse them as
usual (and use generic code to spot any problems etc), and just
discard the regions it describes. This completely solves the ARM vs
arm64 problem.


---------8<--------------
Subject: [PATCH] efi: ARM/arm64: ignore DT memory nodes instead of removing
 them

There are two problems with the UEFI stub DT memory node removal
routine:
- it deletes nodes as it traverses the tree, which happens to work
  but is not supported, as deletion invalidates the node iterator;
- deleting memory nodes entirely may discard annotations in the form
  of additional properties on the nodes.

Since the discovery of DT memory nodes occurs strictly before the
UEFI init sequence, we can simply clear the memblock memory table
before parsing the UEFI memory map. This way, it is no longer
necessary to remove the nodes, so we can remove that logic from the
stub as well.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/arm-init.c    |  8 +++++++
 drivers/firmware/efi/libstub/fdt.c | 24 +-------------------
 2 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
index 9e15d571b53c..40c9d8596d69 100644
--- a/drivers/firmware/efi/arm-init.c
+++ b/drivers/firmware/efi/arm-init.c
@@ -143,6 +143,14 @@ static __init void reserve_regions(void)
  if (efi_enabled(EFI_DBG))
  pr_info("Processing EFI memory map:\n");

+ /*
+ * Discard memblocks discovered so far: if there are any at this
+ * point, they originate from memory nodes in the DT, and UEFI
+ * uses its own memory map instead.
+ */
+ memblock_dump_all();
+ memblock_remove(0, ULLONG_MAX);
+
  for_each_efi_memory_desc(&memmap, md) {
  paddr = md->phys_addr;
  npages = md->num_pages;
diff --git a/drivers/firmware/efi/libstub/fdt.c
b/drivers/firmware/efi/libstub/fdt.c
index 6dba78aef337..e58abfa953cc 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -24,7 +24,7 @@ efi_status_t update_fdt(efi_system_table_t
*sys_table, void *orig_fdt,
  unsigned long map_size, unsigned long desc_size,
  u32 desc_ver)
 {
- int node, prev, num_rsv;
+ int node, num_rsv;
  int status;
  u32 fdt_val32;
  u64 fdt_val64;
@@ -54,28 +54,6 @@
  goto fdt_set_fail;

  /*
- * Delete any memory nodes present. We must delete nodes which
- * early_init_dt_scan_memory may try to use.
- */
- prev = 0;
- for (;;) {
- const char *type;
- int len;
-
- node = fdt_next_node(fdt, prev, NULL);
- if (node < 0)
- break;
-
- type = fdt_getprop(fdt, node, "device_type", &len);
- if (type && strncmp(type, "memory", len) == 0) {
- fdt_del_node(fdt, node);
- continue;
- }
-
- prev = node;
- }
-
- /*
  * Delete all memory reserve map entries. When booting via UEFI,
  * kernel will use the UEFI memory map to find reserved regions.
  */
-- 
1.9.1
