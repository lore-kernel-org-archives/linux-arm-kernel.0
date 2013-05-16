From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 16 May 2013 12:24:23 -0600
Subject: [PATCH 3/6] ARM: tegra: make tegra_resume can work for Tegra114
In-Reply-To: <1368700533.7403.47.camel@jlo-ubuntu-64.nvidia.com>
References: <1368613644-11863-1-git-send-email-josephl@nvidia.com>
 <1368613644-11863-4-git-send-email-josephl@nvidia.com>
 <519412E9.2080905@wwwdotorg.org>
 <1368700533.7403.47.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <51952457.4050108@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2013 04:35 AM, Joseph Lo wrote:
> On Thu, 2013-05-16 at 06:57 +0800, Stephen Warren wrote:
>> On 05/15/2013 04:27 AM, Joseph Lo wrote:

>>> diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S

>>> +	cpu_to_csr_req r1, r0
>>
>> Where is cpu_to_csr_req defined? grep can't find it in next-20130513,
>> and I don't see it added in this series.
>
> The cpu_to_csr_reg macro was defined in "sleep.h".

So it is. I fail at grep.

> I was used to
> translate the bit offset of CPU number in CSR register. The code here
> was used for CPU0 on Tegra30 only before.
...
>> This presumably changes behaviour on Tegra30; will this cause problems?

Ah, OK.

>>> +	mov32	r2, TEGRA_FLOW_CTRL_BASE
>>> +	ldr	r1, [r2, r1]
>>>  	/* Clear event & intr flag */
>>>  	orr	r1, r1, \
>>>  		#FLOW_CTRL_CSR_INTR_FLAG | FLOW_CTRL_CSR_EVENT_FLAG
>>> -	movw	r0, #0x0FFD	@ enable, cluster_switch, immed, & bitmaps
>>> +	movw	r0, #0x3FFD	@ enable, cluster_switch, immed, & bitmaps
>>
>> What does this change do; does the commend need updating to describe the
>> new bits that are set?
>
> It clear the some extensions for CPU power control on Tegra114.

OK; I was implying that perhaps the comment needs updating?
