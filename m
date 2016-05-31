From: holgerschurig@gmail.com (Holger Schurig)
Date: Tue, 31 May 2016 09:40:29 +0200
Subject: [BUG] CONFIG_UNINLINE_SPIN_UNLOCK important for Cortex-A9
Message-ID: <874m9eoetu.fsf@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I chased a bug in the recent weeks that seems to be related to spinlocks.



Hardware & Kernel config
------------------------
I have an i.MX6Q device. I don't use "make imx_v6_v7_defconfig", but
selected only what I need. As such, I only have CONFIG_ARCH_MXC and
CONFIG_SOC_IMX6Q enabled.

As a result, in my kernel CONFIG_UNINLINE_SPIN_UNLOCK was *not* defined.

In a kernel configured with "make imx_v6_v7_defconfig" this is
configured. And so people (e.g. the Freescale/NPX people) that normally
use this defconfig will never see the issue.



Reproduction
------------
There is a test tool called "stress-ng" in Debian, already compiled for
armhf.

If you run "stress-ng --sock 5 --timeout 999999" then you'll get weird
errors within 1 ... 30 hours. It's always some kernel OOPS, and
differing. Usually it's in the network stack, but not always. At it's
core the skb's seem to be inconsistent. I can submit oops logs if you
want.

This stress-ng starts 5 unix domain listeners, and 5 unix domain senders
(and one manager process). They send and receive at full speed. If you
run top, you see that on a 4 core system they eat 79% of system time on
each processor.

My assumption is that those processes fight over the list head of the
skb list and use therefore heavily spinlocks.



Cure
----
When I turned on CONFIG_PROVE_RCU the issue stopped. This option does
"select UNINLINE_SPIN_UNLOCK", and this uninline option is also selected
with the imx_v6_v7_defconfig. I actually don't care if RCUs are proven
or not, this just turns on the uninlining as a side-effect.



Question
--------
I don't have the slightest idea what produces the error and why
uninlining helps (I'm not deep in such internals), so I wonder how to
proceed.

Should I simply send in a patch that "select UNINLINE_SPIN_UNLOCK" on
i.MX6Q ???
