From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Jan 2011 23:28:43 +0000
Subject: [PATCH v2 11/11] msm: Support for the MSM8960 RUMI3 target
In-Reply-To: <1295468747-22796-12-git-send-email-davidb@codeaurora.org>
References: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
	<1295468747-22796-1-git-send-email-davidb@codeaurora.org>
	<1295468747-22796-12-git-send-email-davidb@codeaurora.org>
Message-ID: <20110124232843.GR24104@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 19, 2011 at 12:25:47PM -0800, David Brown wrote:
> --- a/arch/arm/mach-msm/board-msm8960.c
> +++ b/arch/arm/mach-msm/board-msm8960.c
> @@ -41,6 +41,9 @@ static void __init msm8960_init_irq(void)
>  	/* Edge trigger PPIs except AVS_SVICINT and AVS_SVICINTSWDONE */
>  	writel(0xFFFFD7FF, MSM_QGIC_DIST_BASE + GIC_DIST_CONFIG + 4);
>  
> +	if (machine_is_msm8960_rumi3())
> +		writel(0x0000FFFF, MSM_QGIC_DIST_BASE + GIC_DIST_ENABLE_SET);
> +

We really need to sort out the GIC initialization so that this kind of
stuff isn't scattered throughout platform files.

In fact, I thought we had already sorted out enabling the SGI interrupts
in the common gic code - it happens when you call gic_cpu_init().  So
I don't think the above is required.

As far as the edge triggering PPIs, that also needs sorting properly.
