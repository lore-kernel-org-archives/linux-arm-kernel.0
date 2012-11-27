From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Tue, 27 Nov 2012 20:05:35 +0100
Subject: [PATCH] fixup! cpufreq: SPEAr: Add CPUFreq driver
In-Reply-To: <2d845c8e19392c2b82a243e6e878ae4e5e771c2f.1353785862.git.viresh.kumar@linaro.org>
References: <2d845c8e19392c2b82a243e6e878ae4e5e771c2f.1353785862.git.viresh.kumar@linaro.org>
Message-ID: <4703470.E0i3mLgjYu@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 27, 2012 06:01:39 PM Viresh Kumar wrote:
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Hi Rafael,
> 
> To make review easier and faster, i am sending incremental patch for SPEAr
> cpufreq driver. This patch was earlier discussed here:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-November/135088.html

Applied.

Thanks,
Rafael


>  .../devicetree/bindings/cpufreq/cpufreq-spear.txt  | 33 +++++++++++++++-------
>  drivers/cpufreq/spear-cpufreq.c                    |  4 +--
>  2 files changed, 25 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-spear.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-spear.txt
> index 4cf2819..f3d44984 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-spear.txt
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-spear.txt
> @@ -6,7 +6,6 @@ It supports both uniprocessor (UP) and symmetric multiprocessor (SMP) systems
>  which share clock across all CPUs.
>  
>  Required properties:
> -- compatible: "st,cpufreq-spear"
>  - cpufreq_tbl: Table of frequencies CPU could be transitioned into, in the
>    increasing order.
>  
> @@ -14,16 +13,30 @@ Optional properties:
>  - clock-latency: Specify the possible maximum transition latency for clock, in
>    unit of nanoseconds.
>  
> +Both required and optional properties listed above must be defined under node
> +/cpus/cpu at 0.
> +
>  Examples:
>  --------
> +cpus {
> +
> +	<...>
> +
> +	cpu at 0 {
> +		compatible = "arm,cortex-a9";
> +		reg = <0>;
> +
> +		<...>
> +
> +		cpufreq_tbl = < 166000
> +				200000
> +				250000
> +				300000
> +				400000
> +				500000
> +				600000 >;
> +	};
> +
> +	<...>
>  
> -cpufreq {
> -	compatible = "st,cpufreq-spear";
> -	cpufreq_tbl = < 166000
> -			200000
> -			250000
> -			300000
> -			400000
> -			500000
> -			600000 >;
>  };
> diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
> index a7fe880..4575cfe 100644
> --- a/drivers/cpufreq/spear-cpufreq.c
> +++ b/drivers/cpufreq/spear-cpufreq.c
> @@ -224,9 +224,9 @@ static int spear_cpufreq_driver_init(void)
>  	const __be32 *val;
>  	int cnt, i, ret;
>  
> -	np = of_find_compatible_node(NULL, NULL, "st,cpufreq-spear");
> +	np = of_find_node_by_path("/cpus/cpu at 0");
>  	if (!np) {
> -		pr_err("No cpufreq node found");
> +		pr_err("No cpu node found");
>  		return -ENODEV;
>  	}
>  
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
