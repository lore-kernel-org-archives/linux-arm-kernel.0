From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 10 Feb 2015 14:05:01 -0800
Subject: [PATCH v2] ARM: Don't use complete() during __cpu_die
In-Reply-To: <54DA7CEC.7020606@codeaurora.org>
References: <1423131270-24047-1-git-send-email-k.kozlowski@samsung.com>
 <20150205105035.GL8656@n2100.arm.linux.org.uk>
 <20150205142918.GA10634@linux.vnet.ibm.com>
 <20150205161100.GQ8656@n2100.arm.linux.org.uk>
 <54D95DB8.9010308@codeaurora.org> <20150210151416.GD9432@leverpostej>
 <54DA6E92.3090109@codeaurora.org> <54DA725E.6080305@codeaurora.org>
 <20150210211525.GO8656@n2100.arm.linux.org.uk>
 <54DA7CEC.7020606@codeaurora.org>
Message-ID: <54DA808D.5070300@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/15 13:49, Stephen Boyd wrote:
>>> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
>>> index fe0386c751b2..4d213b24db60 100644
>>> --- a/arch/arm/kernel/smp.c
>>> +++ b/arch/arm/kernel/smp.c
>>> @@ -174,18 +174,19 @@ static int platform_cpu_kill(unsigned int cpu)
>>>  	return 1;
>>>  }
>>>  
>>> -static int platform_cpu_disable(unsigned int cpu)
>>> +int platform_can_hotplug_cpu(unsigned int cpu)
>>>  {
>>>  	if (smp_ops.cpu_disable)
>>> -		return smp_ops.cpu_disable(cpu);
>>> +		return smp_ops.cpu_disable(cpu) ? 0 : 1;
>>>  

BTW, we also need this

        /* cpu_die must be specified to support hotplug */
        if (!smp_ops.cpu_die)
                return 0;

otherwise it seems that we can have a situation where cpu_die() does
nothing besides unexpectedly jump to secondary_start_kernel() before
generic cpu hotplug facilities expect it to.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
