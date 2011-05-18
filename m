From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 May 2011 08:56:25 +0100
Subject: [PATCH 04/19] ARM: omap1: convert to using readl/writel
	instead of volatile struct
In-Reply-To: <BANLkTinG0BmBJZTWr-FrBzANg-MbdsghkA@mail.gmail.com>
References: <20110516172334.GD13659@n2100.arm.linux.org.uk>
	<E1QM1ZG-0003DV-PA@rmk-PC.arm.linux.org.uk>
	<BANLkTinG0BmBJZTWr-FrBzANg-MbdsghkA@mail.gmail.com>
Message-ID: <20110518075625.GA12302@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 17, 2011 at 10:59:28PM +0100, Catalin Marinas wrote:
> On 16 May 2011 18:26, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > --- a/arch/arm/mach-omap1/time.c
> > +++ b/arch/arm/mach-omap1/time.c
> ...
> > ?static inline unsigned long notrace omap_mpu_timer_read(int nr)
> > ?{
> > - ? ? ? volatile omap_mpu_timer_regs_t* timer = omap_mpu_timer_base(nr);
> > - ? ? ? return timer->read_tim;
> > + ? ? ? omap_mpu_timer_regs_t __iomem *timer = omap_mpu_timer_base(nr);
> > + ? ? ? return readl(&timer->read_tim);
> > ?}
> 
> We should start using the *_relaxed() accessors a bit more to avoid
> the barriers overhead in the standard I/O accessors.

I thought about that, but when you look at patch 6, it'd change this.
I wanted to use the same accessor here as it ends up with in patch 6.
