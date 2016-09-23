From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 23 Sep 2016 11:49:23 -0400 (EDT)
Subject: [PATCH 2/2] drivers: cci: add missing CCI port availability
 firmware check
In-Reply-To: <20160923130907.4187-2-lorenzo.pieralisi@arm.com>
References: <20160923130907.4187-1-lorenzo.pieralisi@arm.com>
 <20160923130907.4187-2-lorenzo.pieralisi@arm.com>
Message-ID: <alpine.LFD.2.20.1609231148100.9311@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 23 Sep 2016, Lorenzo Pieralisi wrote:

> The CCI ports programming interface is available to the kernel
> only when booted in secure mode (or when firmware enables
> non-secure access to override CCI ports control). In both cases,
> firmware reports the CCI ports availability through the device
> tree CCI ports nodes, which must be parsed and their status checked
> by the kernel probing path.
> 
> This check is currently missing and may cause the kernel to
> erroneously believe it is free to take control of CCI ports
> where in practice CCI ports control is forbidden.
> 
> Add the missing CCI port availability check to the CCI driver
> in order to guarantee sane CCI usage.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
>  drivers/bus/arm-cci.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> index 5755907f..3c7a1c7 100644
> --- a/drivers/bus/arm-cci.c
> +++ b/drivers/bus/arm-cci.c
> @@ -2199,6 +2199,9 @@ static int cci_probe_ports(struct device_node *np)
>  		if (!of_match_node(arm_cci_ctrl_if_matches, cp))
>  			continue;
>  
> +		if (!of_device_is_available(cp))
> +			continue;
> +
>  		i = nb_ace + nb_ace_lite;
>  
>  		if (i >= nb_cci_ports)
> @@ -2241,6 +2244,13 @@ static int cci_probe_ports(struct device_node *np)
>  		ports[i].dn = cp;
>  	}
>  
> +	/*
> +	 * If there is no CCI port that is under kernel control
> +	 * return early and report probe status.
> +	 */
> +	if (!nb_ace && !nb_ace_lite)
> +		return -ENODEV;
> +
>  	 /* initialize a stashed array of ACE ports to speed-up look-up */
>  	cci_ace_init_ports();
>  
> -- 
> 2.10.0
> 
> 
