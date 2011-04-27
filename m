From: mbohan@codeaurora.org (Michael Bohan)
Date: Wed, 27 Apr 2011 15:12:19 -0700
Subject: console_cpu_notify can cause scheduling BUG during CPU hotplug
In-Reply-To: <20110427073839.GA16718@liondog.tnic>
References: <4DB604C7.8090305@codeaurora.org>
	<BANLkTimPHaiiiVC_A6jtUtaa_pYJuhepYg@mail.gmail.com>
	<4DB65EEC.7060604@ti.com> <4DB733D4.3000002@codeaurora.org>
	<20110427073839.GA16718@liondog.tnic>
Message-ID: <4DB894C3.2040300@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/27/2011 12:38 AM, Borislav Petkov wrote:
> Great, whatever you guys come up with, we'd like to give it a run too.
> We (AMD) hit the same issue in one of our tests but in our case we end
> up in an endless loop of the state machine at stop_machine_cpu_stop()
> since the core being offlined cannot ack the state transition to
> STOPMACHINE_EXIT due to a similar reason.
>
> One possible fix is dropping CPU_DYING from console_cpu_notify()
> since it is called into by the offlining path in
> kernel/cpu.c::take_cpu_down().

This seems to be a different problem. Could you elaborate about why 
removing CPU_DYING from console_cpu_notify resolves your problem? What 
are other possible fixes?

In the failure case I witnessed, we're attempting to sleep in atomic 
mode, which is a clear violation caused by the addition of CPU_DYING. I 
haven't thoroughly investigated whether other actions in 
console_cpu_notify (eg. ONLINE, DEAD, DOWN_FAILED, UP_CANCELED) are in 
atomic mode violation as well.

Thanks,
Mike

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
