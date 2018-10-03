From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 3 Oct 2018 11:21:19 +0100
Subject: [PATCH v3 2/3] perf: add arm64 smmuv3 pmu driver
In-Reply-To: <6d51a825-325f-5f78-20da-bf27f208fe37@arm.com>
References: <20180921150803.25444-1-shameerali.kolothum.thodi@huawei.com>
 <20180921150803.25444-3-shameerali.kolothum.thodi@huawei.com>
 <ecc2877c-146c-d70f-efd7-306fe704d55f@arm.com>
 <5FC3163CFD30C246ABAA99954A238FA838793F4E@FRAEML521-MBX.china.huawei.com>
 <6d51a825-325f-5f78-20da-bf27f208fe37@arm.com>
Message-ID: <80f5ad85-c31b-a1b8-ab9c-3a559838f6f2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/10/18 10:46, Jean-Philippe Brucker wrote:
> On 03/10/2018 09:46, Shameerali Kolothum Thodi wrote:
> [...]
>>>> +	/* Verify specified event is supported on this PMU */
>>>> +	event_id = get_event(event);
>>>> +	if (((event_id < SMMU_ARCH_MAX_EVENT_ID) &&
>>>> +	    (!test_bit(event_id, smmu_pmu->supported_events))) ||
>>>> +	    (event_id > SMMU_IMPDEF_MAX_EVENT_ID)) {
>>>
>>>> = ?
>>
>> I was slightly confused by the spec here as it says,
>>
>> Performance events are indicated by a numeric ID, in the following ranges:
>> ? 0x0000 to 0x007F: Architected events
>> ? 0x0080 to 0xFFFF: IMPLEMENTATION DEFINED events
>>
>> It looks to me the ids are valid including those limits.
> 
> Yes my mistake, I mixed up IMPDEF_MAX_EVENT_ID which is inclusive with
> ARCH_MAX_EVENT_ID which isn't, sorry about that

Well, really that's a clear sign that this could be improved - having 
"max" mean both "maximum" and "maximum plus one" in the same context is 
needlessly overcomplicated.

> [...]
>>>> +		dev_err(dev, "Setup irq failed, PMU @%pa\n", &res_0->start);
>>>
>>> You can probably remove "PMU @%pa" from error and info messages, since
>>> the device name already uniquely identifies it:
>>> "[    6.168200] arm-smmu-v3-pmu 2b442000.smmu-pmcg: Registered SMMU
>>> PMU
>>> @ 0x000000002b442000 using 4 counters"
>>
>> Interesting. What I have is,
>>
>> [   25.669636] arm-smmu-v3-pmu arm-smmu-v3-pmu.6.auto: Registered SMMU
>> PMU @ 0x0000000148001000 using 8 counters
>>
>> Are you using the same patches and is booting using ACPI? IIRC, in the iort
>> code  it uses the name "arm-smmu-v3-pmu" and AUTO id to register/add the platform
>> dev. So not sure, how it is printing the address in your case.
>>
>> Please check and let me know.
> 
> Right, I've been using device tree for my tests, not ACPI. I thought it
> was the core platform code that was creating the names. I guess we could
> add nicer names to IORT but that's probably for a different series, so
> nevermind.

TBH, I can't see anyone caring much about the platform device itself, 
since it's the perf pmu device that users actually want to interact 
with. As long as the latter is easily identifiable, the name of the 
former is mostly only relevant to us sanity-checking sysfs and 
/proc/{interrupts,iomem} for development.

Robin.
