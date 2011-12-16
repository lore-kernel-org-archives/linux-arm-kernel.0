From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Fri, 16 Dec 2011 13:54:00 +0530
Subject: [PATCH v9 00/31] gpio/omap: driver cleanup and fixes
In-Reply-To: <CAMQu2gyZtuW3HLbWH5wH-YjB4SpLD9tz5kpVdRHi2j9RsXLA2w@mail.gmail.com>
References: <1323807633-23713-1-git-send-email-tarun.kanti@ti.com>
 <CAMQu2gyZtuW3HLbWH5wH-YjB4SpLD9tz5kpVdRHi2j9RsXLA2w@mail.gmail.com>
Message-ID: <CAC83ZvLYea_8u2erdKaBe+mA3unLSWuga6cdeqUvimpppT3xcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 16, 2011 at 12:58 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
> Tarun,
>
> On Wed, Dec 14, 2011 at 1:50 AM, Tarun Kanti DebBarma
> <tarun.kanti@ti.com> wrote:
>> This series is continuation of cleanup of OMAP GPIO driver and fixes.
>> The cleanup include getting rid of cpu_is_* checks wherever possible,
>> use of gpio_bank list instead of static array, use of unique platform
>> specific value associated data member to OMAP platforms to avoid
>> cpu_is_* checks. The series also include PM runtime support.
>>
>> Baseline: git://github.com/khilman/linux-omap-pm.git
>> Branch: for_3.3/gpio-base
>>
>> Baseline: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>> Branch: master
>> Commit: b835c0f
>>
>> Power Tests
>> a) OMAP3430SDP
>> - Modify board-3430sdp.c file to have multiple GPIO modules active
>> ?with debounce timeout enabled.
>> - Enable CPU-Idle
>> - Enable UART timeouts
>> - Enable offmode
>> - echo mem > /sys/power/state
>> - Verify retention and offmode count increment
>>
>> b) ZOOM3
>> - Enable CPU-Idle
>> - Enable UART timeout
>> - echo mem > /sys/power/state
>> - Wakeup system using serial keyboard
>> - Verify retention count increment
>>
>> Functional Tests
>> - Done on OMAP2430, OMAP3430SDP, ZOOM3, OMAP4430
>>
>> Bootup Test
>> - Done on OMAP1710
>>
>> v9:
>> - Summary of Comments/Issues fixed
>> ?* GPIO wakeup does not work
>> ?* Call debounce clock enable/disable functions from PM runtime callbacks.
>> ? ?This will avoid calling the functions from multiple places.
>> ?* Modify description of following patch to match latest changes.
>> ? ?gpio/omap: save and restore debounce registers
>> ?* Use (bank->regs->set_dataout && bank->regs->clr_dataout) together instead
>> ? ?of using only one of them.
>> ?* Remove cpu_is_omapxxxx() checks from set_gpio_trigger().
>> ?* _gpio_dbck_enable() in runtime callback triggered from omap_gpio_request
>> ? ?does not enable dbck because dbck_enable_mask is not set at this point.
>> ?* Workaround associated with an errata got missed in v8. This has been
>> ? ? ?included.
>>
> As reported by Kevin ( off-the list), only 25 patches out of 31
> reached to the list.
> The rest 8, for some reason didn't reached to the list.
>
> Also since you have added few additional bug fixes in this series on top of
> the v8, the v9 becomes slightly different.
>
> So here is what I suggest.
> 1. Repost your v9 only with those 25 reworked patches.
Ok.

> 2. Create a separate series for additional bug fixes which will apply on top
> of 1)
Sure.

>
> That way it's easier to line up the patches since the 25 ones have gone though
> few review cycles where as the new 8 has only gone through the internal review.
Yes, I will re-base on the mainline latest, test and re-post.
--
Tarun
>
> Regards
> Santosh
