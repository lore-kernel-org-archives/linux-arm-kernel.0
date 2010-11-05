From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Thu, 04 Nov 2010 21:08:35 -0700
Subject: ARM stacktrace and SMP
Message-ID: <4CD38343.8080406@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am looking at the stacktrace support on arm, namely with respect to its
support for SMP. I'm curious as to what is different between the ARM support
and the support on other platforms.

I found this quote from Russell:
 >This is unsafe on SMP - 'tsk == current' has no meaning where SMP systems
 >are concerned - the fact that tsk is not current does not mean that it
 >isn't running on another CPU.
 >
 >Basically, if a thread is running on a CPU, thread_saved_fp() is invalid.
 >
 >So, the question is: what guarantees do we have here that 'tsk' is not
 >running on another CPU?

What harm can come from using an invalid thread_saved_fp()? Is there any
possibility that attempting to unwind a process stack with an invalid frame
pointer could cause a system crash, or will it just return garbage stack
frames?  Do other platforms simply ignore this issue? We are interested in
dumping stack trace data for all processes when our target crashes, so
even potentially inaccurate data is better than nothing.

As far as actually fixing it is concerned, is there a way to stop a given
task from being scheduled, or wait until it is descheduled if it is running?
I didn't see anything like that at first glance, other than stop_machine
which is rather heavy-handed.

-Jeff

-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
