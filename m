From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 27 May 2011 12:30:09 -0700
Subject: [RFC PATCH v4 01/13] ARM: gic: add per-cpu interrupt multiplexer
In-Reply-To: <1306513671-12206-2-git-send-email-marc.zyngier@arm.com>
References: <1306513671-12206-1-git-send-email-marc.zyngier@arm.com>
	<1306513671-12206-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <4DDFFBC1.7010202@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/27/2011 09:27 AM, Marc Zyngier wrote:
> The kernel doesn't handle very well the concept of per-cpu interrupt
> as implemented by the ARM architecture (the same interrupt level is
> exposed on each core).
>
> To work around the problem, add another irq_chip to handle PPIs and
> remap them so that a single interrupt number is only used on a given
> CPU (for example, IRQ 29 and 30 get exposed as IRQ 128 and 129 on
> core 0, 130 and 131 on core 1...).
>
> A helper function gic_ppi_to_vppi() is used to convert the PPI number
> to the per-processor IRQ.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Reviewed-by: Will Deacon <will.deacon@arm.com>

Tested-by: Stephen Boyd <sboyd@codeaurora.org>

> diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
> index ea5ee4d..020a531 100644
> --- a/arch/arm/common/Kconfig
> +++ b/arch/arm/common/Kconfig
> @@ -1,6 +1,11 @@
>  config ARM_GIC
>  	bool
>  
> +config ARM_GIC_VPPI
> +	depends on ARM_GIC
> +	select SPARSE_IRQ
> +        bool
> +

Nitpick: bool should be tabbed out instead of with spaces.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
