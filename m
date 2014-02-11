From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 11 Feb 2014 11:37:05 +0000
Subject: [PATCH 0/7] primecell: make correct clock parsing possible
Message-ID: <1392118632-11312-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently either the drivers for primecell peripherals and their bindings
disagree, or those bindings disagree with the primecell binding which they
derive from. It is impossible in some cases to meet the requirements of both
bindings and drivers.

These patches attempt to harmonize the bindings and the drivers with what's in
use today, in a backwards compatible fashion, relieving us of our present
Kafkaesque nightmare. Each peripheral's clock(s) are given explicit names which
can be used, though code will fall back to the existing behaviour if said names
are not provided. Additionally the currently unmet ordering requirement of
apb_pclk is dropped, given all existing that code requires this to be named
anyway.

I've used IS_ERR to test is a clock wasn't provided by name, but this isn't
always right. In the case of a dodgy clock specifier we might get an error,
even if the expected name was provided explicitly in clock-names. For that case
it would be nice to fail rather than grabbing an almost certainly incorrect
clock. I'm not entirely sure how to check for that with the current
infrastructure though, and while it's possible to use of_property_match_string
to achieve the desired effect, it feels like working around the abstraction we
have in place today.

There are some other issues in the area which remain:

* The pl041 exists in DTs, but has no binding.

* Both pl110 and pl111 have no binding, but appear to be in use on OF
  platforms, with the nspire code proving some sideband data via
  OF_DEV_AUXDATA. The driver grabs a clock (CLCDCLK) without using a name.

* I'm not sure what to do with sp804. The bindings imply a given set of names
  with a specific ordering, but all the dts do something different and the
  driver doesn't bother with names. The given binding is incompatible with the
  primecell binding's ordering requirement for apb_plck.

* There's no binding for the sp805, which grabs a clock with no name.

* There's no binding for the pl341 or pl354. Both seem to be unused yet exist
  in DTs.

* The PL330 docs don't mention clocks at all, though the apb_pclk is required.
  Use of PCLKEN isn't supported, but this doesn't seem to be a problem so far.

Thanks,
Mark.

Mark Rutland (7):
  Documentation: devicetree: fix up pl011 clocks
  serial: amba-pl011: attempt to get uartclk by name
  Documentation: devicetree: fix up pl022 clocks
  spi: pl022: attempt to get sspclk by name
  Documentation: devicetree: fix up pl18x clocks
  mmc: arm-mmci: attempt to get mclk by name
  Documentation: devicetree: loosen primecell clock requirements

 Documentation/devicetree/bindings/arm/primecell.txt | 11 ++++++-----
 Documentation/devicetree/bindings/mmc/mmci.txt      |  4 ++++
 Documentation/devicetree/bindings/serial/pl011.txt  |  6 ++++--
 Documentation/devicetree/bindings/spi/spi_pl022.txt |  2 ++
 drivers/mmc/host/mmci.c                             |  9 ++++++++-
 drivers/spi/spi-pl022.c                             |  9 ++++++++-
 drivers/tty/serial/amba-pl011.c                     |  9 ++++++++-
 7 files changed, 40 insertions(+), 10 deletions(-)

-- 
1.8.1.1
