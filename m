From: imre.deak@nokia.com (Imre Deak)
Date: Mon, 28 Sep 2009 12:29:19 +0300
Subject: arm_syscall cacheflush breakage on VIPT platforms
Message-ID: <20090928092919.GA30271@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

the following test app will cause an unhandled kernel paging request
on VIPT platforms. The triggering condition is the mmap_sem held by
thread_func while the main thread performs cache flushing.

Since the likelihood of this to trigger is relatively low, a patch will
follow that makes similar bugs more visible.

--Imre

#define _GNU_SOURCE
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <pthread.h>

#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/mman.h>

static int exit_thread;
static pthread_t tid;

void *thread_func(void *arg)
{
	while (1) {
		int map_size = 4096;
		void *mem;

		if (exit_thread)
			break;
		mem = mmap(NULL, map_size, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
		if (mem == MAP_FAILED) {
			perror("mmap");
			break;
		}
		munmap(mem, map_size);
	}
}

int start_mmap_thread(void)
{
	if (pthread_create(&tid, NULL, thread_func, NULL) < 0) {
		perror("pthread_create");
		return -1;
	}
}

int stop_mmap_thread(void)
{
	exit_thread = 1;
	pthread_join(tid, NULL);
}

int main(int argc, char *argv[])
{
	void *mem;
	pid_t tid;
	int r;
	size_t size;
	unsigned long end;
	int i;
	int nr_iter = 1000;

	size = 4096;
	if (posix_memalign(&mem, size, 4096) != 0) {
		fprintf(stderr, "malloc\n");
		return -1;
	}

	start_mmap_thread();

	for (i = 0; i < nr_iter; i++) {
		end = (unsigned long)mem + size - 1;
		r = syscall(__ARM_NR_cacheflush, (unsigned long)mem, end, 0);
		if (r < 0) {
			fprintf(stderr, "syscall: %d\n", r);
			goto out;
		}
	}
out:
	free(mem);

	stop_mmap_thread();

	return 0;
}


[   92.347442] Unable to handle kernel paging request at virtual address 00012000
[   92.354797] pgd = cf1d4000
[   92.357574] [00012000] *pgd=8f1dc031, *pte=00000000, *ppte=00000000
[   92.363983] Internal error: Oops: 817 [#1] PREEMPT
[   92.368804] Modules linked in:
[   92.415679] CPU: 0    Not tainted  (2.6.28-omap1-00042-g96a5ca2-dirty #231)
[   92.422729] PC is at v7_coherent_kern_range+0x18/0x44
[   92.427825] LR is@arm_syscall+0x1c4/0x2b0
[   92.432159] pc : [<c0033b88>]    lr : [<c00306ec>]    psr: 80000053
[   92.432159] sp : cf2a3e80  ip : cf1de0b0  fp : cf2a3fa4
[   92.443725] r10: 40024000  r9 : cf2a2000  r8 : 00000000
[   92.449005] r7 : 000f0002  r6 : 00000000  r5 : 00012fff  r4 : 00012000
[   92.455596] r3 : 0000003f  r2 : 00000040  r1 : 00013000  r0 : 00012000
[   92.462188] Flags: Nzcv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment user
[   92.469482] Control: 10c5387d  Table: 8f1d4018  DAC: 00000015
[   92.475280] Process ct (pid: 768, stack limit = 0xcf2a22e0)
[   92.480895] Stack: (0xcf2a3e80 to 0xcf2a4000)
[   92.485290] 3e80: cfdb23c0 c0281880 cf2a3eb4 cf2a3e98 c0285b08 c0285a68 00000000 c004f980
[   92.493743] 3ea0: cf16401c cfdb2700 cf2a3ecc cf2a3eb8 c0285b54 c0285ae0 cf2df900 cfdb2700
[   92.502166] 3ec0: cf2a3efc cf2a3ed0 c02816b8 c00501fc 40000000 cf2a2000 c0381540 00000000
[   92.510589] 3ee0: 00000301 00000000 00000000 00000000 cf2a3f14 cf2a3f00 c0281880 c0281410
[   92.519012] 3f00: cfdb23c0 c0381540 cf2a3f3c cf2a3f18 c0052ff4 c0281848 003d0f00 60000053
[   92.527435] 3f20: cf2a3f3c cfdb23c0 003d0f00 00000000 cf2a3f8c cf2a3f40 c0054f1c c0052f0c
[   92.535858] 3f40: 409734d8 cf215bc0 00000000 c0156750 cf2a3fa4 cf2a3f60 c00a34d4 c0070930
[   92.544281] 3f60: 00100070 409734d8 40973490 4004c000 00000078 c002cac4 cf2a2000 40033888
[   92.552703] 3f80: cf2a3fa4 cf2a3f90 c002f9c0 00000000 bea99ef4 00000001 00000000 cf2a3fa8
[   92.561126] 3fa0: c002c940 c0030534 00000000 bea99ef4 00012000 00012fff 00000000 40023e08
[   92.569549] 3fc0: 00000000 bea99ef4 00000001 000f0002 00000000 00000000 40024000 bea99d9c
[   92.577972] 3fe0: bea99d68 bea99d58 00008788 4010d6f0 60000050 00012000 805b6021 805b6421
[   92.586395] Backtrace:
[   92.588867] [<c0030528>] (arm_syscall+0x0/0x2b0) from [<c002c940>] (ret_fast_syscall+0x0/0x2c)
[   92.597625]  r6:00000001 r5:bea99ef4 r4:00000000
[   92.602294] Code: e3a02010 e1a02312 e2423001 e1c00003 (ee070f3b)
[   92.609893] mtdoops: Ready 26, 219 (no erase)
[   92.878631] ---[ end trace 6854c4877e56a241 ]---
