From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 24 Jul 2017 17:42:14 +0100
Subject: [PATCH v2 2/6] of: Add helper for mapping device node to logical
 CPU number
In-Reply-To: <1500892161-17634-3-git-send-email-suzuki.poulose@arm.com>
References: <1500892161-17634-1-git-send-email-suzuki.poulose@arm.com>
 <1500892161-17634-3-git-send-email-suzuki.poulose@arm.com>
Message-ID: <7ec47d12-3b6b-82c0-ba15-5664b5169974@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 24/07/17 11:29, Suzuki K Poulose wrote:
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
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/of/base.c         | 26 ++++++++++++++++++++++++++
>  include/linux/of_device.h |  7 +++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 686628d..639af23 100644
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
> + */
> +int of_device_node_get_cpu(struct device_node *cpu_node)
> +{
> +	int cpu, thread;
> +	bool found = false;
> +	struct device_node *np;
> +
> +	for_each_possible_cpu(cpu) {
> +		np = of_get_cpu_node(cpu, &thread);

Ideally, we should be able to use of_cpu_device_node_get instead of
of_get_cpu_node which parses the device tree. Not sure if that's the
case here too.

Sorry for following up on this so late. I had a patch in my tree
for-a-while to address that. Just posted it[1] now seeing this patch now.

You can move to of_cpu_device_node_get if all users of this function are
called after CPU's are registered. Otherwise, you can keep it as is for
now and it can be changed once [1] lands.

-- 
Regards,
Sudeep

[1] https://marc.info/?l=devicetree&m=150090452130567&w=2
