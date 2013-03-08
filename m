From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 08 Mar 2013 11:04:00 -0700
Subject: [PATCH 4/5] ARM: DT: tegra114: add KBC controller DT entry
In-Reply-To: <1362750782-15174-5-git-send-email-ldewangan@nvidia.com>
References: <1362750782-15174-1-git-send-email-ldewangan@nvidia.com>
 <1362750782-15174-5-git-send-email-ldewangan@nvidia.com>
Message-ID: <513A2810.1070903@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2013 06:53 AM, Laxman Dewangan wrote:
> NVIDIA's Tegra114 SoCs have the matrix keyboard controller which
> supports 11x8 type of matrix. The number of rows and columns
> are configurable.

Earlier Tegra versions supported up to a 16x8 matrix. This feeds into
the following defines in the driver:

#define KBC_MAX_GPIO    24
#define KBC_MAX_ROW     16
#define KBC_MAX_COL     8
#define KBC_MAX_KEY     (KBC_MAX_ROW * KBC_MAX_COL)

Given Tegra114 supports /fewer/ pins and rows than earlier chips, I
think that makes the HW technically incompatible, since GPIO IDs 19..23
are invalid in this HW but valid earlier.

Now in practice I suppose that with a correct DT keyboard map for a
Tegra114 device, those extra invalid GPIOs would never be referenced, so
this is a little nit-picky, but I still feel we should fix this.

So, I'd like to see the KBC driver updated to derive the values for all
the defines I listed above from the compatible value.

Technically, tegra114.dtsi should not pretend that the Tegra114 KBC is
compatible with previous generations either.

> diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi

> +	kbc {
> +		compatible = "nvidia,tegra20-kbc";

Ignoring any of the discussion above, i.e. even if the HW was 100%
identical, we should still include a Tegra114 entry in the compatible
property (compatible = "nvidia,tegra114-kbc", "nvidia,tegra20-kbc"), so
that if Tegra114-specific bugs were found in the future, any device
trees would already indicate that they describe Tegra114 HW, so the SW
could key off that to enable the workaround.

Re-stated: The rules for compatible are: Always include the exact HW
name, then optionally include any other HW names it's compatible with.
