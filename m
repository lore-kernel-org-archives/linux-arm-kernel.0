From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 31 Mar 2011 12:29:05 +0100
Subject: [PATCH 4/8] OMAP2+: omap_hwmod: manage the omap_devices the
	wake-up latency constraints
In-Reply-To: <1301498364-726-5-git-send-email-j-pihet@ti.com>
References: <1301498364-726-1-git-send-email-j-pihet@ti.com>
	<1301498364-726-5-git-send-email-j-pihet@ti.com>
Message-ID: <20110331112905.GA17547@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2011 at 05:19:20PM +0200, jean.pihet at newoldbits.com wrote:
> +/*
> + * omap_hwmod_set_wkup_constraint- set/release a wake-up latency constraint
> + *
> + * @oh: struct omap_hwmod* to which the target device belongs to.
> + * @cookie: identifier of the constraints list for @oh.
> + * @min_latency: the minimum allowed wake-up latency for @oh.
> + *
> + * Returns 0 upon success.
> + */
> +int omap_hwmod_set_wkup_lat_constraint(struct omap_hwmod *oh,
> +				       void *cookie, long min_latency)
> +{
> +	struct powerdomain *pwrdm = omap_hwmod_get_pwrdm(oh);
> +
> +	if (!PTR_ERR(pwrdm)) {
> +		pr_err("%s: Error: could not find powerdomain "
> +		       "for %s\n", __func__, oh->name);
> +		return -EINVAL;
> +	}

If omap_hwmod_get_pwrdm() returns errors encoded into pointers, then:

	if (IS_ERR(pwrdm)) {
		...
		return PTR_ERR(pwrdm);
	}

If it doesn't, then:

	if (!pwrdm) {
		...
		return -EINVAL;
	}

Note that PTR_ERR returns true for both valid error codes and valid
pointers.  Use the interface correctly and don't take shortcuts.  They
don't work.
