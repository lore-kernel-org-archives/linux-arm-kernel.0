From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 23 Feb 2017 16:34:50 +0100
Subject: [PATCH/RFC 0/6] PSCI: Fix non-PMIC wake-up if SYSTEM_SUSPEND cuts
 power
In-Reply-To: <CAMuHMdVTEbqEocYwu=KW_uXpykYkVwUgSJBnLvQp_Epn8Pjp1g@mail.gmail.com>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <94167d3a-e005-3af0-d290-a1086684d570@arm.com>
 <3c8b3f2d-8604-f999-4208-a82f171b64f2@arm.com>
 <1975396.x0czmkNPOW@aspire.rjw.lan>
 <35840771-e16f-d6fe-3a89-1b3f51f4a8f3@arm.com>
 <CAMuHMdXpKrJn9NrkAarvMtytk9gHEFcRoZLCsWBFgriUCeWo=Q@mail.gmail.com>
 <f649d707-8b0a-5ca9-b021-93ae8cf66b33@arm.com>
 <CAMuHMdVTEbqEocYwu=KW_uXpykYkVwUgSJBnLvQp_Epn8Pjp1g@mail.gmail.com>
Message-ID: <CAMuHMdX3_Vjw2NNTE1XnQkuKS=7YDA4eccEFO1pAZkjw_4q9cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

On Thu, Feb 23, 2017 at 4:26 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Wed, Feb 22, 2017 at 3:32 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> On 22/02/17 13:38, Geert Uytterhoeven wrote:
>>> On Wed, Feb 22, 2017 at 12:03 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>   4. Patch 3/6 adds a new "shallow" state, as it allows to save more
>>> power (the difference may be due to suboptimal cpuidle platform support on R-Car Gen3, though),
>>
>> Why can't you do that in s2idle mode. Please give me the difference
>> between your shallow state and s2idle state, not just power numbers
>> but the actual state of CPUs and the devices in the system.
>
> From the Linux side, there's not much difference, except that the secondary
> CPU cores are disabled.  As that is handled by PSCI, the difference may be
> in the PSCI implementation.  I will have to check that...
>
> On these SoCs, the individual CPU cores and the SCU/L2 are in separate
> (nested) power areas.  Perhaps these power areas are turned off when
> disabling the CPU cores, but not when suspending them.

BTW, I don't care much about the extra state.

>>> E.g. on non-PSCI platforms with an Ethernet driver that supports
>>> Wake-on-LAN, I can do:
>>>
>>>         ethtool -s eth0 wol g
>>>         echo mem > /sys/power/state
>>>
>>> and be sure that the system can be woken up by sending a WoL MagicPacket.
>>
>> Still possible with s2idle if CPU_SUSPEND is correctly implemented by
>> the platform.
>
> Sure. But not automatic, as it needs fiddling with mem_sleep.

I do care about this, as it affects user experience.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
