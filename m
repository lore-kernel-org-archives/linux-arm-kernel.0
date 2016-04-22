From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 22 Apr 2016 15:59:21 +0100
Subject: [PATCH] drivers: firmware: psci: unify enable-method binding on
 ARM {64,32}-bit systems
In-Reply-To: <1461335911-13233-1-git-send-email-sudeep.holla@arm.com>
References: <1461335911-13233-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <20160422145921.GA14353@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2016 at 03:38:31PM +0100, Sudeep Holla wrote:
> Currently ARM CPUs DT bindings allows different enable-method value for
> PSCI based systems. On ARM 64-bit this property is required and must be
> "psci" while on ARM 32-bit systems this property is optional and must
> be "arm,psci".
> 
> This is problematic if 32-bit OS is run on 64-bit system which has
> "psci" as enable-method rather than the expected "arm,psci".
> 
> So let's unify the value into "psci" and remove support for "arm,psci"
> before it finds any users.
> 
> Reported-by: Soby Mathew <Soby.Mathew@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.txt | 1 -
>  drivers/firmware/psci.c                        | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> index ccc62f145306..3f0cbbb8395f 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.txt
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -192,7 +192,6 @@ nodes to be present and contain the properties described below.
>  			  can be one of:
>  			    "allwinner,sun6i-a31"
>  			    "allwinner,sun8i-a23"
> -			    "arm,psci"
>  			    "arm,realview-smp"
>  			    "brcm,bcm-nsp-smp"
>  			    "brcm,brahma-b15"
> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> index 11bfee8b79a9..b5d05807e6ec 100644
> --- a/drivers/firmware/psci.c
> +++ b/drivers/firmware/psci.c
> @@ -360,7 +360,7 @@ static struct cpuidle_ops psci_cpuidle_ops __initdata = {
>  	.init = psci_dt_cpu_init_idle,
>  };
>  
> -CPUIDLE_METHOD_OF_DECLARE(psci, "arm,psci", &psci_cpuidle_ops);
> +CPUIDLE_METHOD_OF_DECLARE(psci, "psci", &psci_cpuidle_ops);
>  #endif
>  #endif
>  
> -- 
> 1.9.1
> 
