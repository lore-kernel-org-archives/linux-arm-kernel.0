From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  8 Mar 2012 22:42:27 +0100
Subject: [RFC] i.MX: drop secondary clocks
Message-ID: <1331242949-22780-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

On i.MX we currently have grouped clocks, also known as secondary clocks.
These are clocks that get enabled when the primary clock gets enabled.  This
doesn't integrate well into the generic clock framework. Also we often return
the rate of one clock and really enable/disable another clock. I plan to get
rid of these clocks by exposing the individual clocks to the drivers. The
following is meant as an example how this can be done. I have a more complete
series internally but this conflicts with Richards clk_prepare series.

Thanks to the nature of clk_get we can simply clk_get the individual clocks in
the drivers and the current clock implementation will always return the one
with con_id = NULL. Then with the generic clk implementation the drivers will
finally get the individual clocks.

So unless there are objections I will follow up on this after the next merge
window.

Sascha

----------------------------------------------------------------
Sascha Hauer (2):
      clk: Add helper to get/put arrays of clocks
      spi i.MX: do not depend on grouped clocks

 drivers/clk/clkdev.c  |   36 ++++++++++++++++++++++++++++++++++++
 drivers/spi/spi-imx.c |   30 ++++++++++++++++++++----------
 include/linux/clk.h   |    3 +++
 3 files changed, 59 insertions(+), 10 deletions(-)
