From: rmk@arm.linux.org.uk (Russell King)
Date: Tue, 03 May 2016 11:21:08 +0100
Subject: [PATCH kexec-tools 01/32] kdump: mmap() and munmap() only work on
 page-aligned quantites
In-Reply-To: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
Message-ID: <E1axXS0-0004gz-5a@e0050434b2927.dyn.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The man page for mmap() and munmap() says that mmap() and munmap()
only works for page-aligned addresses, sizes and offsets.  Arrange
to give these interfaces what they want.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kdump/kdump.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kdump/kdump.c b/kdump/kdump.c
index 821ee7c..3247a54 100644
--- a/kdump/kdump.c
+++ b/kdump/kdump.c
@@ -25,22 +25,35 @@
 #define MAP_WINDOW_SIZE (64*1024*1024)
 #define DEV_MEM "/dev/mem"
 
+#define ALIGN_MASK(x,y) (((x) + (y)) & ~(y))
+#define ALIGN(x,y)	ALIGN_MASK(x, (y) - 1)
+
 static void *map_addr(int fd, unsigned long size, off_t offset)
 {
+	unsigned long page_size = getpagesize();
+	unsigned long map_offset = offset & (page_size - 1);
+	size_t len = ALIGN(size + map_offset, page_size);
 	void *result;
-	result = mmap(0, size, PROT_READ, MAP_SHARED, fd, offset);
+
+	result = mmap(0, len, PROT_READ, MAP_SHARED, fd, offset - map_offset);
 	if (result == MAP_FAILED) {
 		fprintf(stderr, "Cannot mmap " DEV_MEM " offset: %llu size: %lu: %s\n",
 			(unsigned long long)offset, size, strerror(errno));
 		exit(5);
 	}
-	return result;
+	return result + map_offset;
 }
 
 static void unmap_addr(void *addr, unsigned long size)
 {
+	unsigned long page_size = getpagesize();
+	unsigned long map_offset = (uintptr_t)addr & (page_size - 1);
+	size_t len = ALIGN(size + map_offset, page_size);
 	int ret;
-	ret = munmap(addr, size);
+
+	addr -= map_offset;
+
+	ret = munmap(addr, len);
 	if (ret < 0) {
 		fprintf(stderr, "munmap failed: %s\n",
 			strerror(errno));
-- 
1.9.1
