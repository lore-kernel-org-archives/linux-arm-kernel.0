From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Mon, 19 Jun 2017 11:36:19 +0200
Subject: [PATCH v2 0/3] rtc: make st-lpc robust against y2038/2106 bug
Message-ID: <1497864982-29284-1-git-send-email-benjamin.gaignard@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 32bits platforms "struct timeval" or "time_t" are using u32 to code the
date, this cause tools like "date" or "hwclock" failed even before setting
the RTC device if the date is superior to year 2038 (or 2106).

To avoid this problem I add one RTC test file which directly use RTC ioctl
to set and read RTC time and alarm values.
rtctest_setdate allow to set any date/time given in the command line.

On this version 2 I add check of problematics years in rtctest like suggest
by Alexandre.

Finally that had allowed me to test and fix rtc-st-lpc driver.

Benjamin Gaignard (3):
  tools: timer: add rtctest_setdate
  tool: timer: rtctest add check for problematic dates
  rtc: st-lpc: make it robust against y2038/2106 bug

 drivers/rtc/rtc-st-lpc.c                         |  19 ++--
 tools/testing/selftests/timers/Makefile          |   2 +-
 tools/testing/selftests/timers/rtctest.c         | 121 ++++++++++++++++++++++-
 tools/testing/selftests/timers/rtctest_setdate.c |  86 ++++++++++++++++
 4 files changed, 212 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/timers/rtctest_setdate.c

-- 
1.9.1
