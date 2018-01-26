From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 26 Jan 2018 16:33:52 +0000
Subject: [PATCH v3 4/6] arm: Add icache invalidation on switch_mm for
 Cortex-A15
In-Reply-To: <d3252795-ae63-693a-4e63-4a1df074d342@gmail.com>
References: <20180125152139.32431-1-marc.zyngier@arm.com>
 <20180125152139.32431-5-marc.zyngier@arm.com> <20180126091425.GU21802@cbox>
 <38746bda-6773-41e7-3b2f-7f9476ef9fb2@arm.com>
 <d3252795-ae63-693a-4e63-4a1df074d342@gmail.com>
Message-ID: <24fd2382-435b-1823-2512-4091d571a755@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/01/18 16:20, Florian Fainelli wrote:
> 
> 
> On 01/26/2018 01:30 AM, Marc Zyngier wrote:
>> On 26/01/18 09:14, Christoffer Dall wrote:
>>> On Thu, Jan 25, 2018 at 03:21:37PM +0000, Marc Zyngier wrote:
>>>> In order to avoid aliasing attacks against the branch predictor,
>>>> Cortex-A15 require to invalidate the BTB when switching
>>>> from one user context to another. The only way to do so on this
>>>> CPU is to perform an ICIALLU, having set ACTLR[0] to 1 from secure
>>>> mode.
>>>>
>>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>>> ---
>>>>  arch/arm/mm/proc-v7-2level.S | 10 ++++++++++
>>>>  arch/arm/mm/proc-v7-3level.S | 16 ++++++++++++++++
>>>>  arch/arm/mm/proc-v7.S        | 18 +++++++++++++++++-
>>>>  3 files changed, 43 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm/mm/proc-v7-2level.S b/arch/arm/mm/proc-v7-2level.S
>>>> index 0422e58b74e8..7dc9e1c69039 100644
>>>> --- a/arch/arm/mm/proc-v7-2level.S
>>>> +++ b/arch/arm/mm/proc-v7-2level.S
>>>> @@ -40,7 +40,17 @@
>>>>   *	Note that we always need to flush BTAC/BTB if IBE is set
>>>>   *	even on Cortex-A8 revisions not affected by 430973.
>>>>   *	If IBE is not set, the flush BTAC/BTB won't do anything.
>>>> + *
>>>> + *	Cortex-A15 requires ACTLR[0] to be set from secure in order
>>>> + *	for the icache invalidation to also invalidate the BTB.
>>>>   */
>>>
>>> Seems like we can read (but not write) this bit from non-secure.  Should
>>> we test if it's set somewhere during boot and warn the user if not?
>>
>> That would have to be something that happens much later in the boot
>> process, as the proc structure is picked up very early, before we run
>> any C code.
>>
>> I could add some detection code later, but we'll be stuck with a icache
>> invalidation for nothing. Not a pretty situation.
> 
> Would it make sense to put some code in the decompressor (maybe some
> people don't use the decompressor...) similar to how we check for an
> ARMv7 CPU w/o LPAE attempting to boot a LPAE enabled kernel for instance.

Which only works if you have CONFIG_DEBUG_LL, and thus not generally
usable. Also, the LPAE test is not in the decompressor. but in the
kernel itself (head-common.S). Not that it changes anything...

Also, testing that at early boot is not that useful, as you only have
the boot CPU enabled at this point. You want to check that you have
whatever configuration is required on a per-CPU basis, which means you
have to hook this into the SMP bring-up code. And play nice with things
like big-little, in both SMP and MCPM configurations.

> This is not technically a hard failure if ACTLR[0] is not set,
> everything will still work fine, it just is not ideal from a security
> perspective.
> 
> Should we have a Kconfig option, similar to what Nishanth proposed for
> u-boot, with which we could guard an optional check against ACTLR[0]
> being set?

Sure, why not... If you have something in mind, I can review it.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
