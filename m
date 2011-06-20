From: dhylands@gmail.com (Dave Hylands)
Date: Sun, 19 Jun 2011 23:39:49 -0700
Subject: Problems with semaphores, mutexes, and atomic?
Message-ID: <BANLkTikwGgrK0FFiee1a8PvDicJa-bUedg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I wrote a small test module to test semaphores, mutexes and atomic
increments, and I've tested it with CONFIG_SMP=y with 1 and 2
processors and with CONFIG_SMP disabled.

My test code can be found here:
http://svn.hylands.org/linux/test-mutex/test-mutex.c
(it's about 133 lines long).

For each test, I launch 100 threads, and then increment a counter,
either inside a mutex_lock/unlock, a down/up, or do an atomic_inc.

Each thread performs the loop a number of times, and at the end the
count often doesn't have the expected value if the locks were in fact
atomic.

Typical output looks like:

192.168.0.50  ~ # modprobe test-mutex
[   26.220000] Testing mutex...
[   26.230000]     Launching threads ..........
[   26.300000]     Waiting for threads to finish ..........
[   26.310000]   counter = 999888 FAIL
[   26.310000] Testing semaphore...
[   26.310000]     Launching threads ..........
[   26.440000]     Waiting for threads to finish ..........
[   27.810000]   counter = 999575 FAIL
[   27.810000] Testing atomic...
[   27.820000]     Launching threads ..........
[   28.030000]     Waiting for threads to finish ..........
[   28.040000]  counter = 9910929 FAIL

My processor info from /proc/cpuinfo looks like:

192.168.0.50  ~ # cat /proc/cpuinfo
Processor       : ARMv7 Processor rev 5 (v7l)
processor       : 0
BogoMIPS        : 1893.99

processor       : 1
BogoMIPS        : 1893.99

Features        : swp half thumb fastmult vfp edsp neon vfpv3
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x2
CPU part        : 0xc09
CPU revision    : 5

I'm running 2.6.36.3, and some snippets from my boot log:

Uncompressing Linux... done, booting the kernel.
Linux version 2.6.36.3 (dhylands at dave-ubuntu) (gcc version 4.5.1 (GCC)
) #40 SMP PREEMPT Sun Jun 19 13:41:47 PDT 2011
CPU: ARMv7 Processor [412fc095] revision 5 (ARMv7), cr=10c53c7f
CPU: VIPT nonaliasing data cache, VIPT aliasing instruction cache

[    0.280000] CPU: Testing write buffer coherency: ok
[    0.280000] Calibrating local timer... 474.46MHz.
[    0.340000] L310 cache controller enabled
[    0.340000] l2x0: 16 ways, CACHE_ID 0x410000c7, AUX_CTRL 0x7a450000

So given that I'm seeing failures even with CONFIG_SMP disabled, I
have to wonder whether my test is valid, or whether our SoC has issues
some where.

I even tried adding:

    smp_mb();
    dsb();

after acquiring the lock and before releasing the lock, but I still
see failures.

Any feedback would be appreciated, and I can provide more information,
if needed.

-- 
Dave Hylands
Shuswap, BC, Canada
http://www.davehylands.com
