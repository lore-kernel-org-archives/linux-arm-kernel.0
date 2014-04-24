From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Apr 2014 11:52:35 +0100
Subject: [PATCH v2 1/6] ARM: Add platform support for LSI AXM55xx SoC
In-Reply-To: <6486d374332f66a0b8e00178cd5a58dc5996f18a.1398335771.git.anders.berg@lsi.com>
References: <cover.1398335771.git.anders.berg@lsi.com>
 <6486d374332f66a0b8e00178cd5a58dc5996f18a.1398335771.git.anders.berg@lsi.com>
Message-ID: <20140424105235.GL26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 12:44:04PM +0200, Anders Berg wrote:
> diff --git a/arch/arm/mach-axxia/Kconfig b/arch/arm/mach-axxia/Kconfig
> new file mode 100644
> index 0000000..8c308fd
> --- /dev/null
> +++ b/arch/arm/mach-axxia/Kconfig
> @@ -0,0 +1,16 @@
> +config ARCH_AXXIA
> +	bool "LSI Axxia platforms" if (ARCH_MULTI_V7 && ARM_LPAE)
> +	select ARM_GIC
> +	select MFD_SYSCON
> +	select ARM_AMBA
> +	select HAVE_ARM_ARCH_TIMER
> +	select ARM_TIMER_SP804
> +	select ZONE_DMA
> +	select ARCH_DMA_ADDR_T_64BIT
> +	select MIGHT_HAVE_PCI
> +	select PCI_DOMAINS if PCI

Please sort alphabetically.

> +static int axxia_boot_secondary(unsigned int cpu, struct task_struct *idle)
> +{
> +	struct device_node *syscon_np;
> +	void __iomem *syscon;
> +	u32 tmp;
> +
> +	syscon_np = of_find_compatible_node(NULL, NULL, "lsi,axxia-syscon");
> +	if (!syscon_np)
> +		return -ENOENT;
> +
> +	syscon = of_iomap(syscon_np, 0);
> +	if (!syscon)
> +		return -ENOMEM;
> +
> +	tmp = readl(syscon + SC_RST_CPU_HOLD);
> +	writel(0xab, syscon + SC_CRIT_WRITE_KEY);
> +	tmp &= ~(1 << cpu);
> +	writel(tmp, syscon + SC_RST_CPU_HOLD);
> +
> +	return 0;
> +}

This is much better, thanks.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
