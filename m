From: tony@atomide.com (Tony Lindgren)
Date: Wed, 18 Sep 2013 12:23:31 -0700
Subject: [RFCv2 2/3] ARM: OMAP2+: HSI: Introduce OMAP SSI driver
In-Reply-To: <1379277856-24571-3-git-send-email-sre@debian.org>
References: <1379277856-24571-1-git-send-email-sre@debian.org>
 <1379277856-24571-3-git-send-email-sre@debian.org>
Message-ID: <20130918192331.GD9994@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sebastian Reichel <sre@debian.org> [130915 13:56]:
> This patch adds an OMAP SSI driver to the HSI framework.

Thanks for working on this.
 
> +config OMAP_SSI
> +	tristate "OMAP SSI hardware driver"
> +	depends on ARCH_OMAP && HSI
> +	default n
> +	---help---
> +	  SSI is a legacy version of HSI. It is usually used to connect
> +	  an application engine with a cellular modem.
> +	  If you say Y here, you will enable the OMAP SSI hardware driver.

You can drop the "default n" line here, it's the default.

> +/* TODO: HACK: define omap_pm_get_dev_context_loss_count, because it is defined
> + * in arch/arm/mach-omap2/omap-pm.h and thus not available via #include */
> +int omap_pm_get_dev_context_loss_count(struct device *dev);

You can drop this and related calls completely and rely on some
SSI configuration registers instead to detect if context was lost.

The reason for that is that the context loss count should be
implemented in Linux generic way if needed at all and we can leave
out a dependency to that.

If there's a chance that the context is only partially lost,
then of course something else is needed. So far I have not
hit that issue for MMC or serial at least, but you'd have to
test this with off-idle to verify it.

Regards,

Tony
