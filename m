From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 22 May 2012 11:17:04 +0100
Subject: [PATCH V2 1/3] ARM: tegra: trimslice: enable PCIe when booting
 from device tree
In-Reply-To: <1337289674-18581-1-git-send-email-swarren@wwwdotorg.org>
References: <1337289674-18581-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <4FBB67A0.9010606@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/05/12 22:21, Stephen Warren wrote:
> From: Stephen Warren<swarren@nvidia.com>
>
> There currently aren't bindings for the Tegra PCIe controller. Work on
> this is in progress, but not yet complete. Manually initialize PCIe when
> booting from device tree, in order to bring DT support to the same
> feature level as board files, which will in turn allow board files to be
> deprecated.
>
> PCIe hosts the wired Ethernet controller on TrimSlice.
>
> To support this, add infra-structure to board-dt-tegra20.c for board-
> specific initialization code. Once device tree support for the relevant
> features is in place, this code will be removed.
>
> Signed-off-by: Stephen Warren<swarren@nvidia.com>
> ---
> v2: Use .init_late hook in DT_MACHINE_START instead of an explicit late
> initcall.
> ---
>   arch/arm/mach-tegra/board-dt-tegra20.c |   36 +++++++++++++++++++++++++++++++-
>   1 files changed, 35 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-tegra/board-dt-tegra20.c
> index eb7249d..9537f20 100644
> --- a/arch/arm/mach-tegra/board-dt-tegra20.c
> +++ b/arch/arm/mach-tegra/board-dt-tegra20.c
> @@ -98,6 +98,40 @@ static void __init tegra_dt_init(void)
>   				tegra20_auxdata_lookup, NULL);
>   }
>
> +#ifdef CONFIG_MACH_TRIMSLICE
> +static void __init trimslice_init(void)
> +{
> +	int ret;
> +
> +	ret = tegra_pcie_init(true, true);
> +	if (ret)
> +		pr_err("tegra_pci_init() failed: %d\n", ret);
> +}
> +#endif

Given the size of some of these functions, is it worth even
bothering with an #ifdef around them, especially as they are
marked init.

How about having some sort of standard pcie binding for the pcie
part?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
