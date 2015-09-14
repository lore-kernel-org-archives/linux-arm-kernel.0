From: shannon.zhao@linaro.org (Shannon Zhao)
Date: Mon, 14 Sep 2015 20:58:47 +0800
Subject: [PATCH v2 00/22] KVM: ARM64: Add guest PMU support
In-Reply-To: <20150914115300.GM15712@cbox>
References: <1441961715-11688-1-git-send-email-zhaoshenglong@huawei.com>
 <20150914115300.GM15712@cbox>
Message-ID: <55F6C487.5060801@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/9/14 19:53, Christoffer Dall wrote:
> Hi Shannon,
>
> On Fri, Sep 11, 2015 at 04:54:53PM +0800, Shannon Zhao wrote:
>> From: Shannon Zhao <shannon.zhao@linaro.org>
>>
>> This patchset adds guest PMU support for KVM on ARM64. It takes
>> trap-and-emulate approach. When guest wants to monitor one event, it
>> will be trapped by KVM and KVM will call perf_event API to create a perf
>> event and call relevant perf_event APIs to get the count value of event.
>>
>> Use perf to test this patchset in guest. When using "perf list", it
>> shows the list of the hardware events and hardware cache events perf
>> supports. Then use "perf stat -e EVENT" to monitor some event. For
>> example, use "perf stat -e cycles" to count cpu cycles and
>> "perf stat -e cache-misses" to count cache misses.
>>
>> Below are the outputs of "perf stat -r 5 sleep 5" when running in host
>> and guest.
>>
>> Host:
>>   Performance counter stats for 'sleep 5' (5 runs):
>>
>>            0.551428      task-clock (msec)         #    0.000 CPUs utilized            ( +-  0.91% )
>>                   1      context-switches          #    0.002 M/sec
>>                   0      cpu-migrations            #    0.000 K/sec
>>                  48      page-faults               #    0.088 M/sec                    ( +-  1.05% )
>>             1150265      cycles                    #    2.086 GHz                      ( +-  0.92% )
>>     <not supported>      stalled-cycles-frontend
>>     <not supported>      stalled-cycles-backend
>>              526398      instructions              #    0.46  insns per cycle          ( +-  0.89% )
>>     <not supported>      branches
>>                9485      branch-misses             #   17.201 M/sec                    ( +-  2.35% )
>>
>>         5.000831616 seconds time elapsed                                          ( +-  0.00% )
>>
>> Guest:
>>   Performance counter stats for 'sleep 5' (5 runs):
>>
>>            0.730868      task-clock (msec)         #    0.000 CPUs utilized            ( +-  1.13% )
>>                   1      context-switches          #    0.001 M/sec
>>                   0      cpu-migrations            #    0.000 K/sec
>>                  48      page-faults               #    0.065 M/sec                    ( +-  0.42% )
>>             1642982      cycles                    #    2.248 GHz                      ( +-  1.04% )
>>     <not supported>      stalled-cycles-frontend
>>     <not supported>      stalled-cycles-backend
>>              637964      instructions              #    0.39  insns per cycle          ( +-  0.65% )
>>     <not supported>      branches
>>               10377      branch-misses             #   14.198 M/sec                    ( +-  1.09% )
>>
>>         5.001289068 seconds time elapsed                                          ( +-  0.00% )
>>
>> This patchset can be fetched from [1] and the relevant QEMU version for
>> test can be fetched from [2].
>>
> Is there a changelog for this patch set somewhere?
>

I forgot this, while I realized it after sending this patchset out.

> If not, can you include this in v3 addressing Marc's comments?
>
> Thanks,
> -Christoffer
>

-- 
Shannon
