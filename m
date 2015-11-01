From: dan.j.williams@intel.com (Williams, Dan J)
Date: Sun, 1 Nov 2015 20:24:25 +0000
Subject: [GIT PULL] memremap fix for 4.3 (v2)
Message-ID: <1446409463.10982.4.camel@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus, please pull from...

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm libnvdimm-fixes

...to receive a reworked version of the memremap highmem fix.  The
change since v1 is dropping the kmap fallback.

---

The new memremap() api introduced in the 4.3 cycle to unify/replace
ioremap_cache() and ioremap_wt() is mishandling the highmem case.  This
patch has received a build success notification from a 0day-kbuild-robot
run and has received an ack from Ard.

The following changes since commit 25cb62b76430a91cc6195f902e61c2cb84ade622:

  Linux 4.3-rc5 (2015-10-11 11:09:45 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm libnvdimm-fixes

for you to fetch changes up to 182475b7a2831abf7e6ca83b2aced0bef5dcdfd3:

  memremap: fix highmem support (2015-10-26 16:55:56 -0400)

----------------------------------------------------------------
Dan Williams (1):
      memremap: fix highmem support

 kernel/memremap.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

commit 182475b7a2831abf7e6ca83b2aced0bef5dcdfd3
Author: Dan Williams <dan.j.williams@intel.com>
Date:   Mon Oct 26 16:55:56 2015 -0400

    memremap: fix highmem support
    
    Currently memremap checks if the range is "System RAM" and returns the
    kernel linear address.  This is broken for highmem platforms where a
    range may be "System RAM", but is not part of the kernel linear mapping.
    Fallback to ioremap_cache() in these cases, to let the arch code attempt
    to handle it.
    
    Note that ARM ioremap will WARN when attempting to remap ram, and in
    that case the caller needs to be fixed.  For this reason, existing
    ioremap_cache() usages for ARM are already trained to avoid attempts to
    remap ram.
    
    The impact of this bug is low for now since the pmem driver is the only
    user of memremap(), but this is important to fix before more conversions
    to memremap arrive in 4.4.
    
    Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
    Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
    Signed-off-by: Dan Williams <dan.j.williams@intel.com>

diff --git a/kernel/memremap.c b/kernel/memremap.c
index 72b0c66628b6..9d6b55587eaa 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -24,6 +24,16 @@ __weak void __iomem *ioremap_cache(resource_size_t offset, unsigned long size)
 }
 #endif
 
+static void *try_ram_remap(resource_size_t offset, size_t size)
+{
+	struct page *page = pfn_to_page(offset >> PAGE_SHIFT);
+
+	/* In the simple case just return the existing linear address */
+	if (!PageHighMem(page))
+		return __va(offset);
+	return NULL; /* fallback to ioremap_cache */
+}
+
 /**
  * memremap() - remap an iomem_resource as cacheable memory
  * @offset: iomem resource start address
@@ -66,8 +76,8 @@ void *memremap(resource_size_t offset, size_t size, unsigned long flags)
 		 * the requested range is potentially in "System RAM"
 		 */
 		if (is_ram == REGION_INTERSECTS)
-			addr = __va(offset);
-		else
+			addr = try_ram_remap(offset, size);
+		if (!addr)
 			addr = ioremap_cache(offset, size);
 	}
 
