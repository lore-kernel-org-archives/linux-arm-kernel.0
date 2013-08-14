From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 14 Aug 2013 15:38:05 -0600
Subject: [PATCH v3 2/5] ARM: tegra: add support for Trusted Foundations
In-Reply-To: <1376360992-1508-3-git-send-email-acourbot@nvidia.com>
References: <1376360992-1508-1-git-send-email-acourbot@nvidia.com>
 <1376360992-1508-3-git-send-email-acourbot@nvidia.com>
Message-ID: <520BF8BD.7050706@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/2013 08:29 PM, Alexandre Courbot wrote:
> Register the firmware operations for Trusted Foundations if the device
> tree indicates it is active on the device.

> diff --git a/arch/arm/mach-tegra/firmware.c b/arch/arm/mach-tegra/firmware.c

> +void __init tegra_init_firmware(void)
> +{
> +	struct device_node *node;
> +
> +	if (!of_have_populated_dt())
> +		return;

That's never false on Tegra, at least upstream.

> +	node = of_find_compatible_node(NULL, NULL, "tl,trusted-foundations");
> +	if (node) {
> +		const char *tf_version;
> +		int err;
> +
> +		err = of_property_read_string(node, "version", &tf_version);
> +		if (err != 0) {
> +			pr_crit("Cannot read Trusted Foundation version: %d\n",
> +				err);
> +			BUG();
> +		} else {
> +			register_trusted_foundations(tf_version);
> +		}
> +	}
> +}

I think most/all of that function will be common across all SoCs that
support the TF monitor. I think you want to move the code into
register_trusted_foundations() (or a function that calls that) in patch 1?
