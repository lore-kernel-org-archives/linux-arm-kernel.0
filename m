From: ming.lei@canonical.com (Ming Lei)
Date: Wed, 18 Jan 2012 20:24:10 +0800
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <CAMQu2gzW706YbOzHa4Am0=X17T0G3zBhOmWUd8eC6GY9F6OBog@mail.gmail.com>
References: <CAAO=S0+L2Q1YZC-pfm2Lz8jPooTeHYOMaZbtRgHYFoL_m7rvhA@mail.gmail.com>
 <4F0B182D.7060507@us.ibm.com>
 <20120109224945.GA23090@mudshark.cambridge.arm.com>
 <CACVXFVMnAt_YpYNC5B6W4Vh4HvtVS3D6jRORUw0AW5a4ub5aOw@mail.gmail.com>
 <CAMsRxfJe_MEA=anzRu6jehGcZyg49uAx44_nDQ3_FRY=WrFLoA@mail.gmail.com>
 <CACVXFVNXJ2vZM-dAxQPQ5LSOuvv5yvOrnytOB9PxURtkaSCP8w@mail.gmail.com>
 <CACVXFVMH9WZDqs-mVjxL=1FY12uHyQAJMTCQuU5ru1wQT+YnZg@mail.gmail.com>
 <CAMQu2gzW706YbOzHa4Am0=X17T0G3zBhOmWUd8eC6GY9F6OBog@mail.gmail.com>
Message-ID: <CACVXFVPb-McJj1oi284RW37Pe08cAXSw-jteFwfNVPpCJx5EaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2012 at 7:39 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
> On Wed, Jan 18, 2012 at 10:33 AM, Ming Lei <ming.lei@canonical.com> wrote:
>> Hi Will and stephane,
>>
>> On Wed, Jan 18, 2012 at 12:18 PM, Ming Lei <ming.lei@canonical.com> wrote:
>>> Hi stephane & Will,
>>>
>>> On Tue, Jan 10, 2012 at 8:46 AM, stephane eranian
>>> <eranian@googlemail.com> wrote:
>>>> See the dmesg from my 3.2 kernel:
>>>>
>>>>
>>>> [ ? ?0.000000] Booting Linux on physical CPU 0[ ? ?0.000000]
>>
>> But if you test omap4 perf against -next kernel, pmu won't work because
>> the commit[1] may put 'emu_sys_clkdm' ?clock domain into HW_AUTO mode,
>> so writing pmu register may not take effect.
>>
>> I have found ?the similar problem on cam clock domain before[2].
>> CD_EMU is very simliar with CD_CAM in the point below:
>>
>> ? ? ? ?CD_EMU has no static or module wake-up dependency with any other clock
>> ? ? ? ?domain of the device.[3]
>>
>> So the patch[4] can make omap4 pmu work on -next tree.
>>
>> Shilimkar, care to comment on the patch[4]?
>>
>> thanks,
>> --
>> Ming Lei
>>
>> [1], commit 3c50729b3fa1cd8ca1f347e6caf1081204cf1a7c
>> Author: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Date: ? Wed Jan 5 22:03:17 2011 +0530
>>
>> ? ARM: OMAP4: PM: Initialise all the clockdomains to supported states
>>
>> ? Initialise hardware supervised mode for all clockdomains if it's
>> ? supported. Initiate sleep transition for other clockdomains,
>> ? if they are not being used.
>>
>> [2], http://www.spinics.net/lists/linux-omap/msg61911.html
>>
>> [3], 3.6.12.3 of OMAP4 TRM
>>
>> [4],
>> diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c
>> b/arch/arm/mach-omap2/clockdomains44xx_data.c
>> index 9299ac2..41d2260 100644
>> --- a/arch/arm/mach-omap2/clockdomains44xx_data.c
>> +++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
>> @@ -390,7 +390,7 @@ static struct clockdomain emu_sys_44xx_clkdm = {
>> ? ? ? ?.prcm_partition ? = OMAP4430_PRM_PARTITION,
>> ? ? ? ?.cm_inst ? ? ? ? ?= OMAP4430_PRM_EMU_CM_INST,
>> ? ? ? ?.clkdm_offs ? ? ? = OMAP4430_PRM_EMU_CM_EMU_CDOFFS,
>> - ? ? ? .flags ? ? ? ? ? ?= CLKDM_CAN_HWSUP,
>> + ? ? ? .flags ? ? ? ? ? ?= CLKDM_CAN_SWSUP,
>> ?};
> NAK.
>
> You don't need this patch. What you saw on CAMERA was indeed
> a known bug but emulation domain has no such issues.
>
> So the accesses to emulation register should continue to work
> with the clock-domain being kept under hardware supervision.

But why can this patch make omap4 pmu work?  Without the patch,
there are no CTI interrupts generated for pmu irq.

thanks
--
Ming Lei
