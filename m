From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 17 May 2011 22:59:28 +0100
Subject: [PATCH 04/19] ARM: omap1: convert to using readl/writel instead
	of volatile struct
In-Reply-To: <E1QM1ZG-0003DV-PA@rmk-PC.arm.linux.org.uk>
References: <20110516172334.GD13659@n2100.arm.linux.org.uk>
	<E1QM1ZG-0003DV-PA@rmk-PC.arm.linux.org.uk>
Message-ID: <BANLkTinG0BmBJZTWr-FrBzANg-MbdsghkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 May 2011 18:26, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> --- a/arch/arm/mach-omap1/time.c
> +++ b/arch/arm/mach-omap1/time.c
...
> ?static inline unsigned long notrace omap_mpu_timer_read(int nr)
> ?{
> - ? ? ? volatile omap_mpu_timer_regs_t* timer = omap_mpu_timer_base(nr);
> - ? ? ? return timer->read_tim;
> + ? ? ? omap_mpu_timer_regs_t __iomem *timer = omap_mpu_timer_base(nr);
> + ? ? ? return readl(&timer->read_tim);
> ?}

We should start using the *_relaxed() accessors a bit more to avoid
the barriers overhead in the standard I/O accessors.

-- 
Catalin
