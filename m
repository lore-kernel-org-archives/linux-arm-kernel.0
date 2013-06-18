From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Jun 2013 12:36:06 +0100
Subject: [PATCH v4 02/10] pinctrl: mvebu: dove pinctrl driver
In-Reply-To: <1347550912-18021-3-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347550912-18021-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347550912-18021-3-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130618113606.GA26763@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2012 at 05:41:44PM +0200, Sebastian Hesselbarth wrote:
> +#define DOVE_GLOBAL_CONFIG_1		(DOVE_SB_REGS_VIRT_BASE | 0xe802C)
> +#define  DOVE_TWSI_ENABLE_OPTION1	BIT(7)
> +#define DOVE_GLOBAL_CONFIG_2		(DOVE_SB_REGS_VIRT_BASE | 0xe8030)
> +#define  DOVE_TWSI_ENABLE_OPTION2	BIT(20)
> +#define  DOVE_TWSI_ENABLE_OPTION3	BIT(21)
> +#define  DOVE_TWSI_OPTION3_GPIO		BIT(22)
...
> +static int dove_twsi_ctrl_set(struct mvebu_mpp_ctrl *ctrl,
> +				unsigned long config)
> +{
> +	unsigned long gcfg1 = readl(DOVE_GLOBAL_CONFIG_1);
> +	unsigned long gcfg2 = readl(DOVE_GLOBAL_CONFIG_2);
> +
> +	gcfg1 &= ~DOVE_TWSI_ENABLE_OPTION1;
> +	gcfg2 &= ~(DOVE_TWSI_ENABLE_OPTION2 | DOVE_TWSI_ENABLE_OPTION2);
> +
> +	switch (config) {
> +	case 1:
> +		gcfg1 |= DOVE_TWSI_ENABLE_OPTION1;
> +		break;
> +	case 2:
> +		gcfg2 |= DOVE_TWSI_ENABLE_OPTION2;
> +		break;
> +	case 3:
> +		gcfg2 |= DOVE_TWSI_ENABLE_OPTION3;
> +		break;
> +	}
> +
> +	writel(gcfg1, DOVE_GLOBAL_CONFIG_1);
> +	writel(gcfg2, DOVE_GLOBAL_CONFIG_2);
> +
> +	return 0;
> +}

So, I've just been thinking about the LCD clocking on the Armada 510,
and found that there's dividers for the internal LCD clocks in the
global config 1/2 registers.  So I grepped the kernel source for
references to these, expecting to find something in drivers/clk, but
found the above.

Now, the reason that I'm replying to this is that we're again falling
into the same trap that we did with SA1100 devices.  Back in those
days, there wasn't so much of a problem because the kernel was basically
single threaded when it came to code like the above on such platforms.
There was no kernel preemption.

However, todays kernel is sometimes SMP, commonly with kernel preemption
enabled, maybe even RT.  This makes things like the above sequence a
problem where a multifunction register is read, modified and then
written back.

Consider two threads doing this, and a preemption event happening in the
middle of this sequence to another thread also doing a read-modify-write
of the same register.  Which one wins depends on the preemption sequence,
but ultimately one loses out.

Any access to such registers needs careful thought, and protection in some
manner.

Maybe what we need is something like this:

static DEFINE_SPINLOCK(io_lock);
static void modifyl(u32 new, u32 mask, void __iomem *reg)
{
	unsigned long flags;
	u32 val;

	spin_lock_irqsave(&io_lock, flags);
	val = readl(reg) & ~mask;
	val |= new | mask;
	writel(val, reg);
	spin_unlock_irqrestore(&io_lock, flags);
}

in order to provide arbitrated access to these kinds of multifunction
registers in a safe, platform agnostic way.

Comments?
