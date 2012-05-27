From: gmbnomis@gmail.com (Simon Baatz)
Date: Mon, 28 May 2012 01:11:57 +0200
Subject: [RFC/PATCH 0/1] ARM: Handle user space mapped pages in
 flush_kernel_dcache_page
Message-ID: <1338160318-20712-1-git-send-email-gmbnomis@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch f8b63c1 "ARM: 6382/1" changed flush_kernel_dcache_page() to a
no-op. flush_kernel_dcache_page was deemed superfluous as newly
allocated page cache pages are now dirty by default (patch 6379/1).

This relies on the assumption that a block device driver only reads
into new pages (otherwise the request is served from the cache).

However, this assumption is not true for direct IO or SG_IO (see
e.g. [1] and [2]). This is why vgchange fails with mv_cesa as reported
by me in [3]. (Btw., flush_kernel_dcache_page is also called from
"copy_strings" in fs/exec.c when copying env/arg strings between
processes. Thus, its use is not restricted to device drivers.)

At the end of this mail is a small program that uses O_DIRECT to
specifically create two test cases:
- device driver gets an anonymous page to read into
- device driver gets a page with user mapping(s) to read into

The source can also be obtained from [4]. With mv_cesa, both cases
return garbled data (the scatterlist memory iterator uses
flush_kernel_dcache_page).

As explained above, the problem is not specific to mv_cesa. As many
drivers seem to use flush_dcache_page where they probably could use
flush_kernel_dcache_page, the problem did not surface up to now. For
example, one of these uses is in the scatterwalk implementation of
linux crypto. When changing flush_dcache_page to
flush_kernel_dcache_page in crypto/scatterwalk.c, I see the same
coherency problems:

root at ww1:~# rmmod mv_cesa
root at ww1:~# cryptsetup luksOpen /dev/sda2 c_sda2
Enter passphrase for /dev/sda2: 
root at ww1:~# ./mapping_tests 
Anonymous page: differs!
User space mapped page: differs!

The proposed fix is to let flush_kernel_dcache_page handle the 'kernel
mapped only' case as before (no-op) but to flush the kernel mapping in
case of a user space mapped page.

This means that the original idea to 'fix' non-flushing PIO drivers by
patch 6379/1 does not work for all cases. The provided patch should
fix things for drivers that already perform cache flushing, but it
obviously does not fix direct IO for PIO drivers without (I think
there have been discussions for specific PIO mapping APIs in the
past). This and my limited testing on only one architecture (kirkwood,
VIVT) is why the patch is RFC.

- Simon

[1] https://lkml.org/lkml/2008/11/20/20
[2] http://article.gmane.org/gmane.linux.kernel.cross-arch/5159
[3] http://www.mail-archive.com/linux-crypto at vger.kernel.org/msg07038.html
[4] http://ubuntuone.com/0jF9fNsguN8BvI1Z8fsBVI


mapping_tests.c:

#define _GNU_SOURCE

#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <string.h>
#include <assert.h>

const char* read_filename = "/dev/mapper/c_sda2";
const char* map_filename = "./map.out";

/* Init the page and read it to fill some cache lines */
int wr_page(char *p, int ps) {
	int i, sum;

	memset(p, 9, ps);
	sum = 0;
	for(i = 0; i < ps; i++)
		sum += p[i];
	return sum;
}

int main(void) {
	void *org_buffer;
	void *odirect_buffer; 
	char *mbuffer;
	int fd, fdm;
	int i, c;
	unsigned page_size;

	page_size = getpagesize();

	/* Read the first page into a normal buffer.
	   If the page is not in the page cache yet, this will
	   create a new page without user mappings in the kernel.
	 */
	fd = open(read_filename, O_RDONLY);
	assert(fd >= 0);
	org_buffer = malloc(page_size);
	c = read(fd, org_buffer, page_size);
	assert(c == page_size);
	close(fd);

	/* Read the first page into an aligned malloced buffer using
	   O_DIRECT.  The block driver will get an anonymous page.
	 */
	odirect_buffer = NULL;
	posix_memalign(&odirect_buffer, page_size, page_size);
	assert(odirect_buffer);
  
	fd = open(read_filename, O_RDONLY | O_DIRECT);
	assert(fd >= 0);

	for (i = 0 ; i < 100 ; i++) {
		wr_page((char *)odirect_buffer, page_size);
		lseek(fd, 0, SEEK_SET);
		c = read(fd, odirect_buffer, page_size);
		assert(c == page_size);
		if (memcmp(odirect_buffer, org_buffer, page_size) != 0) {
			printf("Anonymous page: differs!\n");
			break;
		}
	}
	close(fd);
	free(odirect_buffer);

	/* Read the first page into an mmapped file (using O_DIRECT).
	   The block driver will get a file backed page with user
	   mappings.
	 */
	fd = open(read_filename, O_RDONLY | O_DIRECT);
	assert(fd >= 0);
	fdm = open(map_filename, O_RDWR | O_CREAT | O_TRUNC);
	assert(fdm >= 0);
	c = write(fdm, org_buffer, page_size);
	assert(c == page_size);
	c = fsync(fdm);
	assert(c == 0);
	mbuffer = mmap(NULL, page_size, PROT_WRITE, MAP_SHARED, fdm, 0);
	for (i = 0 ; i < 100 ; i++) {
		wr_page((char *)mbuffer, page_size);
		lseek(fd, 0, SEEK_SET);
		c = read(fd, mbuffer, page_size);
		assert(c == page_size);
		if (memcmp(mbuffer, org_buffer, page_size) != 0) {
			printf("User space mapped page: differs!\n");
			break;
		}
	}
	munmap(mbuffer, page_size);
	close(fdm);
	close(fd);
	free(org_buffer);
}


Simon Baatz (1):
  ARM: Handle user space mapped pages in flush_kernel_dcache_page

 arch/arm/include/asm/cacheflush.h |    4 ++++
 arch/arm/mm/flush.c               |   22 ++++++++++++++++++++++
 2 files changed, 26 insertions(+)

-- 
1.7.9.5
