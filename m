From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 17 Aug 2015 17:45:31 -0500
Subject: [PATCH 3/3] [v2] hvc_dcc: disable user-space access to DCC
In-Reply-To: <20150810094755.GE1604@arm.com>
References: <1438992995-22610-1-git-send-email-timur@codeaurora.org>
 <1438992995-22610-3-git-send-email-timur@codeaurora.org>
 <20150810094755.GE1604@arm.com>
Message-ID: <55D2640B.5090709@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2015 04:47 AM, Will Deacon wrote:
>> +static inline void __dcc_initialize(void)
>> +{
>> +	u32 val;
>> +
>> +	/* Disable user-space access to DCC */
>> +	asm volatile ("mrs %0, mdscr_el1\n"
>> +		"	orr %0, %0, #4096\n" /* Set the TDCC bit */
>
> So this is the same as your "1 << 12" for arch/arm/. Shouldn't we
> #define that someplace common?

Well, I'm not sure.  First, there is no common place currently 
available.  I would need to create a new header file that only has one 
line in it.

Secondly, DBGDSCR in ARMv7 and MDSCR_EL1 on ARMv8 don't have that much 
in common.  Those two registers probably serve the same function, but 
only a few bits are the same.

I've documented the code.  I can clean it up so that it looks like the same.

>> +	__dcc_initialize();
>> +
>>   	/* Returns -1 if error */
>>   	ret = hvc_instantiate(0, 0, &hvc_dcc_get_put_ops);
>
> Can this driver be built as a module and unloaded? If so, should we
> re-enable userspace access when the kernel doesn't need it anymore?

Not according to the Kconfig:

config HVC_DCC
        bool "ARM JTAG DCC console"

> Finally, have you checked the behaviour on CPU hotplug? It looks like we
> zero mdscr_el1 in the cold boot path. The alternative is to set this bit
> there and never allow userspace access. Do you know of any compelling
> use-cases where userspace accesses the DCC directly?

Maybe KVM?

I have to admit, this is starting to get a little out of my league.  All 
I really wanted to do was make DCC available on ARM64, the same exact 
way it's available on ARM32.  I don't want to have to solve every DCC 
problem that exists today on every ARM platform.  I would rather drop 
this patch than have to spend an inordinate amount of time making it 
perfect.

We've never disabled user-space DCC support on any ARM platform before. 
  If there is a problem with user-space DCC, I've never seen it, and I 
don't know anyone who has.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
