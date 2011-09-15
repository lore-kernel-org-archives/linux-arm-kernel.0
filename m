From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 15 Sep 2011 17:32:00 +0530
Subject: [PATCH 13/25] OMAP4: PM: Add WakeupGen module as OMAP
	gic_arch_extn
In-Reply-To: <4E71C702.40206@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-14-git-send-email-santosh.shilimkar@ti.com>
	<20110913203616.GG24252@atomide.com>
	<CAMQu2gyYETPZRJu=4MWX6bULgmMaJb8MRwfhvURtOuyyWhLkAQ@mail.gmail.com>
	<20110914152116.GM24252@atomide.com> <4E70DB33.5070501@ti.com>
	<20110914170803.GN24252@atomide.com> <4E70E0CC.80300@ti.com>
	<20110914171800.GO24252@atomide.com> <4E70E2DE.2030006@ti.com>
	<4E71C702.40206@ti.com>
Message-ID: <CAMQu2gy0VX5wQVJRjpjMwtNqM5h2Te4FtoFnyZfphFyP+uSXmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2011 at 3:06 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
> Hi Santosh,
>
> On 9/14/2011 7:22 PM, Shilimkar, Santosh wrote:
>>
>> On Wednesday 14 September 2011 10:48 PM, Tony Lindgren wrote:
>>>
>>> * Santosh<santosh.shilimkar@ti.com> ? [110914 09:40]:
>>>>
>>>> On Wednesday 14 September 2011 10:38 PM, Tony Lindgren wrote:
>>>>>
>>>>> * Santosh<santosh.shilimkar@ti.com> ? ?[110914 09:16]:
>>>>>
>>>>> Thanks for the clarification. It seems to me the spec is most likely
>>>>> wrong as we've had the GIC working for over two years now without
>>>>> doing anything with the wakeup gen registers :)
>>>>>
>>>> It's working because CPU clockdomain are never put under HW
>>>> supervised mode and they are kept in force wakeup. Clock-domain
>>>> never idles on mainline code. PM series will put the clock-domains
>>>> under HW supervison as needed to achieve any low power states and
>>>> then all sorts of corner cases will come out.
>>>
>>> But again the wakeup gen triggers only do something when hitting
>>> idle. There should be no use for them during runtime, right?
>>>
>> You missed my point in the description. Clockdomain inactive
>> doesn't depend on idle or WFI execution. Under HW supervison
>> CPU clock domain can get into inactive when CPU is stalled and
>> waiting for a read response from slow interconnect.
>
> I'm a little bit confused by that statement...
>
> I'm wondering how the PRCM can gate the CPU/MPU clock and re-enable it if
> the MPU is gated? What kind of event can wakeup the CPU in case of CPU
> stalled?
>
> The spec seems to indicate that wakeupgen is needed only if CPU are in WFI.
> It is even written: "CPUx will change power state only when StandbyWFI is
> asserted.". Even a WFE is not supposed to trigger a standby.
> How can the CPU be inactive at clock domain level without a WFI?
>
I mean only CPU clock domain and not the power domain inactive
and local CPU clock can be gated without WFI when clock domain
is kept under hardware supervision.

But I agree with you that, for the stalled case, wakeupgen can't
generate any event and it will LPRM state-machine which take
care of un-gating the clock for that local CPU.

I have been discussing today morning with design IP team on the
restriction in the functional specs and they said they will check and
comeback.

For now, I would like to go with what specs says. By next merge window,
am sure we will be clear inputs from IP team on this and if it happens
that the requirement needs to be changed and we need not do
mask/unmask in non-low power scenario, we can start looking
at other aspects as Tony suggested.

Regards
Santosh
