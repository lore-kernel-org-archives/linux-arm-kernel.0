From: robin.murphy@arm.com (Robin Murphy)
Date: Wed,  1 Jun 2016 19:21:42 +0100
Subject: [PATCH v2] drivers: char: mem: Check {read,write}_kmem() addresses
In-Reply-To: <5e293c103f0a86f512d71f17091a55e9746e711f.1464698496.git.robin.murphy@arm.com>
References: <5e293c103f0a86f512d71f17091a55e9746e711f.1464698496.git.robin.murphy@arm.com>
Message-ID: <384215b19582acfb30a6a3660fdebee5189d687b.1464805050.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arriving at read_kmem() with an offset representing a bogus kernel
address (e.g. 0 from a simple "cat /dev/kmem") leads to copy_to_user
faulting on the kernel-side read.

x86_64 happens to get away with this since the optimised implementation
uses "rep movs*", thus the user write (which is allowed to fault) and
the kernel read are the same instruction, the kernel-side fault falls
into the user-side fixup handler and the chain of events which
transpires ends up returning an error as one might expect, even if it's
an inappropriate -EFAULT. On other architectures, though, the read is
not covered by the fixup entry for the write, and we get a big scary
"Unable to hande kernel paging request..." dump.

The more typical use-case of mmap_kmem() has always (within living
memory at least) returned -EIO for addresses which don't satisfy
pfn_valid(), so let's make that consistent across {read,write}_kem()
too.

Reported-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Make the error code consistent and more appropriate, tweak commit message.

 drivers/char/mem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 71025c2f6bbb..e1b8d960341f 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -384,6 +384,9 @@ static ssize_t read_kmem(struct file *file, char __user *buf,
 	char *kbuf; /* k-addr because vread() takes vmlist_lock rwlock */
 	int err = 0;
 
+	if (!pfn_valid(PFN_DOWN(p)))
+		return -EIO;
+
 	read = 0;
 	if (p < (unsigned long) high_memory) {
 		low_count = count;
@@ -512,6 +515,9 @@ static ssize_t write_kmem(struct file *file, const char __user *buf,
 	char *kbuf; /* k-addr because vwrite() takes vmlist_lock rwlock */
 	int err = 0;
 
+	if (!pfn_valid(PFN_DOWN(p)))
+		return -EIO;
+
 	if (p < (unsigned long) high_memory) {
 		unsigned long to_write = min_t(unsigned long, count,
 					       (unsigned long)high_memory - p);
-- 
2.8.1.dirty
