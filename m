From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Jun 2014 15:22:31 +0100
Subject: [PATCH 0/7] Kirkwood ASoC updates
Message-ID: <20140626142231.GR32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

Here are a set of patches I've had for a while as part of my DPCM work.
I think it's worth getting these merged.

The first patch fixes a bug at ASoC level with debugfs handling - it is
not permitted to create more than one debugfs directory with the same
name in the same parent directory - and this can happen when the dummy
platform and codec are used.

The second patch adds a helper definition to handle both I2S and SPDIF
bits in the RECCTL register in the same way that we already do with the
PLAYCTL register.

Patch 3 fixes the RECCTL enable masking - we would accumulate enable bits
but never clear any of them.

Patch 4 makes the driver's handling of the PLAYCTL register slightly more
conformant to the documentation - which requires that the appropriate mute
bits are set while the respective output interface is disabled.

Patch 5 updates my previous attempt to properly fix this.  The previous
attempt did stop things going wrong from the hardware perspective, but
we are left with the occasional stuck-busy.  Although that was harmless,
this patch stops this occuring in addition to the previous fix.

Patch 6 lifts some of the driver restrictions on the period size and
number of periods - there's no reason to restrict these values, so
let's give userspace more flexibility.

Patch 7 adds NO_PERIOD_WAKEUP support for kirkwood, permitting
interrupt-less operation.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
