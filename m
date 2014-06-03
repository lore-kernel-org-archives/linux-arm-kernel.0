From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 3 Jun 2014 15:18:26 +0800
Subject: [PATCH 1/5] ARM: berlin: add SMP support
In-Reply-To: <20140603071017.GA15966@kwain>
References: <1401700866-24804-1-git-send-email-antoine.tenart@free-electrons.com>
 <1401700866-24804-2-git-send-email-antoine.tenart@free-electrons.com>
 <20140603143113.0b2aeb74@xhacker> <20140603071017.GA15966@kwain>
Message-ID: <20140603151826.100a7fd5@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Tue, 3 Jun 2014 00:10:17 -0700
Antoine T?nart <antoine.tenart@free-electrons.com> wrote:

> Hi Jisheng,
> 
> On Tue, Jun 03, 2014 at 02:31:13PM +0800, Jisheng Zhang wrote:
> > On Mon, 2 Jun 2014 02:21:02 -0700
> > Antoine T?nart <antoine.tenart@free-electrons.com> wrote:
> > > +
> > > +extern void berlin_secondary_startup(void);
> > > +extern u32 boot_inst;
> > > +
> > > +static void __iomem *cpu_ctrl;
> > > +
> > > +static inline void berlin_reset_cpu(unsigned int cpu)
> > > +{
> > > +	u32 val;
> > > +
> > > +	val = readl(cpu_ctrl + CPU_RESET);
> > > +	val |= BIT(cpu_logical_map(cpu));
> > > +	writel(val, cpu_ctrl + CPU_RESET);
> > 
> > "writel(BIT(cpu_logical_map(cpu)), cpu_ctrl + CPU_RESET)" is enough.
> > we don't need to read and modify, because we writing 0 has no any effect.
> 
> The reset bit is automatically cleared but I dumped the register value
> and it wasn't 0x0, that's why I preferred to read first and only set the
> reset bit.
> 
> > > +
> > > +	/*
> > > +	 * Write the first instruction the CPU will execute after being
> > > reseted
> > > +	 * in the reset exception register.
> > > +	 */
> > > +	writel(boot_inst, vectors_base + RESET_VECT);
> > 
> > Is it better to let bootloader/firmware handle this writing. Then, we can
> > also remove the tricky boot_inst in headsmp.S.
> 
> We thought about it, and since it can be difficult to update the
> bootloader for some boards, like BG2 based ones, we preferred to include
> this here.
> 
> Thanks!
> 
> Antoine
> 


Got your points. Thanks very much
