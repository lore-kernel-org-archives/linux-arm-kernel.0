From: sebastian.capella@linaro.org (Sebastian Capella)
Date: Thu, 08 May 2014 17:48:38 -0700
Subject: [PATCH RFC v3 5/6] drivers: cpuidle: CPU idle ARM64 driver
In-Reply-To: <1399399483-17112-6-git-send-email-lorenzo.pieralisi@arm.com>
References: <1399399483-17112-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1399399483-17112-6-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <536c25e8.82e6440a.6af4.ffffa583@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Lorenzo Pieralisi (2014-05-06 11:04:42)
> diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuidle-arm64.c
> new file mode 100644
> index 0000000..fef1fad
> --- /dev/null
> +++ b/drivers/cpuidle/cpuidle-arm64.c
> @@ -0,0 +1,161 @@
...
> +/*

Is this intended to be kernel-docs?  If so, should maybe use the /** and
() after the function below.  Otherwise, should you remove the @ in the
argument list below?

> + * arm_enter_idle_state - Programs CPU to enter the specified state
> + *
> + * @dev: cpuidle device
> + * @drv: cpuidle driver
> + * @idx: state index
> + *
> + * Called from the CPUidle framework to program the device to the
> + * specified target state selected by the governor.
> + */
> +static int arm_enter_idle_state(struct cpuidle_device *dev,
> +                               struct cpuidle_driver *drv, int idx)

...

> +static int __init arm64_idle_init(void)
> +{
> +       int i, ret;
> +       const char *entry_method;
> +       struct device_node *idle_states_node;
> +       const struct cpu_suspend_ops *suspend_init;
> +       struct cpuidle_driver *drv = &arm64_idle_driver;
> +
> +       idle_states_node = of_find_node_by_path("/cpus/idle-states");
> +       if (!idle_states_node)
> +               return -ENOENT;
> +
> +       if (of_property_read_string(idle_states_node, "entry-method",
> +                                   &entry_method)) {
> +               pr_warn(" * %s missing entry-method property\n",
> +                           idle_states_node->full_name);
> +               of_node_put(idle_states_node);
> +               return -EOPNOTSUPP;
> +       }
> +
> +       suspend_init = get_suspend_ops(entry_method);
> +       if (!suspend_init) {
> +               pr_warn("Missing suspend initializer\n");
> +               of_node_put(idle_states_node);
> +               return -EOPNOTSUPP;
> +       }
> +
> +       /*
> +        * State at index 0 is standby wfi and considered standard
> +        * on all ARM platforms. If in some platforms simple wfi
> +        * can't be used as "state 0", DT bindings must be implemented
> +        * to work around this issue and allow installing a special
> +        * handler for idle state index 0.
> +        */
> +       drv->states[0].exit_latency = 1;
> +       drv->states[0].target_residency = 1;
> +       drv->states[0].flags = CPUIDLE_FLAG_TIME_VALID;
> +       strncpy(drv->states[0].name, "ARM WFI", CPUIDLE_NAME_LEN);
> +       strncpy(drv->states[0].desc, "ARM WFI", CPUIDLE_DESC_LEN);
> +
> +       drv->cpumask = (struct cpumask *) cpu_possible_mask;
> +       /*
> +        * Start at index 1, request idle state nodes to be filled
> +        */
> +       ret = of_init_idle_driver(drv, state_nodes, 1, true);
> +       if (ret)
> +               return ret;
> +
> +       if (suspend_init->init_fn(drv, state_nodes))
> +               return -EOPNOTSUPP;
> +
> +       for (i = 0; i < drv->state_count; i++)
> +               drv->states[i].enter = arm_enter_idle_state;

Is this missing an of_node_put(idle_states_node)?

Thanks!

Sebastian
