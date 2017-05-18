From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 18 May 2017 11:14:54 +0100
Subject: [PATCH] ARM: MCPM: ensure not to enter __hyp_soft_restart from
 loopback and cpu_power_down
In-Reply-To: <20170518093913.GM22219@n2100.armlinux.org.uk>
References: <1495099592-10439-1-git-send-email-sudeep.holla@arm.com>
 <20170518093913.GM22219@n2100.armlinux.org.uk>
Message-ID: <56c20f41-9023-600c-d4b2-7782f0caa14d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 18/05/17 10:39, Russell King - ARM Linux wrote:
> On Thu, May 18, 2017 at 10:26:32AM +0100, Sudeep Holla wrote:
>> Commit 9da5ac236de6 ("ARM: soft-reboot into same mode that we entered
>> the kernel") added support to enter the new kernel in the same processor
>> mode as the previous one when we soft-reboot from one kernel into
>> another by pass a flag to cpu_reset() so it knows what to do exactly.
>>
>> However it missed to make similar changes in MCPM code. Due to the
>> missing flag, the CPUs enter HYP mode which is not supported with MCPM.
>> MCPM works only in secure mode as it manages CCI.
>>
>> This patch aligns the cpu_reset call in MCPM with other changes in the
>> above mentioned commit.
> 
> I could say... welcome to why casts are bad!  The casts in this code
> have hidden the change of function prototype, which is why it's not been
> picked up by any of the build check systems.
> 

True

> Please change typedef to this:
> 
> typedef typeof(cpu_reset) *phys_reset_t;
>

IIUC, I need to drop * above. I will respin the patch with that change.
Thanks for the suggestion.

> so phys_reset_t at least follows the prototype of cpu_reset().
> 

-- 
Regards,
Sudeep
