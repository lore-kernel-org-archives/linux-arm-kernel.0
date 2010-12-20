From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 20 Dec 2010 14:20:29 -0800
Subject: [PATCHv4 0/4] ARM: Fixing udelay() for SMP and non-SMP systems
Message-ID: <1292883633-19553-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches fix the udelay() issue pointed out on
arm-lkml[1][2]. A quick recap: some SMP machines can scale
their CPU frequencies independent of one another. loops_per_jiffy
is calibrated globally and used in __const_udelay(). If one CPU
is running faster than what the loops_per_jiffy is calculated
(or scaled) for, udelay() will be incorrect and not wait long
enough (or too long). A similar problem occurs if the cpu
frequency is scaled during a udelay() call.

We could fix this issue a couple ways, wholesale replacement
of __udelay() and __const_udelay() (see [2] for that approach),
or replacement of __delay() (this series). Option 1 can fail if
anybody uses udelay() before memory is mapped and also duplicates
most of the code in asm/delay.h. It also needs to hardcode the
timer tick frequency, which can sometimes be inaccurate. The
benefit is that loops_per_jiffy stays the same and thus BogoMIPS
is unchanged.  Option 2 can't fail since the __delay() loop is
replaced after memory is mapped in, but it suffers from a low
BogoMIPS when timers are clocked slowly. It also more accurately
calculates the timer tick frequency through the use of
calibrate_delay_direct().

-- Reference --
[1] http://article.gmane.org/gmane.linux.kernel/977567
[2] http://article.gmane.org/gmane.linux.ports.arm.kernel/78496 

Changes since v3:
 * Inlined set_delay_fn()

Changes since v2:
 * Additional patch using the timer based delay

Changes since v1:
 * likely() in delay.c
 * comment fixup for read_current_timer_delay_loop()
 * cosmetic improvements to commit text

Stephen Boyd (4):
  ARM: Translate delay.S into (mostly) C
  ARM: Allow machines to override __delay()
  ARM: Implement a timer based __delay() loop
  msm: timer: Migrate to timer based __delay()

 arch/arm/include/asm/delay.h           |   11 ++++-
 arch/arm/kernel/armksyms.c             |    4 --
 arch/arm/lib/delay.S                   |   65 -------------------------
 arch/arm/lib/delay.c                   |   81 ++++++++++++++++++++++++++++++++
 arch/arm/mach-msm/include/mach/timex.h |    1 +
 arch/arm/mach-msm/timer.c              |   16 ++++++-
 6 files changed, 107 insertions(+), 71 deletions(-)
 delete mode 100644 arch/arm/lib/delay.S
 create mode 100644 arch/arm/lib/delay.c

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
