From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 May 2011 22:48:11 +0200
Subject: [PATCH 04/19] ARM: omap1: convert to using readl/writel instead
	of volatile struct
In-Reply-To: <BANLkTinG0BmBJZTWr-FrBzANg-MbdsghkA@mail.gmail.com>
References: <20110516172334.GD13659@n2100.arm.linux.org.uk>
	<E1QM1ZG-0003DV-PA@rmk-PC.arm.linux.org.uk>
	<BANLkTinG0BmBJZTWr-FrBzANg-MbdsghkA@mail.gmail.com>
Message-ID: <BANLkTikSZGjM5VUjbNXK2y0UC7jVMmbYEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/17 Catalin Marinas <catalin.marinas@arm.com>:
> On 16 May 2011 18:26, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>> --- a/arch/arm/mach-omap1/time.c
>> +++ b/arch/arm/mach-omap1/time.c
> ...
>> ?static inline unsigned long notrace omap_mpu_timer_read(int nr)
>> ?{
>> - ? ? ? volatile omap_mpu_timer_regs_t* timer = omap_mpu_timer_base(nr);
>> - ? ? ? return timer->read_tim;
>> + ? ? ? omap_mpu_timer_regs_t __iomem *timer = omap_mpu_timer_base(nr);
>> + ? ? ? return readl(&timer->read_tim);
>> ?}
>
> We should start using the *_relaxed() accessors a bit more to avoid
> the barriers overhead in the standard I/O accessors.

Speaking of which.

The documentation for the *_relaxed calls are in
Documentation/DocBook/deviceiobook.tmpl
and reads like this:

"PCI ordering rules also guarantee that PIO read responses arrive after any
outstanding DMA writes from that bus, since for some devices the
result of a readb
call may signal to the driver that a DMA transaction is complete. In many cases,
however, the driver may want to indicate that the next readb call has
no relation to
any previous DMA writes performed by the device. The driver can use
readb_relaxed for these cases, although only some platforms will honor
the relaxed
semantics. Using the relaxed read functions will provide significant performance
benefits on platforms that support it. The qla2xxx driver provides
examples of how
to use readX_relaxed. In many cases, a majority of the driver's readX calls can
safely be converted to readX_relaxed calls, since only a few will indicate or
depend on DMA completion."

I guess that in the ARM case "PCI DMA" corresponds to "bus mastering" but
is this strictly speaking properly describing the semantics of the ARM
*_relaxed operations?

If it isn't a hint on how it should be understood would be much appreciated.

Yours,
Linus Walleij
