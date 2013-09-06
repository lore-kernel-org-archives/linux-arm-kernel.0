From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 06 Sep 2013 13:29:31 -0600
Subject: [PATCH v5 1/5] ARM: add basic Trusted Foundations support
In-Reply-To: <1378351680-14696-2-git-send-email-acourbot@nvidia.com>
References: <1378351680-14696-1-git-send-email-acourbot@nvidia.com>
 <1378351680-14696-2-git-send-email-acourbot@nvidia.com>
Message-ID: <522A2D1B.3010508@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/04/2013 09:27 PM, Alexandre Courbot wrote:
> Trusted Foundations is a TrustZone-based secure monitor for ARM that
> can be invoked  using a consistent SMC-based API on all supported
> platforms. This patch adds initial basic support for Trusted
> Foundations using the ARM firmware API. Current features are limited
> to the ability to boot secondary processors.

> diff --git a/arch/arm/firmware/trusted_foundations.c b/arch/arm/firmware/trusted_foundations.c
...
> +void of_register_trusted_foundations(void)
> +{
> +	struct device_node *node;
> +	struct trusted_foundations_platform_data pdata;
> +	int err;
> +
> +	node = of_find_compatible_node(NULL, NULL, "tl,trusted-foundations");
> +
> +	if (!node)
> +		return;

If you're going to revise this patch for the comment below, then I would
suggest removing the blank line before that if statement.

> diff --git a/arch/arm/include/asm/trusted_foundations.h b/arch/arm/include/asm/trusted_foundations.h

Do we need to add the following here:

#if !IS_ENABLED(CONFIG_OF)
static inline void register_trusted_foundations(...) {}
#endif

So that there is a dummy no-op function for the non-DT-support case? I
guess Tegra always has CONFIG_OF enabled so that call from
mach-tegra/common.c in patch 2 will never be an issue, but perhaps it
might if anyone else uses this?
