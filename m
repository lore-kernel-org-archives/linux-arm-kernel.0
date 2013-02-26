From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 26 Feb 2013 23:17:23 +0100
Subject: [PATCH 0/4] time: dynamic irq affinity
Message-ID: <1361917047-29230-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a cpu goes to a deep idle state where its local timer is shutdown,
it notifies the time framework to use the broadcast timer instead.

Unfortunately, the broadcast device could wake up any CPU, including an
idle one which is not concerned by the wake up at all.

This implies, in the worst case, an idle CPU will wake up to send an IPI
to another idle cpu.

This patch solves this by setting the irq affinity to the cpu concerned
by the nearest timer event, by this way, the CPU which is wake up is
guarantee to be the one concerned by the next event and we are safe with
unnecessary wakeup for another idle CPU.

As the irq affinity is not supported by all the archs, a flag is needed
to specify which clocksource can handle it.

Daniel Lezcano (3):
  time : pass broadcast parameter
  time : set broadcast irq affinity
  ARM: nomadik: add dynamic irq flag to the timer

Viresh Kumar (1):
  ARM: timer-sp: Set dynamic irq affinity

 arch/arm/common/timer-sp.c        |    3 ++-
 drivers/clocksource/nomadik-mtu.c |    3 ++-
 include/linux/clockchips.h        |    1 +
 kernel/time/tick-broadcast.c      |   40 +++++++++++++++++++++++++++++--------
 4 files changed, 37 insertions(+), 10 deletions(-)

-- 
1.7.9.5
