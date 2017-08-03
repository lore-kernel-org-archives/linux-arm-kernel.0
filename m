From: ryanschaefer23@gmail.com (Ryan Schaefer)
Date: Wed, 2 Aug 2017 17:19:22 -0700
Subject: i.mx7: Changing linux,usable-memory causes BUG: Bad Page
In-Reply-To: <c408df4a688158770ba5a404bea1f608@agner.ch>
References: <CAN1Oqpw835L3Rc-J59_qSJ3toUWH8TD00r=ZcN6quvcnE8mnHQ@mail.gmail.com>
 <c408df4a688158770ba5a404bea1f608@agner.ch>
Message-ID: <CAN1Oqpyho5aJtssa+7_gGhac1h3YiSCunjzPrOA0oFfnX1=Nhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Wed, Aug 2, 2017 at 12:44 PM, Stefan Agner <stefan@agner.ch> wrote:
> Hi Ryan,
>
> On 2017-08-02 09:11, Ryan Schaefer wrote:
>> I am using an i.mx7d based board, and attempting to reserve the lower
>> 2MB of memory for the M4 co-processor.
>>
>> I have changed the textofs-y to 0x208000 to move the kernel extraction
>> past the first 2MB, and everything seems to function correctly. Then,
>> after changing the linux,usable-memory, I get a Bad page BUG. The BUG
>> is the same on every boot, with the same exact two bad pages.This
>> article points to a memory integrity issue:
>> http://archive.armlinux.org.uk/lurker/message/20140729.201750.e26283f6.en.html.
>> I've performed overnight memory stress tests and haven't seen any
>> signs of memory
>> corruption, and the bad pages are the same every time.
>
> I do not have a solution for the Bug issue, but I did something similar
> on i.MX 7 as well using a reserved-memory entry, see:
> https://blog.printk.io/2017/05/i-mx-7-cortex-m4-memory-locations-and-performance/
>
> Its some months ago, but as far as I remember that worked fine.
>

I tried to use only a reserved-memory like in the post above. This
does fix the memory issues that I was seeing, and the kernel and
userspace seem to work great. Thanks for the helpful link.

This does break a kernel module that calls ioremap() on the reserved
memory area in order to reload and restart the M4 from linux. I think
this is because even though the kernel will not use the
reserved-memory region for normal allocations, it still has knowledge
of the area and maps it, which then conflicts with ioremap which maps
the memory with different attributes
(https://lwn.net/Articles/409689/). If I add the "no-map" property to
the reserved-memory node, then I get the same bugs as if I had changed
the usable-memory to start 2MB offset from the start of RAM.

Is there a proper way for drivers to allocate physically contiguous
memory in DDR with known addres?

>>
>> The change that causes the BUG is shown below.
>>
>> memory {
>>         device_type = "memory";
>>         reg = <0x80000000 0x40000000>;
>> -        linux,usable-memory = <0x80000000 0x3ff00000>;
>> +       linux,usable-memory = <0x80200000 0x3fdf0000>;
>> };
>>
>> reserved-memory {
>>         #address-cells = <0x1>;
>>         #size-cells = <0x1>;
>>         ranges;
>>
>>         linux,cma {
>>                 compatible = "shared-dma-pool";
>>                 reusable;
>>                 size = <0x14000000>;
>>                 linux,cma-default;
>>         };
>>
>>         m4 at 80000000 {
>>                 reg = <0x80000000 0x200000>;
>>         };
>
> Isn't that kind of contradicting since you take that exact area away
> from Linux above?
>
> --
> Stefan
>

I think you are right.

-Ryan

>>
>>         rpmsg at BFFF0000 {
>>                 reg = <0xbfff0000 0x10000>;
>>         };
>> };
>>
>> Here is the dmesg that includes the BUG with memblock=debug
>>
>>
>> -00017-g4a54f4f-dirty-20170725-1101
>>
>> U-Boot code: 87800000 -> 87831B64  BSS: -> 878386D4
>> CPU:   Freescale i.MX7D rev1.2 at 792 MHz
>> CPU:   Temperature 33 C
>> Reset cause: POR
>> Board: i.MX7D Heartland Board Rev0
>> DDR3L: 533MHz, init mode PLUGIN
>> I2C:   ready
>> DRAM:  Monitor len: 000386D4
>> Ram size: 40000000
>> Ram top: C0000000
>> TLB table from bfff0000 to bfff4000
>> Reserving 225k for U-Boot at: bffb7000
>> Reserving 32776k for malloc() at: bdfb5000
>> Reserving 80 Bytes for Board Info at: bdfb4fb0
>> Reserving 248 Bytes for Global Data at: bdfb4eb8
>>
>> RAM Configuration:
>> Bank #0: 80000000 1 GiB
>>
>> DRAM:  1 GiB
>> New Stack Pointer is: bdfb4e90
>> Relocation Offset is: 387b7000
>> Relocating to bffb7000, new gd at bdfb4eb8, sp at bdfb4e90
>> PMIC: PFUZE300 DEV_ID=0x30 REV_ID=0x11
>> MMC:   FSL_SDHC: 0
>> In:    serial
>> Out:   serial
>> Err:   serial
>> Authentication key not yet programmed
>> ERR: failed to read mac from rpmb
>> Normal Boot
>> Hit any key to stop autoboot:  3     2     1     0
>> 65104 bytes read in 79 ms (804.7 KiB/s)
>> ## Starting auxiliary core at 0x80000000 ...
>> switch to partitions #0, OK
>> mmc0(part 0) is current device
>> switch to partitions #0, OK
>> mmc0(part 0) is current device
>> Checking for rescue mode
>> ** File not found boot.scr **
>> 4449688 bytes read in 182 ms (23.3 MiB/s)
>> Booting from mmc ...
>> 38467 bytes read in 53 ms (708 KiB/s)
>> Kernel image @ 0x80800000 [ 0x000000 - 0x43e598 ]
>> ## Flattened Device Tree blob at 83000000
>>    Booting using the fdt blob at 0x83000000
>>    Using Device Tree in place at 83000000, end 8300c642
>>
>> Starting kernel ...
>>
>> Uncompressing Linux... done, booting the kernel.
>> Booting Linux on physical CPU 0x0
>> Linux version 4.1.15+ (rschaefe at beast) (gcc version 5.3.0 (Timesys
>> 20170419) ) #19 SMP PREEMPT Thu Jul 27 09:11:34 PDT 2017
>> CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c53c7d
>> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
>> Machine model: Freescale i.MX7D Heartland Board
>> memblock_reserve: [0x000000802082c0-0x00000080a34deb] flags 0x0
>> arm_memblock_init+0x30/0x194
>> memblock_reserve: [0x00000080204000-0x00000080207fff] flags 0x0
>> arm_memblock_init+0x140/0x194
>> memblock_reserve: [0x00000083000000-0x00000083009fff] flags 0x0
>> early_init_fdt_scan_reserved_mem+0x34/0x8c
>> memblock_reserve: [0x00000083000000-0x00000083009fff] flags 0x0
>> early_init_fdt_scan_reserved_mem+0x6c/0x8c
>> memblock_reserve: [0x00000080000000-0x000000801fffff] flags 0x0
>> __fdt_scan_reserved_mem+0x218/0x2a0
>> memblock_reserve: [0x000000bfff0000-0x000000bfffffff] flags 0x0
>> __fdt_scan_reserved_mem+0x218/0x2a0
>> memblock_reserve: [0x000000aa000000-0x000000bdffffff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> Reserved memory: created CMA memory pool at 0xaa000000, size 320 MiB
>> Reserved memory: initialized node linux,cma, compatible id shared-dma-pool
>> MEMBLOCK configuration:
>>  memory size = 0x3fdf0000 reserved size = 0x14a4ab2c
>>  memory.cnt  = 0x1
>>  memory[0x0]    [0x00000080200000-0x000000bffeffff], 0x3fdf0000 bytes flags: 0x0
>>  reserved.cnt  = 0x6
>>  reserved[0x0]    [0x00000080000000-0x000000801fffff], 0x200000 bytes flags: 0x0
>>  reserved[0x1]    [0x00000080204000-0x00000080207fff], 0x4000 bytes flags: 0x0
>>  reserved[0x2]    [0x000000802082c0-0x00000080a34deb], 0x82cb2c bytes flags: 0x0
>>  reserved[0x3]    [0x00000083000000-0x00000083009fff], 0xa000 bytes flags: 0x0
>>  reserved[0x4]    [0x000000aa000000-0x000000bdffffff], 0x14000000
>> bytes flags: 0x0
>>  reserved[0x5]    [0x000000bfff0000-0x000000bfffffff], 0x10000 bytes flags: 0x0
>> Memory policy: Data cache writealloc
>> memblock_reserve: [0x000000bfdff000-0x000000bfdfffff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdfefd8-0x000000bfdfefff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdfd000-0x000000bfdfdfff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdfc000-0x000000bfdfcfff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdfb000-0x000000bfdfbfff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdfa000-0x000000bfdfafff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdf9000-0x000000bfdf9fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdf8000-0x000000bfdf8fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdf7000-0x000000bfdf7fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdf6000-0x000000bfdf6fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdf5000-0x000000bfdf5fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdf4000-0x000000bfdf4fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdf3000-0x000000bfdf3fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdf2000-0x000000bfdf2fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdf1000-0x000000bfdf1fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdf0000-0x000000bfdf0fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdef000-0x000000bfdeffff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdee000-0x000000bfdeefff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfded000-0x000000bfdedfff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdec000-0x000000bfdecfff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdeb000-0x000000bfdebfff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdea000-0x000000bfdeafff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfde9000-0x000000bfde9fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfde8000-0x000000bfde8fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfde7000-0x000000bfde7fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfde6000-0x000000bfde6fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfde5000-0x000000bfde5fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfde4000-0x000000bfde4fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfde3000-0x000000bfde3fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfde2000-0x000000bfde2fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfde1000-0x000000bfde1fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfde0000-0x000000bfde0fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfddf000-0x000000bfddffff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdde000-0x000000bfddefff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfddd000-0x000000bfdddfff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfddc000-0x000000bfddcfff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfddb000-0x000000bfddbfff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdda000-0x000000bfddafff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdd9000-0x000000bfdd9fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdd8000-0x000000bfdd8fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdd7000-0x000000bfdd7fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdd6000-0x000000bfdd6fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdd5000-0x000000bfdd5fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdd4000-0x000000bfdd4fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdd3000-0x000000bfdd3fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdd2000-0x000000bfdd2fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdd1000-0x000000bfdd1fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdd0000-0x000000bfdd0fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdcf000-0x000000bfdcffff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdce000-0x000000bfdcefff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdcd000-0x000000bfdcdfff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdcc000-0x000000bfdccfff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdcb000-0x000000bfdcbfff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdca000-0x000000bfdcafff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdc9000-0x000000bfdc9fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdc8000-0x000000bfdc8fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdc7000-0x000000bfdc7fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdc6000-0x000000bfdc6fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdc5000-0x000000bfdc5fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdc4000-0x000000bfdc4fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdc3000-0x000000bfdc3fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdc2000-0x000000bfdc2fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdc1000-0x000000bfdc1fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdc0000-0x000000bfdc0fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdbf000-0x000000bfdbffff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdbe000-0x000000bfdbefff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdbd000-0x000000bfdbdfff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdbc000-0x000000bfdbcfff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdbb000-0x000000bfdbbfff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdba000-0x000000bfdbafff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdb9000-0x000000bfdb9fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdb8000-0x000000bfdb8fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdb7000-0x000000bfdb7fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdb6000-0x000000bfdb6fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdb5000-0x000000bfdb5fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdb4000-0x000000bfdb4fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdb3000-0x000000bfdb3fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdb2000-0x000000bfdb2fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdb1000-0x000000bfdb1fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdb0000-0x000000bfdb0fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdaf000-0x000000bfdaffff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdae000-0x000000bfdaefff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdad000-0x000000bfdadfff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdac000-0x000000bfdacfff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdab000-0x000000bfdabfff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdaa000-0x000000bfdaafff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfda9000-0x000000bfda9fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfda8000-0x000000bfda8fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfda7000-0x000000bfda7fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfda6000-0x000000bfda6fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfda5000-0x000000bfda5fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfda4000-0x000000bfda4fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfda3000-0x000000bfda3fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfda2000-0x000000bfda2fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfda1000-0x000000bfda1fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfda0000-0x000000bfda0fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd9f000-0x000000bfd9ffff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd9e000-0x000000bfd9efff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd9d000-0x000000bfd9dfff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd9c000-0x000000bfd9cfff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd9b000-0x000000bfd9bfff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd9a000-0x000000bfd9afff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd99000-0x000000bfd99fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd98000-0x000000bfd98fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd97000-0x000000bfd97fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd96000-0x000000bfd96fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd95000-0x000000bfd95fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd94000-0x000000bfd94fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd93000-0x000000bfd93fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd92000-0x000000bfd92fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd91000-0x000000bfd91fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd90000-0x000000bfd90fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd8f000-0x000000bfd8ffff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd8e000-0x000000bfd8efff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd8d000-0x000000bfd8dfff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd8c000-0x000000bfd8cfff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd8b000-0x000000bfd8bfff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd8a000-0x000000bfd8afff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd89000-0x000000bfd89fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd88000-0x000000bfd88fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd87000-0x000000bfd87fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd86000-0x000000bfd86fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd85000-0x000000bfd85fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd84000-0x000000bfd84fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd83000-0x000000bfd83fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd82000-0x000000bfd82fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd81000-0x000000bfd81fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd80000-0x000000bfd80fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd7f000-0x000000bfd7ffff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd7e000-0x000000bfd7efff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd7d000-0x000000bfd7dfff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd7c000-0x000000bfd7cfff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd7b000-0x000000bfd7bfff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd7a000-0x000000bfd7afff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd79000-0x000000bfd79fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd78000-0x000000bfd78fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd77000-0x000000bfd77fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd76000-0x000000bfd76fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd75000-0x000000bfd75fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd74000-0x000000bfd74fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd73000-0x000000bfd73fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd72000-0x000000bfd72fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd71000-0x000000bfd71fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd70000-0x000000bfd70fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd6f000-0x000000bfd6ffff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd6e000-0x000000bfd6efff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd6d000-0x000000bfd6dfff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd6c000-0x000000bfd6cfff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd6b000-0x000000bfd6bfff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd6a000-0x000000bfd6afff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd69000-0x000000bfd69fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd68000-0x000000bfd68fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd67000-0x000000bfd67fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd66000-0x000000bfd66fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd65000-0x000000bfd65fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd64000-0x000000bfd64fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd63000-0x000000bfd63fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd62000-0x000000bfd62fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd61000-0x000000bfd61fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd60000-0x000000bfd60fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd5f000-0x000000bfd5ffff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd5e000-0x000000bfd5efff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd5c000-0x000000bfd5dfff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd5b000-0x000000bfd5bfff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdfefb0-0x000000bfdfefd7] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd5a000-0x000000bfd5afff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdfef38-0x000000bfdfefaf] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdfef10-0x000000bfdfef37] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdfeee8-0x000000bfdfef0f] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdfeec0-0x000000bfdfeee7] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdfee98-0x000000bfdfeebf] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdfee70-0x000000bfdfee97] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd59000-0x000000bfd59fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd58000-0x000000bfd58fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfd57000-0x000000bfd57fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> early_memtest: # of tests: 1
>>   0080200000 - 0080204000 pattern 0000000000000000
>>   0080208000 - 00802082c0 pattern 0000000000000000
>>   0080a34dec - 0083000000 pattern 0000000000000000
>>   008300a000 - 00aa000000 pattern 0000000000000000
>>   00be000000 - 00bfd57000 pattern 0000000000000000
>>   00bfdfe000 - 00bfdfee70 pattern 0000000000000000
>> memblock_virt_alloc_try_nid_nopanic: 8388608 bytes align=0x0 nid=0
>> from=0x0 max_addr=0x0 alloc_node_mem_map.constprop.7+0x64/0x8c
>> memblock_reserve: [0x000000bf557000-0x000000bfd56fff] flags 0x0
>> memblock_virt_alloc_internal+0x12c/0x150
>> memblock_virt_alloc_try_nid_nopanic: 16 bytes align=0x0 nid=0 from=0x0
>> max_addr=0x0 free_area_init_node+0x2b4/0x350
>> memblock_reserve: [0x000000bfdfee40-0x000000bfdfee4f] flags 0x0
>> memblock_virt_alloc_internal+0x12c/0x150
>> memblock_virt_alloc_try_nid_nopanic: 12288 bytes align=0x0 nid=0
>> from=0x0 max_addr=0x0 zone_wait_table_init+0x78/0xe4
>> memblock_reserve: [0x000000bf554000-0x000000bf556fff] flags 0x0
>> memblock_virt_alloc_internal+0x12c/0x150
>> memblock_virt_alloc_try_nid_nopanic: 4 bytes align=0x0 nid=0 from=0x0
>> max_addr=0x0 free_area_init_node+0x2b4/0x350
>> memblock_reserve: [0x000000bfdfee00-0x000000bfdfee03] flags 0x0
>> memblock_virt_alloc_internal+0x12c/0x150
>> memblock_virt_alloc_try_nid_nopanic: 48 bytes align=0x0 nid=0 from=0x0
>> max_addr=0x0 zone_wait_table_init+0x78/0xe4
>> memblock_reserve: [0x000000bfdfedc0-0x000000bfdfedef] flags 0x0
>> memblock_virt_alloc_internal+0x12c/0x150
>> memblock_virt_alloc_try_nid: 28 bytes align=0x0 nid=-1 from=0x0
>> max_addr=0x0 setup_arch+0x5f8/0x94c
>> memblock_reserve: [0x000000bfdfed80-0x000000bfdfed9b] flags 0x0
>> memblock_virt_alloc_internal+0x12c/0x150
>> memblock_reserve: [0x000000bf539f2c-0x000000bf553fff] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdfee54-0x000000bfdfee6c] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdfee24-0x000000bfdfee3c] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdfee08-0x000000bfdfee20] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdfeda4-0x000000bfdfedbc] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdfed64-0x000000bfdfed7c] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdfed48-0x000000bfdfed60] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdfed2c-0x000000bfdfed44] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdfed14-0x000000bfdfed2b] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdfecfc-0x000000bfdfed13] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdfece4-0x000000bfdfecfb] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdfeccc-0x000000bfdfece3] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdfecb4-0x000000bfdfeccb] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdfec9c-0x000000bfdfecb3] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdfec84-0x000000bfdfec9b] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdfec68-0x000000bfdfec82] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdfec4c-0x000000bfdfec66] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdfec30-0x000000bfdfec4a] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdfec14-0x000000bfdfec2e] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdfebf8-0x000000bfdfec12] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdfebdc-0x000000bfdfebf6] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdfebc0-0x000000bfdfebda] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdfeba8-0x000000bfdfebbf] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdfeb90-0x000000bfdfeba7] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdfeb78-0x000000bfdfeb8f] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_reserve: [0x000000bfdfeb60-0x000000bfdfeb77] flags 0x0
>> memblock_alloc_range_nid+0x38/0x4c
>> memblock_virt_alloc_try_nid: 155 bytes align=0x0 nid=-1 from=0x0
>> max_addr=0x0 start_kernel+0xc8/0x3a8
>> memblock_reserve: [0x000000bfdfeac0-0x000000bfdfeb5a] flags 0x0
>> memblock_virt_alloc_internal+0x12c/0x150
>> memblock_virt_alloc_try_nid: 155 bytes align=0x0 nid=-1 from=0x0
>> max_addr=0x0 start_kernel+0xec/0x3a8
>> memblock_reserve: [0x000000bfdfea00-0x000000bfdfea9a] flags 0x0
>> memblock_virt_alloc_internal+0x12c/0x150
>> memblock_virt_alloc_try_nid: 155 bytes align=0x0 nid=-1 from=0x0
>> max_addr=0x0 start_kernel+0x110/0x3a8
>> memblock_reserve: [0x000000bfdfe940-0x000000bfdfe9da] flags 0x0
>> memblock_virt_alloc_internal+0x12c/0x150
>> memblock_virt_alloc_try_nid_nopanic: 4096 bytes align=0x0 nid=-1
>> from=0x0 max_addr=0x0 pcpu_alloc_alloc_info+0x4c/0x88
>> memblock_reserve: [0x000000bf538f00-0x000000bf539eff] flags 0x0
>> memblock_virt_alloc_internal+0x12c/0x150
>> memblock_virt_alloc_try_nid_nopanic: 4096 bytes align=0x0 nid=-1
>> from=0x0 max_addr=0x0 pcpu_embed_first_chunk+0x470/0x6f4
>> memblock_reserve: [0x000000bf537f00-0x000000bf538eff] flags 0x0
>> memblock_virt_alloc_internal+0x12c/0x150
>> memblock_virt_alloc_try_nid_nopanic: 98304 bytes align=0x1000 nid=-1
>> from=0xffffffff max_addr=0x0 pcpu_dfl_fc_alloc+0x24/0x2c
>> memblock_reserve: [0x000000bf51f000-0x000000bf536fff] flags 0x0
>> memblock_virt_alloc_internal+0x12c/0x150
>> __memblock_free_early: [0x000000bf52b000-0x000000bf52afff]
>> pcpu_embed_first_chunk+0x5b4/0x6f4
>> __memblock_free_early: [0x000000bf537000-0x000000bf536fff]
>> pcpu_embed_first_chunk+0x5b4/0x6f4
>> PERCPU: Embedded 12 pages/cpu @bf51f000 s16908 r8192 d24052 u49152
>> memblock_virt_alloc_try_nid: 4 bytes align=0x0 nid=-1 from=0x0
>> max_addr=0x0 pcpu_setup_first_chunk+0x154/0x7b0
>> memblock_reserve: [0x000000bfdfe900-0x000000bfdfe903] flags 0x0
>> memblock_virt_alloc_internal+0x12c/0x150
>> memblock_virt_alloc_try_nid: 4 bytes align=0x0 nid=-1 from=0x0
>> max_addr=0x0 pcpu_setup_first_chunk+0x174/0x7b0
>> memblock_reserve: [0x000000bfdfe8c0-0x000000bfdfe8c3] flags 0x0
>> memblock_virt_alloc_internal+0x12c/0x150
>> memblock_virt_alloc_try_nid: 8 bytes align=0x0 nid=-1 from=0x0
>> max_addr=0x0 pcpu_setup_first_chunk+0x194/0x7b0
>> memblock_reserve: [0x000000bfdfe880-0x000000bfdfe887] flags 0x0
>> memblock_virt_alloc_internal+0x12c/0x150
>> memblock_virt_alloc_try_nid: 8 bytes align=0x0 nid=-1 from=0x0
>> max_addr=0x0 pcpu_setup_first_chunk+0x1b4/0x7b0
>> memblock_reserve: [0x000000bfdfe840-0x000000bfdfe847] flags 0x0
>> memblock_virt_alloc_internal+0x12c/0x150
>> memblock_virt_alloc_try_nid: 120 bytes align=0x0 nid=-1 from=0x0
>> max_addr=0x0 pcpu_setup_first_chunk+0x520/0x7b0
>> memblock_reserve: [0x000000bfdfe7c0-0x000000bfdfe837] flags 0x0
>> memblock_virt_alloc_internal+0x12c/0x150
>> memblock_virt_alloc_try_nid: 68 bytes align=0x0 nid=-1 from=0x0
>> max_addr=0x0 pcpu_setup_first_chunk+0x570/0x7b0
>> memblock_reserve: [0x000000bfdfe740-0x000000bfdfe783] flags 0x0
>> memblock_virt_alloc_internal+0x12c/0x150
>> memblock_virt_alloc_try_nid: 68 bytes align=0x0 nid=-1 from=0x0
>> max_addr=0x0 pcpu_setup_first_chunk+0x6a4/0x7b0
>> memblock_reserve: [0x000000bfdfe6c0-0x000000bfdfe703] flags 0x0
>> memblock_virt_alloc_internal+0x12c/0x150
>> __memblock_free_early: [0x000000bf538f00-0x000000bf539eff]
>> pcpu_embed_first_chunk+0x67c/0x6f4
>> __memblock_free_early: [0x000000bf537f00-0x000000bf538eff]
>> pcpu_embed_first_chunk+0x6cc/0x6f4
>> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 259576
>> Kernel command line: console=ttymxc0,115200 logo_index=2
>> clk_ignore_unused root=/dev/mmcblk2p1 rootfstype=ext4 rootwait rw
>> eartlyprintk user_deubug=31 memtest=1 memblock=debug
>> memblock_virt_alloc_try_nid_nopanic: 16384 bytes align=0x0 nid=-1
>> from=0x0 max_addr=0x0 alloc_large_system_hash+0x148/0x250
>> memblock_reserve: [0x000000bf51b000-0x000000bf51efff] flags 0x0
>> memblock_virt_alloc_internal+0x12c/0x150
>> PID hash table entries: 4096 (order: 2, 16384 bytes)
>> memblock_virt_alloc_try_nid_nopanic: 524288 bytes align=0x0 nid=-1
>> from=0x0 max_addr=0x0 alloc_large_system_hash+0x148/0x250
>> memblock_reserve: [0x000000bf49b000-0x000000bf51afff] flags 0x0
>> memblock_virt_alloc_internal+0x12c/0x150
>> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
>> memblock_virt_alloc_try_nid_nopanic: 262144 bytes align=0x0 nid=-1
>> from=0x0 max_addr=0x0 alloc_large_system_hash+0x148/0x250
>> memblock_reserve: [0x000000bf45b000-0x000000bf49afff] flags 0x0
>> memblock_virt_alloc_internal+0x12c/0x150
>> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
>> BUG: Bad page state in process swapper  pfn:bff8c
>> page:bfd5a180 count:0 mapcount:0 mapping:  (null) index:0x0
>> flags: 0x70860253(locked|error|dirty|active|arch_1|mappedtodisk|reclaim)
>> page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
>> bad because of flags:
>> flags: 0x41(locked|active)
>> Modules linked in:
>> CPU: 0 PID: 0 Comm: swapper Not tainted 4.1.15+ #19
>> Hardware name: Freescale i.MX7 Dual (Device Tree)
>> [<80215e78>] (unwind_backtrace) from [<802127dc>] (show_stack+0x10/0x14)
>> [<802127dc>] (show_stack) from [<80729910>] (dump_stack+0x84/0xc4)
>> [<80729910>] (dump_stack) from [<802b31ec>] (bad_page+0xcc/0x11c)
>> [<802b31ec>] (bad_page) from [<802b3464>] (free_pages_prepare+0x228/0x28c)
>> [<802b3464>] (free_pages_prepare) from [<802b5338>]
>> (free_hot_cold_page+0x34/0x198)
>> [<802b5338>] (free_hot_cold_page) from [<802b56fc>]
>> (free_highmem_page+0x28/0x78)
>> [<802b56fc>] (free_highmem_page) from [<809451a8>] (mem_init+0x210/0x404)
>> [<809451a8>] (mem_init) from [<8093facc>] (start_kernel+0x1fc/0x3a8)
>> [<8093facc>] (start_kernel) from [<8020807c>] (0x8020807c)
>> Disabling lock debugging due to kernel taint
>> BUG: Bad page state in process swapper  pfn:bffcc
>> page:bfd5a980 count:0 mapcount:0 mapping:  (null) index:0x0
>> flags: 0x70860053(locked|error|dirty|active|mappedtodisk|reclaim)
>> page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
>> bad because of flags:
>> flags: 0x41(locked|active)
>> Modules linked in:
>> CPU: 0 PID: 0 Comm: swapper Tainted: G    B           4.1.15+ #19
>> Hardware name: Freescale i.MX7 Dual (Device Tree)
>> [<80215e78>] (unwind_backtrace) from [<802127dc>] (show_stack+0x10/0x14)
>> [<802127dc>] (show_stack) from [<80729910>] (dump_stack+0x84/0xc4)
>> [<80729910>] (dump_stack) from [<802b31ec>] (bad_page+0xcc/0x11c)
>> [<802b31ec>] (bad_page) from [<802b3464>] (free_pages_prepare+0x228/0x28c)
>> [<802b3464>] (free_pages_prepare) from [<802b5338>]
>> (free_hot_cold_page+0x34/0x198)
>> [<802b5338>] (free_hot_cold_page) from [<802b56fc>]
>> (free_highmem_page+0x28/0x78)
>> [<802b56fc>] (free_highmem_page) from [<809451a8>] (mem_init+0x210/0x404)
>> [<809451a8>] (mem_init) from [<8093facc>] (start_kernel+0x1fc/0x3a8)
>> [<8093facc>] (start_kernel) from [<8020807c>] (0x8020807c)
>> Memory: 700480K/1046464K available (5428K kernel code, 235K rwdata,
>> 1956K rodata, 364K init, 375K bss, 18296K reserved, 327680K
>> cma-reserved, 1984K highmem)
>> Virtual kernel memory layout:
>>     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>>     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
>>     vmalloc : 0xc0000000 - 0xff000000   (1008 MB)
>>     lowmem  : 0x80000000 - 0xbfff0000   (1023 MB)
>>     pkmap   : 0x7fe00000 - 0x80000000   (   2 MB)
>>     modules : 0x7f000000 - 0x7fe00000   (  14 MB)
>>       .text : 0x80208000 - 0x8093e300   (7385 kB)
>>       .init : 0x8093f000 - 0x8099a000   ( 364 kB)
>>       .data : 0x8099a000 - 0x809d4ce0   ( 236 kB)
>>        .bss : 0x809d7000 - 0x80a34dec   ( 376 kB)
>> SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
>> Preemptible hierarchical RCU implementation.
>>     Additional per-CPU info printed with stalls.
>>     RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
>> RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
>> NR_IRQS:16 nr_irqs:16 16
>> Architected cp15 timer(s) running at 8.00MHz (phys).
>> clocksource arch_sys_counter: mask: 0xffffffffffffff max_cycles:
>> 0x1d854df40, max_idle_ns: 440795202120 ns
>> sched_clock: 56 bits at 8MHz, resolution 125ns, wraps every 2199023255500ns
>> Switching to timer-based delay loop, resolution 125ns
>> mxc_clocksource_init 3000000
>> Ignoring duplicate/late registration of read_current_timer delay
>> clocksource mxc_timer1: mask: 0xffffffff max_cycles: 0xffffffff,
>> max_idle_ns: 637086815595 ns
>> Console: colour dummy device 80x30
>> Calibrating delay loop (skipped), value calculated using timer
>> frequency.. 16.00 BogoMIPS (lpj=80000)
>> pid_max: default: 32768 minimum: 301
>> Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
>> Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
>> CPU: Testing write buffer coherency: ok
>> /cpus/cpu at 0 missing clock-frequency property
>> /cpus/cpu at 1 missing clock-frequency property
>> CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
>> Setting up static identity map for 0x802082c0 - 0x80208318
>> CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
>> Brought up 2 CPUs
>> SMP: Total of 2 processors activated (32.00 BogoMIPS).
>> CPU: All CPU(s) started in SVC mode.
>> devtmpfs: initialized
>> VFP support v0.3: implementor 41 architecture 2 part 30 variant 7 rev 5
>> clocksource jiffies: mask: 0xffffffff max_cycles: 0xffffffff,
>> max_idle_ns: 19112604462750000 ns
>> pinctrl core: initialized pinctrl subsystem
>> NET: Registered protocol family 16
>> DMA: preallocated 256 KiB pool for atomic coherent allocations
>> cpuidle: using governor ladder
>> cpuidle: using governor menu
>> DDR type is DDR3!
>> hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
>> hw-breakpoint: maximum watchpoint size is 8 bytes.
>> imx7d-pinctrl 302c0000.iomuxc-lpsr: initialized IMX pinctrl driver
>> imx7d-pinctrl 30330000.iomuxc: initialized IMX pinctrl driver
>> MU is ready for cross core communication!
>> mxs-dma 33000000.dma-apbh: initialized
>> SCSI subsystem initialized
>> usbcore: registered new interface driver usbfs
>> usbcore: registered new interface driver hub
>> usbcore: registered new device driver usb
>> 30800000.aips-bus:usbphy_nop1 supply vcc not found, using dummy regulator
>> 30800000.aips-bus:usbphy_nop2 supply vcc not found, using dummy regulator
>> i2c i2c-0: IMX I2C adapter registered
>> i2c i2c-0: can't use DMA
>> i2c i2c-1: IMX I2C adapter registered
>> i2c i2c-1: can't use DMA
>> i2c i2c-2: IMX I2C adapter registered
>> i2c i2c-2: can't use DMA
>> i2c i2c-3: IMX I2C adapter registered
>> i2c i2c-3: can't use DMA
>> Linux video capture interface: v2.00
>> pps_core: LinuxPPS API ver. 1 registered
>> pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti
>> <giometti@linux.it>
>> PTP clock support registered
>> MIPI CSI2 driver module loaded
>> Advanced Linux Sound Architecture Driver Initialized.
>> Switched to clocksource arch_sys_counter
>> NET: Registered protocol family 2
>> TCP established hash table entries: 8192 (order: 3, 32768 bytes)
>> TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
>> TCP: Hash tables configured (established 8192 bind 8192)
>> UDP hash table entries: 512 (order: 2, 16384 bytes)
>> UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
>> NET: Registered protocol family 1
>> imx rpmsg driver is registered.
>> Bus freq driver module loaded
>> futex hash table entries: 512 (order: 3, 32768 bytes)
>> VFS: Disk quotas dquot_6.6.0
>> VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
>> bounce: pool size: 64 pages
>> io scheduler noop registered
>> io scheduler deadline registered
>> io scheduler cfq registered (default)
>> mxsfb 30730000.lcdif: failed to find mxc display driver
>> mxsfb 30730000.lcdif: initialized
>> imx-sdma 30bd0000.sdma: no iram assigned, using external mem
>> imx-sdma 30bd0000.sdma: no event needs to be remapped
>> imx-sdma 30bd0000.sdma: loaded firmware 4.2
>> imx-sdma 30bd0000.sdma: initialized
>> pfuze100-regulator 0-0008: Full layer: 1, Metal layer: 1
>> pfuze100-regulator 0-0008: FAB: 0, FIN: 0
>> pfuze100-regulator 0-0008: pfuze3000 found.
>> 30860000.serial: ttymxc0 at MMIO 0x30860000 (irq = 206, base_baud =
>> 1500000) is a IMX
>> console [ttymxc0] enabled
>> imx sema4 driver is registered.
>> [drm] Initialized drm 1.1.0 20060810
>> [drm] Initialized vivante 1.0.0 20120216 on minor 0
>> brd: module loaded
>> loop: module loaded
>> 30bf0000.ethernet supply phy not found, using dummy regulator
>> pps pps0: new PPS source ptp0
>> fec 30bf0000.ethernet (unnamed net_device) (uninitialized): Invalid
>> MAC address: 00:00:00:00:00:00
>> fec 30bf0000.ethernet (unnamed net_device) (uninitialized): Using
>> random MAC address: 4e:32:a8:60:6f:3e
>> libphy: fec_enet_mii_bus: probed
>> fec 30bf0000.ethernet eth0: registered PHC device 0
>> usbcore: registered new interface driver asix
>> usbcore: registered new interface driver ax88179_178a
>> usbcore: registered new interface driver cdc_ether
>> usbcore: registered new interface driver cdc_subset
>> usbcore: registered new interface driver cdc_ncm
>> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
>> ehci-mxc: Freescale On-Chip EHCI Host driver
>> usbcore: registered new interface driver usb-storage
>> usbcore: registered new interface driver usb_ehset_test
>> 30b10200.usbmisc supply vbus-wakeup not found, using dummy regulator
>> 30b20200.usbmisc supply vbus-wakeup not found, using dummy regulator
>> 30b30200.usbmisc supply vbus-wakeup not found, using dummy regulator
>> ci_hdrc ci_hdrc.1: EHCI Host Controller
>> ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus number 1
>> ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00
>> hub 1-0:1.0: USB hub found
>> hub 1-0:1.0: 1 port detected
>> mousedev: PS/2 mouse device common for all mice
>> input: 30370000.snvs:snvs-powerkey as
>> /devices/platform/soc/30000000.aips-bus/30370000.snvs/30370000.snvs:snvs-powerkey/input/input0
>> snvs_rtc 30370000.snvs:snvs-rtc-lp: rtc core: registered
>> 30370000.snvs:snvs- as rtc0
>> i2c /dev entries driver
>> pxp-v4l2 pxp_v4l2_out: initialized
>> bq27x00-battery 1-0055: support ver. 1.2.0 enabled
>> imx2-wdt 30280000.wdog: use WDOG_B to reboot.
>> imx2-wdt 30280000.wdog: timeout 60 sec (nowayout=0)
>> sdhci: Secure Digital Host Controller Interface driver
>> sdhci: Copyright(c) Pierre Ossman
>> sdhci-pltfm: SDHCI platform and OF driver helper
>> /soc/aips-bus at 30800000/usdhc at 30b60000: voltage-ranges unspecified
>> sdhci-esdhc-imx 30b60000.usdhc: No vmmc regulator found
>> sdhci-esdhc-imx 30b60000.usdhc: No vqmmc regulator found
>> mmc2: SDHCI controller on 30b60000.usdhc [30b60000.usdhc] using ADMA
>> caam 30900000.caam: Entropy delay = 3200
>> caam 30900000.caam: Instantiated RNG4 SH0
>> mmc2: MAN_BKOPS_EN bit is not set
>> caam 30900000.caam: Instantiated RNG4 SH1
>> caam 30900000.caam: device ID = 0x0a16030000000000 (Era -524)
>> caam 30900000.caam: job rings = 3, qi = 0
>> mmc2: new HS200 MMC card at address 0001
>> mmcblk2: mmc2:0001 W10004 1.78 GiB
>> mmcblk2boot0: mmc2:0001 W10004 partition 1 4.00 MiB
>> mmcblk2boot1: mmc2:0001 W10004 partition 2 4.00 MiB
>> mmcblk2rpmb: mmc2:0001 W10004 partition 3 4.00 MiB
>>  mmcblk2: p1 p2 p3 < p5 p6 >
>> usb 1-1: new high-speed USB device number 2 using ci_hdrc
>> caam algorithms registered in /proc/crypto
>> caam_jr 30901000.jr0: registering rng-caam
>> snvs-secvio 30370000.caam-snvs: can't get snvs clock
>> snvs-secvio 30370000.caam-snvs: violation handlers armed - non-secure state
>> usbcore: registered new interface driver usbhid
>> usbhid: USB HID core driver
>> imx-mqs sound: failed to find cpu dai device
>> imx-mqs: probe of sound failed with error -22
>> NET: Registered protocol family 26
>> NET: Registered protocol family 17
>> cpu cpu0: dev_pm_opp_get_opp_count: device OPP not found (-19)
>> snvs_rtc 30370000.snvs:snvs-rtc-lp: setting system clock to 1970-01-03
>> 06:30:55 UTC (196255)
>> backlight-pwm-supply: disabling
>> clk: Not disabling unused clocks
>> ALSA device list:
>>   No soundcards found.
>> EXT4-fs (mmcblk2p1): mounted filesystem with ordered data mode. Opts: (null)
>> VFS: Mounted root (ext4 filesystem) on device 179:1.
>> devtmpfs: mounted
>> Freeing unused kernel memory: 364K (8093f000 - 8099a000)
>> init started: BusyBox v1.24.2 (2017-06-14 11:09:03 PDT)
>> EXT4-fs (mmcblk2p1): re-mounted. Opts: data=ordered
>> Setting hotplug handler: [ OK ]
>> Creating device files: ax88179_178a 1-1:1.0 eth1: register
>> 'ax88179_178a' at usb-ci_hdrc.1-1, ASIX AX88179 USB 3.0 Gigabit
>> Ethernet, 8c:ae:4c:f4:5a:7f
>> Auto-mount of [/media/mmcblk2p1] successful
>> EXT3-fs (mmcblk2p2): error: couldn't mount because of unsupported
>> optional features (240)
>> EXT4-fs (mmcblk2p2): couldn't mount as ext2 due to feature incompatibilities
>> EXT4-fs (mmcblk2p2): mounted filesystem with ordered data mode. Opts: (null)
>> Auto-mount of [/media/mmcblk2p2] successful
>> EXT3-fs (mmcblk2p3): error: unable to read superblock
>> EXT4-fs (mmcblk2p3): unable to read superblock
>> EXT4-fs (mmcblk2p3): unable to read superblock
>> EXT3-fs (mmcblk2p5): error: couldn't mount because of unsupported
>> optional features (240)
>> EXT4-fs (mmcblk2p5): couldn't mount as ext2 due to feature incompatibilities
>> EXT4-fs (mmcblk2p5): mounted filesystem with ordered data mode. Opts: (null)
>> Auto-mount of [/media/mmcblk2p5] successful
>> EXT3-fs (mmcblk2p6): error: couldn't mount because of unsupported
>> optional features (240)
>> EXT4-fs (mmcblk2p6): couldn't mount as ext2 due to feature incompatibilities
>> EXT4-fs (mmcblk2p6): mounted filesystem with ordered data mode. Opts: (null)
>> Auto-mount of [/media/mmcblk2p6] successful
>> [ OK ]
>> Setting timezone and system clock: [OK]
>> Starting system logging.
>> Restoring asound.state: alsactl: load_state:1735: No soundcards found...
>> [ FAILED ]
>> Configuring network interfaces: ifdown: interface lo not configured
>> done
>> Starting dbus daemon: random: dbus-daemon urandom read with 17 bits of
>> entropy available
>> OK
>> Starting wpa_supplicant: [FAIL]
>> --- No wireless interface found ---
>> /etc/init.d/S30-pulseaudio: Creating system user 'pulse' with generic
>> settings.  Review and modify as required.
>> Starting dropbear sshd: OK
>> Finding touchscreen using legacy method:[FAIL]
>>
>>
>> BusyBox v1.24.2 (2017-06-14 11:09:03 PDT) built-in shell (ash)
>> Enter 'help' for a list of built-in commands.
>>
>> #
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
