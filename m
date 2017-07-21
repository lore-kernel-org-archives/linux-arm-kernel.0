From: ross.zwisler@linux.intel.com (Ross Zwisler)
Date: Fri, 21 Jul 2017 16:39:50 -0600
Subject: [PATCH v4 0/5] DAX common 4k zero page
Message-ID: <20170721223956.29485-1-ross.zwisler@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v3:
 - Rebased onto the current linux/master which is based on v4.13-rc1.

 - Instead of adding vm_insert_mkwrite_mixed() and duplicating code from
   vm_insert_mixed(), instead just add a 'mkwrite' parameter to
   vm_insert_mixed() and update all call sites.  (Vivek)

 - Added a sanity check to the mkwrite case of insert_pfn() to be sure the
   pfn for the pte we are about to make writable matches the pfn for our
   fault. (Jan)

 - Fixed up some changelog wording for clarity. (Jan)

---

When servicing mmap() reads from file holes the current DAX code allocates
a page cache page of all zeroes and places the struct page pointer in the
mapping->page_tree radix tree.  This has three major drawbacks:

1) It consumes memory unnecessarily.  For every 4k page that is read via a
DAX mmap() over a hole, we allocate a new page cache page.  This means that
if you read 1GiB worth of pages, you end up using 1GiB of zeroed memory.

2) It is slower than using a common zero page because each page fault has
more work to do.  Instead of just inserting a common zero page we have to
allocate a page cache page, zero it, and then insert it.

3) The fact that we had to check for both DAX exceptional entries and for
page cache pages in the radix tree made the DAX code more complex.

This series solves these issues by following the lead of the DAX PMD code
and using a common 4k zero page instead.  This reduces memory usage and
decreases latencies for some workloads, and it simplifies the DAX code,
removing over 100 lines in total.

This series has passed my targeted testing and a full xfstests run on both
XFS and ext4.

Ross Zwisler (5):
  mm: add mkwrite param to vm_insert_mixed()
  dax: relocate some dax functions
  dax: use common 4k zero page for dax mmap reads
  dax: remove DAX code from page_cache_tree_insert()
  dax: move all DAX radix tree defs to fs/dax.c

 Documentation/filesystems/dax.txt       |   5 +-
 drivers/dax/device.c                    |   2 +-
 drivers/gpu/drm/exynos/exynos_drm_gem.c |   3 +-
 drivers/gpu/drm/gma500/framebuffer.c    |   2 +-
 drivers/gpu/drm/msm/msm_gem.c           |   3 +-
 drivers/gpu/drm/omapdrm/omap_gem.c      |   6 +-
 drivers/gpu/drm/ttm/ttm_bo_vm.c         |   2 +-
 fs/dax.c                                | 342 +++++++++++++-------------------
 fs/ext2/file.c                          |  25 +--
 fs/ext4/file.c                          |  32 +--
 fs/xfs/xfs_file.c                       |   2 +-
 include/linux/dax.h                     |  45 -----
 include/linux/mm.h                      |   2 +-
 include/trace/events/fs_dax.h           |   2 -
 mm/filemap.c                            |  13 +-
 mm/memory.c                             |  27 ++-
 16 files changed, 181 insertions(+), 332 deletions(-)

-- 
2.9.4
