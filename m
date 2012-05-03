From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 03 May 2012 11:41:35 -0600
Subject: [PATCHv3 1/4] ARM: tegra: Add Tegra AHB driver
In-Reply-To: <1336061147-10245-1-git-send-email-hdoyu@nvidia.com>
References: <1336061147-10245-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <4FA2C34F.5060406@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/2012 10:05 AM, Hiroshi DOYU wrote:
> Tegra AHB Bus conforms to the AMBA Specification (Rev 2.0) Advanced
> High-performance Bus (AHB) architecture.
> 
> The AHB Arbiter controls AHB bus master arbitration. This effectively
> forms a second level of arbitration for access to the memory
> controller through the AHB Slave Memory device. The AHB pre-fetch
> logic can be configured to enhance performance for devices doing
> sequential access. Each AHB master is assigned to either the high or
> low priority bin. Both Tegra20/30 have this AHB bus.
> 
> Some of configuration param could be passed from DT too.

> diff --git a/drivers/amba/tegra-ahb.c b/drivers/amba/tegra-ahb.c
> +static u32 tegra_ahb_gizmo[] = {

const?

> +static int __init tegra_ahb_module_init(void)
> +{
> +	return platform_driver_register(&tegra_ahb_driver);
> +}
> +postcore_initcall(tegra_ahb_module_init);

Can this be a module_init() instead of postcore_initcall()?

> +
> +static void __exit tegra_ahb_module_exit(void)
> +{
> +	platform_driver_unregister(&tegra_ahb_driver);
> +}
> +module_exit(tegra_ahb_module_exit);

If so, all of the previous two quoted chunks can be replaced with just:

module_platform_driver(tegra_ahb_module_init);
