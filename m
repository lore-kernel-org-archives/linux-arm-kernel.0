From: rafael@kernel.org (Rafael J. Wysocki)
Date: Wed, 22 Feb 2017 15:57:11 +0100
Subject: [PATCH/RFC 4/6] drivers: firmware: psci: Fix non-PMIC wake-up if
 SYSTEM_SUSPEND cuts power
In-Reply-To: <CAMuHMdW8JAYrgvWxi8c_ZLtsUWBYFGZ=V7pu2p+cO=NdwLas2w@mail.gmail.com>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <1487622809-25127-5-git-send-email-geert+renesas@glider.be>
 <20170221174844.GE8605@leverpostej>
 <CAMuHMdW8JAYrgvWxi8c_ZLtsUWBYFGZ=V7pu2p+cO=NdwLas2w@mail.gmail.com>
Message-ID: <CAJZ5v0ihFCe0phwKQHDnPETkfPgKDiWw27GOs8jVv1hyahJ+DQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 22, 2017 at 3:05 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Mark,
>
> On Tue, Feb 21, 2017 at 6:48 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> On Mon, Feb 20, 2017 at 09:33:27PM +0100, Geert Uytterhoeven wrote:
>>> @@ -440,12 +442,14 @@ static int psci_system_suspend_valid(suspend_state_t state)
>>>  static int psci_system_suspend_enter(suspend_state_t state)
>>>  {
>>>       switch (state) {
>>> +     case PM_SUSPEND_MEM:
>>> +             if (!psci_system_suspend_is_power_down ||
>>> +                 !wakeup_source_available())
>>> +                     return cpu_suspend(0, psci_system_suspend);
>>> +             /* fall through */
>>
>> I don't believe that this is the correct place to handle this.
>>
>> The wakeup_source_available() check *might* be ok, though even with that
>> I'd rather we rejected the request rather than trying to fall back to a
>> PSCI_CPU_SUSPEND. Otherwise we have a potential silent power regression.
>
> If we reject the request here, I think the PM core has to be modified to
> try again using a shallower state. Note that it would be better to reject
> the state in the .valid() callback instead of in .enter().
>
> You also have to consider this is dynamic not static.
> I.e. the availability of other wake-up sources may change at runtime (cfr.
> the "wakeup" files in sysfs). Currently pm_sleep_states[] (which controls
> which states are available) is initialized from suspend_set_ops(), and not
> changed later.
>
> Perhaps pm_sleep_states[] should be updated every time the wakeup_sources
> list is changed?

No, the definitions of sleep states *are* static.  They have to be, or
user space won't know what sleep state it is asking for.

And, as I said in my last reply to Sudeep, the list of possible wakeup
devices for the given state is part of that definition.  The sysfs
"wakeup" interface is on top of that, not the other way around (which
seems seems to be what you would want).

Thanks,
Rafael
