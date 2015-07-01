From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 30 Jun 2015 20:57:45 -0500
Subject: [PATCH 1/4] hvc_dcc: bind driver to core0 for reads and writes
In-Reply-To: <5593443C.5070800@codeaurora.org>
References: <1435699387-32591-1-git-send-email-timur@codeaurora.org>
 <5593443C.5070800@codeaurora.org>
Message-ID: <55934919.8070703@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Boyd wrote:
> Maybe we should look into making the console number (i.e. ttyHVC0,
> ttyHVC1, etc.) correspond to the logical CPU number 0, 1, etc? We would
> need some hotplug notifier to tear down and restore the console when the
> CPU comes online and goes offline, but it may work out nicer than taking
> the approach this patch does.

My understanding is that Trace32 only responds to core 0 in SMP mode. 
So if CPU0 goes offline, there's no point in migrating the thread to 
another CPU, because Trace32 won't listen for it anyway.  Without this 
patch, console output is randomly scattered across CPUs because the 
put_chars call run on any CPU.  Without consolidating all console output 
to one CPU, DCC is effectively useless.

So I can make the changes you suggested, but I don't think that actually 
fixes anything.  When CPU0 goes offline, what does schedule_work_on(0, 
actually do?  If it does nothing, then the output FIFO will fill up, and 
put_chars will return 0, and that's it.

Does CPU hotplug automatically take CPUs offline when the load is low? 
If so, then then thread could randomly bounce from CPU to CPU.

Last I checked, ARM64 ACPI does not support discontiguous CPUs, so the 
boot CPU is always core "0".

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
