From: frank.rowand@am.sony.com (Frank Rowand)
Date: Tue, 4 Dec 2012 20:47:22 -0800
Subject: [PATCH RT 0/2][RFC] fix RCU stall warning on ARM
Message-ID: <50BED1DA.7070907@am.sony.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RCU stall warning functions call trigger_all_cpu_backtrace()
to print a backtrace on each cpu.  This function is only
implemented for x86.  Add a version for ARM.

With CONFIG_PREEMPT_RT_FULL enabled, flushing the output from
printk() is inhibited in some contexts to avoid increasing
real time latencies.  The RCU stall warnings are inhibited
on ARM due to this feature.  (I have not tested whether this
is also the case on other architectures.)  Add back the
oops_in_progress flag to allow the RCU stall warnings to
print immediately.

A third patch contains test scaffolding to force the stall
warnings to occur so that the other patches can be tested.
The third patch should __not__ added to the mainline
RT PREEMPT patch tree.

These patches apply to 3.6.7-rt18.  They do not apply
cleanly to 3.0.xx.
