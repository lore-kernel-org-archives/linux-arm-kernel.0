From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 07 Oct 2013 11:16:59 -0700
Subject: [PATCH v7 1/5] ARM: add basic support for Trusted Foundations
In-Reply-To: <1380904635-18113-2-git-send-email-acourbot@nvidia.com>
 (Alexandre Courbot's message of "Fri, 4 Oct 2013 09:37:11 -0700")
References: <1380904635-18113-1-git-send-email-acourbot@nvidia.com>
 <1380904635-18113-2-git-send-email-acourbot@nvidia.com>
Message-ID: <871u3xdjz8.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexandre Courbot <acourbot@nvidia.com> writes:

> Trusted Foundations is a TrustZone-based secure monitor for ARM that
> can be invoked using the same SMC-based API on all supported
> platforms. This patch adds initial basic support for Trusted
> Foundations using the ARM firmware API. Current features are limited
> to the ability to boot secondary processors.
>
> Note: The API followed by Trusted Foundations does *not* follow the SMC
> calling conventions. It has nothing to do with PSCI neither and is only
> relevant to devices that use Trusted Foundations (like most Tegra-based
> retail devices).
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> Reviewed-by: Stephen Warren <swarren@nvidia.com>

[...]

> +void register_trusted_foundations(struct trusted_foundations_platform_data *pd)
> +{
> +	/* we are not using version information for now since currently
> +	 * supported SMCs are compatible with all TF releases */

nit: multi-line comment style...

[...]

> +static inline void register_trusted_foundations(
> +				   struct trusted_foundations_platform_data *pd)
> +{
> +	/* If we try to register TF, this means the system needs it to continue.
> +	 * Its absence if thus a fatal error. */

...and here...

> +	panic("No support for Trusted Foundations, stopping...\n");
> +}
> +
> +static inline void of_register_trusted_foundations(void)
> +{
> +	/* If we find the target should enable TF but does not support it,
> +	 * fail as the system won't be able to do much anyway */

...and here.

> +	if (of_find_compatible_node(NULL, NULL, "tl,trusted-foundations"))
> +		register_trusted_foundations(NULL);
> +}
> +#endif /* CONFIG_TRUSTED_FOUNDATIONS */
> +
> +#endif

Kevin
