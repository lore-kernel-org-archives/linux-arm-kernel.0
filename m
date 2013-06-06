From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 06 Jun 2013 10:44:48 -0600
Subject: [PATCH] ARM: tegra: add basic SecureOS support
In-Reply-To: <1370503687-17767-1-git-send-email-acourbot@nvidia.com>
References: <1370503687-17767-1-git-send-email-acourbot@nvidia.com>
Message-ID: <51B0BC80.9040007@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2013 01:28 AM, Alexandre Courbot wrote:
> Boot loaders on some Tegra devices can be unlocked but do not let the
> system operate without SecureOS. SecureOS prevents access to some
> registers and requires the operating system to perform certain
> operations through Secure Monitor Calls instead of directly accessing
> the hardware.
> 
> This patch introduces basic SecureOS support for Tegra. SecureOS support
> can be enabled by adding a "nvidia,secure-os" property to the "chosen"
> node of the device tree.

I suspect "SecureOS" here is the name of a specific implementation of a
secure monitor, right? It's certainly a very unfortunate name, since it
sounds like a generic concept rather than a specific implementation:-(

There certainly could be (and I believe are in practice?) multiple
implementation of a secure monitor for Tegra. Presumably, each of those
implementations has (or could have) a different definition for what SVC
calls it supports, their parameters, etc.

I think we need to separate the concept of support for *a* secure
monitor, from support for a *particular* secure monitor.

> diff --git a/Documentation/devicetree/bindings/arm/tegra.txt b/Documentation/devicetree/bindings/arm/tegra.txt

> +node:
> +
> +  nvidia,secure-os: enable SecureOS.

... as such, I think some work is needed here to allow specification of
which secure monitor is present and/or which secure monitor ABI it
implements. The suggestion to use a specific DT node, and hence use
compatible values for this, seems reasonable. Alternatively, perhaps:

nvidia,secure-monitor = "name_of_vendor_or_SMC_ABI";

might be reasonable, although using a node would allow ABI-specific
additional properties to be defined should they be needed, so I guess I
would lean towards that.

Similar comments may apply to the CONFIG_ option and description,
filenames, etc.

> diff --git a/arch/arm/mach-tegra/secureos.c b/arch/arm/mach-tegra/secureos.c

> +void __init tegra_init_secureos(void)
> +{
> +	struct device_node *node = of_find_node_by_path("/chosen");
> +
> +	if (node && of_property_read_bool(node, "nvidia,secure-os"))
> +		register_firmware_ops(&tegra_firmware_ops);
> +}

I'm tempted to think that function should /always/ exist an be called
(so no dummy inline in secureos.h).

In particular, what happens when a kernel without CONFIG_SECUREOS
enabled is booted under a secure monitor. Presumably we want the init
code to explicitly check for this condition, and either BUG(), or do
something to disable any features (like SMP) that require SVCs?

So, the algorithm here might be more like:

find node
if node exists
    if (!IS_ENABLED(SECURE_OS))
        BUG/WARN/...
    else
        register_firmware_ops()

?
