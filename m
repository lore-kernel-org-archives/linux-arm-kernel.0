From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Jul 2011 09:54:00 +0200
Subject: [PATCH 1/6 v8] ARM: Add basic architecture support for
	VIA/WonderMedia 85xx SoC's
In-Reply-To: <CABjd4Yxc_jRi563CHg+G7ekTHT40sTxgRUoL68bSke7oh8JVpg@mail.gmail.com>
References: <1289147348-31969-1-git-send-email-alchark@gmail.com>
	<20110706123417.GA25400@n2100.arm.linux.org.uk>
	<CABjd4Yxc_jRi563CHg+G7ekTHT40sTxgRUoL68bSke7oh8JVpg@mail.gmail.com>
Message-ID: <201107070954.00419.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 July 2011 09:13:26 Alexey Charkov wrote:
> >> diff --git a/arch/arm/mach-vt8500/include/mach/io.h b/arch/arm/mach-vt8500/include/mach/io.h
> >> new file mode 100644
> >> index 0000000..8dd55c8
> >> --- /dev/null
> >> +++ b/arch/arm/mach-vt8500/include/mach/io.h
> >> +#ifndef __ASM_ARM_ARCH_IO_H
> >> +#define __ASM_ARM_ARCH_IO_H
> >> +
> >> +#define IO_SPACE_LIMIT 0xffff
> >> +
> >> +#define __io(a)              ((void __iomem *)((a) + 0xf0000000))
> >> +#define __mem_pci(a) (a)
> >
> > Can you explain why you seem to have PCI IO space, yet don't have CONFIG_PCI
> > selected?  Do you have any drivers which use this space without CONFIG_PCI=y?
> 
> We have not yet created support for the PCI bridge (or even verified
> its existence on the chip). These numbers are derived bit by bit from
> vendor-published kernel sources and rather intended as a reference in
> case somebody wishes to try and implement PCI support.
> 
> All the peripherals on these chips that I know of are statically
> mapped platform devices programmed via MMIO registers. There may be
> some boards which have support for external PCI devices, but I haven't
> seen them.

Actually, we did discuss this when I first reviewed your patches. FWIW,
WM8505, WM8510 and VT8500 don't seem to have PCI, but VT8430 has PCI,
according to the data sheet and the patch provided by VIA.

What made this a little hard to understand is the way that VIA provided
an emulated PCI bus even on those platforms that didn't have the hardware,
apparently because it didn't occur to them to add platform device
support to the network driver (via velocity, iirc). They just faked a
configuration space for the USB and network devices to make them work
with the regular PCI drivers.

	Arnd
