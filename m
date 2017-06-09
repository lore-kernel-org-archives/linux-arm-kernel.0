From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri,  9 Jun 2017 16:32:28 +0000
Subject: [RFC PATCH] drivers/char: kmem: disable read/write if VMALLOC_START <
 PAGE_OFFSET
Message-ID: <20170609163228.446-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As it turns out, arm64 deviates from other architectures in the way it
maps the VMALLOC region: on most (all?) other architectures, it resides
strictly above the kernel's direct mapping of DRAM, but on arm64, this
is the other way around. For instance, for a 48-bit VA configuration,
we have

  modules : 0xffff000000000000 - 0xffff000008000000   (   128 MB)
  vmalloc : 0xffff000008000000 - 0xffff7dffbfff0000   (129022 GB)
  ...
  vmemmap : 0xffff7e0000000000 - 0xffff800000000000   (  2048 GB maximum)
            0xffff7e0000000000 - 0xffff7e0003ff0000   (    63 MB actual)
  memory  : 0xffff800000000000 - 0xffff8000ffc00000   (  4092 MB)

This has mostly gone unnoticed until now, but it does appear that it
breaks an assumption in the kcore read/write code, which does something
like

  if (p < (unsigned long) high_memory) {
    ... use straight copy_[to|from]_user() using p as virtual address ...
  }
  ...
  if (count > 0) {
    ... use vread/vwrite for accesses past high_memory ...
  }

The first condition will inadvertently hold for the VMALLOC region if
VMALLOC_START < PAGE_OFFSET, but the read/write will subsequently fail
the virt_addr_valid() check, resulting in a -ENXIO return value.

Given how kmem seems to be living in borrowed time anyway, and given
the fact that nobody noticed that the read/write interface is broken
on arm64 in the first place, let's not bother trying to fix it, but
simply fail such calls with a warning if VMALLOC_START < PAGE_OFFSET.
(Note that kmem's mmap() interface is not affected by this)

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

This is just an RFC. There may be better ways to deal with this, including
disabling /dev/kmem altogether on arm64.

 drivers/char/mem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 6e0cbe092220..c90ca6703dd5 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -408,6 +408,10 @@ static ssize_t read_kmem(struct file *file, char __user *buf,
 	char *kbuf; /* k-addr because vread() takes vmlist_lock rwlock */
 	int err = 0;
 
+	/* the code below assumes VMALLOC_START > PAGE_OFFSET */
+	if (WARN_ON_ONCE(VMALLOC_START < PAGE_OFFSET))
+		return -ENXIO;
+
 	read = 0;
 	if (p < (unsigned long) high_memory) {
 		low_count = count;
@@ -484,6 +488,10 @@ static ssize_t do_write_kmem(unsigned long p, const char __user *buf,
 	ssize_t written, sz;
 	unsigned long copied;
 
+	/* the code below assumes VMALLOC_START > PAGE_OFFSET */
+	if (WARN_ON_ONCE(VMALLOC_START < PAGE_OFFSET))
+		return -ENXIO;
+
 	written = 0;
 #ifdef __ARCH_HAS_NO_PAGE_ZERO_MAPPED
 	/* we don't have page 0 mapped on sparc and m68k.. */
-- 
2.9.3
