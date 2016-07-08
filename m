From: thunder.leizhen@huawei.com (Leizhen (ThunderTown))
Date: Fri, 8 Jul 2016 23:24:26 +0800
Subject: [PATCH 1/1] arm64/hugetlb: clear PG_dcache_clean if the page is
 dirty when munmap
In-Reply-To: <20160708135447.GB22099@e104818-lin.cambridge.arm.com>
References: <1467893344-8352-1-git-send-email-thunder.leizhen@huawei.com>
 <20160707153741.GC27180@e104818-lin.cambridge.arm.com>
 <577F1FD9.1040205@huawei.com>
 <20160708135447.GB22099@e104818-lin.cambridge.arm.com>
Message-ID: <577FC5AA.5010709@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/7/8 21:54, Catalin Marinas wrote:
> On Fri, Jul 08, 2016 at 11:36:57AM +0800, Leizhen (ThunderTown) wrote:
>> On 2016/7/7 23:37, Catalin Marinas wrote:
>>> On Thu, Jul 07, 2016 at 08:09:04PM +0800, Zhen Lei wrote:
>>>> At present, PG_dcache_clean is only cleared when the related huge page
>>>> is about to be freed. But sometimes, there maybe a process is in charge
>>>> to copy binary codes into a shared memory, and notifies other processes
>>>> to execute base on that. For the first time, there is no problem, because
>>>> the default value of page->flags is PG_dcache_clean cleared. So the cache
>>>> will be maintained at the time of set_pte_at for other processes. But if
>>>> the content of the shared memory have been updated again, there is no
>>>> cache operations, because the PG_dcache_clean is still set.
>>>>
>>>> For example:
>>>> Process A
>>>> 	open a hugetlbfs file
>>>> 	mmap it as a shared memory
>>>> 	copy some binary codes into it
>>>> 	munmap
>>>>
>>>> Process B
>>>> 	open the hugetlbfs file
>>>> 	mmap it as a shared memory, executable
>>>> 	invoke the functions in the shared memory
>>>> 	munmap
>>>>
>>>> repeat the above steps.
>>>
>>> Does this work as you would expect with small pages (and for example
>>> shared file mmap)? I don't want to have a different behaviour between
>>> small and huge pages.
>>
>> The small pages also have this problem, I will try to fix it too.
> 
> Have you run the above tests on a standard file (with small pages)? It's
> strange that we haven't hit this so far with gcc or something else
> generating code (unless they don't use mmap but just sequential writes).
The test code should be randomly generated, to make sure the context
in ICache is always stale. I have attached the simplified testcase demo.

The main portion is picked as below:
	srand(time(NULL));
	ptr = (unsigned int *)share_mem;
	*ptr++ = 0xd2800000;				//mov x0, #0
	for (i = 0, total = 0; i < 100; i++) {
		value = 0xfff & rand();
		total += value;
		*ptr++ = 0xb1000000 | (value << 10);	//adds x0, x0, #value
	}
	*ptr = 0xd65f03c0;				//ret

> 
> If both cases need solving, we might better move the fix in the
> __sync_icache_dcache() function. Untested:
Yes.

At first I also want to fix it as below. But I'm not sure which time the PageDirty
will be cleared, and if two or more processes mmap it as executable, cache operations
will be duplicated. At present, I really have not found any good place to clear
PG_dcache_clean. So the below modification may be the best choice, concisely and clearly.

> 
> ------------8<----------------
> diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
> index dbd12ea8ce68..c753fa804165 100644
> --- a/arch/arm64/mm/flush.c
> +++ b/arch/arm64/mm/flush.c
> @@ -75,7 +75,8 @@ void __sync_icache_dcache(pte_t pte, unsigned long addr)
>  	if (!page_mapping(page))
>  		return;
>  
> -	if (!test_and_set_bit(PG_dcache_clean, &page->flags))
> +	if (!test_and_set_bit(PG_dcache_clean, &page->flags) ||
> +	    PageDirty(page))
>  		sync_icache_aliases(page_address(page),
>  				    PAGE_SIZE << compound_order(page));
>  	else if (icache_is_aivivt())
> ----------------8<---------------------
> 
> BTW, can you make your tests (source) available somewhere?
Both cases worked well with this patch.

> 
> Thanks.
> 
-------------- next part --------------
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/mman.h>
#include <sys/stat.h>

#define FILENAME		"/mnt/huge/test_file"
#define TST_MMAP_SIZE		0x200000

typedef unsigned int (*TEST_FUNC_T)(void);

/*
 * mkdir -p /mnt/huge
 * echo 20 > /proc/sys/vm/nr_hugepages
 * mount none /mnt/huge -t hugetlbfs -o pagesize=2048K
 */
int main(void)
{
	int i;
	int fd;
	int ret;
	void *share_mem;
	size_t size;
	struct stat sb;
	TEST_FUNC_T func_ptr;
	unsigned int value, total;
	unsigned int *ptr;

	fd = open(FILENAME, O_RDWR | O_CREAT);
	if (fd == -1) {
		printf("Open file %s failed P1: %s\n", FILENAME, strerror(errno));
		return 1;
	}

	lseek(fd, TST_MMAP_SIZE - 1, SEEK_SET);  
	write(fd, "", 1);

	share_mem = mmap(NULL, TST_MMAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
	if (share_mem == MAP_FAILED) {
		printf("Call mmap failed P1: %s\n", strerror(errno));
		exit(1);
	}

	close(fd);

	srand(time(NULL));
	ptr = (unsigned int *)share_mem;
	*ptr++ = 0xd2800000;				//mov x0, #0
	for (i = 0, total = 0; i < 100; i++) {
		value = 0xfff & rand();
		total += value;
		*ptr++ = 0xb1000000 | (value << 10);	//adds x0, x0, #value
	}
	*ptr = 0xd65f03c0;				//ret

	//__clear_cache((char *)share_mem, (char *)share_mem + 0x200);

	ret = msync(share_mem, TST_MMAP_SIZE, MS_SYNC);
	if (ret) {
		printf("Call msync failed: %s\n", strerror(errno));
		exit(1);
	}

	ret = munmap(share_mem, TST_MMAP_SIZE);
	if (ret) {
		printf("Call munmap failed P1: %s\n", strerror(errno));
		exit(1);
	}

	fd = open(FILENAME, S_IXUSR);
	if (fd == -1) {
		printf("Open file %s failed P2: %s\n", FILENAME, strerror(errno));
		return 1;
	}

	if (fstat(fd, &sb) == -1) {
		printf("Call fstat failed: %s\n", strerror(errno));
		exit(1);
	}
	size = sb.st_size;

	func_ptr = (TEST_FUNC_T)mmap(NULL, size, PROT_EXEC, MAP_SHARED, fd, 0);
	if (func_ptr == MAP_FAILED) {
		printf("Call mmap failed P2: %s\n", strerror(errno));
		exit(1);
	}

	close(fd);

	value = func_ptr();
	printf("Test is %s: The result is 0x%x, expect = 0x%x\n", (value == total) ? "Passed" : "Failed", value, total);

	ret = munmap(share_mem, TST_MMAP_SIZE);
	if (ret) {
		printf("Call munmap failed P2: %s\n", strerror(errno));
		exit(1);
	}

	return 0;
}
