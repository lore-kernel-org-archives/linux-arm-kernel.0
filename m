From: elder@linaro.org (Alex Elder)
Date: Fri, 04 Apr 2014 14:30:15 -0500
Subject: [PATCH 2/5] ARM: add SMP support for Broadcom mobile SoCs
In-Reply-To: <533EF21C.6000909@codeaurora.org>
References: <1396577891-2713-1-git-send-email-elder@linaro.org>
 <1396577891-2713-3-git-send-email-elder@linaro.org>
 <533EF21C.6000909@codeaurora.org>
Message-ID: <533F0847.6050909@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/2014 12:55 PM, Stephen Boyd wrote:
> On 04/03/14 19:18, Alex Elder wrote:
>> +
>> +/*
>> + * Secondary startup method setup routine to extract the location of
>> + * the secondary boot register from a "cpu" or "cpus" device tree
>> + * node.  Only the first seen secondary boot register value is used;
>> + * any others are ignored.  The secondary boot register value must be
>> + * non-zero.
>> + *
>> + * Returns 0 if successful or an error code otherwise.
>> + */
>> +static int __init of_enable_method_setup(struct device_node *node)
>> +{
>> +	int ret;
>> +
>> +	/* Ignore all but the first one specified */
>> +	if (secondary_boot)
>> +		return 0;
>> +
>> +	ret = of_property_read_u32(node, OF_SECONDARY_BOOT, &secondary_boot);
>> +	if (ret)
>> +		pr_err("%s: missing/invalid " OF_SECONDARY_BOOT " property\n",
>> +			node->name);
>> +
>> +	return ret;
>> +}
> 
> I don't understand why we need this. Why can't we get the secondary boot
> address from the /cpus node in the smp_prepare_cpus op. It isn't that
> hard to get access to the cpus node there via of_find_node_by_path().
> Then we don't need patch 1 at all. If it turns out to be common stuff,
> we can always have the common function live in arm common code or maybe
> even be a devicetree API.

You're right, that is one of several ways this could have
also been done.

Part of my thinking about this was affected by seeing how
arm_dt_init_cpu_maps() works.  (Well, at least how it's
structured.)  It looks for an enable method in each "cpu"
node, then falls back to looking for one in the "cpus" node
if none was seen.  It doesn't assume the extra properties
are in the "cpus" node (or a "cpu" node for that matter).
It directly supplies a node that's known to have a matching
"enable-method" property--at the time that match is found--to
make it possible to extract other relevant information from
that matching node.

(As an aside, the documentation doesn't mention that "cpus"
nodes will contain "enable-method" properties, even though
it seems that's more a function of "cpus" than each individual
"cpu".)

I think it offers useful flexibility to do it this way,
and I like that it is unambiguous which node should be
searched for the additional information.

					-Alex
