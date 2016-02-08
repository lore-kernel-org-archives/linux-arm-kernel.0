From: dietmar.eggemann@arm.com (Dietmar Eggemann)
Date: Mon, 8 Feb 2016 12:28:39 +0000
Subject: [PATCH v3 4/6] arm64: Enable dynamic CPU capacity initialization
In-Reply-To: <1454500799-18451-5-git-send-email-juri.lelli@arm.com>
References: <1454500799-18451-1-git-send-email-juri.lelli@arm.com>
 <1454500799-18451-5-git-send-email-juri.lelli@arm.com>
Message-ID: <56B889F7.306@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/02/16 11:59, Juri Lelli wrote:
> Define arch_wants_init_cpu_capacity() to return true; so that
> cpufreq_init_cpu_capacity() can go ahead and profile CPU capacities
> at boot time.

[...]

>  
> +bool arch_wants_init_cpu_capacity(void)
> +{
> +	return true;

Isn't this a little bit too simple? Not every ARM/ARM64 platform is a
heterogeneous one.

You could add code to compare the cpu node 'compatible' properties
(required) and only return true if they differ, which would let you
detect uarch based heterogeneity.

In case of max. frequency based heterogeneity (clusters consisting of
same cpu types but running at different max. frequency), you're at the
mercy of cpu node 'clock-frequency' properties (optional).
We might argue that for these platforms, providing cpu node
'clock-frequency' properties is necessary.
The 'struct cpu_efficiency table_efficiency[]' based approach in ARM
already faces this problem.

> +}
> +
>  static int __init get_cpu_for_node(struct device_node *node)
>  {
>  	struct device_node *cpu_node;
> 
