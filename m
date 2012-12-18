From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 18 Dec 2012 12:06:53 +0000
Subject: [RFC PATCH 0/5] clockevents: decouple broadcast mechanism from drivers
Message-ID: <1355832418-31692-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some SMP systems, cpu-local timers may stop delivering interrupts
when in low power states, or not all CPUs may have local timers. To
support these systems we have a mechanism for broadcasting timer ticks
to other CPUs. This mechanism relies on the struct
clock_event_device::broadcast function pointer, which is a
driver-specific mechanism for broadcasting ticks to other CPUs.

As the broadcast mechanism is architecture-specific, placing the
broadcast function on struct clock_event_device ties each driver to a
single architecture. Additionally the driver or architecture backend
must handle the routing of broadcast ticks to the correct
clock_event_device, leading to duplication of the list of active
clock_event_devices.

These patches introduce a generic mechanism for handling the receipt of
timer broadcasts, and an optional architecture-specific broadcast
function which allows drivers to be decoupled from a particular
architecture will retaining support for timer tick broadcasts. These
mechanisms are wired up for the arm port, and have been boot-tested on a
pandaboard.

Thanks,
Mark.

Mark Rutland (5):
  ARM: remove useless guard in smp.c
  clockevents: Add generic timer broadcast receiver
  ARM: Use generic timer broadcast receive
  clockevents: Add generic timer broadcast function
  ARM: Add generic timer broadcast support

 arch/arm/Kconfig             |    1 +
 arch/arm/kernel/smp.c        |   15 ++-------------
 include/linux/clockchips.h   |    9 +++++++++
 kernel/time/Kconfig          |    4 ++++
 kernel/time/tick-broadcast.c |   30 ++++++++++++++++++++++++++++++
 5 files changed, 46 insertions(+), 13 deletions(-)
