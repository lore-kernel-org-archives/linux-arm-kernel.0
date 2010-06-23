From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 24 Jun 2010 00:24:22 +0100
Subject: clock updates
Message-ID: <20100623232422.GB16584@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've been looking into updating the current samsung socs to use
clkdev to lookup clocks. Currently we have a few issues that we
could do with sorting before running the conversion to clkdev.

Firstly, the s5pc100 has some clocks that could be merged into
common s5p, and a few which don't seem to match the others in
the s5p series.

The i2s clocks which we should look at mergining are:

i2s_cdclk<0..2>
pcm_cdclk<0..l>

also, clocks that have may need changing:

rotator	     => rot
keyif	     => keypad

this isn't an complete list, still working on the changes.

The big changes with respect to drivers is that we will now be using
clk_get(dev, NULL) to get the clock names, and any bus clocks such
as the sdhci bus clock will be updated.

The intention with both the SDHCI and the SPI is to change the clock
lookups to reflect the mux positions, so the sdhci clocks on the
s3c64xx would be changed to use the following lookups:

hsmmc	=> mux0
mmc_bus	=> mux2
48m	=> mux3

This would avoid passing the clock names through the platform data, if
the boards or the arch needs to avoid a clock, an array of clock enable
or disable bits. Any unimplemented clocks will return NULL to ensure
that they can be distinguished from a clock that isn't available.

The changes would be to remove the .name field from all the s3c struct clk,
and replace it with a pointer to a lookup (so that if the clock does not
need a name then it doesn't need a lookup).

There are also a number of clocks that probably don't need a name as they
are part of the clock heirarchy, it would be useful to have a call that
returns all possible parents of a given clock.

I'll post the script whcih runs the changes once i've finished the last
few details to show what happens.

With resepect to the clkdev clk_get() function, we may need to do a couple of
updates (ie, override it for ourselves) due to the following two problems:

1) The s3c/s5p devices change name depending on the soc they are attached
   to, which means we may need to cut the s3cxxxx- part of the device name
   off before running the lookup

2) Some of the lookups are done early for the serial driver, which means
   that the platform devices's name has not been setup, so something needs
   to be done about this.

-- 
Ben










-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
