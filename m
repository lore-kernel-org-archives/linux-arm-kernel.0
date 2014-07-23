From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Wed, 23 Jul 2014 12:34:16 -0400
Subject: [PATCH v6 2/7] drivers: cpuidle: implement DT based idle states
 infrastructure
In-Reply-To: <1405958786-17243-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1405958786-17243-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1405958786-17243-3-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <CAJ5Y-eY9YACzk_8LpZ9mnaj4stqOF_uWWt1+tL7nexqZj-ZFyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On 21 July 2014 12:06, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> +/**
> + * dt_init_idle_driver() - Parse the DT idle states and initialize the
> + *                        idle driver states array
> + *
> + * @drv:         Pointer to CPU idle driver to be initialized
> + * @start_idx:    First idle state index to be initialized
> + *
> + * On success the states array in the cpuidle driver contains
> + * initialized entries in the states array, starting from index start_idx.
> + *
> + * Return:
> + *     0 on success
> + *     <0 on failure
> + */
> +int dt_init_idle_driver(struct cpuidle_driver *drv, unsigned int start_idx)
> +{
> +       unsigned int i, state_idx = start_idx;
> +       struct cpuidle_state *idle_state;
> +       struct device_node *state_node, *cpu_node;
> +
> +
> +       if (state_idx >= CPUIDLE_STATE_MAX)
> +               return -EINVAL;
> +       /*
> +        * We get the idle states for the first logical cpu in the
> +        * driver mask. The kernel does not check idle states on all
> +        * cpus in the driver mask, they are assumed to be the same
> +        * by default.
> +        */
> +       cpu_node = of_cpu_device_node_get(cpumask_first(drv->cpumask));

Is this an assumption for the short term? My understanding from the
corresponding ACPI discussions is that the order of idle states may
not necessarily be same for all CPUs, even for big.Little?

Cheers,
Ashwin
