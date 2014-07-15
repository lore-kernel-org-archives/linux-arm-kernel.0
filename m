From: skannan@codeaurora.org (Saravana Kannan)
Date: Tue, 15 Jul 2014 15:47:51 -0700
Subject: [PATCH v3 0/2] Simplify hotplug/suspend handling
In-Reply-To: <1405052287-4744-1-git-send-email-skannan@codeaurora.org>
Message-ID: <1405464473-3916-1-git-send-email-skannan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Series of patchs to simplify policy/sysfs/kobj/locking handling across
suspend/resume

The following have been tested so far on a 2x2 cluster environment:
- Boot with 2 cpus and no cpufreq driver.
- mod probe driver and see cpufreq sysfs files show up only for the 1st cluster.
- Online the rest of the 2 CPUs and have files show up correctly.
- rmmod the driver and see the files go away.
- modprobe again (or back and forth multiples times) and see it work.
- suspend/resume works as expected.
- When a cluster is offline, all read/writes to its sysfs files return an error

Saravana Kannan (2):
  cpufreq: Don't destroy/realloc policy/sysfs on hotplug/suspend
  cpufreq: Simplify and fix mutual exclusion with hotplug

 drivers/cpufreq/cpufreq.c | 432 ++++++++++++++--------------------------------
 1 file changed, 127 insertions(+), 305 deletions(-)

-- 
1.8.2.1

The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
