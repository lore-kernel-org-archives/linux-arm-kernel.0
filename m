From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 03 Sep 2013 12:40:20 -0600
Subject: [PATCH v4 1/5] ARM: add basic Trusted Foundations support
In-Reply-To: <1377770268-14014-2-git-send-email-acourbot@nvidia.com>
References: <1377770268-14014-1-git-send-email-acourbot@nvidia.com>
 <1377770268-14014-2-git-send-email-acourbot@nvidia.com>
Message-ID: <52262D14.4000907@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/29/2013 03:57 AM, Alexandre Courbot wrote:
> Trusted Foundations is a TrustZone-based secure monitor for ARM that
> can be invoked  using a consistent smc-based API on all supported

Nit: s/smc/SMC/?

> diff --git a/arch/arm/include/asm/trusted_foundations.h b/arch/arm/include/asm/trusted_foundations.h

> +#if IS_ENABLED(CONFIG_TRUSTED_FOUNDATIONS)
> +
> +void register_trusted_foundations(struct trusted_foundations_platform_data *pd);
> +void of_register_trusted_foundations(void);
> +
> +#else
> +
> +static inline void register_trusted_foundations(
> +				   struct trusted_foundations_platform_data *pd)
> +{
> +	pr_crit("No support for Trusted Foundations, stopping...\n");
> +	BUG();
> +}
> +
> +static inline void of_register_trusted_foundations(void)
> +{
> +	register_trusted_foundations(NULL);

That will cause a hard-fail. I assume that should only happen if the TL
DT node is present; if there's no DT node, it's fine for a kernel
without any TL support to run.

> +}
> +
> +#endif /* IS_ENABLED(CONFIG_TRUSTED_FOUNDATIONS) */
