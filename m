From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Tue, 4 Jun 2013 17:09:55 +0530
Subject: [PATCH] ARM: zynq: wfi exit on same cpu is valid
In-Reply-To: <51AC8F74.2060302@linaro.org>
References: <1369997066-10585-1-git-send-email-sanjay.rawat@linaro.org>
 <51AC5060.80806@linaro.org> <51AC672A.5050501@monstr.eu>
 <51AC8F74.2060302@linaro.org>
Message-ID: <CAP245DUsRcomDaNKbxYry39ZLCrR33SDRRAhNCdR91e17sHF-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 3, 2013 at 6:13 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 06/03/2013 11:51 AM, Michal Simek wrote:
>> Hi,
>>
>> On 06/03/2013 10:14 AM, Daniel Lezcano wrote:
>>> On 05/31/2013 12:44 PM, Sanjay Singh Rawat wrote:
>>>> The current code considers every wakeup as spurious, which is not
>>>> correct. Handle the same way as other arm platforms are doing.
>>>>
>>>> Signed-off-by: Sanjay Singh Rawat <sanjay.rawat@linaro.org>
>>> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>
>>>
>>>> ---
>>>>  arch/arm/mach-zynq/hotplug.c |    7 +++++++
>>>>  1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/arch/arm/mach-zynq/hotplug.c b/arch/arm/mach-zynq/hotplug.c
>>>> index c89672b..a1ab22c 100644
>>>> --- a/arch/arm/mach-zynq/hotplug.c
>>>> +++ b/arch/arm/mach-zynq/hotplug.c
>>>> @@ -67,6 +67,13 @@ static inline void zynq_platform_do_lowpower(unsigned int cpu, int *spurious)
>>>>             dsb();
>>>>             wfi();
>>>>
>>>> +           if (pen_release == cpu_logical_map(cpu)) {
>>>> +                   /*
>>>> +                    * OK, proper wakeup, we're done
>>>> +                    */
>>>> +                   break;
>>>> +           }
>>>> +
>> what pen_release stands for?
>> I have looked at it and others platform are also using it in platsmp
>> code which is not zynq case.
>> How is it supposed to work and how this variable should be used?
>
> This variable is used to serialize the secondary cpus boot process.

I'm curious why it is called pen_release. :) Is there some historical
link to some HW lines?

> When the processors boot, all the processors except the CPU0 are in WFI.
