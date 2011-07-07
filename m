From: alchark@gmail.com (Alexey Charkov)
Date: Thu, 7 Jul 2011 11:13:26 +0400
Subject: [PATCH 1/6 v8] ARM: Add basic architecture support for
	VIA/WonderMedia 85xx SoC's
In-Reply-To: <20110706123417.GA25400@n2100.arm.linux.org.uk>
References: <1289147348-31969-1-git-send-email-alchark@gmail.com>
	<20101107165745.GB1759@n2100.arm.linux.org.uk>
	<AANLkTimFJ=Brx4pDiUqZOKDfABaDg0s_yFC7EkZGi7D8@mail.gmail.com>
	<20101107171726.GF1759@n2100.arm.linux.org.uk>
	<20101108171930.GA1471@alchark-u3s.lan>
	<20101111212322.GA15533@alchark-u3s.lan>
	<20101111234957.GA28735@n2100.arm.linux.org.uk>
	<20101219174017.GA31832@alchark-u3s>
	<20110706123417.GA25400@n2100.arm.linux.org.uk>
Message-ID: <CABjd4Yxc_jRi563CHg+G7ekTHT40sTxgRUoL68bSke7oh8JVpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/6 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Sun, Dec 19, 2010 at 08:40:17PM +0300, Alexey Charkov wrote:
>> +static struct map_desc vt8500_io_desc[] __initdata = {
>> + ? ? /* SoC MMIO registers, to be filled in later */
>> + ? ? [0] = {
>> + ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE
>> + ? ? },
>> + ? ? /* PCI I/O space, numbers tied to those in <mach/io.h> */
>> + ? ? [1] = {
>> + ? ? ? ? ? ? .virtual ? ? ? ?= 0xf0000000,
>> + ? ? ? ? ? ? .pfn ? ? ? ? ? ?= __phys_to_pfn(0xc0000000),
>> + ? ? ? ? ? ? .length ? ? ? ? = SZ_64K,
>> + ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE
>> + ? ? },
>> +};
> ...
>> diff --git a/arch/arm/mach-vt8500/include/mach/io.h b/arch/arm/mach-vt8500/include/mach/io.h
>> new file mode 100644
>> index 0000000..8dd55c8
>> --- /dev/null
>> +++ b/arch/arm/mach-vt8500/include/mach/io.h
>> +#ifndef __ASM_ARM_ARCH_IO_H
>> +#define __ASM_ARM_ARCH_IO_H
>> +
>> +#define IO_SPACE_LIMIT 0xffff
>> +
>> +#define __io(a) ? ? ? ? ? ? ?((void __iomem *)((a) + 0xf0000000))
>> +#define __mem_pci(a) (a)
>
> Can you explain why you seem to have PCI IO space, yet don't have CONFIG_PCI
> selected? ?Do you have any drivers which use this space without CONFIG_PCI=y?

We have not yet created support for the PCI bridge (or even verified
its existence on the chip). These numbers are derived bit by bit from
vendor-published kernel sources and rather intended as a reference in
case somebody wishes to try and implement PCI support.

All the peripherals on these chips that I know of are statically
mapped platform devices programmed via MMIO registers. There may be
some boards which have support for external PCI devices, but I haven't
seen them.

Best,
Alexey
