From: d-gerlach@ti.com (Dave Gerlach)
Date: Wed, 21 Sep 2016 14:34:22 -0500
Subject: [PATCH v2 2/2] cpufreq: ti: Add cpufreq driver to determine
 available OPPs at runtime
In-Reply-To: <20160908033909.GR27345@vireshk-i7>
References: <20160901025328.376-1-d-gerlach@ti.com>
 <20160901025328.376-3-d-gerlach@ti.com> <20160907052053.GO27345@vireshk-i7>
 <57D02C85.7020300@ti.com> <20160908033909.GR27345@vireshk-i7>
Message-ID: <57E2E0BE.3070206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Viresh,
On 09/07/2016 10:39 PM, Viresh Kumar wrote:
> On 07-09-16, 10:04, Dave Gerlach wrote:
>>>> +static const struct of_device_id ti_cpufreq_of_match[] = {
>>>> +	{ .compatible = "operating-points-v2-ti-am3352-cpu",
>>>> +	  .data = &am3x_soc_data, },
>>>> +	{ .compatible = "operating-points-v2-ti-am4372-cpu",
>>>> +	  .data = &am4x_soc_data, },
>>>> +	{ .compatible = "operating-points-v2-ti-dra7-cpu",
>>>> +	  .data = &dra7_soc_data },
>>>
>>> You should be using your SoC compatible strings here. OPP compatible
>>> property isn't supposed to be (mis)used for this purpose.
>>>
>>
>> Referring to my comments in patch 1, what if we end up changing the bindings
>> based on DT maintainer comments? We will have these compatible strings, and
>> at that point is it acceptable to match against them? Or is it still better
>> to match to SoC compatibles? I think it makes sense to just probe against
>> these.
>
> But even then I think these are not correct. You should have added a
> single compatible string: operating-points-v2-ti-cpu.
>
> As the properties will stay the same across machines. And then you
> need to use SoC strings here.
>

Are you opposed to moving _of_get_opp_desc_node from 
drivers/base/power/opp/opp.h to include/linux/pm_opp.h and renaming it 
appropriately?

If I move the ti properties out of the cpu node, as discussed in patch 1 
of this series, and into the operating-points-v2 table, I need a way to 
get the operating-points-v2 device node and I think it makes sense to 
reuse this as it is what the opp framework uses internally to parse the 
phandle to the opp table.

Regards,
Dave
