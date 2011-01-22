From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Sat, 22 Jan 2011 02:16:39 +0100
Subject: [PATCH] ARM: mxs: irq_data conversion
In-Reply-To: <20110121104742.GC23596@mail.wantstofly.org>
References: <1295600518-11300-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110121094338.GE13235@n2100.arm.linux.org.uk>
	<20110121101536.GH14956@pengutronix.de>
	<20110121102707.GH13235@n2100.arm.linux.org.uk>
	<20110121104742.GC23596@mail.wantstofly.org>
Message-ID: <20110122011639.GA27938@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 21, 2011 at 11:47:42AM +0100, Lennert Buytenhek wrote:

> > so... patches welcome.
> 
> I'll submit a patch for the above, and to make sure I'll build all
> defconfigs on current -devel as well.

Results:

ag5evm_defconfig fails with:

	arch/arm/mach-shmobile/built-in.o: In function `ag5evm_init':
	board-ag5evm.c:(.init.text+0x238): undefined reference to `sh73a0_pinmux_init'

which isn't my fault.


iop32x_defconfig fails with:

	/tmp/ccLtyaJK.s: Assembler messages:
	/tmp/ccLtyaJK.s:1468: Error: selected processor does not support `movt r2,32768'
	make[3]: *** [drivers/net/r8169.o] Error 1

which isn't immediately obvious (but also doesn't seem to be my fault).


magician_defconfig fails with:

	/data/buytenh/kern.irqdata/linux-2.6/drivers/mfd/asic3.c: In function ?asic3_irq_demux?:
	/data/buytenh/kern.irqdata/linux-2.6/drivers/mfd/asic3.c:146:6: error: ?struct irq_desc? has no member named ?chip?
	/data/buytenh/kern.irqdata/linux-2.6/drivers/mfd/asic3.c:148:13: error: ?struct irq_desc? has no member named ?handler_data?
	make[3]: *** [drivers/mfd/asic3.o] Error 1

for which I've submitted a patch here (my original mfd asic3 irq_data
patch did address this, but the patch that got merged instead didn't):

	http://marc.info/?l=linux-kernel&m=129565853125126&w=2


mx3_defconfig fails with:

	/data/buytenh/kern.irqdata/linux-2.6/drivers/dma/ipu/ipu_irq.c:349:2: error: unknown field ?ack? specified in initializer
	/data/buytenh/kern.irqdata/linux-2.6/drivers/dma/ipu/ipu_irq.c:349:2: warning: initialization from incompatible pointer type
	/data/buytenh/kern.irqdata/linux-2.6/drivers/dma/ipu/ipu_irq.c:350:2: error: unknown field ?mask? specified in initializer
	/data/buytenh/kern.irqdata/linux-2.6/drivers/dma/ipu/ipu_irq.c:350:2: warning: initialization from incompatible pointer type
	/data/buytenh/kern.irqdata/linux-2.6/drivers/dma/ipu/ipu_irq.c:351:2: error: unknown field ?unmask? specified in initializer
	/data/buytenh/kern.irqdata/linux-2.6/drivers/dma/ipu/ipu_irq.c:351:2: warning: initialization from incompatible pointer type
	make[4]: *** [drivers/dma/ipu/ipu_irq.o] Error 1

for which I've (re)submitted a patch here:

	http://marc.info/?l=linux-kernel&m=129565867725213&w=2


u8500_defconfig fails with:

	arch/arm/mach-ux500/built-in.o:(.data+0x2c04): undefined reference to `ab8500_regulators'
	make[1]: *** [.tmp_vmlinux1] Error 1

which isn't my fault.


The rest of the defconfigs build fine.  So I think that turning on
GENERIC_HARDIRQS_NO_DEPRECATED for ARM should be OK.
