From: ming.lei@canonical.com (Ming Lei)
Date: Wed, 29 May 2013 22:56:56 +0800
Subject: [PATCH V1] ARM: mm: lazy cache flushing on non-mapped pages
Message-ID: <1369839416-27817-1-git-send-email-ming.lei@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently flush_dcache_page() thinks pages as non-mapped if
mapping_mapped(mapping) return false. This approach is very
coase:
	- mmap on part of file may cause all pages backed on
	the file being thought as mmaped

	- file-backed pages aren't mapped into user space actually
	if the memory mmaped on the file isn't accessed

This patch uses page_mapped() to decide if the page has been
mapped.

>From the attached test code, I find there is much performance
improvement(>25%) when accessing page caches via read under this
situations, so memcpy benefits a lot from not flushing cache
under this situation.

No.   read time without the patch	No. read time with the patch
================================================================
No. 0, time  22615636 us		No. 0, time  22014717 us
No. 1, time  4387851 us 		No. 1, time  3113184 us
No. 2, time  4276535 us 		No. 2, time  3005244 us
No. 3, time  4259821 us 		No. 3, time  3001565 us
No. 4, time  4263811 us 		No. 4, time  3002748 us
No. 5, time  4258486 us 		No. 5, time  3004104 us
No. 6, time  4253009 us 		No. 6, time  3002188 us
No. 7, time  4262809 us 		No. 7, time  2998196 us
No. 8, time  4264525 us 		No. 8, time  3007255 us
No. 9, time  4267795 us 		No. 9, time  3005094 us

1), No.0. is to read the file from storage device, and others are
to read the file from page caches basically.
2), file size is 512M, and is on ext4 over usb mass storage.
3), the test is done on Pandaboard.

unsigned int  sum = 0;
unsigned long sum_val = 0;

static unsigned long tv_diff(struct timeval *tv1, struct timeval *tv2)
{
	return (tv2->tv_sec - tv1->tv_sec) * 1000000 +
		(tv2->tv_usec - tv1->tv_usec);
}

int main(int argc, char *argv[])
{
	char *mbuf, fbuf;
	int fd;
	int i;
	unsigned long page_size, size;
	struct stat stat;
	struct timeval t1, t2;
	unsigned char *rbuf = malloc(32 * page_size);

	if (!rbuf) {
		printf("	%s\n", "malloc failed");
		exit(-1);
	}

	page_size = getpagesize();
	fd = open(argv[1], O_RDWR);
	assert(fd >= 0);

	fstat(fd, &stat);
	size = stat.st_size;
	printf("%s: file %s, size %lu, page size %lu\n",
		argv[0],
		argv[1], size, page_size);

	gettimeofday(&t1, NULL);
	mbuf = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
	if (!mbuf) {
		printf("	%s\n", "mmap failed");
		exit(-1);
	}

	for (i = 0 ; i < size ; i += (page_size * 32)) {
		int rcnt;
		lseek(fd, i, SEEK_SET);
		rcnt = read(fd, rbuf, page_size * 32);
		if (rcnt != page_size * 32) {
			printf("%s: read faild\n", __func__);
			exit(-1);
		}
	}
	free(rbuf);
	munmap(mbuf, size);
	gettimeofday(&t2, NULL);
	printf("\tread mmaped time: %luus\n", tv_diff(&t1, &t2));

	close(fd);
}

Cc: Michel Lespinasse <walken@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
V1:
	- take Catalin's suggestion to use page_mapped()

 arch/arm/mm/flush.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 0d473cc..008af99 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -286,8 +286,8 @@ void flush_dcache_page(struct page *page)
 
 	mapping = page_mapping(page);
 
-	if (!cache_ops_need_broadcast() &&
-	    mapping && !mapping_mapped(mapping))
+	if (!cache_ops_need_broadcast() && mapping &&
+		(!mapping_mapped(mapping) || !page_mapped(page)))
 		clear_bit(PG_dcache_clean, &page->flags);
 	else {
 		__flush_dcache_page(mapping, page);
-- 
1.7.9.5
