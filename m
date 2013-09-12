From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Sep 2013 15:40:08 +0100
Subject: [PATCH 1/4] Add smp support for Allwinner A20(sunxi 7i).
In-Reply-To: <1378968687-8200-2-git-send-email-cinifr@gmail.com>
References: <1378968687-8200-1-git-send-email-cinifr@gmail.com>
 <1378968687-8200-2-git-send-email-cinifr@gmail.com>
Message-ID: <20130912144008.GM12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some other comments:

On Thu, Sep 12, 2013 at 02:51:24PM +0800, Fan Rong wrote:
> +    /* L1RSTDISABLE hold low */
> +	pwr_reg = readl(cc_base + AW_CPUCFG_GENCTL);
> +	pwr_reg &= ~(1<<cpu);

If you pass your patch through checkpatch.pl, it will warn about some of
this.  You should have one space each side of <<.

> +    /* step3: clear power-off gating */
> +	pwr_reg = readl(cc_base + AW_CPU1_PWROFF_REG);
> +	pwr_reg &= ~(1);

You don't need the parens here.

> +	pwr_reg = readl(cc_base + AW_CPUCFG_DBGCTL1);
> +	pwr_reg |= (1<<cpu);

Nor here.

> +static int sunxi7i_boot_secondary(unsigned int cpu, struct task_struct *idle)
> +{
> +	pr_debug("[%s] enter cpu %d\n", __func__, cpu);
> +	spin_lock(&boot_lock);
> +	enable_aw_cpu(cpu);
> +	spin_unlock(&boot_lock);

What exactly does this spinlock protect?  The core code already provides
the guarantee that only one CPU will be brought online or taken offline
at a time.
