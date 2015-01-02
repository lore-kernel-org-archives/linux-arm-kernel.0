From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 2 Jan 2015 18:14:24 +0000
Subject: [PATCH 0/4] mmc: core: Add support for MMC power sequences
In-Reply-To: <1420215248-20650-1-git-send-email-ulf.hansson@linaro.org>
References: <1420215248-20650-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20150102181423.GS11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 02, 2015 at 05:14:04PM +0100, Ulf Hansson wrote:
> To be able to handle these SOC specific power sequences, we add a MMC power
> sequence interface, which helps the mmc core to deal with such.

I think this should be done differently - part of that is with hind sight
given that we now have a range of interface types.

One of my early design mistakes with MMC was to incorporate the power up
and initialisation protocol (the 74 clocks business) into the core code.
This was wrong, because it is a detail which only applies to dumb host
interfaces.  More inteligent interfaces do not need that complexity as
they handle that in hardware.

Rather than MMC ending up with more layers and more infrastructure like
this - turning it more into the turd which is sdhci - I would like to see
some proper thought put into design, specifically addressing the above
design issue.

What should be done is to move away from the opaque "set_ios" method into
something more appropriate - a set of callbacks which describe what we
want to achieve.

In the case of power up, there should be a single call into the host
controller code which is responsible for initiating the power up
sequence, and waits for the power up sequence to complete.  In other
words, most of mmc_power_up() should be moved to a library function,
which dumb host adapters hook into the "power up" method.  More
inteligent adapters (eg, PXA, sdhci) can add their own hook which poke
the hardware and return when the hardware has completed its power up
sequence.

That avoids the "mmc_delay(10)" for inteligent adapters where these
delays are not required - which presumably also are not required if some
special power up sequence for eMMC is required.

The same thing goes for this "powerseq" stuff - all you're doing is
propagating the same design mistake (with the POWER_UP/POWER_ON etc
details) into it.  That shouldn't be the case - think about the dumb
powerup method I described above vs the inteligent method - these are
two separate powerup methods, and should be implemented as such.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
