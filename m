From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 7 Feb 2012 16:23:02 +0530
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <CAMsRxfKR1ODH56BtcUT5Dv6qOVEYGVheEcW9ugXsZmLKok==bg@mail.gmail.com>
References: <1328578047.1724.17.camel@dave-Dell-System-XPS-L502X>
 <CAMQu2gwfo5JXAqQaLUNs7C7J3TUhEO2zOcyD0Rk-D_O61Yrfag@mail.gmail.com>
 <CAMsRxfLNBbQO5XF+EHJqNsnW+s=ay3mjSV5dh=sxdwzktUu03g@mail.gmail.com>
 <CAMQu2gzfNAwtf1c6jrTZpfGMSqBgBrQKmFTeCFzbvMh9ESBDUg@mail.gmail.com>
 <CAMsRxfKR1ODH56BtcUT5Dv6qOVEYGVheEcW9ugXsZmLKok==bg@mail.gmail.com>
Message-ID: <CAMQu2gwWt6oQPjxc1YHgOoxVkHdck_q78Xf==7ncwRj0_uS-JQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

( Removing dead "linux-arm-kernel at lists.arm.linux.org.uk" and adding
correct list

On Tue, Feb 7, 2012 at 4:07 PM, stephane eranian <eranian@googlemail.com> wrote:
> Hi,
>
> Ok, with Santosh's patch this is much better almost as expected, still
> 10-15% off.
>
> With Santosh's:
> $ perf record noploop 10
> $ perf report -D | fgrep SAMPLE
> 552272888183 0x19a80 [0x28]: PERF_RECORD_SAMPLE(IP, 2): 3864/3864:
> 0x87b4 period: 1005980 addr: 0
> 552273895263 0x19aa8 [0x28]: PERF_RECORD_SAMPLE(IP, 2): 3864/3864:
> 0x87b4 period: 1005097 addr: 0
> 552274902343 0x19ad0 [0x28]: PERF_RECORD_SAMPLE(IP, 2): 3864/3864:
> 0x87b4 period: 1008113 addr: 0
> 552275909423 0x19af8 [0x28]: PERF_RECORD_SAMPLE(IP, 2): 3864/3864:
> 0x87b4 period: 1007228 addr: 0
> 552276885986 0x19b20 [0x28]: PERF_RECORD_SAMPLE(IP, 2): 3864/3864:
> 0x87b4 period: 1006344 addr: 0
> 552277893066 0x19b48 [0x28]: PERF_RECORD_SAMPLE(IP, 2): 3864/3864:
> 0x87b4 period: 1005461 addr: 0
> 552278900146 0x19b70 [0x28]: PERF_RECORD_SAMPLE(IP, 2): 3864/3864:
> 0x87b4 period: 1008478 addr: 0
> 552279907226 0x19b98 [0x28]: PERF_RECORD_SAMPLE(IP, 2): 3864/3864:
> 0x87b4 period: 1007321 addr: 0
> 552280914306 0x19bc0 [0x28]: PERF_RECORD_SAMPLE(IP, 2): 3864/3864:
> 0x87b4 period: 1006437 addr: 0
> 552281890869 0x19be8 [0x28]: PERF_RECORD_SAMPLE(IP, 2): 3864/3864:
> 0x87b4 period: 1005554 addr: 0
> 552282897949 0x19c10 [0x28]: PERF_RECORD_SAMPLE(IP, 2): 3864/3864:
> 0x87b4 period: 1004672 addr: 0
> 552283905029 0x19c38 [0x28]: PERF_RECORD_SAMPLE(IP, 2): 3864/3864:
> 0x87b4 period: 1007686 addr: 0
> 552284912109 0x19c60 [0x28]: PERF_RECORD_SAMPLE(IP, 2): 3864/3864:
> 0x87b4 period: 1006802 addr: 0
> 552285919189 0x19c88 [0x28]: PERF_RECORD_SAMPLE(IP, 2): 3864/3864:
> 0x87b4 period: 1005918 addr: 0
> 552286895751 0x19cb0 [0x28]: PERF_RECORD_SAMPLE(IP, 2): 3864/3864:
> 0x87b4 period: 1005088 addr: 0
>
> What's important is here is the value of period. on a 1GHz CPU
> sampling @ 1000Hz, should
> be hovering around 1000000000/1000 = 1000000, which is what we're seeing above.
>
> Total samples:
> $ perf report -D | tail -20
> cycles stats:
> ? ? ? ? ? TOTAL events: ? ? ? 8959
> ? ? ? ? ? ?MMAP events: ? ? ? ? 13
> ? ? ? ? ? ?COMM events: ? ? ? ? ?2
> ? ? ? ? ? ?EXIT events: ? ? ? ? ?2
> ? ? ? ? ?SAMPLE events: ? ? ? 8942
>
> Should have 10k samples, we're close.
>
> Without Santosh's:
> 1305066131591 0x143f0 [0x28]: PERF_RECORD_SAMPLE(IP, 2): 3778/3778:
> 0x87b4 period: 6933517 addr: 0
> 1305071594238 0x14418 [0x28]: PERF_RECORD_SAMPLE(IP, 2): 3778/3778:
> 0x87b4 period: 5501604 addr: 0
> 1305075866699 0x14440 [0x28]: PERF_RECORD_SAMPLE(IP, 2): 3778/3778:
> 0x87b4 period: 4429665 addr: 0
> 1305079956054 0x14468 [0x28]: PERF_RECORD_SAMPLE(IP, 2): 3778/3778:
> 0x87b4 period: 3977321 addr: 0
> 1305080017089 0x14490 [0x28]: PERF_RECORD_SAMPLE(IP, 2): 3778/3778:
> 0x87b4 period: 3325451 addr: 0
> 1305085510253 0x144b8 [0x28]: PERF_RECORD_SAMPLE(IP, 2): 3778/3778:
> 0x87b4 period: 3011420 addr: 0
> 1305093994140 0x144e0 [0x28]: PERF_RECORD_SAMPLE(IP, 2): 3778/3778:
> 0x87b4 period: 7804304 addr: 0
> 1305100219726 0x14508 [0x28]: PERF_RECORD_SAMPLE(IP, 2): 3778/3778:
> 0x87b4 period: 6247468 addr: 0
> 1305100280761 0x14530 [0x28]: PERF_RECORD_SAMPLE(IP, 2): 3778/3778:
> 0x87b4 period: 4954601 addr: 0
> 1305106201171 0x14558 [0x28]: PERF_RECORD_SAMPLE(IP, 2): 3778/3778:
> 0x87b4 period: 4434758 addr: 0
> 1305120941162 0x14580 [0x28]: PERF_RECORD_SAMPLE(IP, 2): 3778/3778:
> 0x87b4 period: 11484036 addr: 0
> 1305121826171 0x145a8 [0x28]: PERF_RECORD_SAMPLE(IP, 2): 3778/3778:
> 0x87b4 period: 9130408 addr: 0
> 1305137145996 0x145d0 [0x28]: PERF_RECORD_SAMPLE(IP, 2): 3778/3778:
> 0x87b4 period: 7181085 addr: 0
>
> It's all over the map. And the number of samples is way off:
> $ perf report -D | tail -20
> cycles stats:
> ? ? ? ? ? TOTAL events: ? ? ? 2150
> ? ? ? ? ? ?MMAP events: ? ? ? ? 13
> ? ? ? ? ? ?COMM events: ? ? ? ? ?2
> ? ? ? ? ? ?EXIT events: ? ? ? ? ?2
> ? ? ? ? ?SAMPLE events: ? ? ? 2133
>
> So the fix does help. I am wondering why we're not getting closer to
> 10k samples. But that
> may be due to some overhead somewhere in there.
>

Glad to hear that patch helped you. I will check with OMAP design team
on the issue and post a post to mainline accordingly.

Am keeping below thread as is since this is first time it will apear
on active arm list :)
Regards
Santosh

>
>
> On Tue, Feb 7, 2012 at 10:08 AM, Shilimkar, Santosh
> <santosh.shilimkar@ti.com> wrote:
>> On Tue, Feb 7, 2012 at 2:24 PM, stephane eranian <eranian@googlemail.com> wrote:
>>> Hi,
>>>
>>> There is something I don't understand in this discussion about idle and clock
>>> domain. In my example, I never go idle, I am running a busy loop at
>>> the user level.
>>> Unless there is something I am missing about ARM and clocks, I don't see how
>>> your patches could be helpful. Please enlighten me.
>>>
>> On OMAP specifically there are many power-domains and clock-domains and
>> they sort of independent. ?The clockdomain may be few modules and if
>> all the modules in that clockdomain idle, the clockdomain can idle as
>> well. This all happens in hardware.
>>
>> Your busy loop might keep the CPU and may be interconnect active
>> but l4_wk clockdomain can sitill idle when all the modules in that
>> clock-domain idle.
>>
>> Now the issue seems to be the independent idling of l4wk and
>> MPU. generally whenever there is CPU access for 32k counter,
>> l4_wkup clockdomain and counter should come out of idle and the
>> read should work. This scheme is hardware controlled and we have
>> come across few issues in other modules. So in my patch
>> I am trying to setup a config, in which wherever CPU needs
>> to access ?l4_wkup modules, it will be already active because
>> of the dependency patch sets. This is far more complicated
>> at hardware level but those details are not that important since
>> they behavior is expected to the one mentioned above.
>>
>> Hope this clarifies.
>>
>>> Thanks.
>>>
>>> On Tue, Feb 7, 2012 at 8:31 AM, Shilimkar, Santosh
>>> <santosh.shilimkar@ti.com> wrote:
>>>> On Tue, Feb 7, 2012 at 6:57 AM, David Long <dave.long@linaro.org> wrote:
>>>>>> Ok, so I did a few more tests and there is a serious issue when sampling
>>>>>> in frequency mode (the default). I noticed wrong number of samples, so
>>>>>> I investigated this some more and instrumented the perf_event kernel code.
>>>>>> I found some erratic timer ticks causing broken period adjustments.
>>>>>
>>>>> I also had a report of what appeared to be timer variability using perf
>>>>> on a panda. ?After much experimentation (including disabling frequency
>>>>> scaling) I was forced to conclude that the hardware 32K timer being used
>>>>> for the system tick was occasionally reporting stale values on read.
>>>>> This would give the appearance of code suddenly running impossibly fast
>>>>> for one sample period. ?The time would soon catch up showing an apparent
>>>>> slowing down for one period. ?Eventually I tried changing the 32K clock
>>>>> idle modes and that made the problem disappear. ?I have no explanation
>>>>> for exactly what is going on. ?Here is the diff:
>>>>>
>>>>>
>>>>>
>>>>> For some reason we seem to get stale 32k timer values when we allow the module to
>>>>> auto idle. Prevent this by disabling auto idle for this module.
>>>>>
>>>>> Signed-off-by: David A. Long <dave.long@linaro.org>
>>>>> ---
>>>>> ?arch/arm/mach-omap2/omap_hwmod_44xx_data.c | ? ?2 +-
>>>>> ?1 files changed, 1 insertions(+), 1 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>>>> index daaf165..de6fe96 100644
>>>>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>>>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>>>> @@ -896,7 +896,7 @@ static struct omap_hwmod omap44xx_counter_32k_hwmod = {
>>>>> ? ? ? ?.name ? ? ? ? ? = "counter_32k",
>>>>> ? ? ? ?.class ? ? ? ? ?= &omap44xx_counter_hwmod_class,
>>>>> ? ? ? ?.clkdm_name ? ? = "l4_wkup_clkdm",
>>>>> - ? ? ? .flags ? ? ? ? ?= HWMOD_SWSUP_SIDLE,
>>>>> + ? ? ? .flags ? ? ? ? ?= (HWMOD_SWSUP_SIDLE | HWMOD_INIT_NO_IDLE),
>>>>> ? ? ? ?.main_clk ? ? ? = "sys_32k_ck",
>>>>> ? ? ? ?.prcm = {
>>>>> ? ? ? ? ? ? ? ?.omap4 = {
>>>>
>>>> Not sure how the above change will help. 32K counter module mode
>>>> is read-only register, so above change shouldn't have any impact.
>>>>
>>>> ------------------------
>>>> 1:0 MODULEMODE Control the way mandatory clocks are managed.
>>>> R 0x1
>>>> Read 0x1: Module is managed automatically by hardware Rreturns
>>>> according to clock domain transition. A clock domain
>>>> sleep transition put module into idle. A wakeup domain
>>>> transition put it back into function. If CLKTRCTRL=3, any
>>>> INTRCONN access to module is always granted. Module
>>>> clocks may be gated according to the clock domain state.
>>>> --------------------------------------------
>>>>
>>>> But it might not allow the always on l4_wkup clock
>>>> domain to idle and that might be helping.
>>>>
>>>> can you try below change instead of above and it see if it
>>>> helps.
>>>> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
>>>> index c264ef7..687fcf2 100644
>>>> --- a/arch/arm/mach-omap2/pm44xx.c
>>>> +++ b/arch/arm/mach-omap2/pm44xx.c
>>>> @@ -197,7 +197,7 @@ static int __init omap4_pm_init(void)
>>>> ?{
>>>> ? ? ? ?int ret;
>>>> ? ? ? ?struct clockdomain *emif_clkdm, *mpuss_clkdm, *l3_1_clkdm;
>>>> - ? ? ? struct clockdomain *ducati_clkdm, *l3_2_clkdm, *l4_per_clkdm;
>>>> + ? ? ? struct clockdomain *ducati_clkdm, *l3_2_clkdm, *l4_per_clkdm, *l4wkup;
>>>>
>>>> ? ? ? ?if (!cpu_is_omap44xx())
>>>> ? ? ? ? ? ? ? ?return -ENODEV;
>>>> @@ -227,14 +227,16 @@ static int __init omap4_pm_init(void)
>>>> ? ? ? ?l3_2_clkdm = clkdm_lookup("l3_2_clkdm");
>>>> ? ? ? ?l4_per_clkdm = clkdm_lookup("l4_per_clkdm");
>>>> ? ? ? ?ducati_clkdm = clkdm_lookup("ducati_clkdm");
>>>> + ? ? ? l4wkup = clkdm_lookup("l4_wkup_clkdm");
>>>> ? ? ? ?if ((!mpuss_clkdm) || (!emif_clkdm) || (!l3_1_clkdm) ||
>>>> - ? ? ? ? ? ? ? (!l3_2_clkdm) || (!ducati_clkdm) || (!l4_per_clkdm))
>>>> + ? ? ? (!l3_2_clkdm) || (!ducati_clkdm) || (!l4_per_clkdm) || (!l4wkup))
>>>> ? ? ? ? ? ? ? ?goto err2;
>>>>
>>>> ? ? ? ?ret = clkdm_add_wkdep(mpuss_clkdm, emif_clkdm);
>>>> ? ? ? ?ret |= clkdm_add_wkdep(mpuss_clkdm, l3_1_clkdm);
>>>> ? ? ? ?ret |= clkdm_add_wkdep(mpuss_clkdm, l3_2_clkdm);
>>>> ? ? ? ?ret |= clkdm_add_wkdep(mpuss_clkdm, l4_per_clkdm);
>>>> + ? ? ? ret |= clkdm_add_wkdep(mpuss_clkdm, l4wkup);
>>>> ? ? ? ?ret |= clkdm_add_wkdep(ducati_clkdm, l3_1_clkdm);
>>>> ? ? ? ?ret |= clkdm_add_wkdep(ducati_clkdm, l3_2_clkdm);
>>>> ? ? ? ?if (ret) {
