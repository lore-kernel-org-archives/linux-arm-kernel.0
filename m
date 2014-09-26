From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 26 Sep 2014 08:48:40 +0800
Subject: [PATCH 2/2] ARM: vf610: Use ARM Global Timer as clocksource
In-Reply-To: <87a95njqnr.fsf@nbsps.com>
References: <1410437175-6636-1-git-send-email-stefan@agner.ch>
 <1410437175-6636-2-git-send-email-stefan@agner.ch>
 <20140925075013.GD6405@dragon> <7006ad6e519c2ce3eeded54d35c87183@agner.ch>
 <87a95njqnr.fsf@nbsps.com>
Message-ID: <20140926004839.GA21077@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 06:12:24PM -0400, Bill Pringlemeir wrote:
> The global timer is based off the 133/166Mhz BUSCLK.  I think the PIT is
> also and I don't think you can clock the PIT with the 32Khz clock?  The
> ARM MPCore-A5 has this to say,
> 
>    2.4.2 Power domains
>    In addition, the SCU provides two more power domains:
> 
>    ? One for the SCU control logic and peripherals, such as the interrupt
>      controller and timer/watchdog units, V SCU.
> 
>    The separate SCU power domains can remain active even when all the
>    cores are powered down.
> 
> So, it seems that the global timer could remain powered.  However, we
> need the GPC to have the 'Global timer' as a wakeup source.  I think the
> PIT can wake the CPU via the PDB.
> 
> The Global timer may keep counting even when the Core is in some stop
> modes as long as the BUSCLK is on.  However, I don't think it can wake
> the CPU and it definitely can not run from the 32K clock which would be
> the lowest power mode.  I think only the LPTMR and the FTM support this
> clock.  The PIT seems to be as fragile as the ARM global timer, except
> for wakeups.  If the BUSCLK changes due to frequency scaling, then both
> will be affected.
> 
> The ARM global timer seems like it is more efficient to access than the
> PIT which runs through the AXI bus.  For this reason, I thought it
> should be the default.  I guess benchmarks would be nice?  At least
> Stefan's patches give this opportunity.

So it sounds like the global timer will keep counting even when ARM core
is powered down, and you're saying that ARM global timer doesn't do
anything worse than PIT and should be the default.  In that case, I'm
fine with the patch and will apply them shortly.

Shawn
