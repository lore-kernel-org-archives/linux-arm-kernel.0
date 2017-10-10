From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 10 Oct 2017 14:32:13 -0600
Subject: [PATCH 2/2] doc: coresight: correct usage for disabling idle states
In-Reply-To: <1507667533-21707-1-git-send-email-mathieu.poirier@linaro.org>
References: <1507667533-21707-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1507667533-21707-3-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leo Yan <leo.yan@linaro.org>

In the coresight CPU debug document it suggests to use 'echo' command
to set latency request to /dev/cpu_dma_latency so can disable all CPU
idle states, but in fact this doesn't work.

This is because when the command 'echo' exits, it releases the device
node's file descriptor and the kernel release function removes the QoS
constraint; finally when the command 'echo' finished there have no
constraint imposed on cpu_dma_latency.

This patch changes to use 'exec' to access '/dev/cpu_dma_latency', the
command 'exec' can avoid the file descriptor to be closed so we can
keep the constraint on cpu_dma_latency.

This patch also adds the info for reference docs for PM QoS and cpuidle
sysfs.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Reported-by: Kim Phillips <kim.phillips@arm.com>
Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 Documentation/trace/coresight-cpu-debug.txt | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/Documentation/trace/coresight-cpu-debug.txt b/Documentation/trace/coresight-cpu-debug.txt
index b3da1f90b861..2b9b51cd501e 100644
--- a/Documentation/trace/coresight-cpu-debug.txt
+++ b/Documentation/trace/coresight-cpu-debug.txt
@@ -149,11 +149,23 @@ If you want to limit idle states at boot time, you can use "nohlt" or
 
 At the runtime you can disable idle states with below methods:
 
-Set latency request to /dev/cpu_dma_latency to disable all CPUs specific idle
-states (if latency = 0uS then disable all idle states):
-# echo "what_ever_latency_you_need_in_uS" > /dev/cpu_dma_latency
-
-Disable specific CPU's specific idle state:
+It is possible to disable CPU idle states by way of the PM QoS
+subsystem, more specifically by using the "/dev/cpu_dma_latency"
+interface (see Documentation/power/pm_qos_interface.txt for more
+details).  As specified in the PM QoS documentation the requested
+parameter will stay in effect until the file descriptor is released.
+For example:
+
+# exec 3<> /dev/cpu_dma_latency; echo 0 >&3
+...
+Do some work...
+...
+# exec 3<>-
+
+The same can also be done from an application program.
+
+Disable specific CPU's specific idle state from cpuidle sysfs (see
+Documentation/cpuidle/sysfs.txt):
 # echo 1 > /sys/devices/system/cpu/cpu$cpu/cpuidle/state$state/disable
 
 
-- 
2.7.4
