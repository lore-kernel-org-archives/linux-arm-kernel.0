From: leo.yan@linaro.org (Leo Yan)
Date: Wed, 23 Aug 2017 15:23:18 +0800
Subject: [PATCH] doc: coresight: correct usage for '/dev/cpu_dma_latency'
Message-ID: <1503472998-9009-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

This patch also corrects the description when set latency = 0uS, in
this case the idle state0 still can be selected by CPUIdle governor so
this means on ARM platform the 'WFI' state is still enabled, but all
other deeper states have been disabled so CPUs will not be powered off.

Cc: Kim Phillips <kim.phillips@arm.com>
Reported-by: Kim Phillips <kim.phillips@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 Documentation/trace/coresight-cpu-debug.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/coresight-cpu-debug.txt b/Documentation/trace/coresight-cpu-debug.txt
index b3da1f9..17ff8ed 100644
--- a/Documentation/trace/coresight-cpu-debug.txt
+++ b/Documentation/trace/coresight-cpu-debug.txt
@@ -150,8 +150,10 @@ If you want to limit idle states at boot time, you can use "nohlt" or
 At the runtime you can disable idle states with below methods:
 
 Set latency request to /dev/cpu_dma_latency to disable all CPUs specific idle
-states (if latency = 0uS then disable all idle states):
-# echo "what_ever_latency_you_need_in_uS" > /dev/cpu_dma_latency
+states (if latency = 0uS then CPU Idle governor selects idle state0, so this
+means 'WFI' is still enabled but other deeper states have be disabled, this
+can avoid power off CPUs):
+# exec 3<> /dev/cpu_dma_latency; echo "what_ever_latency_you_need_in_uS" >&3
 
 Disable specific CPU's specific idle state:
 # echo 1 > /sys/devices/system/cpu/cpu$cpu/cpuidle/state$state/disable
-- 
2.7.4
