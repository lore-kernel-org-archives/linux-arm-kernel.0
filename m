From: labbott@redhat.com (Laura Abbott)
Date: Tue, 13 Dec 2016 06:50:16 -0800
Subject: i.MX31 3DS board not booting after commit 1c2f87c22... ARM:
 8025/1: Get rid of meminfo
In-Reply-To: <27bbaa4c-7c8d-cf76-c98f-e8edc89367db@gmail.com>
References: <27bbaa4c-7c8d-cf76-c98f-e8edc89367db@gmail.com>
Message-ID: <e24006c5-a311-93b8-9794-1400692322bc@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/2016 02:34 AM, Magnus Lilja wrote:
> Hi,
> 
> I'm trying to get current modern Linux kernels to boot on the i.MX31 PDK board (a.k.a MX31_3DS).
> 
> One problem I've noticed is that I have to comment out the following code from mach-mx31_3ds.c, the reserve function is registered as mach_desc->reserve . If I leave this function as is the kernel stops very early in the boot (see end of the mail).
> 
> static void __init mx31_3ds_reserve(void)
> {
>     /* reserve MX31_3DS_CAMERA_BUF_SIZE bytes for mx3-camera */
>     mx3_camera_base = arm_memblock_steal(MX31_3DS_CAMERA_BUF_SIZE,
>                      MX31_3DS_CAMERA_BUF_SIZE);
> }
> 
> The commits that causes this problem (according to git bisect) is:
> [1c2f87c22566cd057bc8cde10c37ae9da1a1bb76] ARM: 8025/1: Get rid of meminfo
> 
> (Yes, it's been a while since I last tried to boot a modern kernel on this board)
> 
> I'm using the imx_v6_v7_defconfig.
> 
> Kernel boot log using earlyprintk. (the arm_memblock_init NNN lines are my added printk's)
> 
> Uncompressing Linux... done, booting the kernel.
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 4.9.0-rc7-dirty (lilja at xubuntu-14-04) (gcc version 4. 8.3 20140320 (prerelease) (Sourcery CodeBench Lite 2014.05-29) ) #150 SMP Sun Dec 11 11:12:32 CET 2016
> [    0.000000] CPU: ARMv6-compatible processor [4107b364] revision 4 (ARMv6TEJ), cr=00c5387d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
> [    0.000000] Machine: Freescale MX31PDK (3DS)
> [    0.000000] bootconsole [earlycon0] enabled
> [    0.000000] arm_memblock_init 268
> [    0.000000] arm_memblock_init 273
> [    0.000000] arm_memblock_init 277
> [    0.000000] cma: Reserved 16 MiB at 0x86800000
> [    0.000000] arm_memblock_init 281
> [    0.000000] Memory policy: Data cache writeback
> [    0.000000] CPU: All CPU(s) started in SVC mode.
> [    0.000000] percpu: Embedded 14 pages/cpu @c64f0000 s26688 r8192 d22464 u57344
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on. Total pages: 30464
> [    0.000000] Kernel command line: console=ttymxc0,115200 earlyprintk
> [    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
> [    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
> [    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
> 
> This is where boot stops. If I comment out the arm_memblock_steal() call from mx31_3ds_reserve() the boot works and the next couple of lines are:
> 
> [    0.000000] Memory: 92564K/131072K available (8192K kernel code, 360K rwdata, 2 280K rodata, 1024K init, 8218K bss, 22124K reserved, 16384K cma-reserved, 0K highmem)
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> [    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
> [    0.000000]     vmalloc : 0xc8800000 - 0xff800000   ( 880 MB)
> [    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
> [    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
> [    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
> [    0.000000]       .text : 0xc0008000 - 0xc0900000   (9184 kB)
> [    0.000000]       .init : 0xc0c00000 - 0xc0d00000   (1024 kB)
> [    0.000000]       .data : 0xc0d00000 - 0xc0d5a120   ( 361 kB
> 
> 
> I have really no clue why that commit causes problems. There are not a lot of boards using mach_desc->reserve .
> 
> Any ideas on how to fix or debug this?
> 
> Regards, Magnus

I found the bug, it's another issue with removal and the lowmem boundary.
Given this has been present for 2.5 years without a complaint, I'm going
to take a little bit more time to think about a fix.

Thanks,
Laura
