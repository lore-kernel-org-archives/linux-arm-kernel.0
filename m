From: eranian@googlemail.com (stephane eranian)
Date: Mon, 30 Jan 2012 11:24:59 +0100
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <CACVXFVMgDpaYeaU+0LGirYzNfJb8k0wFfL=+UU5qAwYfXgWLMQ@mail.gmail.com>
References: <CAMsRxfJWjwznJYujSvr0DfhNxtnJDVdfjXXpx34HUDBRtMvjqw@mail.gmail.com>
 <20120127121311.GB2347@mudshark.cambridge.arm.com>
 <yw1x1uqlnw1o.fsf@unicorn.mansr.com>
 <20120127132826.GD2347@mudshark.cambridge.arm.com>
 <CACVXFVPHpmPX9OdeYzzWjQ-qqs=9oYbL_og-_xJA2ypYNu0nRA@mail.gmail.com>
 <CAMsRxfJOAh1V7sMWxqCXADDB_eSAuxop1iYAGqXvLC_74Pfz1A@mail.gmail.com>
 <20120127155454.GH2347@mudshark.cambridge.arm.com>
 <CAMsRxfK-SFEyP5+jyXDyWSQPJ2KO_1YQM_yZdtwV0NJu+idqHA@mail.gmail.com>
 <20120127165941.GK2347@mudshark.cambridge.arm.com>
 <CAMsRxf+iv06zOCMzhYONeLaf6RvOLp38T53mR--8ESHvCXMeFQ@mail.gmail.com>
 <20120127171009.GL2347@mudshark.cambridge.arm.com>
 <CAMsRxfJufRMrcfGZp53ALOdEFLk+YDMvQMrHw-jR9tQ8ThE+-Q@mail.gmail.com>
 <CAMsRxfK5tv1DZmHH4F0BT+zVUboESiMmCkatO2NLHp03=e51fQ@mail.gmail.com>
 <CACVXFVMgDpaYeaU+0LGirYzNfJb8k0wFfL=+UU5qAwYfXgWLMQ@mail.gmail.com>
Message-ID: <CAMsRxfJq1-tSQH4bv0BeNWXV9aysi9AUvywkh3e9SaamMDfZ0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ok, let me try again with 3.3.0-rc1, that was with 3.2.0.
The only thing that changed was that one line and it made
a big difference.


On Mon, Jan 30, 2012 at 10:40 AM, Ming Lei <ming.lei@canonical.com> wrote:
> Hi,
>
> On Mon, Jan 30, 2012 at 1:36 AM, stephane eranian
> <eranian@googlemail.com> wrote:
>> Hi,
>>
>> Ok, so I did a few more tests and there is a serious issue when sampling
>> in frequency mode (the default). I noticed wrong number of samples, so
>> I investigated this some more and instrumented the perf_event kernel code.
>> I found some erratic timer ticks causing broken period adjustments.
>>
>> In fact, the problem is visible using top.
>> I am running a noploop program on CPU0 and nothing else besides top.
>> The noploop program ?does: for(;;);. That is 100% user. On a 2-way
>
> Sometimes it is not 100% user, for example irq/exception handling...
>
>> system otherwise idle, I expect top to return 50% user 50% idle.
>>
>> Top with the commit:
>>
>> top - 16:19:21 up 5 min, ?1 user, ?load average: 0.23, 0.15, 0.07
>> Tasks: ?70 total, ? 2 running, ?68 sleeping, ? 0 stopped, ? 0 zombie
>> Cpu(s): 31.1%us, ?2.0%sy, ?0.0%ni, 66.2%id, ?0.0%wa, ?0.0%hi, ?0.7%si, ?0.0%st
>> ? ? ? ? ? ?^^^^^^^^ That's WRONG
>
> Did you reproduce the issue each time or just occasionally?
>
> Looks no such issue on my board with 3.3-rc1 plus the 5 extra pmu/emu patches.
>
> top - 00:59:15 up 7 min, ?1 user, ?load average: 1.00, 0.73, 0.35
> Tasks: ?56 total, ? 2 running, ?54 sleeping, ? 0 stopped, ? 0 zombie
> Cpu(s): 42.6%us, ?0.2%sy, ?0.0%ni, 56.8%id, ?0.0%wa, ?0.0%hi, ?0.4%si, ?0.0%st
> Mem: ? 1013560k total, ? ?50960k used, ? 962600k free, ? ? 6272k buffers
> Swap: ? ? ? ?0k total, ? ? ? ?0k used, ? ? ? ?0k free, ? ?29036k cached
>
> ?PID USER ? ? ?PR ?NI ?VIRT ?RES ?SHR S %CPU %MEM ? ?TIME+ ?COMMAND
> ?1355 root ? ? ?20 ? 0 ?1460 ?260 ?216 R ? 99 ?0.0 ? 5:07.38 busy
> ?532 root ? ? ?20 ? 0 ? ? 0 ? ?0 ? ?0 S ? ?0 ?0.0 ? 0:00.23 kworker/1:1
> ?1356 root ? ? ?20 ? 0 ?2552 1120 ?916 R ? ?0 ?0.1 ? 0:01.93 top
>
>>
>> Mem: ? ?940292k total, ? ?74984k used, ? 865308k free, ? ? 8020k buffers
>> Swap: ? 524240k total, ? ? ? ?0k used, ? 524240k free, ? ?37420k cached
>>
>> ?PID USER ? ? ?PR ?NI ?VIRT ?RES ?SHR S %CPU %MEM ? ?TIME+ ?COMMAND
>> ?3770 eranian ? 20 ? 0 644 160 128 R ? 99 ?0.0 ? 0:14.21 noploop
>> ?3771 eranian ? 20 ? 0 ?2184 1052 ?804 R ? ?2 ?0.1 ? 0:00.32 top
>> ? ?1 root ? ? ?20 ? 0 ?2564 1528 ?952 S ? ?0 ?0.2 ? 0:01.26 init
>>
>>
>> I removed that one liner patch from Ming. The one fiddling with the
>> clockdomains:
>>
>> --- a/arch/arm/mach-omap2/clockdomains44xx_data.c
>> +++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
>> @@ -390,7 +390,7 @@ static struct clockdomain emu_sys_44xx_clkdm = {
>> ? ? ? ?.prcm_partition ? = OMAP4430_PRM_PARTITION,
>> ? ? ? ?.cm_inst ? ? ? ? ?= OMAP4430_PRM_EMU_CM_INST,
>> ? ? ? ?.clkdm_offs ? ? ? = OMAP4430_PRM_EMU_CM_EMU_CDOFFS,
>> - ? ? ? .flags ? ? ? ? ? ?= CLKDM_CAN_HWSUP,
>> + ? ? ? .flags ? ? ? ? ? ?= CLKDM_CAN_SWSUP,
>
> The patch should not affect timer tick logic, and what the patch does is
> just to revert the commit [1] ?wrt. emu clock domain.
>
>>
>> When I rerun, the test, it now work:
>>
>> top - 16:02:51 up 15 min, ?1 user, ?load average: 1.02, 0.46, 0.21
>> Tasks: ?70 total, ? 2 running, ?68 sleeping, ? 0 stopped, ? 0 zombie
>> Cpu(s): 47.2%us, ?1.0%sy, ?0.0%ni, 50.8%id, ?0.0%wa, ?0.0%hi, ?1.0%si, ?0.0%st
>> ? ? ? ? ? ^^^^^^^^ close enough (in it stabilize somehow around 49%
>> which is good)
>>
>> Mem: ? ?940292k total, ? ?75288k used, ? 865004k free, ? ? 8004k buffers
>> Swap: ? 524240k total, ? ? ? ?0k used, ? 524240k free, ? ?37408k cached
>>
>> ?PID USER ? ? ?PR ?NI ?VIRT ?RES ?SHR S %CPU %MEM ? ?TIME+ ?COMMAND
>> ?3771 eranian ? 20 ? 0 644 160 128 R ?100 ?0.0 ? 0:34.44 noploop
>>
>> Although the patch fixes PMU interrupts, it breaks the timer tick logic somehow.
>> The perf problem is related to timer tick.
>>
>> I am hoping that the tradeoff is not:
>> ? ? PMU interrupts but broken timer ticks
>> vs.
>> ? ?No PMU interrupts but working timer ticks
>
>
>
> [1], 3c50729b3fa1cd8ca1f347e6caf1081204cf1a7c
> ARM: OMAP4: PM: Initialise all the clockdomains to supported states
>
> thanks
> --
> Ming Lei
