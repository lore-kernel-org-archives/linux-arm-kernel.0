From: marex@denx.de (Marek Vasut)
Date: Mon, 21 Jul 2014 18:15:20 +0200
Subject: [PATCH RFC 9/9] arm: imx: non-secure aliased mapping of GIC
 registers
In-Reply-To: <1405954040-30399-10-git-send-email-daniel.thompson@linaro.org>
References: <1405954040-30399-1-git-send-email-daniel.thompson@linaro.org>
 <1405954040-30399-10-git-send-email-daniel.thompson@linaro.org>
Message-ID: <201407211815.21099.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 21, 2014 at 04:47:20 PM, Daniel Thompson wrote:
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  arch/arm/mach-imx/mach-imx6q.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/mach-imx6q.c
> b/arch/arm/mach-imx/mach-imx6q.c index e60456d..192d268 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -381,10 +381,21 @@ static void __init imx6q_init_late(void)
>  	}
>  }
> 
> +static struct map_desc gic_cpu_io_desc __initdata = {
> +		.virtual        = 0xff000000,
> +		.pfn            = __phys_to_pfn(0x00a00000),
> +		.length         = SZ_1M,
> +		.type           = MT_DEVICE_NS,
> +};
> +
>  static void __init imx6q_map_io(void)
>  {
>  	debug_ll_io_init();
>  	imx_scu_map_io();
> +	/* TODO: Need to check we are running without a secure monitor before
> +	 *       setting up this mapping.
> +	 */
> +	iotable_init(&gic_cpu_io_desc, 1);
>  }

Is there no way to add ioremap_nonsecure() so the gic can allocate the mapping 
itself instead of adding a static one ? Also, can you add a flag to the 
MT_DEVICE_NS that says the mapping can only ever be in L1 and never in "lower" 
levels of the page table ?

Best regards,
Marek Vasut
