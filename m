From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Dec 2010 21:44:20 +0000
Subject: [PATCH v5 5/5] msm: add SMP support for msm
In-Reply-To: <1292482456-22690-6-git-send-email-johlstei@codeaurora.org>
References: <1292482456-22690-1-git-send-email-johlstei@codeaurora.org>
	<1292482456-22690-6-git-send-email-johlstei@codeaurora.org>
Message-ID: <20101216214420.GX9937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 15, 2010 at 10:54:16PM -0800, Jeff Ohlstein wrote:
> +void __cpuinit platform_secondary_init(unsigned int cpu)
> +{
> +	/* Configure edge-triggered PPIs */
> +	writel(GIC_PPI_EDGE_MASK, MSM_QGIC_DIST_BASE + GIC_DIST_CONFIG + 4);

At some point we should really clean this up so we don't have code
writing directly to the GIC registers like this.

> +static __init void prepare_cold_cpu(unsigned int cpu)
> +{
> +	int ret;
> +	ret = scm_set_boot_addr((void *)
> +				virt_to_phys(msm_secondary_startup),

It seems wrong to cast a physical address to a pointer - physical
addresses should not be pointer-like.  Can it stay as an integer?
