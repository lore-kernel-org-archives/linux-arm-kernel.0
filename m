From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 27 Jul 2017 10:48:34 -0500
Subject: [PATCH v3 2/6] of: Add helper for mapping device node to logical
 CPU number
In-Reply-To: <1501168218-26741-3-git-send-email-suzuki.poulose@arm.com>
References: <1501168218-26741-1-git-send-email-suzuki.poulose@arm.com>
 <1501168218-26741-3-git-send-email-suzuki.poulose@arm.com>
Message-ID: <CAL_JsqKTdysnhHMRKyqODm7VN4k=tkddozmUYXWv9nOmYGtzdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please use get_maintainers and cc the right people/lists.

+Frank, DT list

On Thu, Jul 27, 2017 at 10:10 AM, Suzuki K Poulose
<suzuki.poulose@arm.com> wrote:
> Add a helper to map a device node to a logical CPU number to avoid
> duplication. Currently this is open coded in different places (e.g
> gic-v3, coresight). The helper tries to map device node to a "possible"
> logical CPU id, which may not be online yet. It is the responsibility
> of the user to make sure that the CPU is online. The helper uses
> of_get_cpu_node() which uses arch specific backends to match the phyiscal
> ids.
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/of/base.c         | 26 ++++++++++++++++++++++++++
>  include/linux/of_device.h |  7 +++++++
>  2 files changed, 33 insertions(+)
>
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 686628d..0b01515 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -420,6 +420,32 @@ struct device_node *of_get_cpu_node(int cpu, unsigned int *thread)
>  EXPORT_SYMBOL(of_get_cpu_node);
>
>  /**
> + * of_device_node_get_cpu: Get the logical CPU number for a given device_node
> + *
> + * @cpu_node: Pointer to the device_node for CPU.
> + *
> + * Returns the logical CPU number of the given CPU device_node.
> + * Returns >= nr_cpu_ids if CPU is not found.

Wouldn't negative be easier to test for? Then the caller doesn't need
to know nr_cpu_ids.

> + */
> +int of_device_node_get_cpu(struct device_node *cpu_node)

of_device_* is for functions operating on struct device. So find
another name. of_cpu_node_to_id perhaps.

_get functions generally imply incrementing ref counts which you are
not doing here.

> +{
> +       int cpu;
> +       bool found = false;
> +       struct device_node *np;
> +
> +       for_each_possible_cpu(cpu) {
> +               np = of_get_cpu_node(cpu, NULL);
> +               found = (cpu_node == np);
> +               of_node_put(np);
> +               if (found)
> +                       break;
> +       }
> +
> +       return cpu;
> +}
> +EXPORT_SYMBOL(of_device_node_get_cpu);
> +
> +/**
>   * __of_device_is_compatible() - Check if the node matches given constraints
>   * @device: pointer to node
>   * @compat: required compatible string, NULL or "" for any match
> diff --git a/include/linux/of_device.h b/include/linux/of_device.h
> index b4ad8b4..00a4ba9 100644
> --- a/include/linux/of_device.h
> +++ b/include/linux/of_device.h
> @@ -40,6 +40,8 @@ extern int of_device_request_module(struct device *dev);
>  extern void of_device_uevent(struct device *dev, struct kobj_uevent_env *env);
>  extern int of_device_uevent_modalias(struct device *dev, struct kobj_uevent_env *env);
>
> +extern int of_device_node_get_cpu(struct device_node *np);
> +

Wrong place for this.

>  static inline void of_device_node_put(struct device *dev)
>  {
>         of_node_put(dev->of_node);
> @@ -110,6 +112,11 @@ static inline int of_dma_configure(struct device *dev, struct device_node *np)
>  }
>  static inline void of_dma_deconfigure(struct device *dev)
>  {}
> +
> +static inline int of_device_node_get_cpu(struct device_node *np)
> +{
> +       return nr_cpu_ids;
> +}
>  #endif /* CONFIG_OF */
>
>  #endif /* _LINUX_OF_DEVICE_H */
> --
> 2.7.5
>
