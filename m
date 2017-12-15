From: jbastian@redhat.com (Jeffrey Bastian)
Date: Fri, 15 Dec 2017 16:29:26 -0600
Subject: [PATCH v4 10/12] arm64: vdso: replace gettimeofday.S with global
 vgettimeofday.C
In-Reply-To: <20171121180319.tawkc42jjx4ow3hg@tarantula.localdomain>
References: <20171031183306.81375-1-salyzyn@android.com>
 <7775cc5e-4a24-1e33-aae5-6181ca018d80@android.com>
 <61EF90BA-9A6D-4DC4-A1F4-BEAA210D708C@redhat.com>
 <20171121180319.tawkc42jjx4ow3hg@tarantula.localdomain>
Message-ID: <20171215222926.spj24zrmq7e6yz7h@tarantula.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 21, 2017 at 13:28:13 PST, Mark Salyzyn wrote:
> I ran the test (32 and 64 bit) on my latest work (but back-ported to
> 4.9) and it passes. I did not change __vdso_clock_getres or the fallback
> (syscall) handler in the patch series though, so the failure has me
> wondering. Could you re-run the test with latest to be sure, and I will
> look into setting up to test with a ToT kernel (after the thanksgiving
> break).


I applied your patch set to a 4.14 kernel and ran LTP clock_getres01
(64-bit) and it still passed:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[root at localhost ~]# uname -r
4.14.0-vdsogtod.aarch64

[root at localhost ~]# ./ltp-full-20170929/testcases/kernel/syscalls/clock_getres/clock_getres01
tst_test.c:934: INFO: Timeout per run is 0h 05m 00s
clock_getres01.c:79: PASS: clock_getres(REALTIME, ...) succeeded
clock_getres01.c:79: PASS: clock_getres(MONOTONIC, ...) succeeded
clock_getres01.c:79: PASS: clock_getres(PROCESS_CPUTIME_ID, ...) succeeded
clock_getres01.c:79: PASS: clock_getres(THREAD_CPUTIME_ID, ...) succeeded
clock_getres01.c:79: PASS: clock_getres(REALTIME, ...) succeeded
clock_getres01.c:79: PASS: clock_getres(CLOCK_MONOTONIC_RAW, ...) succeeded
clock_getres01.c:79: PASS: clock_getres(CLOCK_REALTIME_COARSE, ...) succeeded
clock_getres01.c:79: PASS: clock_getres(CLOCK_MONOTONIC_COARSE, ...) succeeded
clock_getres01.c:79: PASS: clock_getres(CLOCK_BOOTTIME, ...) succeeded
clock_getres01.c:64: CONF: clock_getres(CLOCK_REALTIME_ALARM, ...) NO SUPPORTED
clock_getres01.c:64: CONF: clock_getres(CLOCK_BOOTTIME_ALARM, ...) NO SUPPORTED
clock_getres01.c:79: PASS: clock_getres(-1, ...) succeeded

Summary:
passed   10
failed   0
skipped  2
warnings 0
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


I also tried another test (see source below) which sleeps for 0.5
seconds and then verifies that approximately 0.5 seconds passed.  With
the original gettimeofday-in-C patches, it would often fail with weird
elapsed times like 0.1 seconds or 1.1 seconds:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[root at localhost ~]# ./a.out ; echo $?
1: clock_gettime: tv_sec = 1207, tv_nsec = 6403566
Sleeping 0.5 seconds
2: clock_gettime: tv_sec = 1207, tv_nsec = 16512476
Elapsed: 0.10108910
FAIL: elapsed time is not approximately 0.5 seconds
255

[root at localhost ~]# ./a.out ; echo $?
1: clock_gettime: tv_sec = 1215, tv_nsec = 9784545
Sleeping 0.5 seconds
2: clock_gettime: tv_sec = 1216, tv_nsec = 9898595
Elapsed: 1.114050
FAIL: elapsed time is not approximately 0.5 seconds
255

[root at localhost ~]# ./a.out ; echo $?
1: clock_gettime: tv_sec = 1225, tv_nsec = 13710370
Sleeping 0.5 seconds
2: clock_gettime: tv_sec = 1225, tv_nsec = 13819740
Elapsed: 0.109370
FAIL: elapsed time is not approximately 0.5 seconds
255
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


The elapsed time matches the expected 0.5 seconds with the latest patch
version:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[root at localhost ~]# ./a.out ; echo $?
1: clock_gettime: tv_sec = 2077, tv_nsec = 989623095
Sleeping 0.5 seconds
2: clock_gettime: tv_sec = 2078, tv_nsec = 489728070
Elapsed: 0.500104975
PASS
0
[root at localhost ~]# ./a.out ; echo $?
1: clock_gettime: tv_sec = 2079, tv_nsec = 519625035
Sleeping 0.5 seconds
2: clock_gettime: tv_sec = 2080, tv_nsec = 19726365
Elapsed: 0.500101330
PASS
0
[root at localhost ~]# ./a.out ; echo $?
1: clock_gettime: tv_sec = 2080, tv_nsec = 684894725
Sleeping 0.5 seconds
2: clock_gettime: tv_sec = 2081, tv_nsec = 184994605
Elapsed: 0.500099880
PASS
0
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Source for the elapsed time test:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#include <stdio.h>
#include <time.h>

int main(void)
{
    int ret;
    clockid_t clk_id = CLOCK_MONOTONIC_RAW;
    struct timespec tp1, tp2, elapsed;
    struct timespec req, rem;

    ret = clock_gettime(clk_id, &tp1);
    if (ret) {
        perror("ERROR: clock_gettime:");
    }
    printf("1: clock_gettime: tv_sec = %ld, tv_nsec = %lld\n",
           tp1.tv_sec, tp1.tv_nsec);

    printf("Sleeping 0.5 seconds\n");
    req.tv_sec = 0;
    req.tv_nsec = 500000000;
    ret = nanosleep(&req, &rem);
    if (ret) {
        perror("ERROR: nanosleep:");
        printf("       Remaining sleep: tv_sec = %ld, tv_nsec = %lld\n",
               rem.tv_sec, rem.tv_nsec);
    }

    ret = clock_gettime(clk_id, &tp2);
    if (ret) {
        perror("ERROR: clock_gettime:");
    }
    printf("2: clock_gettime: tv_sec = %ld, tv_nsec = %lld\n",
           tp2.tv_sec, tp2.tv_nsec);

    if ((tp2.tv_nsec - tp1.tv_nsec) < 0) {
        elapsed.tv_sec = tp2.tv_sec - tp1.tv_sec - 1;
        elapsed.tv_nsec = 1000000000 + tp2.tv_nsec - tp1.tv_nsec;
    } else {
        elapsed.tv_sec = tp2.tv_sec - tp1.tv_sec;
        elapsed.tv_nsec = tp2.tv_nsec - tp1.tv_nsec;
    }

    printf("Elapsed: %ld.%lld\n", elapsed.tv_sec, elapsed.tv_nsec);

    if (elapsed.tv_sec != 0 ||
        elapsed.tv_nsec < 490000000 ||
        elapsed.tv_nsec > 510000000) {
        printf("FAIL: elapsed time is not approximately 0.5 seconds\n");
        return -1;
    }

    printf("PASS\n");
    return 0;
}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


-- 
Jeff Bastian
Kernel QE - Hardware Enablement
Red Hat
