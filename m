From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 28 May 2015 20:41:45 +0200
Subject: [PATCH 0/3] clk: Add regmap support for clk mulitplexer
Message-ID: <1432838508-5184-1-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds regmap support for the simple clock multiplexer.
Regmap use, apart from a pointer to the regmap struct needs an
offset value to know where in the regmap it has to read/write.
We add both fields to struct clk_mux.

The driver will distinguish between a clock which is based on regmap or not
through a flag specified for the mux.
The approach does not break the existing clock framework API but adds two
new functions for registering regmap clocks. Unregistering the clocks is
independent of the use of regmap or not, so that no new function was
implemented.

As an example user of the regmap clock multiplexer, it was implemented on
the mt8135. When accepted it will also be applied to the other Mediatek SoCs.
Other possible user are Qualcomm SoCs which up to now implement their own
regmap based clock multiplexer.

Any comments welcome.

Matthias Brugger (3):
  clk: mux: Add regmap support for simple mux
  clk: mediatek: Add support for clk-mux using regmap
  clk: mediatek: Use regmap clk-mux for mt8135

 drivers/clk/clk-mux.c             | 103 ++++++++++++++++++++++++++++++++++----
 drivers/clk/mediatek/clk-mt8135.c |  21 +++-----
 drivers/clk/mediatek/clk-mtk.c    |  37 ++++++++++++++
 drivers/clk/mediatek/clk-mtk.h    |  26 ++++++++++
 include/linux/clk-provider.h      |  40 +++++++++++++++
 5 files changed, 202 insertions(+), 25 deletions(-)

-- 
1.9.1
