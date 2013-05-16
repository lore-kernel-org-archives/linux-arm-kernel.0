From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 16 May 2013 12:26:49 -0600
Subject: [PATCH 6/6] ARM: tegra114: add CPU hotplug support
In-Reply-To: <1368702862.7403.86.camel@jlo-ubuntu-64.nvidia.com>
References: <1368613644-11863-1-git-send-email-josephl@nvidia.com>
 <1368613644-11863-7-git-send-email-josephl@nvidia.com>
 <5194162D.7010007@wwwdotorg.org>
 <1368702862.7403.86.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <519524E9.8000401@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2013 05:14 AM, Joseph Lo wrote:
> On Thu, 2013-05-16 at 07:11 +0800, Stephen Warren wrote:
>> On 05/15/2013 04:27 AM, Joseph Lo wrote:
>>> The Tegra114 is a quad cores SoC. Each core can be hotplugged including
>>> CPU0. The hotplug sequence can be controlled by setting event trigger in
>>> flow controller. Then the flow controller will take care all the power
>>> sequence that include CPU up and down.

>>>  	tst	r0, #TEGRA30_POWER_HOTPLUG_SHUTDOWN
>>> +	beq	flow_ctrl_setting_for_lp2
>>> +
>>> +	/* flow controller set up for hotplug */
>>> +	mov	r3, #FLOW_CTRL_WAITEVENT		@ For hotplug
>>> +	b	flow_ctrl_done
>>> +flow_ctrl_setting_for_lp2:
>>> +	/* flow controller set up for LP2 */
>>> +	cmp	r10, #(TEGRA30 << 8)
>>>  	moveq   r3, #FLOW_CTRL_WAIT_FOR_INTERRUPT	@ For LP2
>>
>> Do you need e.g. "movne r3, #0" or similar here? Otherwise, I think r3
>> ends up not being initialized.
> 
> Yes, I will add the code when I add LP2 support for Tegra114 later.
> Currently the LP2 code flow only for Tegra30, so it's OK.

Ah, I see. Can we add the extra move to make sure the register is always
initialized now even though the path won't be used. That way, nobody
will be confused by this.

>>> -	movne	r3, #FLOW_CTRL_WAITEVENT		@ For hotplug
>>> +flow_ctrl_done:
>>> +	cmp	r10, #(TEGRA30 << 8)
>>>  	str	r3, [r2]
>>
>> I wonder whether creating a separate tegra114_cpu_shutdown() wouldn't be
>> better, to avoid all the runtime conditional code.
> 
> I personally think the conditional code is OK. And the ARM CPU also had
> hardware for branch detection also.
> 
> I had finished some further features for both Tegra30 and Tegra114. And
> most of the code here can be shared each other at least until now I
> could see. Once I see if there is a significant difference, then I would
> prepare maintain the code separately too.

OK, if the function gets larger with more shared, I guess it's fine.
Right now, the conditional-to-non-conditional code ratio is pretty high.
