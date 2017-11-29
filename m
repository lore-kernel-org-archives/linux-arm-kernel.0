From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 29 Nov 2017 10:55:28 +0000
Subject: gicv3: 1 of N model implementation related
In-Reply-To: <20171129103421.niju3tkdah3tzajw@lakrids.cambridge.arm.com>
References: <e83aac509dcef816bbf279c4ba2bed1a@codeaurora.org>
 <20171129103421.niju3tkdah3tzajw@lakrids.cambridge.arm.com>
Message-ID: <394b7dd0-703c-4fc8-e33f-e85d37d33b9d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Mark,

On 29/11/17 10:34, Mark Rutland wrote:
> On Tue, Nov 28, 2017 at 04:42:47PM -0800, ckadabi at codeaurora.org wrote:
>> Hi Mark:
> 
> Hi,
> 
> I'm afraid I don't know much about GICv3 or the irq infrastrcuture in
> the kernel . Did you mean to ask Marc Zyngier (Cc'd)?
> 
> Thanks,
> Mark.
> 
>> I have some question related to gicv3 driver on 1 of N distribution model.
>> Looking at the linux kernel implementation the interrupt is always affined
>> to the first online cpu and does not use the 1 of N distribution model.
>> As per the Gic spec 1 of N model could help to achieve low latency as
>> handling the interrupts as there are more PE's participating in handling the
>> interrupt.
>>
>> Is there a reason the Linux kernel driver does not implement the 1 of N
>> model?

The 1-N model comes at the expense of interrupting all the participating
CPUs until one of them actually ACKs the interrupt (and the others only
see a spurious interrupt). This indeed reduces the latency to service
the interrupt, and kills the performance of all the CPUs. Not the
brightest thing, IMO.

It feels to me that a better option is to let an external agent spread
the interrupts on the less busy CPUs. Something like irqbalance...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
