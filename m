From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Oct 2016 11:06:20 +0200
Subject: [PATCH 1/2] ARM: oxnas: Add OX820 SMP support
In-Reply-To: <20161017084303.20078-2-narmstrong@baylibre.com>
References: <20161017084303.20078-1-narmstrong@baylibre.com>
 <20161017084303.20078-2-narmstrong@baylibre.com>
Message-ID: <14513531.isB50DxNJf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, October 17, 2016 10:43:02 AM CEST Neil Armstrong wrote:
> +
> +       /*
> +        * This is really belt and braces; we hold unintended secondary
> +        * CPUs in the holding pen until we're ready for them.  However,
> +        * since we haven't sent them a soft interrupt, they shouldn't
> +        * be there.
> +        */
> +       write_pen_release(cpu);
> +
> +       /*
> +        * Enable GIC cpu interface in CPU Interface Control Register
> +        */
> +       writel(GIC_CPU_CTRL_ENABLE,
> +               gic_cpu_ctrl + GIC_NCPU_OFFSET(cpu) + GIC_CPU_CTRL);
> +
> +       /*
> +        * Send the secondary CPU a soft interrupt, thereby causing
> +        * the boot monitor to read the system wide flags register,
> +        * and branch to the address found there.
> +        */
> +
> +       arch_send_wakeup_ipi_mask(cpumask_of(cpu));
> +       timeout = jiffies + (1 * HZ);
> +       while (time_before(jiffies, timeout)) {
> +               smp_rmb();
> +               if (read_pen_release() == -1)
> +                       break;
> +
> +               udelay(10);
> +       }
> 

This seems to have been copied from plat-versatile, but is really
not needed here since you apparently have proper hardware support for
starting up the CPUs.

Any reason you can't just write to the cpu_ctrl register
once and keep going without that whole holding_pen loop
and spinlock?

	Arnd
