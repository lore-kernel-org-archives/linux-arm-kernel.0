From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 12 Aug 2013 13:09:50 +0200
Subject: [PATCH V3] ARM: tegra: disable LP2 cpuidle state if PCIe is
 enabled
In-Reply-To: <1376078656-1378-1-git-send-email-swarren@wwwdotorg.org>
References: <1376078656-1378-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130812110949.GB12042@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 09, 2013 at 02:04:16PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Tegra20 HW appears to have a bug such that PCIe device interrupts, whether
> they are legacy IRQs or MSI, are lost when LP2 is enabled. To work around
> this, simply disable LP2 if the PCI driver and DT node are both enabled.

This description is no longer accurate.

> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> I intend to apply this on top of Thierry's Tegra PCIe driver series.
> 
> v3: Only disable LP2 if a PCIe device that requests an interrupt is
> actually present. This prevents the loss of power-saving when the WAR
> isn't required.

Currently I see the informational message about LP2 being disabled
rather early in PCI setup. That's probably caused by the .map_irq()
being called during enumeration/fixup. So effectively this disables LP2
as soon as a PCI device is found, whether it needs the IRQ or not. But I
don't think we can do any better than this, so that's fine.

[...]
> diff --git a/arch/arm/mach-tegra/cpuidle.c b/arch/arm/mach-tegra/cpuidle.c
[...]
> +void tegra_cpuidle_pcie_irqs_in_use(void)
> +{
> +	switch (tegra_chip_id) {
> +	case TEGRA20:
> +		if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC))
> +			tegra20_cpuidle_pcie_irqs_in_use();
> +		break;
> +	}
> +}

I plan to eventually (3.13 perhaps) support building the pci-tegra
driver as a module since most or all prerequisites are now in place, so
we'll need to export this function eventually. But we can do that when
we actually need it. Perhaps somebody will find a better fix for the LP2
problem until then.

> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
[...]
> @@ -41,6 +41,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
> +#include <linux/tegra-cpuidle.h>

That file doesn't exist in any tree I have. Perhaps it's a new file and
you forgot to add it in this commit?

I've added that file locally to test the patch and verified that it
works around the issue on TrimSlice while not causing any regressions on
Beaver (it doesn't run any code on !ARCH_TEGRA_2x_SOC anyway, but better
safe than sorry).

So with the missing header file added:

Tested-by: Thierry Reding <treding@nvidia.com>

And with an updated commit message:

Acked-by: Thierry Reding <treding@nvidia.com>

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130812/d8727962/attachment.sig>
