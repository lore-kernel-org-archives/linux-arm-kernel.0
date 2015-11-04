From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 4 Nov 2015 18:17:36 +0000
Subject: [PATCHv2 1/4] arm-cci: Refactor CCI PMU code
In-Reply-To: <20151104180139.GF23860@leverpostej>
References: <1445346326-30820-1-git-send-email-suzuki.poulose@arm.com>
 <1445346326-30820-2-git-send-email-suzuki.poulose@arm.com>
 <20151104180139.GF23860@leverpostej>
Message-ID: <563A4BC0.60009@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/15 18:01, Mark Rutland wrote:
> On Tue, Oct 20, 2015 at 02:05:23PM +0100, Suzuki K. Poulose wrote:
>> This patch refactors the CCI PMU driver code a little bit to
>> make it easier share the code for enabling/disabling the CCI
>> PMU. This will be used by the hooks to work around the special cases
>> where writing to a counter is not always that easy(e.g, CCI-500)
>>


>> +static void cci_pmu_disable(struct pmu *pmu)
>> +{
>> +	struct cci_pmu *cci_pmu = to_cci_pmu(pmu);
>> +	struct cci_pmu_hw_events *hw_events = &cci_pmu->hw_events;
>> +	unsigned long flags;
>> +
>> +	raw_spin_lock_irqsave(&hw_events->pmu_lock, flags);
>> +	__cci_pmu_disable();
>> +	raw_spin_unlock_irqrestore(&hw_events->pmu_lock, flags);
>> +}
>
> Why are these moved up here? It makes the diff harder to read, and it
> doesn't seem necessary in the context of this patch.
>
> Would they otherwise have to move in a later patch? It might be better
> to move them when required (without changes).

These will be used later in cci500 specific routines to write the counter.
I can move them later.


>> -	if (unlikely(!pmu_is_valid_counter(cci_pmu, idx)))
>> +	if (unlikely(!pmu_is_valid_counter(cci_pmu, idx))) {
>>   		dev_err(&cci_pmu->plat_device->dev, "Invalid CCI PMU counter %d\n", idx);
>> -	else
>> -		pmu_write_register(cci_pmu, value, idx, CCI_PMU_CNTR);
>> +		return;
>> +	}
>> +	__pmu_write_counter(cci_pmu, idx, value);
>>   }
>
> While I don't disagree with the new structure of this function, the
> reorganisation wasn't necessary. We only need to substitute
> __pmu_write_counter in place of pmu_write_register.

We will add a check in Patch4/4 to override the default method with a
CCI_PMU model specific method.

>
> I'm happy with splitting out the lower level accessors, but I think the
> additional reshuffling makes this patch overly complex. I'd prefer the
> minial facotring out if possible.

Ok, I will rearrange the patches to make the changes readable.

Thanks
Suzuki
