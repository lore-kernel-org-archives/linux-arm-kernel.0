From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 26 May 2016 03:45:01 -0400
Subject: ARM: dts: exynos: Add MFC memory banks for Peach boards
In-Reply-To: <574670E7.3060508@samsung.com>
References: <1461871311-18344-1-git-send-email-javier@osg.samsung.com>
 <57456344.7020708@samsung.com>
 <d045b880-4a44-acd8-f7f6-e521caf374aa@osg.samsung.com>
 <574670E7.3060508@samsung.com>
Message-ID: <476edff1-9f3e-fc5b-4385-d04ae917b58e@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding Kevin and Sjoerd who also noticed issues with this patch]

Hi Pankaj,

On 05/25/2016 11:43 PM, pankaj.dubey wrote:
> Hi Javier,
> 
> On Wednesday 25 May 2016 08:32 PM, Javier Martinez Canillas wrote:
>> Hello Pankaj,
>>
>> On 05/25/2016 04:33 AM, pankaj.dubey wrote:
>>> Hi Javier,
>>>
>>>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>>
>>> Just noticed that, current krzk/for-next failed to boot on Exynos5880
>>> based Chromebook device. Git bisect is showing culprit as this patch.
>>
>> Strange, krzk/for-next boots correctly on my Exynos5800 Peach Pi:
>>
>> $ git log --pretty=oneline --abbrev-commit HEAD
>> 35e691cf5165 Merge branch 'fixes-v4.7' into for-next
>>
> 
> This is same as mine.
> 
> My other build parameters are:
> defconfig: exynos_defconfig
> CROSS_COMPILE: gcc-linaro-arm-linux-gnueabihf-4.9-2014.09_linux

I'm also using exynos_defconfig and a similar compiler
(gcc-linaro-arm-linux-gnueabihf-4.9-2015.01-3).

> rootfs: small cramfs
>
>> $ uname -r
>> 4.6.0-00073-g35e691cf5165
>>
>>> When I reverted this patch, its able to boot normally.
>>> Is there any missing patches that we need to take on krzk/for-next to
>>> boot on Chromebook.
>>>
>>
> 
> Further I checked that, either I revert this patch OR do not reserve
> memory for MFC in exynos_reserve using following changes, both cases I
> am able to boot kernel on Chromebook (Exynos5800).
> 
> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> index f977eea..e615e24 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -268,7 +268,7 @@ static char const *const exynos_dt_compat[]
> __initconst = {
> 
>  static void __init exynos_reserve(void)
>  {
> -#ifdef CONFIG_S5P_DEV_MFC
> +#ifndef CONFIG_S5P_DEV_MFC
>         int i;
>         char *mfc_mem[] = {
>                 "samsung,mfc-v5",
> @@ -280,6 +280,8 @@ static void __init exynos_reserve(void)
>         for (i = 0; i < ARRAY_SIZE(mfc_mem); i++)
>                 if (of_scan_flat_dt(s5p_fdt_alloc_mfc_mem, mfc_mem[i]))
>                         break;
> +#else
> +       pr_err("*****exynos_reserve Bypassing Memory Reservation for MFC
> ********\n");
>  #endif
>  }
> 
> 
>> No that I'm aware of. I wonder why it boots for me but fails for
>> you. Can you please share your complete boot log to see if there
>> are any hints there?
>>  
> 
> Following is failed boot log:
> U-Boot 2013.04-g8e3e5ef (May 26 2015 - 16:11:36) for Peach
> 
> CPU:    Exynos5422 at 900MHz
> 
> Board: Google Peach Pi, rev 11.6
> I2C:   ready
> DRAM:  3.5 GiB
> Relocation Offset dbd54000, base at ffb54000
> SPL stack at 2072c00, used 3f0, free 10
> PMIC max77802-pmic initialized
> CPU:    Exynos5422 at 1800MHz
> TPS65090 PMIC EC init
> MMC:   EXYNOS DWMMC: 0, EXYNOS DWMMC: 1
> SF: Detected W25Q32DW with page size 4 KiB, total 32 MiB
> In:    cros-ec-keyb
> Out:   lcd
> Err:   lcd
> SF: Detected W25Q32DW with page size 4 KiB, total 32 MiB
> ELOG: Event(17) added with size 13
> Net:   No ethernet found.
> Hit any key to stop autoboot:  0
> mmc1 is current device
> 4586144 bytes read in 242 ms (18.1 MiB/s)
> 26583040 bytes read in 1166 ms (21.7 MiB/s)
> ## Loading kernel from FIT Image at 20008000 ...
>    Using 'conf at 2' configuration
>    Trying 'kernel at 1' kernel subimage
>      Description:  unavailable
>      Type:         Kernel Image (no loading done)
>      Compression:  uncompressed
>      Data Start:   0x200080c8
>      Data Size:    4459024 Bytes = 4.3 MiB
>    Verifying Hash Integrity ... OK
> ## Loading fdt from FIT Image at 20008000 ...

A difference I see is that I'm chain loading a non-verified u-boot and you
are loading a signed FIT image directly. But Sjoerd also chain loads a nv
u-boot and his Peach doesn't boot either so I don't think that's a cause.

>    Using 'conf at 2' configuration
>    Trying 'fdt at 2' fdt subimage
>      Description:  exynos5800-peach-pi.dtb
>      Type:         Flat Device Tree
>      Compression:  uncompressed
>      Data Start:   0x20458148
>      Data Size:    63002 Bytes = 61.5 KiB
>      Architecture: ARM
>      Hash algo:    sha1
>      Hash value:   cd1c1703f744b44b1833ca61ec36b625665548de
>    Verifying Hash Integrity ... sha1+ OK
>    Booting using the fdt blob at 0x20458148
>    XIP Kernel Image (no loading done) ... OK
>    Loading Device Tree to 3ffe1000, end 3ffffb49 ... OK
> boot_kernel.c: ft_board_setup: warning: Must pass exactly one of vboot
> or cdata
> 
> Starting kernel ...
> 
> Timer summary in microseconds:
>        Mark    Elapsed  Stage
>           0          0  reset
>     122,793    122,793  board_init_f
>     143,214     20,421  board_init_r
>     238,069     94,855  id=64
>     240,278      2,209  main_loop
>   4,841,682  4,601,404  bootm_start
>   4,841,683          1  id=1
>   4,846,604      4,921  id=100
>   4,846,607          3  id=101
>   4,846,607          0  id=102
>   4,850,208      3,601  id=110
>   4,877,729     27,521  id=105
>   4,877,731          2  id=106
>   4,877,734          3  id=107
>   4,877,735          1  id=108
>   4,877,736          1  id=109
>   4,882,406      4,670  id=90
>   4,882,408          2  id=92
>   4,882,408          0  id=91
>   4,927,272     44,864  id=95
>   4,927,274          2  id=96
>   4,927,276          2  id=97
>   4,927,277          1  id=98
>   4,927,279          2  id=99
>   4,937,617     10,338  id=7
>   4,951,899     14,282  id=15
>   4,955,112      3,213  start_kernel
> 
> Accumulated time:
>                  6,948  SPI read
> Uncompressing Linux... done, booting the kernel.
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 4.6.0-00073-g35e691c
> (pankaj at chromebld-server) (gcc version 4.9.2 20140904 (prerelease)
> (crosstool-NG linaro-1.13.1-4.9-2014.09 - Linaro GCC
> 4.9-2014.09) ) #59 SMP PREEMPT Thu May 26 08:21:07 IST 2016
> [    0.000000] CPU: ARMv7 Processor [412fc0f3] revision 3 (ARMv7),
> cr=10c5387d
> [    0.000000] CPU: div instructions available: patching division code
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction
> cache
> [    0.000000] Machine model: Google Peach Pi Rev 10+
> [    0.000000] bootconsole [earlycon0] enabled
> [    0.000000] cma: Reserved 64 MiB at 0xfbc00000
> [    0.000000] Memory policy: Data cache writealloc
> [    0.000000] Samsung CPU ID: 0xe5422001
> [    0.000000] On node 0 totalpages: 913407
> [    0.000000] free_area_init_node: node 0, pgdat c0b42cc0, node_mem_map
> ee3f7000
> [    0.000000]   Normal zone: 1536 pages used for memmap
> [    0.000000]   Normal zone: 0 pages reserved
> [    0.000000]   Normal zone: 194560 pages, LIFO batch:31
> [    0.000000]   HighMem zone: 718847 pages, LIFO batch:31
> [    0.000000] percpu: Embedded 12 pages/cpu @ee341000 s19392 r8192
> d21568 u49152
> [    0.000000] pcpu-alloc: s19392 r8192 d21568 u49152 alloc=12*4096
> [    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
> Total pages: 911871
> [    0.000000] Kernel command line: cros_legacy console=ttySAC3,115200
> debug earlyprintk cros_debug no_console_suspend root=/dev/ram0 rw
> ramdisk=32768 initrd=0x42000000,3
> 2M

I see that you are loading an initrd at 0x42000000 with size of 32 MiB.

[...]

> [    1.121421] Trying to unpack rootfs image as initramfs...
> [    1.126940] rootfs image is not initramfs (junk in compressed
> archive); looks like an initrd
> [    1.160139] Unable to handle kernel paging request at virtual address
> e3000000

So I wonder if the problem is that the memblock_remove() is called very
early and so the kernel is not able to copy the initrd from 0x42000000
to 0x44000000 since overlaps with the mfc-r mem (0x43000000-0x43800000).

Specially since the NULL pointer dereference below happens in the
populate_rootfs() function when calling xwrite() to do the copy.

Could you please try to change the load address for your initrd, or
change the mfc-r start address to see if that prevents the issue?

> [    1.167270] pgd = c0004000
> [    1.170046] [e3000000] *pgd=00000000
> [    1.173693] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> [    1.179068] Modules linked in:
> [    1.182194] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> 4.6.0-00073-g35e691c #59
> [    1.189477] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [    1.195638] task: edc88000 ti: edc76000 task.ti: edc76000
> [    1.201111] PC is at memcpy+0x48/0x330
> [    1.204923] LR is at iov_iter_copy_from_user_atomic+0x184/0x24c
> [    1.210906] pc : [<c0320388>]    lr : [<c0331688>]    psr: 20000013
> [    1.210906] sp : edc77cd4  ip : 00000000  fp : c070b640
> [    1.222530] r10: 00000000  r9 : 00000000  r8 : ffefe000
> [    1.227822] r7 : 00000000  r6 : ffeff000  r5 : 00001000  r4 : edc77dec
> [    1.234415] r3 : 01000000  r2 : 00000f80  r1 : e3000000  r0 : ffefe000
> [    1.241009] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
> Segment none
> [    1.248208] Control: 10c5387d  Table: 2000406a  DAC: 00000051
> [    1.254020] Process swapper/0 (pid: 1, stack limit = 0xedc76210)
> [    1.260093] Stack: (0xedc77cd4 to 0xedc78000)
> [    1.264518] 7cc0:
> 00001000 ffeff000 00000000
> [    1.272760] 7ce0: ffefe000 ffefe000 edc77dec c0331688 00001000
> 00001000 edc77df4 ed85508c
> [    1.281001] 7d00: 00001000 01000000 00000000 00000000 c070b640
> c01966d8 00001000 00000001
> [    1.289242] 7d20: edc77d40 edc77d44 00000000 edf0e600 01000000
> 00000000 edc76000 00000001
> [    1.297483] 7d40: eff519e0 c01f6100 00000000 00000000 edc77e08
> 00000000 edc77df4 edc77df4
> [    1.305725] 7d60: edf0e600 ed85508c c0b45050 c0197f88 c0b45050
> c06c9d3c c0b67b58 c0b67b58
> [    1.313966] 7d80: 000000a8 00000003 ed855018 edc77e08 ed855018
> edf0e600 edc77df4 02000000
> [    1.322207] 7da0: 00000000 c0b4504c c0b45050 c0198118 eded6860
> c0b4504c c0b45050 c01ec01c
> [    1.330448] 7dc0: edf0e600 02000000 00000000 00000000 edc77e60
> eded6860 c0b4504c c01dd0b8
> [    1.338690] 7de0: 02000000 00000301 00000002 e2000000 02000000
> 00000003 01000000 01000000
> [    1.346931] 7e00: edc77dec 00000001 edf0e600 00000000 00000000
> 00000000 00000000 00000000
> [    1.355172] 7e20: 00000000 00000000 edf0e600 02000000 e2000000
> edc77e60 00000000 c01dddac
> [    1.363414] 7e40: ed854fa0 edf0e608 edf0e600 edf0e600 e2000000
> 02000000 00000000 c01dead8
> [    1.371655] 7e60: 00000000 00000000 c08781c0 02000000 e2000000
> 00000000 00000000 c0a027a8
> [    1.379896] 7e80: 00000000 00000000 eded6800 c0b43a4c 00000000
> c0a02eb4 c0871494 eded685b
> [    1.388137] 7ea0: 00000001 00000068 000241ed 00000000 00000000
> 00000000 00001000 00000000
> [    1.396378] 7ec0: 57465fab 00000000 57465fab 00000000 00000000
> 376eac80 00000000 00000000
> [    1.404619] 7ee0: 00000000 c0b05a50 c0b05a50 c0a02d70 00000000
> edf24ac0 000000d4 c0a34848
> [    1.412861] 7f00: 00000000 c0101814 c0b0a98c edc77f18 c0b47668
> c06c98b0 60000000 c0b0933c
> [    1.421102] 7f20: 00000000 c0b0933c c0926578 c0716b3c 000000d4
> c0135ef0 0000cccd 00000000
> [    1.429343] 7f40: c08dd0e0 00000000 00000005 00000005 c0b09318
> efffc8c0 c0a5ba5c 00000005
> [    1.437585] 7f60: c0a3483c c0b45000 c0b45000 000000d4 c0a34848
> c0a00db8 00000005 00000005
> [    1.445826] 7f80: 00000000 c0a005a0 00000000 c06c6254 00000000
> 00000000 00000000 00000000
> [    1.454067] 7fa0: 00000000 c06c625c 00000000 c0107a38 00000000
> 00000000 00000000 00000000
> [    1.462308] 7fc0: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [    1.470549] 7fe0: 00000000 00000000 00000000 00000000 00000013
> 00000000 f7ffffff a7ffefff
> [    1.478797] [<c0320388>] (memcpy) from [<c0331688>]
> (iov_iter_copy_from_user_atomic+0x184/0x24c)
> [    1.487646] [<c0331688>] (iov_iter_copy_from_user_atomic) from
> [<c01966d8>] (generic_perform_write+0xf8/0x1c8)
> [    1.497706] [<c01966d8>] (generic_perform_write) from [<c0197f88>]
> (__generic_file_write_iter+0x198/0x1f4)
> [    1.507420] [<c0197f88>] (__generic_file_write_iter) from
> [<c0198118>] (generic_file_write_iter+0x134/0x260)
> [    1.517311] [<c0198118>] (generic_file_write_iter) from [<c01dd0b8>]
> (__vfs_write+0xa8/0xd8)
> [    1.525811] [<c01dd0b8>] (__vfs_write) from [<c01dddac>]
> (vfs_write+0x90/0x164)
> [    1.533184] [<c01dddac>] (vfs_write) from [<c01dead8>]
> (SyS_write+0x44/0x9c)
> [    1.540301] [<c01dead8>] (SyS_write) from [<c0a027a8>] (xwrite+0x2c/0x68)
> [    1.547152] [<c0a027a8>] (xwrite) from [<c0a02eb4>]
> (populate_rootfs+0x144/0x268)
> [    1.554700] [<c0a02eb4>] (populate_rootfs) from [<c0101814>]
> (do_one_initcall+0x90/0x1d8)
> [    1.562939] [<c0101814>] (do_one_initcall) from [<c0a00db8>]
> (kernel_init_freeable+0x15c/0x1fc)
> [    1.571706] [<c0a00db8>] (kernel_init_freeable) from [<c06c625c>]
> (kernel_init+0x8/0x114)
> [    1.579945] [<c06c625c>] (kernel_init) from [<c0107a38>]
> (ret_from_fork+0x14/0x3c)
> [    1.587576] Code: ba000002 f5d1f03c f5d1f05c f5d1f07c (e8b151f8)
> [    1.593751] ---[ end trace 065c5ae2b4577941 ]---

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
