From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 11 Nov 2011 16:28:52 +0000
Subject: [REPOST PATCH] ARM: gic: allow GIC to support non-banked setups
In-Reply-To: <4EBD4476.7030200@gmail.com>
References: <1320421221-28711-1-git-send-email-marc.zyngier@arm.com>
 <4EBD4476.7030200@gmail.com>
Message-ID: <4EBD4D44.2010408@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/11 15:51, Rob Herring wrote:
> On 11/04/2011 10:40 AM, Marc Zyngier wrote:
>> The GIC support code is heavily using the fact that hardware
>> implementations are exposing banked registers. Unfortunately, it
>> looks like at least one GIC implementation (EXYNOS4) offers both
>> the distributor and the CPU interfaces at different addresses,
>> depending on the CPU.
>>
>> This problem is solved by turning the distributor and CPU interface
>> addresses into per-cpu variables. The EXYNOS4 code is updated not
>> to mess with the GIC internals while handling interrupts, and
>> struct gic_chip_data is back to being private.
>>
>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>> I'm reposting this in order to generate some comments on the
>> approach. An alternative has been suggested by Will Deacon,
>> by adding platform specific callbacks returning the base addresses.
>> Both solutions have a runtime impact on "normal" platforms.
>>
> This doesn't really work well for DT as you are adding a place where the
> platform needs to know the register addresses. Perhaps extending the gic
> reg field to an array of cpu and dist addresses. This could all be setup
> by gic_of_init on cpu 0.

Agreed, this isn't very nice. Another possibility would be to encode the
per-cpu offset and provide the GIC with one single massive range, but
this looks very Samsung specific, again.

> It would be nice if everyone else wasn't punished with percpu data
> lookups for the base addresses for 1 weird platform...

That's exactly my problem at the moment. One broken platform is
impacting *all* the others, and I wonder if we wouldn't be better off
with a separate driver altogether...

Thanks for having a look.

	M.
-- 
Jazz is not dead. It just smells funny...
