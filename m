From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 21 Mar 2015 11:43:56 +0100
Subject: [PATCH v3 0/5] clocksource: sun5i: Support parent clock rate
 changes
In-Reply-To: <20150320205655.GJ4255@lukather>
References: <1425550856-12928-1-git-send-email-maxime.ripard@free-electrons.com>
 <20150319225344.GF4255@lukather> <550C28EC.2040800@linaro.org>
 <20150320205655.GJ4255@lukather>
Message-ID: <550D4B6C.2020607@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 20-03-15 21:56, Maxime Ripard wrote:
> Hi,
>
> On Fri, Mar 20, 2015 at 03:04:28PM +0100, Daniel Lezcano wrote:
>> On 03/19/2015 11:53 PM, Maxime Ripard wrote:
>>> Hi Daniel,
>>>
>>> On Thu, Mar 05, 2015 at 11:20:51AM +0100, Maxime Ripard wrote:
>>>> Hi,
>>>>
>>>> The Allwinner HS timers have the AHB clock as their parent
>>>> clock. Since this clock is shared with other devices, we could very
>>>> well have another driver requesting a rate change of that clock,
>>>> making our timer change frequency at the same time.
>>>>
>>>> This is especially true on the A31, where the DMA controller needs to
>>>> do such a rate change, making the HS timer unreliable at the time on
>>>> the A31.
>>>>
>>>> This serie makes some cleanups and implements clock notifiers to be
>>>> able to reflect such rate changes and make sure that the timer is
>>>> always working.
>>>>
>>>> Maxime
>>>>
>>>> Changes from v2:
>>>>    - Rebased on top of v4.0-rc1
>>>>    - Removed the local_irq_save/restore around clockevents_update_freq
>>>>
>>>> Changes from v1:
>>>>    - Changed the interrupt name to its previous value
>>>>
>>>> Maxime Ripard (5):
>>>>    clocksource: sun5i: Switch to request_irq
>>>>    clocksource: sun5i: Use of_io_request_and_map
>>>>    clocksource: sun5i: Remove sched_clock
>>>>    clocksource: sun5i: Refactor the current code
>>>>    clocksource: sun5i: Add clock notifiers
>>>
>>> Have these patches been merged?
>>>
>>> If not, it woulde be great if the third one ("clocksource: sun5i:
>>> Remove sched_clock") was merged for 4.0.
>>>
>>> The sched_clock we use on some system is this timer's, and since we
>>> started using cpufreq, the cpu clock (that is one of the timer's clock
>>> indirect parent) now changes, along with the actual sched_clock rate.
>>>
>>> We can safely remove the sched_clock on those systems, since we have
>>> other reliable sched_clock in the system.
>>
>> Ok, I applied the patch for v4.0-rc5 but I had to fix a conflict and change
>> the changelog.
>
> It looks fine.
>
> Note that the rest of the serie should also be merged, this is just a
> temporary measure for 4.0.
>
>> Mind to test it works ?
>>
>> git.linaro.org/people/daniel.lezcano/linux.git clockevents/v4.0-rc4
>
> Unfortunately, I won't have access to my boards for ~10 days due to
> travel to ELC. Chen-Yu, Hans, could you test this and see if it works?

I've just given this a test run on an A20 board, using the dmesg
timestamps are off reproducer discussed before, and the problem no
longer reproduces on the clockevents/4.0-rc4 branch, and everything
else still seems to work fine.

Regards,

Hans
