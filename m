From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 27 Aug 2012 19:31:19 +0200
Subject: [PATCH 3/6] arm: cache-l2x0: add support for Aurora L2 cache ctrl
In-Reply-To: <5037776A.6050605@free-electrons.com>
References: <1345799361-23735-1-git-send-email-gregory.clement@free-electrons.com>
 <1345799361-23735-4-git-send-email-gregory.clement@free-electrons.com>
 <20120824104309.GE5400@mudshark.cambridge.arm.com>
 <5037776A.6050605@free-electrons.com>
Message-ID: <503BAEE7.5080401@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24/2012 02:45 PM, Gregory CLEMENT wrote:
> On 08/24/2012 12:43 PM, Will Deacon wrote:> On Fri, Aug 24, 2012 at 10:09:18AM +0100, Gregory CLEMENT wrote:
>>> +static void __init aurora_broadcast_l2_commands(void)
>>> +{
>>> +       __u32 u;
>>> +       /* Enable Broadcasting of cache commands to L2*/
>>> +       __asm__ __volatile__("mrc p15, 1, %0, c15, c2, 0" : "=r"(u));
>>> +       u |= 0x100;             /* Set the FW bit */
>>> +       __asm__ __volatile__("mcr p15, 1, %0, c15, c2, 0\n" : : "r"(u));
>>> +}
>>
>> Couple of questions about this code:
>>
>> 1. Is this register r/w from non-secure?
> 
> This register is banked.
> 
>> 2. I'm surprised that there aren't barriers and/or maintenance operations
>>    needed around this operation. It might be worth checking in the
>>    documentation that you have (you probably need at least an isb()
>>    following the mcr).
> 
> I didn't find any mention of barriers and/or maintenance operations
> needed around this operation, but maybe I have missed something, or it
> was implicit for the people who wrote the documentation. I will ask
> confirmation that we don't need this.

I've just received confirmation that this register is  r/w from non-secure.
And that it would be good practice to have an ISB after this MCR, so I
will add this for the next version coming soon.

> 
>>
>> Will
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
