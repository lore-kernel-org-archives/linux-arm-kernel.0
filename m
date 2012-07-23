From: ccross@android.com (Colin Cross)
Date: Mon, 23 Jul 2012 12:27:47 -0700
Subject: [RFC] ARM: sched_clock: update epoch_cyc on resume
In-Reply-To: <CACRpkdaHdCvx1HJNDsyJSZAN--sF+4-V1TbzXZL1v+7Asoe_oA@mail.gmail.com>
References: <1342567672-29071-1-git-send-email-ccross@android.com>
 <CACRpkdaHdCvx1HJNDsyJSZAN--sF+4-V1TbzXZL1v+7Asoe_oA@mail.gmail.com>
Message-ID: <CAMbhsRR2-VjUeL2XPKubeaG=iLV5NE-i_sVYbuMAryXLxsbo1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2012 at 11:55 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Wed, Jul 18, 2012 at 1:27 AM, Colin Cross <ccross@android.com> wrote:
>
>> This will have a side effect of causing SoCs that have clocks that
>> continue to count in suspend to appear to stop counting, reporting the
>> same sched_clock() value before and after suspend.
>
> So for our platform (ux500) that has a sched clock that *does*
> continue to run during suspend,
> drivers/clocksource/clksrc-dbx500-prcmu.c
> how do we opt out of this behaviour?

Does the clock you use for sched_clock continue to run in all suspend
modes?  All the SoC's I've used only have a 32kHz clock in the deepest
suspend mode, which is not ideal for sched_clock.  For example, on
Tegra2 the faster 1MHz clock used for sched_clock resets in the
deepest suspend state (LP0) but not the shallowest suspend state
(LP2), and which suspend state the chip hits depends on which hardware
is active.  Opting out of this patch would cause Tegra's clock to
sometimes run in suspend, and sometimes not, which seems worse for
debugging than consistently not running in suspend.  I'd be surprised
if a similar situation didn't apply to your platform.

> Since sched_clock is used for the debug prints, if we have a
> crash immediately after resume() it will appear to be at resume
> time in the log which kinda sucks. :-(

Most resume implementations I've seen print a resume message very
early, making it fairly easy to distinguish between suspend and resume
crashes, but I can see why an accurate timestamp would be helpful.

> Isn't the proper way to do this either:
>
> - Assign suspend/resume hooks to the sched_clock code in the
>   platform and let the code that reads the hardware clock deal with
>   this

That's effectively what I've done on 3 different platforms, which is
why I thought it might be better to put it in the core code.

> Or
>
> - If it absolutely needs to be in the core code, also have a bool
>   field indicating whether the clock is going to die during suspend
>   and add new registration functions for setting that sched_clock
>   type, e.g. setup_sched_clock_nonsuspendable()

Sounds reasonable if some platforms need the extra complexity.
