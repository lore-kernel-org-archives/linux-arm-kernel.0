From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 31 Mar 2015 09:27:53 -0700
Subject: [PATCH 2/4] soc: Mediatek: Add SCPSYS power domain driver
In-Reply-To: <1426002063-25713-3-git-send-email-s.hauer@pengutronix.de>
 (Sascha Hauer's message of "Tue, 10 Mar 2015 16:41:01 +0100")
References: <1426002063-25713-1-git-send-email-s.hauer@pengutronix.de>
 <1426002063-25713-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <7hbnj9b08m.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

Sascha Hauer <s.hauer@pengutronix.de> writes:

> This adds a power domain driver for the Mediatek SCPSYS unit.
>
> The System Control Processor System (SCPSYS) has several power
> management related tasks in the system. The tasks include thermal
> measurement, dynamic voltage frequency scaling (DVFS), interrupt
> filter and lowlevel sleep control. The System Power Manager (SPM)
> inside the SCPSYS is for the MTCMOS power domain control.
>
> For now this driver only adds power domain support, the more
> advanced features are not yet supported. The driver implements
> the generic PM domain device tree bindings, the first user will
> most likely be the Mediatek AFE audio driver.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Sorry for the lag, was travelling last week at ELC and not keeping up
with reviews.

This version looks pretty good to me, but had one minor
comment/question...

[...]

> +#define NUM_DOMAINS	ARRAY_SIZE(scp_domain_data)
> +
> +struct scp;
> +
> +struct scp_domain {
> +	struct generic_pm_domain pmd;
> +	struct scp_domain_data *data;
> +	struct scp *scp;
> +};
> +
> +struct scp {
> +	struct scp_domain domains[NUM_DOMAINS];
> +	struct generic_pm_domain *pmd[NUM_DOMAINS];

Why is this genpd pointer needed?  It's just a pointer to the
.domains.pmd[i] anyways, and IMO makes the code a bit hard to follow.

Kevin
