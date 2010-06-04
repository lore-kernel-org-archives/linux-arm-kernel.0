From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 4 Jun 2010 15:12:48 +0800
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <20100604061034.GI6499@atomide.com>
References: <20100603192459.GA9169@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1006031829020.24526@xanadu.home>
	<4C083BCF.2060500@bluewatersys.com>
	<201006040310.15019.marek.vasut@gmail.com>
	<4C0853E1.1080005@bluewatersys.com>
	<AANLkTinEq99_8UyVNnmzNEreDoyHKEnxpuJmaAo_kpPN@mail.gmail.com>
	<20100604061034.GI6499@atomide.com>
Message-ID: <AANLkTikrK-RkDntgrpptBaG6TvnesNFncOw3DW4Jt-TY@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 4, 2010 at 2:10 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Eric Miao <eric.y.miao@gmail.com> [100604 04:35]:
>>
>> Also, we are now working on a single kernel for multiple sub-arch (at least
>> what Nicolas and I am doing now, and welcome to join us). It's tough (the
>> way to handle different phys_offset is only the tip of the iceberg) and seems
>> now more and more necessary. so hopefully by the end of the day, we may
>> possible end up with only very few defconfig.
>
> Great, do you have some git branch for that somewhere?
>

All the currently done work I've posted to the mailing list:

1. SPARSEIRQ
2. MULTI_IRQ_HANDLER
3. Makefile.boot move to arch/arm/boot/bootp _only_
4. RUNTIME_PHYS_OFFSET (not really my work, but Uwe's)

Nico and I have setup a blueprint and wiki spec for this, I hope more
can join us with the effort.

https://blueprints.launchpad.net/ubuntu/+spec/kernel-maverick-arm-single-zimage
https://wiki.ubuntu.com/Specs/ARMSingleKernel

I'll push what I did to

git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git
unified-kernel

But it's a mess now.

> Parallel to dealing with different phys_offset we can also try combining
> some two ARM platforms that have the same phy_offset. That already exposes
> tons of conflicting defines that need to be sorted out..
>

A first step to take might be looking at all those machine specific header
files that will be included into generic <asm/*.h> and in turn included by
other code. The PHYS_OFFSET is only a small tip of the iceberg I'm afraid.
A very rough grep and analysis as below:

`    $ git grep "#include <mach" arch/arm/include/asm/` <<BR>>
`    arch/arm/include/asm/dma.h:#include <mach/isa-dma.h>` <<BR>>
`    arch/arm/include/asm/floppy.h:#include <mach/floppy.h>` <<BR>>
`    arch/arm/include/asm/gpio.h:#include <mach/gpio.h>` <<BR>>
`    arch/arm/include/asm/hardware/dec21285.h:#include <mach/hardware.h>` <<BR>>
`    arch/arm/include/asm/hardware/iop3xx-adma.h:#include
<mach/hardware.h>` <<BR>>
`    arch/arm/include/asm/hardware/iop3xx-gpio.h:#include
<mach/hardware.h>` <<BR>>
`    arch/arm/include/asm/hardware/sa1111.h:#include <mach/bitfield.h>` <<BR>>
`    arch/arm/include/asm/io.h:#include <mach/io.h>` <<BR>>
`    arch/arm/include/asm/irq.h:#include <mach/irqs.h>` <<BR>>
`    arch/arm/include/asm/mc146818rtc.h:#include <mach/irqs.h>` <<BR>>
`    arch/arm/include/asm/memory.h:#include <mach/memory.h>` <<BR>>
`    arch/arm/include/asm/mmzone.h:#include <mach/memory.h>` <<BR>>
`    arch/arm/include/asm/mtd-xip.h:#include <mach/mtd-xip.h>` <<BR>>
`    arch/arm/include/asm/pci.h:#include <mach/hardware.h> /* for
PCIBIOS_MIN_* */` <<BR>>
`    arch/arm/include/asm/pgtable.h:#include <mach/vmalloc.h>` <<BR>>
`    arch/arm/include/asm/smp.h:#include <mach/smp.h>` <<BR>>
`    arch/arm/include/asm/system.h:#include <mach/barriers.h>` <<BR>>
`    arch/arm/include/asm/timex.h:#include <mach/timex.h>` <<BR>>
`    arch/arm/include/asm/vga.h:#include <mach/hardware.h>` <<BR>>

  * <mach/floppy.h> is no longer necessary

1.  arch/arm/include/asm/memory.h:#include <mach/memory.h>

1.1 PHYS_OFFSET

  * can be ignored if RUNTIME_PHYS_OFFSET is doable
  * should be removed from <mach/memory.h>
  * but we need this somewhere to allow the usage of a hardcoded constant
    [a config option?]

1.2 ISA_DMA_THRESHOLD and DMA_MAX_ADDRESS

  * make them into variables and encode them in machine_desc

1.3 arch_adjust_zones()

  * can be moved into machine_desc
  * this depends on CONFIG_ZONE_DMA
  * what to do with CONFIG_ZONE_DMA?

1.4 NODE_MEM_SIZE_BITS, SECTION_SIZE_BITS, MAX_PHYSMEM_BITS, ...

1.5 CONFIG_SPARSEMEM

  * N/A

2. arch/arm/include/asm/dma.h:#include <mach/isa-dma.h>

  * depends on CONFIG_ISA_DMA_API
  * currently only the machines below:
    * arch/arm/mach-h720x/include/mach/isa-dma.h
    * arch/arm/mach-footbridge/include/mach/isa-dma.h
    * arch/arm/mach-shark/include/mach/isa-dma.h
    * arch/arm/mach-rpc/include/mach/isa-dma.h
  * the most important definition is MAX_DMA_CHANNELS, which can be
    converted to a variable
  * some other machine specific definitions

3. arch/arm/include/asm/gpio.h:#include <mach/gpio.h>

  * gpio_to_irq() and irq_to_gpio(), need to make this generic but
    could hurt performance
  * inlined version of gpio_{get,set}_value(), gpio_direction_*()
    and others will conflict with each other
  * some other definitions like GPIO registers

4. arch/arm/include/asm/hardware/dec21285.h:#include <mach/hardware.h>
   arch/arm/include/asm/hardware/iop3xx-adma.h:#include <mach/hardware.h>
   arch/arm/include/asm/hardware/iop3xx-gpio.h:#include <mach/hardware.h>
   arch/arm/include/asm/vga.h:#include <mach/hardware.h>

  * <mach/hardware.h> is really machine specific and could possibly contain
    anything

5. arch/arm/include/asm/io.h:#include <mach/io.h>

  * IO_SPACE_LIMIT (actually IO_SPACE_LIMIT for _all_ machines are now
    0xffff_ffff), if no exception could just be removed and make it a
    default
  * definitions of __io(), this is defined as __typesafe_io(a) on most
    platforms, on other platforms, it can be abstracted as
`      ((void __iomem *)(BASE + (a)))` <<BR>>
    as long as we can make BASE a variable, this can be removed
  * definitions of __mem_pci(a), defined as (a) on all platforms, can
    be removed and make a default
  * ixp4xx is especially complex, depending on INDIRECT_PCI and PCI
  * how to handle different definitions of {in,out}{b,w,l}()
  * __arch_ioremap() and __arch_iounmap()

6. arch/arm/include/asm/irq.h:#include <mach/irqs.h>

  * what <asm/irq.h> needs is NR_IRQS (can be solved by SPARSEIRQ)
  * <mach/irqs.h> can be made internal to machine specific code _only_

7. arch/arm/include/asm/mtd-xip.h:#include <mach/mtd-xip.h>

  * currently, only omap1, pxa, sa1100 supports this
  * xip_irqpending()
  * xip_currtime()
  * xip_elapsed_since()
  * xip_cpu_idle()

8. arch/arm/include/asm/pci.h:#include <mach/hardware.h> /* for PCIBIOS_MIN_* */

  * need to make PCIBIOS_MIN_* variables

9. arch/arm/include/asm/pgtable.h:#include <mach/vmalloc.h>

  * mainly for VMALLOC_END could be made into a machine specific variable

10. arch/arm/include/asm/smp.h:#include <mach/smp.h>

  * smp_cross_call()
  * hard_smp_processor_id()

11. arch/arm/include/asm/system.h:#include <mach/barriers.h>

  * currently no machine defines barriers.h

12. arch/arm/include/asm/timex.h:#include <mach/timex.h>

  * CLOCK_TICK_RATE, can actually be removed
