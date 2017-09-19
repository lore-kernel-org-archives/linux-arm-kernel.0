From: dianders@chromium.org (Douglas Anderson)
Date: Tue, 19 Sep 2017 12:56:26 -0700
Subject: [PATCH v2 0/4] phy: rockchip-typec: Set "flip" properly; some cleanups;
 fix swing
Message-ID: <20170919195630.18747-1-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When connecting to certain DP monitors it was observed that only one
of the two orientations of the type C to DP cable would work.
Debugging showed that the problem was that we needed to set the type C
"flip" state earlier.  Once we did this, problems went away.

While trying to dig into this problem and some others, I found that
the proper documentation for the Type C PHY was available to me.  This
allowed me to cleanup the magic numbers in the funtion that I was
touching and also fix a few minor issues that (luckily) haven't caused
any problems yet.

I also found that aux channel communications were flaky on some
adapters until I adjusted the voltage swing.

For this series I've added Chris Zhong's Reviewed-by tags to some of
the patches since he gave a +1 to nearly identical patches on the
Chrome OS gerrit and I didn't think he'd mind me carrying his tag.  If
folks would rather I didn't do that, please yell.

Changes in v2:
- Removed extra blank line
- Voltage swing patch new for v2.

Douglas Anderson (4):
  phy: rockchip-typec: Set the AUX channel flip state earlier
  phy: rockchip-typec: Avoid magic numbers + add delays in aux calib
  phy: rockchip-typec: Do the calibration more correctly
  phy: rockchip-typec: Don't set the aux voltage swing to 400 mV

 drivers/phy/rockchip/phy-rockchip-typec.c | 246 ++++++++++++++++++++++++------
 1 file changed, 201 insertions(+), 45 deletions(-)

-- 
2.14.1.690.gbb1197296e-goog
