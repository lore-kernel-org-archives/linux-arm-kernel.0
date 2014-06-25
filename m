From: geoff@infradead.org (Geoff Levand)
Date: Wed, 25 Jun 2014 13:34:23 -0700
Subject: [PATCH v5 5/8] drivers: cpuidle: CPU idle ARM64 driver
In-Reply-To: <1403705421-17597-6-git-send-email-lorenzo.pieralisi@arm.com>
References: <1403705421-17597-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1403705421-17597-6-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1403728463.11749.52.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On Wed, 2014-06-25 at 15:10 +0100, Lorenzo Pieralisi wrote:
> This patch implements a generic CPU idle driver for ARM64 machines.

...

> +typedef int (*suspend_init_fn)(struct cpuidle_driver *,
> +			       struct device_node *[]);
> +
> +struct cpu_suspend_ops {
> +	const char *id;
> +	suspend_init_fn init_fn;
> +};
> +
> +static const struct cpu_suspend_ops suspend_operations[] __initconst = {
> +	{"arm,psci", psci_dt_register_idle_states},
> +	{}

With this we'll have two completely independent mechanisms for
interacting with the cpu ops, this struct cpu_suspend_ops, and the
struct cpu_operations.  This doesn't seem good.

I feel we need to fix the cpu ops to include some way to operate on the
operation method to do initialization, shutdown, etc.  At present,
cpu_operations only has a mechanism to operate on the individual cpus.

-Geoff
