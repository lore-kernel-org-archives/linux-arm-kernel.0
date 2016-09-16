From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri, 16 Sep 2016 10:35:32 -0500
Subject: [PATCH v9 07/10] arm: arm64: pmu: Assign platform PMU CPU affinity
In-Reply-To: <20160916132953.GR3380@arm.com>
References: <1473892358-22574-1-git-send-email-jeremy.linton@arm.com>
 <1473892358-22574-8-git-send-email-jeremy.linton@arm.com>
 <20160916132953.GR3380@arm.com>
Message-ID: <8d76725a-507b-4d70-8aad-993ccfa488f6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi
	Thanks for taking a look at this..

On 09/16/2016 08:29 AM, Will Deacon wrote:
> On Wed, Sep 14, 2016 at 05:32:35PM -0500, Jeremy Linton wrote:
>> On systems with multiple PMU types the PMU to CPU affinity
>> needs to be detected and set. The CPU to interrupt affinity
>> should also be set.
>>
(trimming)
>>  			continue;
>>  		ret = info->init(pmu);
>> +		/*
>> +		 * if this pmu declaration is unspecified and we have
>> +		 * previously found a PMU on this platform then append
>> +		 * a PMU number to the pmu name. This avoids changing
>> +		 * the names of PMUs that are specific to a class of CPUs.
>> +		 * The assumption is that if we match a specific PMU in the
>> +		 * provided pmu_probe_info then it's unique, and another PMU
>> +		 * in the system will match a different entry rather than
>> +		 * needing the _number to assure its unique.
>> +		 */
>> +		if ((!info->cpuid) && (duplicate_pmus)) {
>
> Hmm, the duplicate_pmus check looks a little odd here. Doesn't it mean
> that you'd end up with things like:
>
> "arm,armv8-pmuv3"
> "arm,armv8-pmuv3_1"
>
> which looks needlessly fiddly to parse. Is this intentional?

Well, IIRC, you recommend that format, or maybe I misunderstood. Anyway, 
per the comment I'm trying to assure that legacy platform devices don't 
accidentally get a "_X" appended to their name and break something.

Further, by itself the name itself doesn't have any meaning/ordering and 
could just as well be a random string. So, I don't think anyone is going 
to try and parse it except to compare it as a whole something like 
"armv8_cortex_a53". Which is why the cpu affinity is required. 
Additionally, doing it this way allows a tiny tweak to the pmu table in 
the future to re-enable meaningful PMU names. Lastly, its big.little 
exclusive, so I would rather apply pain to non-existant big.little 
server machines, than uglify the common case.
