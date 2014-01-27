From: monstr@monstr.eu (Michal Simek)
Date: Mon, 27 Jan 2014 18:45:50 +0100
Subject: [Q] block / zynq: DMA bouncing
In-Reply-To: <20140127170230.GQ15937@n2100.arm.linux.org.uk>
References: <Pine.LNX.4.64.1401271549280.23931@axis700.grange>
 <20140127170230.GQ15937@n2100.arm.linux.org.uk>
Message-ID: <52E69B4E.5010604@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/27/2014 06:02 PM, Russell King - ARM Linux wrote:
> On Mon, Jan 27, 2014 at 04:13:56PM +0100, Guennadi Liakhovetski wrote:
>> I'm working on an MMC driver with a DMA capability. All has been working 
>> well, until at some point I've got a bus error, when the mmc driver had 
>> been handed in a buffer at 0x3000 physical RAM address. The reason is, 
>> that on Zynq arch bus masters cannot access RAM below 0x80000. Therefore 
>> my question: how shall I configure this in software?
> 
> You're going to run into all sorts of problems here.  Normally, the
> DMA-able memory is limited to the first N bytes of memory, not "you must
> avoid the first N bytes of memory".
> 
> Linux has it hard-coded into the memory subsystems that the DMA zone
> is from the start of memory to N, the normal zone is from N to H, and
> high memory is from H upwards - and allocations for high can fall back
> to normal, which can fall back to DMA but not the other way around.
> 
> Short of permanently reserving the first 0x80000 bytes of memory, I'm
> not sure that there's much which can be done.  You may wish to talk to
> the MM gurus to see whether there's a modern alternative.

We use memblock_reserve for allocation of this space in .reserse phase.
Look at git.xilinx.com - linux repo arch/arm/mach-zynq/common.c

/**
 * zynq_memory_init() - Initialize special memory
 *
 * We need to stop things allocating the low memory as DMA can't work in
 * the 1st 512K of memory.  Using reserve vs remove is not totally clear yet.
 */
static void __init zynq_memory_init(void)
{
	/*
	 * Reserve the 0-0x4000 addresses (before page tables and kernel)
	 * which can't be used for DMA
	 */
	if (!__pa(PAGE_OFFSET))
		memblock_reserve(0, 0x4000);
}

DT_MACHINE_START(XILINX_EP107, "Xilinx Zynq Platform")
...
	.reserve	= zynq_memory_init,
...
MACHINE_END


I have checked why we are reserving just 0 - 0x4000 when kernel starts from 0x8000
and maybe Russell can help me with this better.
I got answer that using memblock_reserve was recommended in past for that.

Why 0x4000? IRC Linux for ARM is using space for any purpose.
Russell knows this much better than I.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140127/dfd95526/attachment.sig>
