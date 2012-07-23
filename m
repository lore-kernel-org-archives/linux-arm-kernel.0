From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 23 Jul 2012 20:55:22 +0200
Subject: [RFC] ARM: sched_clock: update epoch_cyc on resume
In-Reply-To: <1342567672-29071-1-git-send-email-ccross@android.com>
References: <1342567672-29071-1-git-send-email-ccross@android.com>
Message-ID: <CACRpkdaHdCvx1HJNDsyJSZAN--sF+4-V1TbzXZL1v+7Asoe_oA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2012 at 1:27 AM, Colin Cross <ccross@android.com> wrote:

> This will have a side effect of causing SoCs that have clocks that
> continue to count in suspend to appear to stop counting, reporting the
> same sched_clock() value before and after suspend.

So for our platform (ux500) that has a sched clock that *does*
continue to run during suspend,
drivers/clocksource/clksrc-dbx500-prcmu.c
how do we opt out of this behaviour?

Since sched_clock is used for the debug prints, if we have a
crash immediately after resume() it will appear to be at resume
time in the log which kinda sucks. :-(

Isn't the proper way to do this either:

- Assign suspend/resume hooks to the sched_clock code in the
  platform and let the code that reads the hardware clock deal with
  this

Or

- If it absolutely needs to be in the core code, also have a bool
  field indicating whether the clock is going to die during suspend
  and add new registration functions for setting that sched_clock
  type, e.g. setup_sched_clock_nonsuspendable()

Yours,
Linus Walleij
