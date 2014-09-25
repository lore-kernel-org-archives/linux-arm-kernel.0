From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 25 Sep 2014 23:10:14 +0800
Subject: [PATCH 2/2] ARM: vf610: Use ARM Global Timer as clocksource
In-Reply-To: <7006ad6e519c2ce3eeded54d35c87183@agner.ch>
References: <1410437175-6636-1-git-send-email-stefan@agner.ch>
 <1410437175-6636-2-git-send-email-stefan@agner.ch>
 <20140925075013.GD6405@dragon>
 <7006ad6e519c2ce3eeded54d35c87183@agner.ch>
Message-ID: <20140925151012.GI6405@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 10:25:13AM +0200, Stefan Agner wrote:
> Am 2014-09-25 09:50, schrieb Shawn Guo:
> > On Thu, Sep 11, 2014 at 02:06:15PM +0200, Stefan Agner wrote:
> >> Use ARM Global Timer as clocksource instead of the PIT timer. This
> >> leaves the PIT timer for other users e.g. the secondary Cortex-M4
> >> core. Also, the Global Timer has double the precission (running at
> >> pheripheral clock compared to IPG clock) and a 64-bit incrementing
> >> counter register.
> > 
> > I just think of one thing.  Will this change cause a problem of the low
> > power idle support in case we want to power down ARM core in there?
> > 
> 
> I'm not sure what really happend to the Global Timer when we power down
> the ARM core. We use a clocksoure of different power domain now, so it
> might make a difference in low power modes, but I think it will improve
> things: The PIT timer's clock currently have been clock gated even in
> STOP mode, which does not power down the ARM core. And it would be shut
> down completely in LP-Mode 1-3 which since PIT is part of the big power
> domain 1. 
> 
> But AFAIK, its not required that the clocksource is running while in low
> power modes. The time should just not jump, and if the timers registers
> are lost during suspend, a proper suspend/resume support need to be
> implemented. 

Sorry, I should be more specific in the first place.  What I'm concerned
is more about clockevent than clocksource.  If some day we have a
cpuidle driver for vf610, which powers off ARM core in a deep C-state,
the clockevent device will be gone as long as system enters the C-state,
and no timer interrupt can wake up the core from idle state.

Shawn
