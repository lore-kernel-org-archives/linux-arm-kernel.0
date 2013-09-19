From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 19 Sep 2013 13:49:31 -0700
Subject: [PATCH v6 1/5] ARM: add basic support for Trusted Foundations
In-Reply-To: <1379238028-7960-2-git-send-email-acourbot@nvidia.com> (Alexandre
 Courbot's message of "Sun, 15 Sep 2013 18:40:24 +0900")
References: <1379238028-7960-1-git-send-email-acourbot@nvidia.com>
 <1379238028-7960-2-git-send-email-acourbot@nvidia.com>
Message-ID: <87d2o4edus.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexandre Courbot <acourbot@nvidia.com> writes:

> Trusted Foundations is a TrustZone-based secure monitor for ARM that
> can be invoked using the same SMC-based API on all supported
> platforms. This patch adds initial basic support for Trusted
> Foundations using the ARM firmware API. Current features are limited
> to the ability to boot secondary processors.

[...]

> +#if IS_ENABLED(CONFIG_OF)
> +void of_register_trusted_foundations(void)
> +{
> +	struct device_node *node;
> +	struct trusted_foundations_platform_data pdata;
> +	int err;
> +
> +	node = of_find_compatible_node(NULL, NULL, "tl,trusted-foundations");
> +	if (!node)
> +		return;
> +
> +	err = of_property_read_u32(node, "version-major", &pdata.version_major);
> +	if (err != 0)
> +		panic("Trusted Foundation: missing version-major property\n");

Do really need to panic() the whole kernel for a missing property?
Surely this can more gracefully recover, or assume some defaults?  

Same comment for the other uses of panic() in this patch.

Kevin
