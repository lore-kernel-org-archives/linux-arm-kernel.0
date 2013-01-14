From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 14 Jan 2013 17:05:20 +0000
Subject: [PATCHv3 0/4] clockevents: decouple broadcast mechanism from drivers
Message-ID: <1358183124-28461-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is an updated version of the series I posted earlier this month:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/140528.html

The core patches can be found at:
git://linux-arm.org/linux-mr.git tags/timer-broadcast-v3-core

And the full series can be found at:
git://linux-arm.org/linux-mr.git tags/timer-broadcast-v3-arm

Changes since v2:
* Add evt->event_handler check in tick_receive_broadcast
* Remove tick_receive_broadcast stub for !GENERIC_CLOCKEVENTS_BROADCAST
* #ifdef IPI_TIMER handler for unexpected IPI warning
* Reorder patches (generic first, then arm implementation)
Changes since v1:
* Drop removal of guards in smp.c
* Removed useless evt->evt_handler check in tick_receive_broadcast
* Fix up tick_receive_broadcast when !GENERIC_CLOCKEVENTS_BROADCAST
* Fix checkpatch issues (multi-line strings)

Thanks to Stephen Boyd, Santosh Shilimkar, and Thomas Gleixner for their
commments.

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

Mark Rutland (4):
  clockevents: Add generic timer broadcast receiver
  clockevents: Add generic timer broadcast function
  arm: Use generic timer broadcast receiver
  arm: Add generic timer broadcast support

 arch/arm/Kconfig             |    1 +
 arch/arm/kernel/smp.c        |   13 ++++---------
 include/linux/clockchips.h   |    9 +++++++++
 kernel/time/Kconfig          |    4 ++++
 kernel/time/tick-broadcast.c |   28 ++++++++++++++++++++++++++++
 5 files changed, 46 insertions(+), 9 deletions(-)
