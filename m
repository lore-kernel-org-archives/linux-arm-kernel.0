From: mboards@prograde.net (Michael Cashwell)
Date: Tue, 26 Oct 2010 13:06:36 -0400
Subject: PXA270 Random Hangs at Low Core Freq
In-Reply-To: <AANLkTi=Y-JYQ_eZ4EdNirPrm_xkiduSZP19BPWckP2iW@mail.gmail.com>
References: <471CD45F-4531-4C87-B292-411CE519D0A5@prograde.net>
	<201010220222.36285.marek.vasut@gmail.com>
	<AANLkTim0yMQbMkP7eke3A18TqwuyFz2DvaYoO8bN7o-9@mail.gmail.com>
	<A257B8DC-1E93-4888-AA57-AB9A41AF11AA@prograde.net>
	<AANLkTi=Y-JYQ_eZ4EdNirPrm_xkiduSZP19BPWckP2iW@mail.gmail.com>
Message-ID: <A6E7D305-39A1-42B3-8A2B-0D2CDBBE5EEE@prograde.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Oct 25, 2010, at 3:22 PM, Eric Miao wrote:

> Several suggestions:
> 
> 1) Check the status of the CPU frequency related registers, e.g. CCCR, CCLKCFG and so on

OK. I've decomposed those in the past but here's what I presently am using with CPUfreq disabled:

CCSR: 30000190, MDREFR: 200fc031, CLKCFG: 0000000b
Run Mode clock: 208.00MHz (*16)
Turbo Mode clock: 312.00MHz (*1.5, active)
Half-Turbo Mode clock: 156.00MHz (*3, inactive)
Memory clock: 208.00MHz
System bus clock: 208.00MHz 
SD clock 0: disabled
SD clock 1: 104.00MHz 
SD clock 2: 104.00MHz 
SD clock 3: disabled

It's worth noting that all of these are set by the bootloader and if CPUfreq is disabled I think the kernel leaves them alone. (This is ignoring the code paths for suspend/resume. My kernel does not use these as the concept of suspend does not apply to our application.)

> 2) Check the HW - like external power/voltage changes happen when switching frequencies?

Trying to investigate the problem along these lines is precisely why I have disabled CPUfreq and the voltage regulators yet the hangs still happen. (All that's needed is to be running at 312MHz or less.) So whatever is happening is not due to *changing* the core frequency or voltage.

Voltage slewing is an area I had been working on. The TPS65023 driver has some problems (like failing to actually command a voltage change!). I'm going to submit patches for this but it's not involved in the problem it's disabled in my kernel config. The Verdex Pro PMIC is strapped to come out of reset at a core voltage of 1.55VDC (verified on a scope). That's high enough to support all core speeds.

> 3) If by any chance it's a fake hang, try SysRq ...

That's on and when running normally a "break-t" shows me all thread states as expected. When hung it does nothing.

> 3) ... or JTAG hot debug to see where it is stuck exactly.

I'm using a Lauterbach PowerTrace. I can pause/run and while paused I can see memory, stacks, registers and the PXA peripherals. When it hangs the JTAG software complains that the debug port has "timed out" when I attempt to pause. No JTAG operation other than sys.down works at that point.

I'm unfamiliar with "hot debug" but if that means to logically attach to a running processor then (like SysRq) it works in general but is non-responsive when attempted on a hung CPU.

-Mike
