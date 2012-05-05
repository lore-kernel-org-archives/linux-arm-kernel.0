From: mturquette@ti.com (Turquette, Mike)
Date: Sat, 5 May 2012 10:44:17 -0700
Subject: common clock framework
In-Reply-To: <20120505082840.GQ4141@pengutronix.de>
References: <AAD1C6EB06EE3649B35B7E026785068D1A74A94270@SC-VEXCH2.marvell.com>
 <20120504082110.GB16535@pengutronix.de>
 <CAJOA=zOs8FLTRUh=LOd2f=YxFz7Sdxgp2JJurpQkdDFALcCiVw@mail.gmail.com>
 <20120505082840.GQ4141@pengutronix.de>
Message-ID: <CAJOA=zPozuanQFWt10PU4mySQ1kV+YV6iO5+BOfDWGPS2Y0aYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Mark & Graeme (for audio/pmic perspective)

On Sat, May 5, 2012 at 1:28 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Fri, May 04, 2012 at 04:08:20PM -0700, Turquette, Mike wrote:
>>
>> We are very close. ?I have been hacking on this in a private branch
>> and have converted OMAP's CPUfreq driver over to using *only* the the
>> clock framework for DVFS.
>>
>> Good news: it works! ?The CPUfreq driver's .target callback does the
>> normal rate validation and table lookup to get a good rate for the
>> CPU, then it simply calls clk_set_rate. ?The pre- and post-rate-change
>> notifiers are then fired off. ?I have added notifier handlers to the
>> OMAP regulator drivers which use a look-up-table (soon to be converted
>> to the OPP library) to determine voltage and they simply call
>> regulator_set_voltage either before or after the clock rate changes,
>> depending on scaling direction.
>>
>> Bad news: lockdep gets cranky about possible deadlocks due to holding
>> prepare_lock and then trying to hold it again in a rate-change
>> notifier handler (from OMAP's regulator code). ?Specifically
>> clk_set_rate holds prepare_lock, and then the i2c message sent to the
>> PMIC to raise voltage calls clk_prepare as part of the standard
>> messaging sequence. ?This is clearly a candidate for a deadlock.
>>
>> Having clk_set_rate and clk_prepare both hold the same prepare_lock
>> mutex seems suboptimal, but it is easy. ?Having reentrant accesses to
>> the clock tree is going to be hard... ?I've spent some time thinking
>> of ways to solve this, but I would appreciate suggestions. ?I suspect
>> the exact same case I'm describing above will affect many SoCs.
>
> That's interesting. Here's another one: What will happen when Mark
> attaches one of his i2c wolfson chips to a omap core and wants to test
> his new clock driver? a clk_prepare on some clock on the wolfson chip
> will trigger another clk_prepare inside the i2c driver.
> So the reentrancy problem is not limited to prepare vs. set_rate.
