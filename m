From: julien.grall@arm.com (Julien Grall)
Date: Fri, 8 Jul 2016 10:35:55 +0100
Subject: [PATCH v2] xen/arm: register clocks used by the hypervisor
In-Reply-To: <20733b68-9529-bdb9-2a7d-576c8193f15c@de.bosch.com>
References: <1467282752-14053-1-git-send-email-dirk.behme@de.bosch.com>
 <146776885213.35356.11565744417822933094@resonance>
 <20733b68-9529-bdb9-2a7d-576c8193f15c@de.bosch.com>
Message-ID: <577F73FB.1070302@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/07/16 07:48, Dirk Behme wrote:
>>>  #include <linux/cpuidle.h>
>>>  #include <linux/cpufreq.h>
>>>  #include <linux/cpu.h>
>>> @@ -444,6 +445,52 @@ static int __init xen_pm_init(void)
>>>  }
>>>  late_initcall(xen_pm_init);
>>>
>>> +/*
>>> + * Check if we want to register some clocks, that they
>>> + * are not freed because unused by clk_disable_unused().
>>> + * E.g. the serial console clock.
>>> + */
>>> +static int __init xen_arm_register_clks(void)
>>> +{
>>> +       struct clk *clk;
>>> +       struct device_node *xen_node;
>>> +       unsigned int i, count;
>>> +       int ret = 0;
>>> +
>>> +       xen_node = of_find_compatible_node(NULL, NULL, "xen,xen");
>>> +       if (!xen_node) {
>>> +               pr_err("Xen support was detected before, but it has
>>> disappeared\n");
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       count = of_clk_get_parent_count(xen_node);
>>> +       if (!count)
>>> +               goto out;
>>> +
>>> +       for (i = 0; i < count; i++) {
>>> +               clk = of_clk_get(xen_node, i);
>>
>> Is there a struct device we can use here?
>
>
> It doesn't look so. Julien?

We don't have a struct device. Maybe we can create a dummy one if it 
simplifies the logic?

-- 
Julien Grall
