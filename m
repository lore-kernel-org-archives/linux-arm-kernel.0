From: kmpark@infradead.org (Kyungmin Park)
Date: Mon, 12 Jul 2010 19:08:11 +0900
Subject: About SECTION_SIZE_BITS for Sparsemem
In-Reply-To: <001601cb21a8$d1cdd120$75697360$%kim@samsung.com>
References: <000601cb219c$c7830b60$56892220$%kim@samsung.com>
	<AANLkTin1M4CnLb1sj9mZiePjF4SvgRXySyJmT4eWpJlj@mail.gmail.com>
	<001601cb21a8$d1cdd120$75697360$%kim@samsung.com>
Message-ID: <AANLkTimsEDWv9X3PeX2EBjvxl53j9R6tnAkxQuOS3CQD@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 12, 2010 at 6:58 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Kyungmin Park wrote:
>
>>
>> Interesting.
>>
>> I got tested with
>> #define MAX_PHYSMEM_BITS ? ? ? ?31
>> #define SECTION_SIZE_BITS ? ? ? 27
>>
>> # cat /proc/sys/vm/min_free_kbytes
>> 1832
>> # echo 1828 > /proc/sys/vm/min_free_kbytes
>> # cat /proc/sys/vm/min_free_kbytes
>> 1828
>> # echo 1820 > /proc/sys/vm/min_free_kbytes
>> # cat /proc/sys/vm/min_free_kbytes
>> 1820
>> # echo 1700 > /proc/sys/vm/min_free_kbytes
>> # cat /proc/sys/vm/min_free_kbytes
>> 1700
>>
>> No kernel panic.
>>
>
> Thanks for your test on the board.
>
> But I need your environment for comparing.
>
> Please let me know.
> Following is my board environment.
>
> From boot-loader(u-boot).
>
> SMDKC110 # bdinfo
> arch_number = 0x00000891
> env_t ? ? ? = 0x00000000
> boot_params = 0x20000100
> DRAM bank ? = 0x00000000
> -> start ? ?= 0x20000000
> -> size ? ? = 0x05000000
> DRAM bank ? = 0x00000001
> -> start ? ?= 0x40000000
> -> size ? ? = 0x10000000
> DRAM bank ? = 0x00000002
> -> start ? ?= 0x50000000
> -> size ? ? = 0x08000000
>
> From kernel boot message.
>
> SMDKC110 # bootm c0008000
> Boot with zImage
>
> Starting kernel ...
>
> Uncompressing Linux... done, booting the kernel.
> Linux version 2.6.35-rc4-00008-g98c749c (kgene at starstone) (gcc version 4.4.1
> (Sourcery G++ Lite 2009q3-67) ) #1 PREEMPT Mon Jul 12 18:47:04 KST 2010
> CPU: ARMv7 Processor [412fc082] revision 2 (ARMv7), cr=10c53c7f
> CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
> Machine: SMDKC110
> ...
> Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Memory: 80MB 256MB 128MB = 464MB total
> Memory: 459616k/459616k available, 15520k reserved, 0K highmem
> Virtual kernel memory layout:
> ? ?vector ?: 0xffff0000 - 0xffff1000 ? ( ? 4 kB)
> ? ?fixmap ?: 0xfff00000 - 0xfffe0000 ? ( 896 kB)
> ? ?DMA ? ? : 0xff000000 - 0xffe00000 ? ( ?14 MB)
> ? ?vmalloc : 0xb8800000 - 0xe0000000 ? ( 632 MB)
> ? ?lowmem ?: 0x80000000 - 0xb8000000 ? ( 896 MB)
> ? ?modules : 0x7f000000 - 0x80000000 ? ( ?16 MB)
> ? ? ?.init : 0x80008000 - 0x8001e000 ? ( ?88 kB)
> ? ? ?.text : 0x8001e000 - 0x801be000 ? (1664 kB)
> ? ? ?.data : 0x801ce000 - 0x801e6600 ? ( ?98 kB)
> SLUB: Genslabs=9, HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> Hierarchical RCU implementation.
> ? ? ? ?RCU-based detection of stalled CPUs is disabled.
> ? ? ? ?Verbose stalled-CPUs detection is disabled.
> ...
>
> And SECTION_SIZE_BITS is 28, not 27.

27 for our board. 28 for generic.

Note that I enabled HIGHMEM and modify the VMALLOC_END to 0xd000'0000
to test HIGHMEM.

Universal # bdinfo
arch_number = 0x00000B2E
env_t       = 0x00000000
boot_params = 0x30000100
DRAM bank   = 0x00000000
-> start    = 0x30000000
-> size     = 0x05000000
DRAM bank   = 0x00000001
-> start    = 0x40000000
-> size     = 0x18000000
baudrate    = 115200 bps
Universal # run bootcmd

OneNAND read: offset 0xc00000, size 0x600000
 6291456 bytes read: OK
## Booting kernel from Legacy Image at 30007fc0 ...
   Image Name:   Linux-2.6.35-rc4+
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1548496 Bytes = 1.5 MiB
   Load Address: 30008000
   Entry Point:  30008000
   Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Linux version 2.6.35-rc4+ (kmpark at july) (gcc version 4.4.1 (GCC)0
[    0.000000] CPU: ARMv7 Processor [412fc082] revision 2 (ARMv7), cr=10c53c7f
[    0.000000] CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction ce
[    0.000000] Machine: GONI
[    0.000000] Ignoring unrecognised tag 0x54410008
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] CPU S5PV210/S5PC110 (id 0x43110200)
...
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Memory: 80MB 128MB 128MB 128MB = 464MB total
[    0.000000] Memory: 468224k/468224k available, 6912k reserved, 262144K highmm
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     DMA     : 0xff000000 - 0xffe00000   (  14 MB)
[    0.000000]     vmalloc : 0xd8800000 - 0xe0000000   ( 120 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd8000000   ( 384 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .init : 0xc0008000 - 0xc001b000   (  76 kB)
[    0.000000]       .text : 0xc001b000 - 0xc0282000   (2460 kB)
[    0.000000]       .data : 0xc0298000 - 0xc02b1160   ( 101 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU-based detection of stalled CPUs is disabled.
[    0.000000]  Verbose stalled-CPUs detection is disabled.
[    0.000000] NR_IRQS:176
[    0.000000] VIC @f4000000: id 0x00041192, vendor 0x41
[    0.000000] VIC @f4010000: id 0x00041192, vendor 0x41
[    0.000000] VIC @f4020000: id 0x00041192, vendor 0x41
[    0.000000] VIC @f4030000: id 0x00041192, vendor 0x41
[    0.000000] Console: colour dummy device 80x30
[    0.000000] console [ttySAC2] enabled
[    0.010000] Calibrating delay loop... 797.90 BogoMIPS (lpj=1994752)


>
>> Thank you,
>> Kyungmin Park
>>
>> On Mon, Jul 12, 2010 at 5:32 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>> > Russell,
>> >
>> > Hi,
>> >
>> > Kukjin Kim wrote:
>> >> Russell wrote:
>> >> > So, memory starts at 0x20000000 and finishes at 0x25000000. ?That's
>> > fine.
>> >> > That doesn't mean the section size is 16MB.
>> >> >
>> >> > As I've already said, the section size has _nothing_ what so ever to
> do
>> >> > with the size of memory, or the granularity of the size of memory.
> ?By
>> >> > way of illustration, it is perfectly legal to have a section size of
>> >> > 256MB but only have 1MB in a section and this is perfectly legal. ?So
>> >> > sections do not have to be completely filled.
>> >> >
>> >> Actually, as you know, the hole's area of mem_map is freed from bootmem
> if
>> > a
>> >> section has a hole when initializing sparse memory.
>> >>
>> >> I identified that a section doesn't need to be a contiguous area of
>> > physical
>> >> memory when reading your comment with the fact that the mem_map of a
>> > section
>> >> can be smaller than the size of a section.
>> >>
>> >> I found, however, the kernel panics when modifying min_free_kbytes file
> in
>> >> the proc filesystem if a section has a hole.
>> >>
>> >> While processing the change of min_free_kbytes in the kernel, page
>> >> descriptors in a hole of an online section is accessed.
>> >
>> > As I said, following error happens.
>> > It would be helpful to me if any opinions or comments.
>> >
>> > ---
>
>
> (snip)
>
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
>
