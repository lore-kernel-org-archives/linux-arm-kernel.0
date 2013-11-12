From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 12 Nov 2013 15:48:22 -0700
Subject: [PATCHv4 1/7] ARM: tegra: Create a DT header defining SWGROUP ID
In-Reply-To: <1384158718-4756-2-git-send-email-hdoyu@nvidia.com>
References: <1384158718-4756-1-git-send-email-hdoyu@nvidia.com>
 <1384158718-4756-2-git-send-email-hdoyu@nvidia.com>
Message-ID: <5282B036.9090604@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/2013 01:31 AM, Hiroshi Doyu wrote:
> Create a header file to define the swgroup IDs used by the IOMMU(SMMU)
> binding. "swgroup" is a group of H/W clients which a Tegra SoC
> supports. This unique ID can be used to calculate MC_SMMU_<swgroup
> name>_ASID_0 register offset and MC_<swgroup name>_HOTRESET_*_0
> register bit. This will allow the same header to be used by both
> device tree files, and drivers implementing this binding, which
> guarantees that the two stay in sync. This also makes device trees
> more readable by using names instead of magic numbers. For HOTRESET
> bit shifting we need another conversion table, which will come later.

> diff --git a/include/dt-bindings/memory/tegra-swgroup.h b/include/dt-bindings/memory/tegra-swgroup.h

> +#define TEGRA_SWGROUP_PPCS2	32	/* 0xab0 */
> +
> +#define TEGRA_SWGROUP_MAX	64
> +
> +#define TEGRA_SWGROUP_BIT(x)	(1ULL << TEGRA_SWGROUP_##x)

If I put the following into a DT and compile it:

#define TEGRA_SWGROUP_PPCS2	32	/* 0xab0 */
#define TEGRA_SWGROUP_BIT(x)	(1ULL << TEGRA_SWGROUP_##x)
/ {
	test-prop = <(TEGRA_SWGROUP_BIT(PPCS2))>;
};

I get:

Error: arch/arm/boot/dts/tegra20.dtsi:11.28-29 integer value out of
range 0000000000000020 (32 bits)
FATAL ERROR: Syntax error parsing input tree

Is TEGRA_SWGROUP_BIT() not meant to be used in DT files? If it is, the
definition is broken. If it is not, it should be defined in the driver
not the header, since DT files have no use for it.

Note: I mentioned this issue last time I reviewed this patch:-(
