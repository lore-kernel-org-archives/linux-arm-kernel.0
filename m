From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  1 Aug 2017 09:02:53 +0100
Subject: [PATCH v2 0/4] Working around CPU hotplug and static keys locking
Message-ID: <20170801080257.5056-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since f2545b2d4ce1 ("jump_label: Reorder hotplug lock and
jump_label_lock"), it has become impossible to switch a static key
from a CPU hotplug notifier:

- On the primary CPU, cpu_hotplug_lock is taken by
  __cpuhp_setup_state(), and then again by static_key_slow_inc(). The
  lock being taken as a reader, so it is OK so far.

- On a secondary CPU, _cpu_up takes the lock *as a writer* on the boot
  CPU, and the secondary tries to switch the static key, taking the
  lock as well (as a reader). In that case, we're toasted.

I couldn't find an elegant solution to this, so this series works
around the issue in the most disgusting way, adding a _nolock version
of the static key API to be used in CPU hotplug situations.

The last patch uses this API to work around the issue that Leo
reported, where the static key flipped on a secondary CPU brings the
box down in flames.

Marc Zyngier (4):
  jump_label: Move cpu hotplug locking
  jump_label: Split out code under the hotplug lock
  jump_label: Provide hotplug context variants
  clocksource/arm_arch_timer: Use static_branch_enable_cpuslocked()

 Documentation/static-keys.txt        | 15 ++++++++++++
 drivers/clocksource/arm_arch_timer.c |  6 ++++-
 include/linux/jump_label.h           | 11 +++++++--
 kernel/jump_label.c                  | 44 +++++++++++++++++++++++++++++++-----
 4 files changed, 67 insertions(+), 9 deletions(-)

-- 
2.11.0
