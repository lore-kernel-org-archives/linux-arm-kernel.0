From: joshc@codeaurora.org (Josh Cartwright)
Date: Wed, 30 Apr 2014 11:17:17 -0500
Subject: [PATCH] arm: socfpga: reserve the region at start of phys mem
In-Reply-To: <1392744897-6384-1-git-send-email-bigeasy@linutronix.de>
References: <1392744897-6384-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <20140430161717.GY5546@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 06:34:57PM +0100, Sebastian Andrzej Siewior wrote:
> The SMP bringup code copies trampline code to the physical location 0x0.
> If somebody allocated memory from this location then it will be
> overwritten.
> This patch reserves the few bytes so that it won't be used by the memory
> allocator.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
[..]
> +static void __init socfmpga_smp_reserve(void)
> +{
> +#ifdef CONFIG_SMP
> +	int trampoline_size = &secondary_trampoline_end - &secondary_trampoline;
> +	int ret;
> +
> +	ret = memblock_reserve(0, trampoline_size);
> +	WARN_ON(ret);
> +#endif
> +}
> +
>  static const char *altera_dt_match[] = {
>  	"altr,socfpga",
>  	NULL
> @@ -327,4 +339,5 @@ DT_MACHINE_START(SOCFPGA, "Altera SOCFPGA")
>  	.init_machine	= socfpga_cyclone5_init,
>  	.restart	= socfpga_cyclone5_restart,
>  	.dt_compat	= altera_dt_match,
> +	.reserve	= socfmpga_smp_reserve,
>  MACHINE_END

Is there a particular reason why you aren't describing this reservation
in devicetree using a /memreserve/ node?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
