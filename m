From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 05 Feb 2014 12:15:46 -0700
Subject: [PATCH v3 3/6] misc: fuse: Add efuse driver for Tegra
In-Reply-To: <1390952176-30402-4-git-send-email-pdeschrijver@nvidia.com>
References: <1390952176-30402-1-git-send-email-pdeschrijver@nvidia.com>
 <1390952176-30402-4-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <52F28DE2.1040207@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28/2014 04:36 PM, Peter De Schrijver wrote:
> Implement fuse driver for Tegra20, Tegra30, Tegra114 and Tegra124.

I assume most of this code is simply cut/paste from the existing code in
arch/arm/mach-tegra/? If so, "git format-patch -C" would have been
useful to highlight what changed when duplicating the files.

> diff --git a/Documentation/ABI/testing/sysfs-driver-tegra-fuse b/Documentation/ABI/testing/sysfs-driver-tegra-fuse
> +What:		/sys/devices/*/<our-device>/fuse
> +Date:		December 2013
> +Contact:	Peter De Schrijver <pdeschrijver@nvidia.com>
> +Description:	read-only access to the efuses on Tegra20, Tegra30, Tegra114
> +		and Tegra124 SoC's from NVIDIA. The efuses contain write once
> +		data programmed at the factory.
> +Users:		any user space application which wants to read the efuses on
> +		Tegra SoC's

Surely this file should describe the format of the file, since that's
part of the ABI too, right?

> diff --git a/drivers/misc/fuse/tegra/fuse-tegra20.c b/drivers/misc/fuse/tegra/fuse-tegra20.c

> +static int tegra20_fuse_probe(struct platform_device *pdev)
...
> +	sku_info.revision = tegra_revision;
> +	tegra20_init_speedo_data(&sku_info, &pdev->dev);
...
> +}
> +
> +static struct platform_driver tegra20_fuse_driver = {
> +	.probe = tegra20_fuse_probe,
> +	.driver = {
> +		.name = "tegra20_fuse",
> +		.owner = THIS_MODULE,
> +		.of_match_table = tegra20_fuse_of_match,
> +	}
> +};
> +
> +static int __init tegra20_fuse_init(void)
> +{
> +	return platform_driver_register(&tegra20_fuse_driver);
> +}
> +postcore_initcall(tegra20_fuse_init);

That call to tegra20_init_speedo_data() now happens much later in boot.
Are you sure there's nothing that relies on data it sets up between when
tegra_fuse_init() is called (which is where it happens before this
series), and the somewhat arbitrary later time when this driver probes?

> diff --git a/drivers/misc/fuse/tegra/fuse-tegra30.c b/drivers/misc/fuse/tegra/fuse-tegra30.c

> +postcore_initcall(tegra30_fuse_init);
> +

There's a blank line at the end of the file. I thought checkpatch warned
about this? But actually it doesn't seem to at least in -f mode.

> diff --git a/drivers/misc/fuse/tegra/fuse.h b/drivers/misc/fuse/tegra/fuse.h

> +struct tegra_sku_info {
> +	int sku_id;
> +	int cpu_process_id;
> +	int cpu_speedo_id;
> +	int cpu_speedo_value;
> +	int cpu_iddq_value;
> +	int core_process_id;
> +	int soc_speedo_id;
> +	int gpu_speedo_id;
> +	int gpu_process_id;
> +	int gpu_speedo_value;
> +	enum tegra_revision revision;
> +};

The only use of this appears to be to pass to tegra_fuse_create_sysfs()
which prints out the fields. Will there be more users in the future?
Otherwise, I'd be tempted to just print it out outside/before-calling
tegra_fuse_create_sysfs().

That said, I wonder if these values could/should be exposed in the sysfs
file to make it easier to interpret the fuses?

> diff --git a/drivers/misc/fuse/tegra/tegra114_speedo.c b/drivers/misc/fuse/tegra/tegra114_speedo.c

It might be nice to make these filenames consistent with the others,
e.g. fuse-speedo-tegraNNN.c/speedo-tegraNNN.c, or wrap them into
fuse-tegraNNN.c?

> diff --git a/drivers/misc/fuse/tegra/tegra30_speedo.c b/drivers/misc/fuse/tegra/tegra30_speedo.c

> +#define FUSE_SPEEDO_CALIB_0	0x14
> +#define FUSE_PACKAGE_INFO	0XFC
> +#define FUSE_TEST_PROG_VER	0X28

In arch/arm/mach-tegra/tegra30_speedo.c, those values are different:

#define FUSE_SPEEDO_CALIB_0	0x114
#define FUSE_PACKAGE_INFO	0X1FC
#define FUSE_TEST_PROG_VER	0X128

Was this change intentional? Perhaps it should be in a separate patch to
highlight the change, if it's an intentional bug-fix?
