From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Thu,  9 Aug 2018 18:52:12 +0200
Subject: [PATCH 0/5] Set max rate for video PLLs
Message-ID: <20180809165217.30680-1-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series implement maximum rate constraint for video PLLs,
because it is possible to set higher PLL rate that is actually
supported in HW.

Issue became apparent when user reported non-working monitor connected
to board with H5 SoC. Native monitor resolution in this case was
2560x1080, with 185580 kHz pixel clock. Clock subsystem found out that
best matching pixel clock can be generated if video PLL is set to 2040
MHz, which is way out of specs for PLL. With this patch series applied,
everything worked just fine, with slightly higher rate error, but within
working limits for PLL and HDMI.

I'm not sure if "Fixes" tag should be added. It solves real world
problem, but there was nothing wrongly implemented, just upper limit
is missing.

While user reported that these patches solve the issue on H5, I added
similar fixes for other SoCs too. Since I don't have such monitor,
I only tested if board boots up and if HDMI works (H3, R40 and A83T).

Jernej Skrabec (5):
  clk: sunxi-ng: Add maximum rate constraint to NM PLLs
  clk: sunxi-ng: h3/h5: Add max. rate constraint to pll-video
  clk: sunxi-ng: r40: Add max. rate constraint to video PLLs
  clk: sunxi-ng: nkmp: Add constraint for maximum rate
  clk: sunxi-ng: a83t: Add max. rate constraint to video PLLs

 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c |  2 ++
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c   | 25 ++++++-------
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c  | 52 +++++++++++++--------------
 drivers/clk/sunxi-ng/ccu_nkmp.c       |  7 ++++
 drivers/clk/sunxi-ng/ccu_nkmp.h       |  1 +
 drivers/clk/sunxi-ng/ccu_nm.c         |  7 ++++
 drivers/clk/sunxi-ng/ccu_nm.h         | 30 ++++++++++++++++
 7 files changed, 86 insertions(+), 38 deletions(-)

-- 
2.18.0
