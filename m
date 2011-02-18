From: ccross@android.com (Colin Cross)
Date: Thu, 17 Feb 2011 16:58:09 -0800
Subject: [RFC PATCH 2/3] ARM: gic: Use cpu pm notifiers to save gic state
In-Reply-To: <1297373487-23902-3-git-send-email-ccross@android.com>
References: <1297373487-23902-1-git-send-email-ccross@android.com>
	<1297373487-23902-3-git-send-email-ccross@android.com>
Message-ID: <AANLkTik3O_keaFh25kd_Pr7dkiSAG5rg3-ZGZ7wAVN6S@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 10, 2011 at 1:31 PM, Colin Cross <ccross@android.com> wrote:

<snip>

> +#ifdef CONFIG_PM
> + ? ? ? u32 saved_spi_enable[DIV_ROUND_UP(1020, 32)];
> + ? ? ? u32 saved_spi_conf[DIV_ROUND_UP(1020, 16)];
> + ? ? ? u32 saved_spi_pri[DIV_ROUND_UP(1020, 4)];
> + ? ? ? u32 saved_spi_target[DIV_ROUND_UP(1020, 4)];
> + ? ? ? u32 __percpu *saved_ppi_enable;
> + ? ? ? u32 __percpu *saved_ppi_conf;
> + ? ? ? u32 __percpu *saved_ppi_pri;
> +#endif
The #ifdef CONFIG_PM breaks building !CONFIG_PM, and this should
depend on CONFIG_CPU_IDLE, not CONFIG_PM.

> +static void gic_cpu_save(unsigned int gic_nr)
> +{
> + ? ? ? int i;
> + ? ? ? u32 *ptr;
> + ? ? ? void __iomem *dist_base;
> + ? ? ? void __iomem *cpu_base;
> +
> + ? ? ? if (gic_nr >= MAX_GIC_NR)
> + ? ? ? ? ? ? ? BUG();
> +
> + ? ? ? dist_base = gic_data[gic_nr].dist_base;
> + ? ? ? cpu_base = gic_data[gic_nr].cpu_base;
> +
> + ? ? ? if (!dist_base || !cpu_base)
> + ? ? ? ? ? ? ? return;
> +
> + ? ? ? ptr = __this_cpu_ptr(gic_data[gic_nr].saved_ppi_enable);
> + ? ? ? for (i = 0; i < DIV_ROUND_UP(32, 32); i++)
> + ? ? ? ? ? ? ? ptr[i] = readl(dist_base + GIC_DIST_ENABLE_SET + i * 4);
> +
> + ? ? ? ptr = __this_cpu_ptr(gic_data[gic_nr].saved_ppi_conf);
> + ? ? ? for (i = 0; i < DIV_ROUND_UP(32, 16); i++)
> + ? ? ? ? ? ? ? ptr[i] = readl(dist_base + GIC_DIST_CONFIG + i * 4);
> +
> + ? ? ? ptr = __this_cpu_ptr(gic_data[gic_nr].saved_ppi_pri);
> + ? ? ? for (i = 0; i < DIV_ROUND_UP(32, 4); i++)
> + ? ? ? ? ? ? ? ptr[i] = readl(dist_base + GIC_DIST_PRI + i * 4);
> +
> + ? ? ? writel(0, cpu_base + GIC_CPU_CTRL);
> +}
Disabling the GIC cpu interface here prevents SGIs from waking the CPU
from WFI.  On Tegra2, it is useful to be able to go to WFI, and then
either back to normal or into reset depending on the state of the
other CPU.  Is it safe to leave the GIC CPU control on when going to
reset?
