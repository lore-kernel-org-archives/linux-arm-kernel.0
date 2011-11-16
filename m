From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 16 Nov 2011 15:44:02 +0000
Subject: [PATCH 3/5] ARM: vexpress: Add DT support in v2m
In-Reply-To: <1321036026-23411-4-git-send-email-pawel.moll@arm.com>
References: <1321036026-23411-1-git-send-email-pawel.moll@arm.com>
 <1321036026-23411-4-git-send-email-pawel.moll@arm.com>
Message-ID: <20111116154402.GE2073@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2011 at 06:27:04PM +0000, Pawel Moll wrote:
> This patch provides hooks for DT-based tile machine implementations
> and adds Device Tree description for the motherboard.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/vexpress    |   92 ++++++++++
>  arch/arm/boot/dts/vexpress-v2m-legacy.dtsi        |  190 +++++++++++++++++++++
>  arch/arm/mach-vexpress/Kconfig                    |    4 +
>  arch/arm/mach-vexpress/core.h                     |    9 +
>  arch/arm/mach-vexpress/include/mach/motherboard.h |    8 +
>  arch/arm/mach-vexpress/v2m.c                      |  140 +++++++++++++++-
>  6 files changed, 442 insertions(+), 1 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/vexpress
>  create mode 100644 arch/arm/boot/dts/vexpress-v2m-legacy.dtsi
> 
> diff --git a/Documentation/devicetree/bindings/arm/vexpress b/Documentation/devicetree/bindings/arm/vexpress

[...]

> +Required properties in the root node:
> +- compatible value:
> +  - for motherboard in "legacy" mode:
> +	compatible = "arm,vexpress-<model>", "arm,vexpress-legacy", "arm-vexpress";
> +  - for motherboard in "RS1" mode:
> +	compatible = "arm,vexpress-<model>", "arm-vexpress";

So, we have:

arm,vexpress-* implies arm,vexpress
arm,vexpress-* may imply arm,vexpress-legacy
arm,vexpress-legacy implies arm,vexpress

This means we have no bounded test for RS1-only features:
the needed test is
"compatible(node, "arm,vexpress") && !compatible(node, "arm,vexpress-legacy")

Unfortunately, if there is someday an "rs2" memory map, that will also match
the above.  Using "inverse compatibility" in this way feels dangerous,
because the condition will pass for an arbitrary set of future conditions
that we haven't imagined yet.

This means it's, impossible even in principle to panic the kernel cleanly if
presented with a device tree for a platform variant which is too new for the
kernel to support.


Can we instead have a specific "arm,vexpress-rs1"?

	compatible = "arm,vexpress-<model>", "arm-vexpress-rs1", "arm-vexpress";

Then, we can be exact about compatibility: universal features are compatible
with "arm,vexpress"; memory-map-specific features are compatible with either
"arm,vexpress-legacy" or "arm,vexpress-rs1".


> +  where <model> is the the model, eg:

Two "the"s.

What "model" means isn't obvious to the uninitiated -- how about
something like "where <model> is the full platform model name" ?

> +  - for Coretile Express A5x2 (V2P-CA5s):
> +	compatible = "arm,vexpress-v2p-ca5s", "arm-vexpress";
> +  - Coretile Express A9x4 (V2P-CA9):
> +	comaptible = "arm,vexpress-v2p-ca9", "arm,vexpress-legacy", "arm-vexpress";
> +
> +Current Linux implementation requires a "timer" alias pointing
> +at a SP804 timer block to be used when tile is not using local
> +timer source.

We should specify a list of all the "standard" aliases used by the
generic motherboard code here, since these are part of the contract
between each board-specific device tree and the motherboard code.

Is "timer" the only one, or are there others?

[...]

> diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
> index 9311484..4c11e90 100644
> --- a/arch/arm/mach-vexpress/Kconfig
> +++ b/arch/arm/mach-vexpress/Kconfig
> @@ -9,4 +9,8 @@ config ARCH_VEXPRESS_CA9X4
>  	select ARM_ERRATA_751472
>  	select ARM_ERRATA_753970
>  

For "non-interactive" config items, can we still please have comments
indicating what the item means and how it should be used?

Such comments can be very brief, but having at least something makes the
configs easier to understand and maintain, in my view.

[...]

> diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c

[...]

> +void __init v2m_dt_init_early(void)
> +{
> +	struct device_node *node;
> +	const __be32 *reg;
> +	u32 dt_hbi;
> +
> +	node = of_find_compatible_node(NULL, NULL, "arm,vexpress-sysreg");
> +	BUG_ON(!node);
> +	/* The following will become of_iomap() when possible */
> +	reg = of_get_property(node, "reg", NULL);
> +	BUG_ON(!reg);
> +	v2m_sysreg_base = V2M_PERIPH_P2V(be32_to_cpup(reg));
> +
> +	/* Confirm board type against DT property, if available */
> +	if (of_property_read_u32(allnodes, "arm,hbi", &dt_hbi) == 0) {
> +		u32 misc = readl(v2m_sysreg_base + V2M_SYS_MISC);
> +		u32 id = readl(v2m_sysreg_base + (misc & SYS_MISC_MASTERSITE ?
> +				V2M_SYS_PROCID1 : V2M_SYS_PROCID0));
> +		u32 hbi = id & SYS_PROCIDx_HBI_MASK;
> +
> +		if (WARN_ON(dt_hbi != hbi))
> +			pr_warning("vexpress: DT HBI (%x) is not matching "
> +					"hardware (%x)!\n", dt_hbi, hbi);

Once this code is mature enough, should we panic the kernel here
instead?

Cheers
---Dave
