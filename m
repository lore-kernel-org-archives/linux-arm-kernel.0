From: w@1wt.eu (Willy Tarreau)
Date: Sat, 13 Jul 2013 19:24:45 +0200
Subject: Call for testing/opinions: Optimized memset/memcpy
In-Reply-To: <loom.20130713T172357-560@post.gmane.org>
References: <loom.20130713T172357-560@post.gmane.org>
Message-ID: <20130713172445.GL32054@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Harm,

On Sat, Jul 13, 2013 at 03:51:07PM +0000, Harm Hanemaaijer wrote:
> Hello,
> 
> I've been doing some work on optimizing the memset/memcpy family of
> functions for modern ARM platforms, including copy_page, memset,
> memzero, memcpy, copy_from_user and copy_to_user. It appears that
> there is room for improvement, especially with regard to using an
> optimal preload strategy for armv6/v7 architectures as well as
> aligning the write target. For example, on an armv6-based platform
> (RPi) I am seeing a 80% speed-up in copy_page and large sized
> memcpy. Gains in the range 10-25% are seen on a Cortex A8 device.

Interesting, especially for devices that have a narrow DDR bus where
we want to shave every possible bus cycle!

(...)
> So in short, I am looking for opinions, and test results especially
> from the userspace benchmark, to see the relative merit of these
> optimizations on different platforms.

OK I've run bench.script on the following platforms :

  - Snowball board : it is a dual-core 1GHz cortex-a9 from STE (A9500).
    It has some 32-bit LPDDR2 soldered on the CPU (package on package).
    The test ran only in ARMv7 mode.

    root at snowball:tmp# cat /proc/cpuinfo 
    processor       : 0
    model name      : ARMv7 Processor rev 1 (v7l)
    BogoMIPS        : 4.80
    Features        : swp half thumb fastmult vfp edsp neon vfpv3 tls 
    CPU implementer : 0x41
    CPU architecture: 7
    CPU variant     : 0x2
    CPU part        : 0xc09
    CPU revision    : 1

  - Armada XP-GP board : it's a quad-core 1.6 GHz Marvell Armada-XP (PJ4Bv2)
    CPU. It has 64-bit DDR3-1600 RAM on a DIMM. The tests were run in ARMv7
    and Thumb2 modes. The difference was not impressive between the two
    modes.

    root at xpgp:tmp# cat /proc/cpuinfo 
    processor       : 0
    model name      : ARMv7 Processor rev 2 (v7l)
    BogoMIPS        : 1594.16
    Features        : swp half thumb fastmult vfp edsp vfpv3 tls idiva idivt 
    CPU implementer : 0x56
    CPU architecture: 7
    CPU variant     : 0x2
    CPU part        : 0x584
    CPU revision    : 2

  - Mirabox : single-core 1.2 GHz Marvell Armada370 (PJ4B) CPU. It uses
    16-bit DDR3-1200 soldered onboard. The tests were run in ARMv7 and
    Thumb2 modes. It can be useful to compare with the xp-gp above because
    its CPU can be seen as a scaled down version of the previous one, with
    1/4 of the DRAM bus width, and both have the DRAM at half CPU frequency.

    root at mirabox:tmp# cat /proc/cpuinfo 
    processor       : 0
    model name      : ARMv7 Processor rev 1 (v7l)
    BogoMIPS        : 597.60
    Features        : swp half thumb fastmult vfp edsp vfpv3 vfpv3d16 tls idivt 
    CPU implementer : 0x56
    CPU architecture: 7
    CPU variant     : 0x1
    CPU part        : 0x581
    CPU revision    : 1

I'm attaching all the results.

Hoping this helps,
Willy

-------------- next part --------------
libc memcpy:
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 599.89 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 600.57 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 597.81 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 598.70 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 595.39 MB/s
kernel memcpy (original):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 618.28 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 615.10 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 618.15 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 615.02 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 621.19 MB/s
kernel memcpy (optimized):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 618.03 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 612.97 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 614.82 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 611.68 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 616.50 MB/s
libc memcpy:
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 363.92 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 365.71 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 363.92 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 365.73 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 365.63 MB/s
kernel memcpy (original):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 381.35 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 383.49 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 381.49 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 383.32 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 381.47 MB/s
kernel memcpy (optimized):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 426.75 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 426.75 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 426.75 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 426.69 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 424.72 MB/s
libc memcpy:
Mixed multiples of 4 from 4 to 130, word aligned: 311.75 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 310.30 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 311.74 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 310.22 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 311.76 MB/s
kernel memcpy (original):
Mixed multiples of 4 from 4 to 130, word aligned: 327.84 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 327.89 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 327.87 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 326.25 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 327.87 MB/s
kernel memcpy (optimized):
Mixed multiples of 4 from 4 to 130, word aligned: 364.50 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 366.29 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 364.51 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 366.24 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 366.31 MB/s
kernel copy_from_user (optimized):
Mixed multiples of 4 from 4 to 130, word aligned: 361.11 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 362.86 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 361.10 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 362.86 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 361.13 MB/s
kernel copy_to_user (optimized):
Mixed multiples of 4 from 4 to 130, word aligned: 366.61 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 364.79 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 366.56 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 366.60 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 364.84 MB/s
libc memcpy:
4096 bytes page aligned: 356.71 MB/s
4096 bytes page aligned: 355.04 MB/s
4096 bytes page aligned: 356.67 MB/s
4096 bytes page aligned: 354.98 MB/s
4096 bytes page aligned: 356.68 MB/s
kernel memcpy (original):
4096 bytes page aligned: 355.32 MB/s
4096 bytes page aligned: 356.96 MB/s
4096 bytes page aligned: 355.31 MB/s
4096 bytes page aligned: 357.01 MB/s
4096 bytes page aligned: 355.30 MB/s
kernel memcpy (optimized):
4096 bytes page aligned: 341.05 MB/s
4096 bytes page aligned: 339.37 MB/s
4096 bytes page aligned: 341.04 MB/s
4096 bytes page aligned: 339.37 MB/s
4096 bytes page aligned: 341.03 MB/s
kernel copy_page (original):
4096 bytes page aligned: 382.31 MB/s
4096 bytes page aligned: 384.19 MB/s
4096 bytes page aligned: 382.29 MB/s
4096 bytes page aligned: 384.25 MB/s
4096 bytes page aligned: 382.30 MB/s
kernel copy_page (optimized):
4096 bytes page aligned: 340.55 MB/s
4096 bytes page aligned: 338.96 MB/s
4096 bytes page aligned: 340.60 MB/s
4096 bytes page aligned: 338.96 MB/s
4096 bytes page aligned: 340.56 MB/s
libc memcpy:
Mixed from 1 to 1023 (power law), unaligned: 513.06 MB/s
Mixed from 1 to 1023 (power law), unaligned: 513.02 MB/s
Mixed from 1 to 1023 (power law), unaligned: 512.94 MB/s
Mixed from 1 to 1023 (power law), unaligned: 510.37 MB/s
Mixed from 1 to 1023 (power law), unaligned: 513.35 MB/s
kernel memcpy (original):
Mixed from 1 to 1023 (power law), unaligned: 532.66 MB/s
Mixed from 1 to 1023 (power law), unaligned: 535.20 MB/s
Mixed from 1 to 1023 (power law), unaligned: 532.29 MB/s
Mixed from 1 to 1023 (power law), unaligned: 535.41 MB/s
Mixed from 1 to 1023 (power law), unaligned: 535.59 MB/s
kernel memcpy (optimized):
Mixed from 1 to 1023 (power law), unaligned: 528.33 MB/s
Mixed from 1 to 1023 (power law), unaligned: 531.12 MB/s
Mixed from 1 to 1023 (power law), unaligned: 527.64 MB/s
Mixed from 1 to 1023 (power law), unaligned: 530.72 MB/s
Mixed from 1 to 1023 (power law), unaligned: 528.05 MB/s
libc memset:
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 888.47 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 884.25 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 888.42 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 888.49 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 884.05 MB/s
kernel memset (original):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 962.84 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 958.71 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 963.20 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 958.83 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 962.86 MB/s
kernel memset (optimized):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1004.37 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 999.61 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1004.49 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 999.43 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1004.46 MB/s
kernel memzero (original):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 922.59 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 926.98 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 926.99 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 922.46 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 927.07 MB/s
kernel memzero (optimized):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 930.00 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 934.53 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 930.89 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 935.60 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 935.32 MB/s
libc memset:
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 520.37 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 520.42 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 517.93 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 520.36 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 517.84 MB/s
kernel memset (original):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 594.94 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 591.54 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 594.39 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 594.45 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 591.58 MB/s
kernel memset (optimized):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 658.84 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 655.68 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 658.78 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 655.58 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 658.85 MB/s
kernel memzero (original):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 567.21 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 569.94 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 569.92 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 567.08 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 569.93 MB/s
kernel memzero (optimized):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 586.06 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 588.64 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 585.75 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 588.86 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 588.66 MB/s
libc memset:
4096 bytes page aligned: 2052.77 MB/s
4096 bytes page aligned: 2052.69 MB/s
4096 bytes page aligned: 2042.84 MB/s
4096 bytes page aligned: 2052.72 MB/s
4096 bytes page aligned: 2042.30 MB/s
kernel memset (original):
4096 bytes page aligned: 1920.98 MB/s
4096 bytes page aligned: 1911.66 MB/s
4096 bytes page aligned: 1921.13 MB/s
4096 bytes page aligned: 1921.17 MB/s
4096 bytes page aligned: 1911.92 MB/s
kernel memset (optimized):
4096 bytes page aligned: 1900.46 MB/s
4096 bytes page aligned: 1891.21 MB/s
4096 bytes page aligned: 1900.52 MB/s
4096 bytes page aligned: 1891.16 MB/s
4096 bytes page aligned: 1900.64 MB/s
kernel memzero (original):
4096 bytes page aligned: 1910.57 MB/s
4096 bytes page aligned: 1920.05 MB/s
4096 bytes page aligned: 1920.02 MB/s
4096 bytes page aligned: 1910.87 MB/s
4096 bytes page aligned: 1920.06 MB/s
kernel memzero (optimized):
4096 bytes page aligned: 1917.74 MB/s
4096 bytes page aligned: 1927.05 MB/s
4096 bytes page aligned: 1917.28 MB/s
4096 bytes page aligned: 1927.11 MB/s
4096 bytes page aligned: 1926.87 MB/s
libc memset:
Mixed from 1 to 1023 (power law), unaligned: 759.37 MB/s
Mixed from 1 to 1023 (power law), unaligned: 759.42 MB/s
Mixed from 1 to 1023 (power law), unaligned: 755.88 MB/s
Mixed from 1 to 1023 (power law), unaligned: 759.32 MB/s
Mixed from 1 to 1023 (power law), unaligned: 756.04 MB/s
kernel memset (original):
Mixed from 1 to 1023 (power law), unaligned: 802.77 MB/s
Mixed from 1 to 1023 (power law), unaligned: 798.89 MB/s
Mixed from 1 to 1023 (power law), unaligned: 801.62 MB/s
Mixed from 1 to 1023 (power law), unaligned: 802.67 MB/s
Mixed from 1 to 1023 (power law), unaligned: 798.07 MB/s
kernel memset (optimized):
Mixed from 1 to 1023 (power law), unaligned: 862.50 MB/s
Mixed from 1 to 1023 (power law), unaligned: 857.72 MB/s
Mixed from 1 to 1023 (power law), unaligned: 862.52 MB/s
Mixed from 1 to 1023 (power law), unaligned: 857.00 MB/s
Mixed from 1 to 1023 (power law), unaligned: 860.71 MB/s
kernel memzero (original):
Mixed from 1 to 1023 (power law), unaligned: 784.48 MB/s
Mixed from 1 to 1023 (power law), unaligned: 780.41 MB/s
Mixed from 1 to 1023 (power law), unaligned: 784.97 MB/s
Mixed from 1 to 1023 (power law), unaligned: 781.14 MB/s
Mixed from 1 to 1023 (power law), unaligned: 783.99 MB/s
kernel memzero (optimized):
Mixed from 1 to 1023 (power law), unaligned: 793.48 MB/s
Mixed from 1 to 1023 (power law), unaligned: 796.39 MB/s
Mixed from 1 to 1023 (power law), unaligned: 792.86 MB/s
Mixed from 1 to 1023 (power law), unaligned: 796.20 MB/s
Mixed from 1 to 1023 (power law), unaligned: 796.68 MB/s
-------------- next part --------------
libc memcpy:
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 614.78 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 618.39 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 614.90 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 618.16 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 614.83 MB/s
kernel memcpy (original):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 654.11 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 650.60 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 653.49 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 653.81 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 649.56 MB/s
kernel memcpy (optimized):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 653.09 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 650.86 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 653.72 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 650.74 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 653.71 MB/s
libc memcpy:
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 332.22 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 333.86 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 332.22 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 333.86 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 333.77 MB/s
kernel memcpy (original):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 365.63 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 365.65 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 363.96 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 365.63 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 363.95 MB/s
kernel memcpy (optimized):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 403.08 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 401.21 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 403.06 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 401.23 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 403.02 MB/s
libc memcpy:
Mixed multiples of 4 from 4 to 130, word aligned: 293.84 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 293.87 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 293.79 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 292.46 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 293.78 MB/s
kernel memcpy (original):
Mixed multiples of 4 from 4 to 130, word aligned: 312.63 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 314.11 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 312.64 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 314.05 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 312.63 MB/s
kernel memcpy (optimized):
Mixed multiples of 4 from 4 to 130, word aligned: 347.08 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 345.40 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 347.01 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 347.06 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 347.05 MB/s
kernel copy_from_user (optimized):
Mixed multiples of 4 from 4 to 130, word aligned: 338.99 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 337.42 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 338.96 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 337.42 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 339.07 MB/s
kernel copy_to_user (optimized):
Mixed multiples of 4 from 4 to 130, word aligned: 336.61 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 338.16 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 336.61 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 338.21 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 336.58 MB/s
libc memcpy:
4096 bytes page aligned: 358.08 MB/s
4096 bytes page aligned: 356.32 MB/s
4096 bytes page aligned: 358.07 MB/s
4096 bytes page aligned: 356.39 MB/s
4096 bytes page aligned: 358.08 MB/s
kernel memcpy (original):
4096 bytes page aligned: 356.76 MB/s
4096 bytes page aligned: 358.47 MB/s
4096 bytes page aligned: 356.76 MB/s
4096 bytes page aligned: 358.47 MB/s
4096 bytes page aligned: 356.86 MB/s
kernel memcpy (optimized):
4096 bytes page aligned: 342.33 MB/s
4096 bytes page aligned: 340.66 MB/s
4096 bytes page aligned: 342.32 MB/s
4096 bytes page aligned: 340.70 MB/s
4096 bytes page aligned: 342.31 MB/s
kernel copy_page (original):
4096 bytes page aligned: 381.93 MB/s
4096 bytes page aligned: 383.87 MB/s
4096 bytes page aligned: 381.97 MB/s
4096 bytes page aligned: 383.86 MB/s
4096 bytes page aligned: 381.98 MB/s
kernel copy_page (optimized):
4096 bytes page aligned: 341.86 MB/s
4096 bytes page aligned: 341.83 MB/s
4096 bytes page aligned: 341.86 MB/s
4096 bytes page aligned: 341.80 MB/s
4096 bytes page aligned: 341.85 MB/s
libc memcpy:
Mixed from 1 to 1023 (power law), unaligned: 484.57 MB/s
Mixed from 1 to 1023 (power law), unaligned: 482.42 MB/s
Mixed from 1 to 1023 (power law), unaligned: 484.45 MB/s
Mixed from 1 to 1023 (power law), unaligned: 482.49 MB/s
Mixed from 1 to 1023 (power law), unaligned: 484.27 MB/s
kernel memcpy (original):
Mixed from 1 to 1023 (power law), unaligned: 503.45 MB/s
Mixed from 1 to 1023 (power law), unaligned: 505.11 MB/s
Mixed from 1 to 1023 (power law), unaligned: 502.65 MB/s
Mixed from 1 to 1023 (power law), unaligned: 505.09 MB/s
Mixed from 1 to 1023 (power law), unaligned: 502.69 MB/s
kernel memcpy (optimized):
Mixed from 1 to 1023 (power law), unaligned: 490.07 MB/s
Mixed from 1 to 1023 (power law), unaligned: 490.26 MB/s
Mixed from 1 to 1023 (power law), unaligned: 486.98 MB/s
Mixed from 1 to 1023 (power law), unaligned: 489.95 MB/s
Mixed from 1 to 1023 (power law), unaligned: 487.95 MB/s
libc memset:
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 844.51 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 840.39 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 844.37 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 840.68 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 844.55 MB/s
kernel memset (original):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 886.05 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 890.19 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 890.11 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 885.76 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 889.84 MB/s
kernel memset (optimized):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 930.57 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 934.93 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 930.50 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 934.75 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 930.35 MB/s
kernel memzero (original):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 860.46 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 860.40 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 860.34 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 860.40 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 856.31 MB/s
kernel memzero (optimized):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 881.67 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 877.42 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 881.60 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 877.48 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 881.70 MB/s
libc memset:
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 496.66 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 499.04 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 498.98 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 496.62 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 498.96 MB/s
kernel memset (original):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 551.78 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 554.33 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 551.63 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 554.13 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 551.60 MB/s
kernel memset (optimized):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 601.07 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 597.87 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 601.06 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 601.08 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 598.38 MB/s
kernel memzero (original):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 525.40 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 522.99 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 525.42 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 522.74 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 525.28 MB/s
kernel memzero (optimized):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 556.46 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 559.02 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 559.16 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 559.00 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 559.13 MB/s
libc memset:
4096 bytes page aligned: 2029.13 MB/s
4096 bytes page aligned: 2038.87 MB/s
4096 bytes page aligned: 2029.11 MB/s
4096 bytes page aligned: 2038.82 MB/s
4096 bytes page aligned: 2028.82 MB/s
kernel memset (original):
4096 bytes page aligned: 1918.99 MB/s
4096 bytes page aligned: 1909.79 MB/s
4096 bytes page aligned: 1919.03 MB/s
4096 bytes page aligned: 1918.82 MB/s
4096 bytes page aligned: 1918.96 MB/s
kernel memset (optimized):
4096 bytes page aligned: 1920.02 MB/s
4096 bytes page aligned: 1910.71 MB/s
4096 bytes page aligned: 1920.03 MB/s
4096 bytes page aligned: 1910.58 MB/s
4096 bytes page aligned: 1919.89 MB/s
kernel memzero (original):
4096 bytes page aligned: 1885.37 MB/s
4096 bytes page aligned: 1894.53 MB/s
4096 bytes page aligned: 1885.11 MB/s
4096 bytes page aligned: 1894.52 MB/s
4096 bytes page aligned: 1894.52 MB/s
kernel memzero (optimized):
4096 bytes page aligned: 1895.10 MB/s
4096 bytes page aligned: 1894.72 MB/s
4096 bytes page aligned: 1885.82 MB/s
4096 bytes page aligned: 1895.08 MB/s
4096 bytes page aligned: 1885.86 MB/s
libc memset:
Mixed from 1 to 1023 (power law), unaligned: 737.90 MB/s
Mixed from 1 to 1023 (power law), unaligned: 734.13 MB/s
Mixed from 1 to 1023 (power law), unaligned: 737.61 MB/s
Mixed from 1 to 1023 (power law), unaligned: 734.18 MB/s
Mixed from 1 to 1023 (power law), unaligned: 737.53 MB/s
kernel memset (original):
Mixed from 1 to 1023 (power law), unaligned: 786.00 MB/s
Mixed from 1 to 1023 (power law), unaligned: 786.00 MB/s
Mixed from 1 to 1023 (power law), unaligned: 785.98 MB/s
Mixed from 1 to 1023 (power law), unaligned: 782.09 MB/s
Mixed from 1 to 1023 (power law), unaligned: 785.96 MB/s
kernel memset (optimized):
Mixed from 1 to 1023 (power law), unaligned: 813.68 MB/s
Mixed from 1 to 1023 (power law), unaligned: 817.65 MB/s
Mixed from 1 to 1023 (power law), unaligned: 813.22 MB/s
Mixed from 1 to 1023 (power law), unaligned: 817.10 MB/s
Mixed from 1 to 1023 (power law), unaligned: 813.94 MB/s
kernel memzero (original):
Mixed from 1 to 1023 (power law), unaligned: 746.57 MB/s
Mixed from 1 to 1023 (power law), unaligned: 746.77 MB/s
Mixed from 1 to 1023 (power law), unaligned: 742.82 MB/s
Mixed from 1 to 1023 (power law), unaligned: 746.56 MB/s
Mixed from 1 to 1023 (power law), unaligned: 743.25 MB/s
kernel memzero (optimized):
Mixed from 1 to 1023 (power law), unaligned: 785.01 MB/s
Mixed from 1 to 1023 (power law), unaligned: 781.21 MB/s
Mixed from 1 to 1023 (power law), unaligned: 785.10 MB/s
Mixed from 1 to 1023 (power law), unaligned: 781.19 MB/s
Mixed from 1 to 1023 (power law), unaligned: 784.99 MB/s
-------------- next part --------------
libc memcpy:
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 944.06 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 939.55 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 936.32 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 938.91 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 935.52 MB/s
kernel memcpy (original):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 921.58 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 918.61 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 915.82 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 915.27 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 911.62 MB/s
kernel memcpy (optimized):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 908.06 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 905.13 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 907.52 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 906.64 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 907.89 MB/s
libc memcpy:
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 547.23 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 547.29 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 546.17 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 547.24 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 547.50 MB/s
kernel memcpy (original):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 541.90 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 541.91 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 541.93 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 542.91 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 541.95 MB/s
kernel memcpy (optimized):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 615.08 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 614.48 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 615.11 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 615.07 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 614.90 MB/s
libc memcpy:
Mixed multiples of 4 from 4 to 130, word aligned: 459.28 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 459.87 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 459.40 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 459.62 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 459.40 MB/s
kernel memcpy (original):
Mixed multiples of 4 from 4 to 130, word aligned: 457.91 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 458.35 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 457.98 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 458.22 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 457.85 MB/s
kernel memcpy (optimized):
Mixed multiples of 4 from 4 to 130, word aligned: 545.62 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 544.90 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 545.52 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 545.42 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 545.54 MB/s
kernel copy_from_user (optimized):
Mixed multiples of 4 from 4 to 130, word aligned: 485.72 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 484.69 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 484.78 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 485.02 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 485.64 MB/s
kernel copy_to_user (optimized):
Mixed multiples of 4 from 4 to 130, word aligned: 489.08 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 491.05 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 492.40 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 493.27 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 491.08 MB/s
libc memcpy:
4096 bytes page aligned: 1027.53 MB/s
4096 bytes page aligned: 1020.33 MB/s
4096 bytes page aligned: 1026.20 MB/s
4096 bytes page aligned: 1025.76 MB/s
4096 bytes page aligned: 1024.70 MB/s
kernel memcpy (original):
4096 bytes page aligned: 1026.80 MB/s
4096 bytes page aligned: 1027.25 MB/s
4096 bytes page aligned: 1026.46 MB/s
4096 bytes page aligned: 1020.09 MB/s
4096 bytes page aligned: 1027.83 MB/s
kernel memcpy (optimized):
4096 bytes page aligned: 841.49 MB/s
4096 bytes page aligned: 847.07 MB/s
4096 bytes page aligned: 840.32 MB/s
4096 bytes page aligned: 847.07 MB/s
4096 bytes page aligned: 841.32 MB/s
kernel copy_page (original):
4096 bytes page aligned: 948.27 MB/s
4096 bytes page aligned: 940.34 MB/s
4096 bytes page aligned: 946.30 MB/s
4096 bytes page aligned: 942.02 MB/s
4096 bytes page aligned: 948.32 MB/s
kernel copy_page (optimized):
4096 bytes page aligned: 850.59 MB/s
4096 bytes page aligned: 857.73 MB/s
4096 bytes page aligned: 851.24 MB/s
4096 bytes page aligned: 858.75 MB/s
4096 bytes page aligned: 851.73 MB/s
libc memcpy:
Mixed from 1 to 1023 (power law), unaligned: 715.47 MB/s
Mixed from 1 to 1023 (power law), unaligned: 714.09 MB/s
Mixed from 1 to 1023 (power law), unaligned: 715.65 MB/s
Mixed from 1 to 1023 (power law), unaligned: 714.83 MB/s
Mixed from 1 to 1023 (power law), unaligned: 712.47 MB/s
kernel memcpy (original):
Mixed from 1 to 1023 (power law), unaligned: 721.70 MB/s
Mixed from 1 to 1023 (power law), unaligned: 719.15 MB/s
Mixed from 1 to 1023 (power law), unaligned: 721.34 MB/s
Mixed from 1 to 1023 (power law), unaligned: 718.81 MB/s
Mixed from 1 to 1023 (power law), unaligned: 721.02 MB/s
kernel memcpy (optimized):
Mixed from 1 to 1023 (power law), unaligned: 635.79 MB/s
Mixed from 1 to 1023 (power law), unaligned: 636.97 MB/s
Mixed from 1 to 1023 (power law), unaligned: 635.52 MB/s
Mixed from 1 to 1023 (power law), unaligned: 636.23 MB/s
Mixed from 1 to 1023 (power law), unaligned: 636.05 MB/s
libc memset:
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1323.49 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1326.82 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1348.12 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1328.57 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1324.56 MB/s
kernel memset (original):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1786.48 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1782.46 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1776.21 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1745.68 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1771.53 MB/s
kernel memset (optimized):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1770.77 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1759.21 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1721.21 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1782.98 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1762.74 MB/s
kernel memzero (original):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1745.20 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1763.23 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1743.48 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1766.37 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1728.34 MB/s
kernel memzero (optimized):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1682.73 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1660.62 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1695.76 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1703.42 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1766.86 MB/s
libc memset:
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 901.11 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 901.81 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 889.89 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 886.94 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 899.02 MB/s
kernel memset (original):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1142.87 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1145.74 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1141.91 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1142.41 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1143.23 MB/s
kernel memset (optimized):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1129.60 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1132.20 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1131.63 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1131.37 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1128.10 MB/s
kernel memzero (original):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1110.96 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1105.10 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1106.56 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1107.89 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1105.29 MB/s
kernel memzero (optimized):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1081.12 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1086.37 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1086.06 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1086.13 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1085.48 MB/s
libc memset:
4096 bytes page aligned: 1371.96 MB/s
4096 bytes page aligned: 1362.53 MB/s
4096 bytes page aligned: 1383.10 MB/s
4096 bytes page aligned: 1356.89 MB/s
4096 bytes page aligned: 1367.61 MB/s
kernel memset (original):
4096 bytes page aligned: 1321.56 MB/s
4096 bytes page aligned: 1337.12 MB/s
4096 bytes page aligned: 1318.98 MB/s
4096 bytes page aligned: 1330.80 MB/s
4096 bytes page aligned: 1324.66 MB/s
kernel memset (optimized):
4096 bytes page aligned: 1317.07 MB/s
4096 bytes page aligned: 1305.07 MB/s
4096 bytes page aligned: 1311.78 MB/s
4096 bytes page aligned: 1301.32 MB/s
4096 bytes page aligned: 1305.47 MB/s
kernel memzero (original):
4096 bytes page aligned: 1320.70 MB/s
4096 bytes page aligned: 1317.15 MB/s
4096 bytes page aligned: 1380.78 MB/s
4096 bytes page aligned: 1316.34 MB/s
4096 bytes page aligned: 1363.25 MB/s
kernel memzero (optimized):
4096 bytes page aligned: 1302.89 MB/s
4096 bytes page aligned: 1349.68 MB/s
4096 bytes page aligned: 1305.33 MB/s
4096 bytes page aligned: 1338.91 MB/s
4096 bytes page aligned: 1304.71 MB/s
libc memset:
Mixed from 1 to 1023 (power law), unaligned: 1296.85 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1281.93 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1284.15 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1303.82 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1289.72 MB/s
kernel memset (original):
Mixed from 1 to 1023 (power law), unaligned: 1635.98 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1631.05 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1630.50 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1629.33 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1640.34 MB/s
kernel memset (optimized):
Mixed from 1 to 1023 (power law), unaligned: 1674.27 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1661.84 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1670.77 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1656.26 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1664.30 MB/s
kernel memzero (original):
Mixed from 1 to 1023 (power law), unaligned: 1583.12 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1576.78 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1579.13 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1571.27 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1554.87 MB/s
kernel memzero (optimized):
Mixed from 1 to 1023 (power law), unaligned: 1613.16 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1624.66 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1613.26 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1624.16 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1611.64 MB/s
-------------- next part --------------
libc memcpy:
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 938.28 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 938.13 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 938.22 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 937.87 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 938.26 MB/s
kernel memcpy (original):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 992.48 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 992.77 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 992.53 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 992.82 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 992.45 MB/s
kernel memcpy (optimized):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 869.57 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 870.32 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 869.57 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 870.32 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 869.65 MB/s
libc memcpy:
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 506.25 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 506.18 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 506.17 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 506.16 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 506.19 MB/s
kernel memcpy (original):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 542.36 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 542.08 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 541.74 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 542.09 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 542.71 MB/s
kernel memcpy (optimized):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 568.31 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 567.96 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 567.96 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 567.81 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 567.88 MB/s
libc memcpy:
Mixed multiples of 4 from 4 to 130, word aligned: 425.27 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 425.41 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 425.29 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 426.54 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 425.58 MB/s
kernel memcpy (original):
Mixed multiples of 4 from 4 to 130, word aligned: 458.17 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 458.13 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 458.73 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 458.32 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 458.95 MB/s
kernel memcpy (optimized):
Mixed multiples of 4 from 4 to 130, word aligned: 503.75 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 503.23 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 503.38 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 502.87 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 503.40 MB/s
kernel copy_from_user (optimized):
Mixed multiples of 4 from 4 to 130, word aligned: 486.47 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 485.02 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 485.65 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 485.20 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 485.11 MB/s
kernel copy_to_user (optimized):
Mixed multiples of 4 from 4 to 130, word aligned: 456.43 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 455.72 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 455.60 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 455.58 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 456.06 MB/s
libc memcpy:
4096 bytes page aligned: 2733.85 MB/s
4096 bytes page aligned: 2734.82 MB/s
4096 bytes page aligned: 2735.47 MB/s
4096 bytes page aligned: 2733.74 MB/s
4096 bytes page aligned: 2735.10 MB/s
kernel memcpy (original):
4096 bytes page aligned: 2763.15 MB/s
4096 bytes page aligned: 2764.57 MB/s
4096 bytes page aligned: 2762.87 MB/s
4096 bytes page aligned: 2764.31 MB/s
4096 bytes page aligned: 2763.97 MB/s
kernel memcpy (optimized):
4096 bytes page aligned: 2021.61 MB/s
4096 bytes page aligned: 2022.85 MB/s
4096 bytes page aligned: 2021.30 MB/s
4096 bytes page aligned: 2022.75 MB/s
4096 bytes page aligned: 2021.18 MB/s
kernel copy_page (original):
4096 bytes page aligned: 1536.64 MB/s
4096 bytes page aligned: 1536.07 MB/s
4096 bytes page aligned: 1536.62 MB/s
4096 bytes page aligned: 1536.44 MB/s
4096 bytes page aligned: 1536.04 MB/s
kernel copy_page (optimized):
4096 bytes page aligned: 2029.46 MB/s
4096 bytes page aligned: 2028.46 MB/s
4096 bytes page aligned: 2029.26 MB/s
4096 bytes page aligned: 2028.49 MB/s
4096 bytes page aligned: 2029.51 MB/s
libc memcpy:
Mixed from 1 to 1023 (power law), unaligned: 677.42 MB/s
Mixed from 1 to 1023 (power law), unaligned: 677.45 MB/s
Mixed from 1 to 1023 (power law), unaligned: 677.43 MB/s
Mixed from 1 to 1023 (power law), unaligned: 677.49 MB/s
Mixed from 1 to 1023 (power law), unaligned: 677.55 MB/s
kernel memcpy (original):
Mixed from 1 to 1023 (power law), unaligned: 705.91 MB/s
Mixed from 1 to 1023 (power law), unaligned: 705.96 MB/s
Mixed from 1 to 1023 (power law), unaligned: 706.14 MB/s
Mixed from 1 to 1023 (power law), unaligned: 706.18 MB/s
Mixed from 1 to 1023 (power law), unaligned: 706.32 MB/s
kernel memcpy (optimized):
Mixed from 1 to 1023 (power law), unaligned: 671.04 MB/s
Mixed from 1 to 1023 (power law), unaligned: 671.49 MB/s
Mixed from 1 to 1023 (power law), unaligned: 671.19 MB/s
Mixed from 1 to 1023 (power law), unaligned: 671.87 MB/s
Mixed from 1 to 1023 (power law), unaligned: 671.50 MB/s
libc memset:
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1288.97 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1288.99 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1288.74 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1288.95 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1288.51 MB/s
kernel memset (original):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1698.82 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1695.12 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1695.28 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1699.55 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1698.91 MB/s
kernel memset (optimized):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1826.35 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1826.33 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1833.66 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1833.25 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1834.97 MB/s
kernel memzero (original):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1608.61 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1603.63 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1606.36 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1608.51 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1607.49 MB/s
kernel memzero (optimized):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1654.00 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1653.34 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1653.09 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1647.16 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1653.98 MB/s
libc memset:
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 779.98 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 780.05 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 779.98 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 780.09 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 779.82 MB/s
kernel memset (original):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 971.07 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 969.65 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 969.63 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 969.63 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 969.45 MB/s
kernel memset (optimized):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1166.68 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1166.31 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1166.68 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1166.41 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1166.45 MB/s
kernel memzero (original):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 915.94 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 915.88 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 916.08 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 915.77 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 915.94 MB/s
kernel memzero (optimized):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 980.79 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 981.17 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 981.46 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 981.44 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 981.17 MB/s
libc memset:
4096 bytes page aligned: 2808.48 MB/s
4096 bytes page aligned: 2809.23 MB/s
4096 bytes page aligned: 2809.10 MB/s
4096 bytes page aligned: 2808.32 MB/s
4096 bytes page aligned: 2808.85 MB/s
kernel memset (original):
4096 bytes page aligned: 4285.77 MB/s
4096 bytes page aligned: 4286.95 MB/s
4096 bytes page aligned: 4285.80 MB/s
4096 bytes page aligned: 4287.03 MB/s
4096 bytes page aligned: 4286.30 MB/s
kernel memset (optimized):
4096 bytes page aligned: 4332.88 MB/s
4096 bytes page aligned: 4333.13 MB/s
4096 bytes page aligned: 4332.22 MB/s
4096 bytes page aligned: 4333.00 MB/s
4096 bytes page aligned: 4331.64 MB/s
kernel memzero (original):
4096 bytes page aligned: 4286.68 MB/s
4096 bytes page aligned: 4286.68 MB/s
4096 bytes page aligned: 4286.96 MB/s
4096 bytes page aligned: 4286.31 MB/s
4096 bytes page aligned: 4285.41 MB/s
kernel memzero (optimized):
4096 bytes page aligned: 4307.47 MB/s
4096 bytes page aligned: 4306.33 MB/s
4096 bytes page aligned: 4307.97 MB/s
4096 bytes page aligned: 4305.94 MB/s
4096 bytes page aligned: 4307.61 MB/s
libc memset:
Mixed from 1 to 1023 (power law), unaligned: 1150.12 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1149.80 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1150.06 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1149.76 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1149.91 MB/s
kernel memset (original):
Mixed from 1 to 1023 (power law), unaligned: 1482.23 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1483.26 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1483.42 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1482.48 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1483.19 MB/s
kernel memset (optimized):
Mixed from 1 to 1023 (power law), unaligned: 1683.39 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1680.19 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1681.58 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1680.15 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1680.06 MB/s
kernel memzero (original):
Mixed from 1 to 1023 (power law), unaligned: 1357.13 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1357.31 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1356.41 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1357.16 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1356.60 MB/s
kernel memzero (optimized):
Mixed from 1 to 1023 (power law), unaligned: 1469.08 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1470.31 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1469.47 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1468.80 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1469.37 MB/s
-------------- next part --------------
libc memcpy:
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 869.54 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 869.27 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 869.78 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 869.52 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 869.50 MB/s
kernel memcpy (original):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 954.22 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 954.17 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 954.16 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 954.08 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 954.19 MB/s
kernel memcpy (optimized):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 852.17 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 852.53 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 852.37 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 852.44 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 852.45 MB/s
libc memcpy:
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 455.51 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 457.69 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 455.01 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 455.30 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 455.68 MB/s
kernel memcpy (original):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 512.36 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 512.02 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 512.47 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 512.47 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 512.66 MB/s
kernel memcpy (optimized):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 538.32 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 537.83 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 538.36 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 538.29 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 539.25 MB/s
libc memcpy:
Mixed multiples of 4 from 4 to 130, word aligned: 392.90 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 388.25 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 388.67 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 392.51 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 392.09 MB/s
kernel memcpy (original):
Mixed multiples of 4 from 4 to 130, word aligned: 433.21 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 433.73 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 433.34 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 433.91 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 433.43 MB/s
kernel memcpy (optimized):
Mixed multiples of 4 from 4 to 130, word aligned: 474.10 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 474.06 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 474.29 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 474.10 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 473.95 MB/s
kernel copy_from_user (optimized):
Mixed multiples of 4 from 4 to 130, word aligned: 455.22 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 455.10 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 454.55 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 454.71 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 454.86 MB/s
kernel copy_to_user (optimized):
Mixed multiples of 4 from 4 to 130, word aligned: 429.08 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 429.08 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 429.42 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 429.12 MB/s
Mixed multiples of 4 from 4 to 130, word aligned: 429.59 MB/s
libc memcpy:
4096 bytes page aligned: 2698.97 MB/s
4096 bytes page aligned: 2703.85 MB/s
4096 bytes page aligned: 2706.42 MB/s
4096 bytes page aligned: 2701.26 MB/s
4096 bytes page aligned: 2699.65 MB/s
kernel memcpy (original):
4096 bytes page aligned: 2735.92 MB/s
4096 bytes page aligned: 2735.76 MB/s
4096 bytes page aligned: 2739.53 MB/s
4096 bytes page aligned: 2737.95 MB/s
4096 bytes page aligned: 2735.23 MB/s
kernel memcpy (optimized):
4096 bytes page aligned: 2016.76 MB/s
4096 bytes page aligned: 2015.85 MB/s
4096 bytes page aligned: 2016.87 MB/s
4096 bytes page aligned: 2015.99 MB/s
4096 bytes page aligned: 2018.49 MB/s
kernel copy_page (original):
4096 bytes page aligned: 1533.05 MB/s
4096 bytes page aligned: 1533.36 MB/s
4096 bytes page aligned: 1533.81 MB/s
4096 bytes page aligned: 1533.62 MB/s
4096 bytes page aligned: 1533.05 MB/s
kernel copy_page (optimized):
4096 bytes page aligned: 2016.48 MB/s
4096 bytes page aligned: 2019.79 MB/s
4096 bytes page aligned: 2016.49 MB/s
4096 bytes page aligned: 2017.68 MB/s
4096 bytes page aligned: 2018.23 MB/s
libc memcpy:
Mixed from 1 to 1023 (power law), unaligned: 640.12 MB/s
Mixed from 1 to 1023 (power law), unaligned: 640.23 MB/s
Mixed from 1 to 1023 (power law), unaligned: 640.13 MB/s
Mixed from 1 to 1023 (power law), unaligned: 640.34 MB/s
Mixed from 1 to 1023 (power law), unaligned: 640.36 MB/s
kernel memcpy (original):
Mixed from 1 to 1023 (power law), unaligned: 681.11 MB/s
Mixed from 1 to 1023 (power law), unaligned: 680.79 MB/s
Mixed from 1 to 1023 (power law), unaligned: 681.19 MB/s
Mixed from 1 to 1023 (power law), unaligned: 680.93 MB/s
Mixed from 1 to 1023 (power law), unaligned: 681.05 MB/s
kernel memcpy (optimized):
Mixed from 1 to 1023 (power law), unaligned: 645.50 MB/s
Mixed from 1 to 1023 (power law), unaligned: 644.98 MB/s
Mixed from 1 to 1023 (power law), unaligned: 645.10 MB/s
Mixed from 1 to 1023 (power law), unaligned: 644.91 MB/s
Mixed from 1 to 1023 (power law), unaligned: 645.03 MB/s
libc memset:
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1246.47 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1246.77 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1246.49 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1246.87 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1246.58 MB/s
kernel memset (original):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1609.02 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1612.50 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1612.66 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1614.68 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1609.93 MB/s
kernel memset (optimized):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1744.85 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1747.18 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1748.65 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1745.03 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1745.42 MB/s
kernel memzero (original):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1509.51 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1510.41 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1509.70 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1508.00 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1508.73 MB/s
kernel memzero (optimized):
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1615.44 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1617.76 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1612.05 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1616.54 MB/s
Mixed powers of 2 from 4 to 4096 (power law), word aligned: 1610.91 MB/s
libc memset:
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 735.51 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 735.65 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 735.62 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 735.75 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 735.83 MB/s
kernel memset (original):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 884.22 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 884.39 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 884.11 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 885.90 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 884.09 MB/s
kernel memset (optimized):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1025.79 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1025.70 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1025.98 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1025.56 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 1025.59 MB/s
kernel memzero (original):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 831.09 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 830.34 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 830.77 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 830.50 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 830.64 MB/s
kernel memzero (optimized):
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 919.83 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 920.16 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 919.50 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 919.75 MB/s
Mixed multiples of 4 from 4 to 1024 (power law), word aligned: 920.02 MB/s
libc memset:
4096 bytes page aligned: 2789.85 MB/s
4096 bytes page aligned: 2790.47 MB/s
4096 bytes page aligned: 2789.64 MB/s
4096 bytes page aligned: 2790.60 MB/s
4096 bytes page aligned: 2789.42 MB/s
kernel memset (original):
4096 bytes page aligned: 4292.31 MB/s
4096 bytes page aligned: 4292.19 MB/s
4096 bytes page aligned: 4291.39 MB/s
4096 bytes page aligned: 4291.91 MB/s
4096 bytes page aligned: 4291.29 MB/s
kernel memset (optimized):
4096 bytes page aligned: 4321.51 MB/s
4096 bytes page aligned: 4319.98 MB/s
4096 bytes page aligned: 4321.53 MB/s
4096 bytes page aligned: 4319.93 MB/s
4096 bytes page aligned: 4321.46 MB/s
kernel memzero (original):
4096 bytes page aligned: 4243.19 MB/s
4096 bytes page aligned: 4242.35 MB/s
4096 bytes page aligned: 4243.32 MB/s
4096 bytes page aligned: 4242.29 MB/s
4096 bytes page aligned: 4243.34 MB/s
kernel memzero (optimized):
4096 bytes page aligned: 4261.67 MB/s
4096 bytes page aligned: 4262.59 MB/s
4096 bytes page aligned: 4262.13 MB/s
4096 bytes page aligned: 4262.75 MB/s
4096 bytes page aligned: 4262.62 MB/s
libc memset:
Mixed from 1 to 1023 (power law), unaligned: 1084.53 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1084.89 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1084.61 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1084.71 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1084.43 MB/s
kernel memset (original):
Mixed from 1 to 1023 (power law), unaligned: 1364.45 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1363.67 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1364.87 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1364.47 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1364.17 MB/s
kernel memset (optimized):
Mixed from 1 to 1023 (power law), unaligned: 1508.02 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1510.44 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1508.57 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1508.86 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1510.14 MB/s
kernel memzero (original):
Mixed from 1 to 1023 (power law), unaligned: 1261.52 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1261.24 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1262.57 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1260.26 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1261.35 MB/s
kernel memzero (optimized):
Mixed from 1 to 1023 (power law), unaligned: 1412.76 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1412.17 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1413.32 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1412.77 MB/s
Mixed from 1 to 1023 (power law), unaligned: 1413.13 MB/s
