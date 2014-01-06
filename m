From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 06 Jan 2014 13:32:24 -0700
Subject: [PATCH v2 2/6] misc: fuse: Add efuse driver for Tegra
In-Reply-To: <1387891931-9854-3-git-send-email-pdeschrijver@nvidia.com>
References: <1387891931-9854-1-git-send-email-pdeschrijver@nvidia.com>
 <1387891931-9854-3-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <52CB12D8.7000203@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/24/2013 06:32 AM, Peter De Schrijver wrote:
> Implement fuse driver for Tegra20, Tegra30, Tegra114 and Tegra124.

> diff --git a/drivers/misc/fuse/Kconfig b/drivers/misc/fuse/Kconfig

> +config FUSE_TEGRA
> +	tristate "Tegra fuse supprt"
> +	depends on ARCH_TEGRA && SYSFS

Since (I think) the Tegra-specific APIs this uses are stubbed if they
can't build, perhaps this should depend on "|| COMPILE_TEST" too?

> +	help
> +	  This drivers provides read-only to the e-fuses in Tegra chips.
> +	  Parsing of the data is left to userspace.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called tegra_efuse.
> +endmenu

I'd expect a blank line before "endmenu" since there's one at the start
of the menu contents.

> diff --git a/drivers/misc/fuse/tegra/Makefile b/drivers/misc/fuse/tegra/Makefile

> +obj-y					+= fuse-tegra.o
> +obj-y					+= fuse-tegra30.o
> +obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= fuse-tegra20.o
> +obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= tegra20_speedo.o
> +obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= tegra30_speedo.o
> +obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= tegra114_speedo.o
> +obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= tegra124_speedo.o

> diff --git a/drivers/misc/fuse/tegra/fuse-tegra20.c b/drivers/misc/fuse/tegra/fuse-tegra20.c

> +static int fuse_size;

I don't think that's used.

> +static u32 tegra20_fuse_readl(const unsigned int offset)
...
> +	ret = tegra_apb_readl_using_dma(fuse_phys + FUSE_BEGIN + offset, &val);

Shouldn't this use the generic tegra_apb_readl(), so that it works
irrespective of whether the Tegra20 APB DMA driver is available?

> +static const struct of_device_id tegra20_fuse_of_match[] = {
> +	{ .compatible = "nvidia,tegra20-efuse" },
> +}
> +
> +MODULE_DEVICE_TABLE(of, tegra20_fuse_of_match);

You'd typically omit that blank line.

> +static int tegra_fuse_probe(struct platform_device *pdev)

> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	fuse_phys = res->start;

Don't you need to error-check res here?

> +	fuse_randomness();

If this is a driver, and particularly if this could be in a module, is
there any guarantee at all that fuse_randomness() gets called early
enough to be useful?>

> +	platform_set_drvdata(pdev, NULL);

That seems pointless; if the drvdata isn't used, there's no need to set
it to anything in particular at all.

> +	if (tegra_fuse_sysfs(&pdev->dev, FUSE_SIZE, tegra20_fuse_readl,
> +			     &sku_info))

Here (and also for fuse_randomness()), there's no verb in the function
name. Perhaps use tegra_fuse_create_sysfs() and fuse_add_randomness().
It wouldn't hurt to be consistent and use a tegra20_ prefix on all the
function names too.

> diff --git a/drivers/misc/fuse/tegra/fuse-tegra30.c b/drivers/misc/fuse/tegra/fuse-tegra30.c

> +u32 tegra30_fuse_readl(const unsigned int offset)

> +	val = readl_relaxed(fuse_base + FUSE_BEGIN + offset);

If you aren't going to call tegra_apb_readl() here, I wonder if you
shouldn't rename tegra_apb_readl() as tegra20_apb_readl() to make it
obvious that the workaround isn't needed on all chips?

> +	clk_disable_unprepare(fuse_clk);

Doesn't the use of readl_**relaxed**() above mean that the
clk_disable_unprepare() could turn off the clock before the fuse read
had completed, and hence hang the system?

> +static int tegra_fuse_probe(struct platform_device *pdev)

> +	fuse_randomness();

Here, the same function name is used as in fuse-tegra20.c, which might
make debugging a bit more annoying.

> +MODULE_LICENSE("GPLv2");

s/GPLv2/GPL v2/ Perhaps the same in other files?

> diff --git a/drivers/misc/fuse/tegra/fuse.h b/drivers/misc/fuse/tegra/fuse.h

> +#ifdef CONFIG_ARCH_TEGRA_2x_SOC
> +void tegra20_init_speedo_data(struct tegra_sku_info *sku_info,
> +			      struct device *dev);
> +bool tegra20_spare_fuse(int bit);
> +#else
> +static inline void tegra20_init_speedo_data(struct tegra_sku_info *sku_info,
> +					    struct device *dev) {}
> +static inline bool tegra20_spare_fuse(int bit) {}
> +#endif

I suppose it doesn't hurt, but the Tegra20 functions don't need stubs
since they're only called from files that are only compiled for Tegra20.
But, I suppose it's fine to be consistent within this file and provide
stubs anyway.
