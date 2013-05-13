From: ming.lei@canonical.com (Ming Lei)
Date: Mon, 13 May 2013 09:56:31 +0800
Subject: [PATCH] ARM: DMA-mapping: mark all !DMA_TO_DEVICE pages in
 unmapping as clean
In-Reply-To: <1367572365-18905-1-git-send-email-ming.lei@canonical.com>
References: <1367572365-18905-1-git-send-email-ming.lei@canonical.com>
Message-ID: <CACVXFVMSibWd2+QG88QypJC0KYYE0oyyyt4iHpdnK5YR4AN-6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, May 3, 2013 at 5:12 PM, Ming Lei <ming.lei@canonical.com> wrote:
> It is common for one sg to include many pages, so mark all these
> pages as clean to avoid unnecessary flushing on them in
> set_pte_at() or update_mmu_cache().
>
> The patch might improve loading performance of applciation code a bit.
>
> On the below test code to read file(~1GByte size) from usb mass storage
> disk to buffer created with mmap(PROT_READ | PROT_EXEC) on
> Pandaboard, average ~1% improvement can be observed with the patch on
> 10 times test.
>
>
> #define _GNU_SOURCE
>
> #include <fcntl.h>
> #include <stdio.h>
> #include <unistd.h>
> #include <stdlib.h>
> #include <sys/mman.h>
> #include <sys/stat.h>
> #include <string.h>
> #include <assert.h>
>
> unsigned int sum = 0;
>
> static unsigned long tv_diff(struct timeval *tv1, struct timeval *tv2)
> {
>         return (tv2->tv_sec - tv1->tv_sec) * 1000000 +
>                 (tv2->tv_usec - tv1->tv_usec);
> }
>
> int main(int argc, char *argv[])
> {
>         char *mbuffer;
>         int fd;
>         int i;
>         unsigned long page_size, size;
>         struct stat stat;
>         struct timeval t1, t2;
>
>         page_size = getpagesize();
>         fd = open(argv[1], O_RDONLY);
>         assert(fd >= 0);
>
>         fstat(fd, &stat);
>         size = stat.st_size;
>         printf("%s: file %s, file size %lu, page size %lu\n", argv[0],
>                 read_filename, size, page_size);
>
>         gettimeofday(&t1, NULL);
>         mbuffer = mmap(NULL, size, PROT_READ | PROT_EXEC, MAP_SHARED, fd, 0);
>         for (i = 0 ; i < size ; i += page_size)
>                 sum += mbuffer[i];
>         munmap(mbuffer, page_size);
>         gettimeofday(&t2, NULL);
>         printf("\tread mmaped time: %luus\n", tv_diff(&t1, &t2));
>
>         close(fd);
> }
>
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Ming Lei <ming.lei@canonical.com>

Gentle ping, :-)

Thanks,
--
Ming Lei
