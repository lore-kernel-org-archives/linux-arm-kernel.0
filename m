From: pankaj.dubey@samsung.com (pankaj.dubey)
Date: Thu, 26 May 2016 14:40:44 +0530
Subject: ARM: dts: exynos: Add MFC memory banks for Peach boards
In-Reply-To: <476edff1-9f3e-fc5b-4385-d04ae917b58e@osg.samsung.com>
References: <1461871311-18344-1-git-send-email-javier@osg.samsung.com>
 <57456344.7020708@samsung.com>
 <d045b880-4a44-acd8-f7f6-e521caf374aa@osg.samsung.com>
 <574670E7.3060508@samsung.com>
 <476edff1-9f3e-fc5b-4385-d04ae917b58e@osg.samsung.com>
Message-ID: <5746BD94.3070903@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On Thursday 26 May 2016 01:15 PM, Javier Martinez Canillas wrote:
> [adding Kevin and Sjoerd who also noticed issues with this patch]
> 
> Hi Pankaj,
> 
> On 05/25/2016 11:43 PM, pankaj.dubey wrote:
>> Hi Javier,
>>
>> On Wednesday 25 May 2016 08:32 PM, Javier Martinez Canillas wrote:
>>> Hello Pankaj,
>>>
>>> On 05/25/2016 04:33 AM, pankaj.dubey wrote:
>>>> Hi Javier,
>>>>
>>>>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>>>
>>>> Just noticed that, current krzk/for-next failed to boot on Exynos5880
>>>> based Chromebook device. Git bisect is showing culprit as this patch.
>>>
>>> Strange, krzk/for-next boots correctly on my Exynos5800 Peach Pi:
>>>
>>> $ git log --pretty=oneline --abbrev-commit HEAD
>>> 35e691cf5165 Merge branch 'fixes-v4.7' into for-next
>>>
>>
>> This is same as mine.
>>
>> My other build parameters are:
>> defconfig: exynos_defconfig
>> CROSS_COMPILE: gcc-linaro-arm-linux-gnueabihf-4.9-2014.09_linux
> 
> I'm also using exynos_defconfig and a similar compiler
> (gcc-linaro-arm-linux-gnueabihf-4.9-2015.01-3).
> 
>> rootfs: small cramfs
>>
>>> $ uname -r
>>> 4.6.0-00073-g35e691cf5165
>>>
>>>> When I reverted this patch, its able to boot normally.
>>>> Is there any missing patches that we need to take on krzk/for-next to
>>>> boot on Chromebook.
>>>>
>>>
>>
>> Further I checked that, either I revert this patch OR do not reserve
>> memory for MFC in exynos_reserve using following changes, both cases I
>> am able to boot kernel on Chromebook (Exynos5800).
>>
>> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
>> index f977eea..e615e24 100644
>> --- a/arch/arm/mach-exynos/exynos.c
>> +++ b/arch/arm/mach-exynos/exynos.c
>> @@ -268,7 +268,7 @@ static char const *const exynos_dt_compat[]
>> __initconst = {
>>
>>  static void __init exynos_reserve(void)
>>  {
>> -#ifdef CONFIG_S5P_DEV_MFC
>> +#ifndef CONFIG_S5P_DEV_MFC
>>         int i;
>>         char *mfc_mem[] = {
>>                 "samsung,mfc-v5",
>> @@ -280,6 +280,8 @@ static void __init exynos_reserve(void)
>>         for (i = 0; i < ARRAY_SIZE(mfc_mem); i++)
>>                 if (of_scan_flat_dt(s5p_fdt_alloc_mfc_mem, mfc_mem[i]))
>>                         break;
>> +#else
>> +       pr_err("*****exynos_reserve Bypassing Memory Reservation for MFC
>> ********\n");
>>  #endif
>>  }
>>
>>
>>> No that I'm aware of. I wonder why it boots for me but fails for
>>> you. Can you please share your complete boot log to see if there
>>> are any hints there?
>>>  
>>
>> Following is failed boot log:
>> U-Boot 2013.04-g8e3e5ef (May 26 2015 - 16:11:36) for Peach
>>
>> CPU:    Exynos5422 at 900MHz
>>
>> Board: Google Peach Pi, rev 11.6
>> I2C:   ready
>> DRAM:  3.5 GiB
>> Relocation Offset dbd54000, base at ffb54000
>> SPL stack at 2072c00, used 3f0, free 10
>> PMIC max77802-pmic initialized
>> CPU:    Exynos5422 at 1800MHz
>> TPS65090 PMIC EC init
>> MMC:   EXYNOS DWMMC: 0, EXYNOS DWMMC: 1
>> SF: Detected W25Q32DW with page size 4 KiB, total 32 MiB
>> In:    cros-ec-keyb
>> Out:   lcd
>> Err:   lcd
>> SF: Detected W25Q32DW with page size 4 KiB, total 32 MiB
>> ELOG: Event(17) added with size 13
>> Net:   No ethernet found.
>> Hit any key to stop autoboot:  0
>> mmc1 is current device
>> 4586144 bytes read in 242 ms (18.1 MiB/s)
>> 26583040 bytes read in 1166 ms (21.7 MiB/s)
>> ## Loading kernel from FIT Image at 20008000 ...
>>    Using 'conf at 2' configuration
>>    Trying 'kernel at 1' kernel subimage
>>      Description:  unavailable
>>      Type:         Kernel Image (no loading done)
>>      Compression:  uncompressed
>>      Data Start:   0x200080c8
>>      Data Size:    4459024 Bytes = 4.3 MiB
>>    Verifying Hash Integrity ... OK
>> ## Loading fdt from FIT Image at 20008000 ...
> 
> A difference I see is that I'm chain loading a non-verified u-boot and you
> are loading a signed FIT image directly. But Sjoerd also chain loads a nv
> u-boot and his Peach doesn't boot either so I don't think that's a cause.
> 
>>    Using 'conf at 2' configuration
>>    Trying 'fdt at 2' fdt subimage
>>      Description:  exynos5800-peach-pi.dtb
>>      Type:         Flat Device Tree
>>      Compression:  uncompressed
>>      Data Start:   0x20458148
>>      Data Size:    63002 Bytes = 61.5 KiB
>>      Architecture: ARM
>>      Hash algo:    sha1
>>      Hash value:   cd1c1703f744b44b1833ca61ec36b625665548de
>>    Verifying Hash Integrity ... sha1+ OK
>>    Booting using the fdt blob at 0x20458148
>>    XIP Kernel Image (no loading done) ... OK
>>    Loading Device Tree to 3ffe1000, end 3ffffb49 ... OK
>> boot_kernel.c: ft_board_setup: warning: Must pass exactly one of vboot
>> or cdata
>>
>> Starting kernel ...
>>
>> Timer summary in microseconds:
>>        Mark    Elapsed  Stage
>>           0          0  reset
>>     122,793    122,793  board_init_f
>>     143,214     20,421  board_init_r
>>     238,069     94,855  id=64
>>     240,278      2,209  main_loop
>>   4,841,682  4,601,404  bootm_start
>>   4,841,683          1  id=1
>>   4,846,604      4,921  id=100
>>   4,846,607          3  id=101
>>   4,846,607          0  id=102
>>   4,850,208      3,601  id=110
>>   4,877,729     27,521  id=105
>>   4,877,731          2  id=106
>>   4,877,734          3  id=107
>>   4,877,735          1  id=108
>>   4,877,736          1  id=109
>>   4,882,406      4,670  id=90
>>   4,882,408          2  id=92
>>   4,882,408          0  id=91
>>   4,927,272     44,864  id=95
>>   4,927,274          2  id=96
>>   4,927,276          2  id=97
>>   4,927,277          1  id=98
>>   4,927,279          2  id=99
>>   4,937,617     10,338  id=7
>>   4,951,899     14,282  id=15
>>   4,955,112      3,213  start_kernel
>>
>> Accumulated time:
>>                  6,948  SPI read
>> Uncompressing Linux... done, booting the kernel.
>> [    0.000000] Booting Linux on physical CPU 0x0
>> [    0.000000] Linux version 4.6.0-00073-g35e691c
>> (pankaj at chromebld-server) (gcc version 4.9.2 20140904 (prerelease)
>> (crosstool-NG linaro-1.13.1-4.9-2014.09 - Linaro GCC
>> 4.9-2014.09) ) #59 SMP PREEMPT Thu May 26 08:21:07 IST 2016
>> [    0.000000] CPU: ARMv7 Processor [412fc0f3] revision 3 (ARMv7),
>> cr=10c5387d
>> [    0.000000] CPU: div instructions available: patching division code
>> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction
>> cache
>> [    0.000000] Machine model: Google Peach Pi Rev 10+
>> [    0.000000] bootconsole [earlycon0] enabled
>> [    0.000000] cma: Reserved 64 MiB at 0xfbc00000
>> [    0.000000] Memory policy: Data cache writealloc
>> [    0.000000] Samsung CPU ID: 0xe5422001
>> [    0.000000] On node 0 totalpages: 913407
>> [    0.000000] free_area_init_node: node 0, pgdat c0b42cc0, node_mem_map
>> ee3f7000
>> [    0.000000]   Normal zone: 1536 pages used for memmap
>> [    0.000000]   Normal zone: 0 pages reserved
>> [    0.000000]   Normal zone: 194560 pages, LIFO batch:31
>> [    0.000000]   HighMem zone: 718847 pages, LIFO batch:31
>> [    0.000000] percpu: Embedded 12 pages/cpu @ee341000 s19392 r8192
>> d21568 u49152
>> [    0.000000] pcpu-alloc: s19392 r8192 d21568 u49152 alloc=12*4096
>> [    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7
>> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
>> Total pages: 911871
>> [    0.000000] Kernel command line: cros_legacy console=ttySAC3,115200
>> debug earlyprintk cros_debug no_console_suspend root=/dev/ram0 rw
>> ramdisk=32768 initrd=0x42000000,3
>> 2M
> 
> I see that you are loading an initrd at 0x42000000 with size of 32 MiB.
> 
> [...]
> 
>> [    1.121421] Trying to unpack rootfs image as initramfs...
>> [    1.126940] rootfs image is not initramfs (junk in compressed
>> archive); looks like an initrd
>> [    1.160139] Unable to handle kernel paging request at virtual address
>> e3000000
> 
> So I wonder if the problem is that the memblock_remove() is called very
> early and so the kernel is not able to copy the initrd from 0x42000000
> to 0x44000000 since overlaps with the mfc-r mem (0x43000000-0x43800000).
> 
> Specially since the NULL pointer dereference below happens in the
> populate_rootfs() function when calling xwrite() to do the copy.
> 
> Could you please try to change the load address for your initrd, or
> change the mfc-r start address to see if that prevents the issue?
> 

Yes, you are correct. This was the case.
I changed initrd location from 0x42000000 to 0x44000000, and it is able
to boot without any crash.

Thanks,
Pankaj Dubey
