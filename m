From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 10 Mar 2017 14:29:53 +0000
Subject: [v3 3/5] coresight: add support for debug module
In-Reply-To: <20170309175915.GA964@leoy-linaro>
References: <1488520809-31670-4-git-send-email-leo.yan@linaro.org>
 <011fdac0-59bf-b539-2de3-0b59a41bc922@arm.com>
 <20170309175915.GA964@leoy-linaro>
Message-ID: <3f27efee-3b63-81fd-eb96-73fd7e6f5e92@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/03/17 17:59, Leo Yan wrote:
> Hi Suziku,
  
>> The problem is, it is not guaranteed that the EDPCSR_Hi, EDCIDSR & EDVIDSR are
>> updated as a side effect of a memory mapped access (which is what we do here) to the
>> EDPCSR_Lo.
>>
>> Section H.7.1.2 : Reads of EDPCSRs (in ARM DDI 0487A.k) :
>>
>> "The indirect writes to EDCIDSR, EDVIDSR, and EDPCSRhi might not occur for a memory-mapped access
>> to the external debug interface. For more information, see Memory-mapped accesses to the external debug
>> interface on page H8-4968."
>>
>> So we cannot really rely on the values in EDVIDSR which we use to make further decisions. So I
>> am wondering if this is really guranteed to be useful.
>
> So this is caused by Software lock is locked?
>
> Section H8.4.1:
>
> "Reads and writes have no side-effects. A side-effect is where a
> direct read or a direct write of a register creates
> an indirect write of the same or another register. When the Software
> Lock is locked, the indirect write does
> not occur."

Yes, thats correct, further :

Section H9.2.32: EDPCSR

"For a read of EDPCSRlo from the memory-mapped interface, if EDLSR.SLK == 1, meaning
the Software Lock is locked, then the access has no side-effects. That is, EDCIDSR,
EDVIDSR, and EDPCSRhi are unchanged."

And since we do a CS_UNLOCK, that should be fine. Please ignore my comment.

>>> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
>>> index 130cb21..3ed651e 100644
>>> --- a/drivers/hwtracing/coresight/Kconfig
>>> +++ b/drivers/hwtracing/coresight/Kconfig
>>> @@ -89,4 +89,14 @@ config CORESIGHT_STM
>>> 	  logging useful software events or data coming from various entities
>>> 	  in the system, possibly running different OSs
>>>
>>> +config CORESIGHT_DEBUG
>>
>> To make it more specific, may be CORESIGHT_CPU_DEBUG ?
>
> Will fix.
>
>>> +	bool "CoreSight debug driver"
>>
>> "Coresight CPU Debug driver"
>
> Will fix.
>
>>> +	depends on ARM || ARM64
>>> +	help
>>> +	  This driver provides support for coresight debugging module. This
>>> +	  is primarily used to dump sample-based profiling registers for
>>> +	  panic. To avoid lockups when accessing debug module registers,
>>> +	  it is safer to disable CPU low power states (like "nohlt" on the
>>> +	  kernel command line) when using this feature.
>>> +
>>
>>> +#define EDPCSR_THUMB			BIT(0)
>>> +#define EDPCSR_ARM_INST_MASK		GENMASK(31, 2)
>>> +#define EDPCSR_THUMB_INST_MASK		GENMASK(31, 1)
>>
>> We don't need two different masks. {ED/DBG}PCSR has only bit 0 reserved
>> for instruction set indication.
>
> I think we need this two different masks. Please review below extra doc
> for PC offset analysis in ARM ARM.

You're correct. Thanks for the pointer. I got confused, as there was no bit
dedicated in the DBGPCSR bit assignment figure.

>>> +	/*
>>> +	 * Handle arm instruction offset, if the arm instruction
>>> +	 * is not 4 byte alignment then it's possible the case
>>> +	 * for implementation defined; keep original value for this
>>> +	 * case and print info for notice.
>>> +	 */
>>> +	if (pc & BIT(1))
>>> +		pr_emerg("Instruction offset is implementation defined\n");
>>
>> I am struggling to find the any mention about this in the ARM ARM. Please could
>> you point me to it.
>
> Sure, please see ARM DDI 0406C.b, chapter C11.11.34 "
> DBGPCSR, Program Counter Sampling Register":
>
> A profiling tool can use the value of the T bit to calculate the
> instruction address as follows:
>
> When an offset is applied to the sampled address
> - if T is 0 and DBGPCSR[1] is 0, ((DBGPCSR[31:2] << 2) - 8) is the
> address of the sampled ARM instruction
> - if T is 0 and DBGPCSR[1] is 1, the instruction address is
> IMPLEMENTATION DEFINED
> - if T is 1, ((DBGPCSR[31:1] << 1) - 4) is the address of the sampled
> Thumb or ThumbEE instruction.
>
> When no offset is applied to the sampled address
> -  if T is 0 and DBGPCSR[1] is 0, (DBGPCSR[31:2] << 2) is the address
> of the sampled ARM instruction
> -  if T is 0 and DBGPCSR[1] is 1, the instruction address is
> IMPLEMENTATION DEFINED
> - if T is 1, (DBGPCSR[31:1] << 1) is the address of the sampled Thumb
> or ThumbEE instruction.
>

Ok.


>>> +
>>> +	put_online_cpus();
>>> +
>>> +	if (!debug_count++)
>>> +		atomic_notifier_chain_register(&panic_notifier_list,
>>> +					       &debug_notifier);
>>> +
>>
>>> +	sprintf(buf, (char *)id->data, drvdata->cpu);
>>> +	dev_info(dev, "%s initialized\n", buf);
>>
>> This could simply be :
>> 	dev_info(dev, "Coresight debug-CPU%d initialized\n", drvdata->cpu);
>>
>> and get rid of the static string and the buffer, see below.

Also we need pm_runtime_put() here to balance the pm_runtime_get_ from AMBA
device probe. More on that below.

>>
>>> +	return 0;
>>> +}
>>> +
>>> +static struct amba_id debug_ids[] = {
>>> +	{       /* Debug for Cortex-A53 */
>>> +		.id	= 0x000bbd03,
>>> +		.mask	= 0x000fffff,
>>
>> ...
>>
>>> +		.data   = "Coresight debug-CPU%d",
>>
>> I think this is pointless, as the debug area we are interested in is always associated
>> with a CPU, we could as well figure out what to print from the drvdata->cpu above.
>
> I prefer to follow your suggestion for upper two comments; but I'd like
> check with Mathieu, due I followed up Mathieu's suggestion to write
> current code.

Btw, I don't see any PM calls to make sure the power domain (at least the debug domain)
is up, which could cause problems with accesses to some of these registers (leave alone the
ones in CPU power domain), especially the EDPRSR. We could also do pm_runtime_get on the
CPU's power domain, if the CPU is online, before we access the pcsr.

Suzuki
