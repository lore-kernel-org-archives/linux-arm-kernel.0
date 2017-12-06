From: john.garry@huawei.com (John Garry)
Date: Wed, 6 Dec 2017 17:35:11 +0000
Subject: [RFC PATCH 0/5] perf events patches for improved ARM64 support
In-Reply-To: <12034446-ccc9-9a88-6b2c-3318216f4817@redhat.com>
References: <1512490399-94107-1-git-send-email-john.garry@huawei.com>
 <12034446-ccc9-9a88-6b2c-3318216f4817@redhat.com>
Message-ID: <827ed425-0d82-1fd8-b66a-962fa994e054@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2017 16:42, William Cohen wrote:
> On 12/05/2017 11:13 AM, John Garry wrote:
>> This patchset adds support for some perf events features,
>> targeted at ARM64, implemented in a generic fashion.
>>
>> The two main features are as follows:
>> - support for arch/vendor/platform pmu events directory structure
>> - support for parsing architecture recommended pmu events
>>
>> On the back of these, the Cavium ThunderX2 and HiSilicon hip08
>> JSONs are relocated/added.
>>
>> TODO:
>> 	- Documentation needs to be updated for recommended
>> 	events format in the JSON
>> 	- tidy up patches a bit
>>
>> John Garry (5):
>>   perf jevents: add support for pmu events vendor subdirectory
>>   perf jevents: add support for arch recommended events
>>   perf vendor events arm64: add armv8 recommended events JSON
>>   perf vendor events arm64: relocate thunderx2 JSON
>>   perf vendor events arm64: add HiSilicon hip08 JSON
>>
>>  .../pmu-events/arch/arm64/armv8-recommended.json   | 452 +++++++++++++++++++++
>>  .../arch/arm64/cavium/thunderx2-imp-def.json       |  62 ---
>>  .../arch/arm64/cavium/thunderx2/core-imp-def.json  |  32 ++
>>  .../arch/arm64/hisilicon/hip08/core-imp-def.json   | 122 ++++++
>>  tools/perf/pmu-events/arch/arm64/mapfile.csv       |   3 +-
>>  tools/perf/pmu-events/jevents.c                    | 272 ++++++++++++-
>>  6 files changed, 859 insertions(+), 84 deletions(-)
>>  create mode 100644 tools/perf/pmu-events/arch/arm64/armv8-recommended.json
>>  delete mode 100644 tools/perf/pmu-events/arch/arm64/cavium/thunderx2-imp-def.json
>>  create mode 100644 tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
>>  create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json
>>
>
>
> Hi,
>
> How is this code dealing with the possible different configurations within the aach64 architecture?  For example the Cortex-A53 implementations may exclude the L2 cache and not have L2 cache events implemented?  Is there some way that perf could make use of the PMCEID0 and PMCEID1 register information to accurately get the subset of events the processor supports?  Using this information could eliminate a lot of busy work adding implementation specific descriptions due to slight implementation differences.
>

Hi Will,

Thanks for the input.

So today the PMCEID registers are used in the kernel to detect whether 
common architectural/microarchitectual events are implemented.

Here, in this patchset (specifically 2/5 onwards), we are trying to deal 
with the Recommended (IMPLEMENTATION DEFINED) 
architectural/microarchitectual events.

Cheers,
John

> -Will Cohen
>
> .
>
