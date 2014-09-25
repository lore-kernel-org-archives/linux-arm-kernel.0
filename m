From: bpringlemeir@nbsps.com (Bill Pringlemeir)
Date: Thu, 25 Sep 2014 18:12:24 -0400
Subject: [PATCH 2/2] ARM: vf610: Use ARM Global Timer as clocksource
References: <1410437175-6636-1-git-send-email-stefan@agner.ch>
 <1410437175-6636-2-git-send-email-stefan@agner.ch>
 <20140925075013.GD6405@dragon>
 <7006ad6e519c2ce3eeded54d35c87183@agner.ch>
Message-ID: <87a95njqnr.fsf@nbsps.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 Sep 2014, stefan at agner.ch wrote:

> Am 2014-09-25 09:50, schrieb Shawn Guo:
>> On Thu, Sep 11, 2014 at 02:06:15PM +0200, Stefan Agner wrote:
>>> Use ARM Global Timer as clocksource instead of the PIT timer. This
>>> leaves the PIT timer for other users e.g. the secondary Cortex-M4
>>> core. Also, the Global Timer has double the precission (running at
>>> pheripheral clock compared to IPG clock) and a 64-bit incrementing
>>> counter register.

>> I just think of one thing.  Will this change cause a problem of the
>> low power idle support in case we want to power down ARM core in
>> there?

> I'm not sure what really happend to the Global Timer when we power
> down the ARM core. We use a clocksoure of different power domain now,
> so it might make a difference in low power modes, but I think it will
> improve things: The PIT timer's clock currently have been clock gated
> even in STOP mode, which does not power down the ARM core. And it
> would be shut down completely in LP-Mode 1-3 which since PIT is part
> of the big power domain 1.

> But AFAIK, its not required that the clocksource is running while in
> low power modes. The time should just not jump, and if the timers
> registers are lost during suspend, a proper suspend/resume support
> need to be implemented.

The global timer is based off the 133/166Mhz BUSCLK.  I think the PIT is
also and I don't think you can clock the PIT with the 32Khz clock?  The
ARM MPCore-A5 has this to say,

   2.4.2 Power domains
   In addition, the SCU provides two more power domains:

   ? One for the SCU control logic and peripherals, such as the interrupt
     controller and timer/watchdog units, V SCU.

   The separate SCU power domains can remain active even when all the
   cores are powered down.

So, it seems that the global timer could remain powered.  However, we
need the GPC to have the 'Global timer' as a wakeup source.  I think the
PIT can wake the CPU via the PDB.

The Global timer may keep counting even when the Core is in some stop
modes as long as the BUSCLK is on.  However, I don't think it can wake
the CPU and it definitely can not run from the 32K clock which would be
the lowest power mode.  I think only the LPTMR and the FTM support this
clock.  The PIT seems to be as fragile as the ARM global timer, except
for wakeups.  If the BUSCLK changes due to frequency scaling, then both
will be affected.

The ARM global timer seems like it is more efficient to access than the
PIT which runs through the AXI bus.  For this reason, I thought it
should be the default.  I guess benchmarks would be nice?  At least
Stefan's patches give this opportunity.

Fwiw,
Bill Pringlemeir.
