From: hesham.mahmoud@gmail.com (Hesham Mahmoud)
Date: Tue, 16 Jul 2013 07:11:39 +0000 (UTC)
Subject: Problems with semaphores, mutexes, and atomic?
References: <BANLkTikwGgrK0FFiee1a8PvDicJa-bUedg@mail.gmail.com>
Message-ID: <loom.20130716T090824-983@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Dave Hylands <dhylands <at> gmail.com> writes:

> 
> Hi,
> 
> I wrote a small test module to test semaphores, mutexes and atomic
> increments, and I've tested it with CONFIG_SMP=y with 1 and 2
> processors and with CONFIG_SMP disabled.
> 
> My test code can be found here:
> http://svn.hylands.org/linux/test-mutex/test-mutex.c
> (it's about 133 lines long).
> 
> For each test, I launch 100 threads, and then increment a counter,
> either inside a mutex_lock/unlock, a down/up, or do an atomic_inc.
> 
> Each thread performs the loop a number of times, and at the end the
> count often doesn't have the expected value if the locks were in fact
> atomic.
> 
> Typical output looks like:
> 
> 192.168.0.50  ~ # modprobe test-mutex
> [   26.220000] Testing mutex...
> [   26.230000]     Launching threads ..........
> [   26.300000]     Waiting for threads to finish ..........
> [   26.310000]   counter = 999888 FAIL
> [   26.310000] Testing semaphore...
> [   26.310000]     Launching threads ..........
> [   26.440000]     Waiting for threads to finish ..........
> [   27.810000]   counter = 999575 FAIL
> [   27.810000] Testing atomic...
> [   27.820000]     Launching threads ..........
> [   28.030000]     Waiting for threads to finish ..........
> [   28.040000]  counter = 9910929 FAIL
> 
> My processor info from /proc/cpuinfo looks like:
> 
> 192.168.0.50  ~ # cat /proc/cpuinfo
> Processor       : ARMv7 Processor rev 5 (v7l)
> processor       : 0
> BogoMIPS        : 1893.99
> 
> processor       : 1
> BogoMIPS        : 1893.99
> 
> Features        : swp half thumb fastmult vfp edsp neon vfpv3
> CPU implementer : 0x41
> CPU architecture: 7
> CPU variant     : 0x2
> CPU part        : 0xc09
> CPU revision    : 5
> 
> I'm running 2.6.36.3, and some snippets from my boot log:
> 
> Uncompressing Linux... done, booting the kernel.
> Linux version 2.6.36.3 (dhylands <at> dave-ubuntu) (gcc version 4.5.1 (GCC)
> ) #40 SMP PREEMPT Sun Jun 19 13:41:47 PDT 2011
> CPU: ARMv7 Processor [412fc095] revision 5 (ARMv7), cr=10c53c7f
> CPU: VIPT nonaliasing data cache, VIPT aliasing instruction cache
> 
> [    0.280000] CPU: Testing write buffer coherency: ok
> [    0.280000] Calibrating local timer... 474.46MHz.
> [    0.340000] L310 cache controller enabled
> [    0.340000] l2x0: 16 ways, CACHE_ID 0x410000c7, AUX_CTRL 0x7a450000
> 
> So given that I'm seeing failures even with CONFIG_SMP disabled, I
> have to wonder whether my test is valid, or whether our SoC has issues
> some where.
> 
> I even tried adding:
> 
>     smp_mb();
>     dsb();
> 
> after acquiring the lock and before releasing the lock, but I still
> see failures.
> 
> Any feedback would be appreciated, and I can provide more information,
> if needed.
> 

I ran this test on a PC. It gave me a FAILED result. I fixed it by
initializing the thread_Wait semaphore to locked state. It worked fine.

Failed:

Jul 16 02:57:12 ubuntu kernel: [ 1837.858846] Testing mutex...
Jul 16 02:57:12 ubuntu kernel: [ 1837.858868]     Launching threads .
Jul 16 02:57:12 ubuntu kernel: [ 1837.876590]     Waiting for threads to
finish .
Jul 16 02:57:12 ubuntu kernel: [ 1837.876652]   counter = 90000 FAIL
Jul 16 02:57:12 ubuntu kernel: [ 1837.876660] Testing semaphore...
Jul 16 02:57:12 ubuntu kernel: [ 1837.876688]     Launching threads .
Jul 16 02:57:12 ubuntu kernel: [ 1837.901929]     Waiting for threads to
finish .
Jul 16 02:57:12 ubuntu kernel: [ 1837.901956]   counter = 90000 FAIL
Jul 16 02:57:12 ubuntu kernel: [ 1837.901966] Testing atomic...
Jul 16 02:57:12 ubuntu kernel: [ 1837.901974]     Launching threads .
Jul 16 02:57:12 ubuntu kernel: [ 1837.931911]     Waiting for threads to
finish .
Jul 16 02:57:12 ubuntu kernel: [ 1837.931938]  counter = 900000 FAIL


Passed:
Jul 16 03:08:22 ubuntu kernel: [ 2507.982633] test_mutex_exit: called
Jul 16 03:11:06 ubuntu kernel: [ 2671.515674] Testing mutex...
Jul 16 03:11:06 ubuntu kernel: [ 2671.515700]     Launching threads ..........
Jul 16 03:11:06 ubuntu kernel: [ 2671.607958]     Waiting for threads to
finish ..........
Jul 16 03:11:06 ubuntu kernel: [ 2671.609115]   counter = 1000000 Pass
Jul 16 03:11:06 ubuntu kernel: [ 2671.609125] Testing semaphore...
Jul 16 03:11:06 ubuntu kernel: [ 2671.609153]     Launching threads ..........
Jul 16 03:11:06 ubuntu kernel: [ 2671.743826]     Waiting for threads to
finish ..........
Jul 16 03:11:06 ubuntu kernel: [ 2671.745109]   counter = 1000000 Pass
Jul 16 03:11:06 ubuntu kernel: [ 2671.745119] Testing atomic...
Jul 16 03:11:06 ubuntu kernel: [ 2671.745127]     Launching threads ..........
Jul 16 03:11:06 ubuntu kernel: [ 2671.950545]     Waiting for threads to
finish ..........
Jul 16 03:11:06 ubuntu kernel: [ 2671.952532]  counter = 10000000 Pass

$ uname -r
2.6.32-34-generic

Thanks,
-Hesham
