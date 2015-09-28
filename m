From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 28 Sep 2015 16:35:51 +0000 (UTC)
Subject: [PATCH v3 0/3] ARM: OMAP2+: hwmod: RTC: Add lock and unlock hooks
In-Reply-To: <56037FEA.5070807@ti.com>
References: <1437657946-10733-1-git-send-email-lokeshvutla@ti.com>
 <55DE9055.4090701@ti.com> <56037FEA.5070807@ti.com>
Message-ID: <alpine.DEB.2.02.1509280822250.7947@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 24 Sep 2015, Lokesh Vutla wrote:

> On Thursday 27 August 2015 09:51 AM, Lokesh Vutla wrote:
> > On Thursday 23 July 2015 06:55 PM, Lokesh Vutla wrote:
> >> This series implements lock and unlock functions for RTC and hooks
> >> the same to DRA7 and AMx3xx hwmod.
> >> This is dependent on the patch https://patchwork.kernel.org/patch/6578281/,
> >> which is queued recently by Paul.
> > Gentle ping on this series.
> Do you have any comments on this series?

Looks pretty good.  I'm slightly concerned about the latency jitter impact 
on -rt kernels for that local_irq_disable() section.  Looks like it could 
hold off interrupts for ~(50 udelay ?s) + 50*((RTC register read time) + 
1).  But I'm not sure if preempt_enable/disable() is a good alternative 
since a bunch of interrupt top halves could conceivably run after the RTC 
goes non-busy and result in the RTC not being locked/unlocked.  

Is there an RTC IP block register that the code can read, or a safe 
sequence that the code can execute, after the RTC lock/unlock operation to 
verify that the RTC has successfully been locked or unlocked?  If so then 
it's probably worth converting the local_irq_disable/enable() to 
preempt_disable/enable() and testing that, then retrying the lock/unlock 
if it fails.


- Paul
