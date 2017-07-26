From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 26 Jul 2017 15:35:25 +0100
Subject: [PATCH v8 1/3] perf: cavium: Support memory controller PMU
 counters
In-Reply-To: <20170726131058.GA8665@hc>
References: <20170725150422.4775-1-jglauber@cavium.com>
 <20170725150422.4775-2-jglauber@cavium.com>
 <72145781-e9ec-036f-f752-b4756fef08ee@arm.com> <20170726111946.GA6273@hc>
 <faa339c4-b087-d970-1099-3d6cf8186545@arm.com> <20170726131058.GA8665@hc>
Message-ID: <131179fe-42e7-f286-5bd4-801f4c93d5f9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+To: Boris

Hi Boris,

On 26/07/17 14:10, Jan Glauber wrote:
> On Wed, Jul 26, 2017 at 01:47:35PM +0100, Suzuki K Poulose wrote:
>> On 26/07/17 12:19, Jan Glauber wrote:
>>> On Tue, Jul 25, 2017 at 04:39:18PM +0100, Suzuki K Poulose wrote:
>>>> On 25/07/17 16:04, Jan Glauber wrote:
>>>>> Add support for the PMU counters on Cavium SOC memory controllers.
>>>>>
>>>>> This patch also adds generic functions to allow supporting more
>>>>> devices with PMU counters.
>>>>>
>>>>> Properties of the LMC PMU counters:
>>>>> - not stoppable
>>>>> - fixed purpose
>>>>> - read-only
>>>>> - one PCI device per memory controller
>>>>>
>>>>> Signed-off-by: Jan Glauber <jglauber@cavium.com>
>>>>> ---
>>>>> drivers/perf/Kconfig       |   8 +
>>>>> drivers/perf/Makefile      |   1 +
>>>>> drivers/perf/cavium_pmu.c  | 424 +++++++++++++++++++++++++++++++++++++++++++++
>>>>> include/linux/cpuhotplug.h |   1 +
>>>>> 4 files changed, 434 insertions(+)
>>>>> create mode 100644 drivers/perf/cavium_pmu.c
>>>>>
>>>>> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
>>>>> index e5197ff..a46c3f0 100644
>>>>> --- a/drivers/perf/Kconfig
>>>>> +++ b/drivers/perf/Kconfig
>>>>> @@ -43,4 +43,12 @@ config XGENE_PMU
>>>>>        help
>>>>>          Say y if you want to use APM X-Gene SoC performance monitors.
>>>>>
>>>>> +config CAVIUM_PMU
>>>>> +	bool "Cavium SOC PMU"
>>>>
>>>> Is there any specific reason why this can't be built as a module ?
>>>
>>> Yes. I don't know how to load the module automatically. I can't make it
>>> a pci driver as the EDAC driver "owns" the device (and having two
>>> drivers for one device wont work as far as I know). I tried to hook
>>> into the EDAC driver but the EDAC maintainer was not overly welcoming
>>> that approach.
>>
>>>
>>> And while it would be possible to have it a s a module I think it is of
>>> no use if it requires manualy loading. But maybe there is a simple
>>> solution I'm missing here?
>>
>>
>> If you are talking about a Cavium specific EDAC driver, may be we could
>> make that depend on this driver "at runtime" via symbols (may be even,
>> trigger the probe of PMU), which will be referenced only when CONFIG_CAVIUM_PMU
>> is defined. It is not the perfect solution, but that should do the trick.
>
> I think that is roughly what I proposed in v6. Can you have a look at:
>
> https://lkml.org/lkml/2017/6/23/333
> https://patchwork.kernel.org/patch/9806427/

So the Cavium EDACs, which appear as PCI devices have a PMU attached to it.
In order to build this PMU driver as a module, we need a way to load the module
automatically based on the PCI id. However, since the EDAC driver already
registers with that PCI id, we cannot use the same for the PMU. Ideally,
the PMU driver should be loaded when the EDAC driver is loaded. But looking
at the links above, it looks like you don't like the idea of triggering a
probe of the PMU component from the EDAC driver. We may be able to get rid
of the PMU specific information from the EDAC driver by maintaining the PCI
id of the device in the PMU driver. But we may still need to make sure that
the PMU driver gets a chance to probe the PMU when the device is available.

What do you think is the best option here ?

Suzuki
