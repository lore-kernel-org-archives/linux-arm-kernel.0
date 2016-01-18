From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 18 Jan 2016 14:28:48 +0000
Subject: [PATCH 0/3] clk: Add support for critical clocks
Message-ID: <1453127331-20616-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some platforms contain clocks which if gated, will cause undefined or
catastrophic behaviours.  As such they are not to be turned off, ever.
Many of these such clocks do not have devices, thus device drivers
where clocks may be enabled and references taken to ensure they stay
enabled do not exist.  Therefore, we must handle these such cases in
the core.

This patchset defines an CLK_IS_CRITICAL flag which the core can use
to identify critical clocks and subsequently refuse to gate them.
Once a clock has been recognised as critical, we take extra
references to ensure the continued functionality of the clock
whatever else happens.

Mike,

It's been 17 weeks since our meeting in San Francisco and I'm keen to
move this forward.  As per our meeting, the plan is to separate our
two requirements, as users who require both critical clocks AND the
hand-off feature do not currently exist.  If you'd like to continue
enablement of the hand-off functionality you were interested in, I'll
continue on with critical clocks, as we still need this for our
platform.

I'm hoping this isn't the wrong approach, but if it is, let me know
how it can be improved and I'll re-roll.

Kind regards,
Lee

Lee Jones (3):
  clk: Allow clocks to be marked as CRITICAL
  clk: WARN_ON about to disable a critical clock
  clk: Provide OF helper to mark clocks as CRITICAL

 drivers/clk/clk.c            | 13 ++++++++++++-
 include/linux/clk-provider.h | 23 +++++++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

-- 
1.9.1
