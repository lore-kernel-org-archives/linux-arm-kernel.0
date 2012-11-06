From: smuckle@codeaurora.org (Steve Muckle)
Date: Tue, 06 Nov 2012 12:24:20 -0800
Subject: ARM: idle sleep time for hotplugged cpu
In-Reply-To: <20121105091533.GB28327@n2100.arm.linux.org.uk>
References: <50973842.9010708@codeaurora.org>
 <20121105091533.GB28327@n2100.arm.linux.org.uk>
Message-ID: <509971F4.4060604@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/12 01:15, Russell King - ARM Linux wrote:
> On Mon, Nov 05, 2012 at 09:23:38AM +0530, Taniya Das wrote:
>> I was looking at the arch/arm/process.c:cpu_die, I was wondering why we
>> do not exit from NOHZ for a hotplugged/offline cpu?
> 
> Offlined CPUs are not supposed to just 'return' from cpu_die(), and
> in actual fact they can't.

Although an offline CPU will not come back into the idle thread by
returning from cpu_die(), I believe the question about exiting nohz mode
before cpu_die() still stands.

>From arch/arm/process.c:cpu_idle() it appears a CPU could enter
pm_idle() for a while (in nohz mode), then execute the inner loop again
and call cpu_die(). Is there the potential for cpu idle time accounting
to get messed up here by not exiting nohz mode prior to the cpu dying,
so that missed ticks from nohz are properly accounted for?

thanks,
Steve

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
