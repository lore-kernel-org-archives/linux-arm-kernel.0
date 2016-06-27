From: dianders@chromium.org (Douglas Anderson)
Date: Mon, 27 Jun 2016 10:39:24 -0700
Subject: [PATCH 0/3] mmc: Fixes for 150 MHz Rockchip eMMC series
Message-ID: <1467049167-14628-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Despite positive testing across a number of machines and a number of
people, last week I got a report that my 150 MHz series was breaking
things on a handful of boards.

It turns out that reverting the patch to always power cycle across clock
changes fixes things and reverting that patch also doesn't actually
cause any known problems (and 150 MHz should even continue to work).

Although we really need to get to the bottom of things, it seems
expedient to revert while we're waiting for a better solution, hence
this series.  Also in this series is further increase in the time we'll
wait for the DLL to stabilize (found during reboot stress testing) and a
fix to the way we handle the card clock being reported as 0 (needed for
suspend/resume because of the revert we just did).

It's expected that this series could go through Ulf's mmc tree (like the
previous) with Kishon's Ack as appropriate.


Douglas Anderson (3):
  mmc: sdhci-of-arasan: Revert: Always power the PHY off/on when clock
    changes
  phy: rockchip-emmc: Be tolerant to card clock of 0 in power on
  phy: rockchip-emmc: Wait even longer for the DLL to lock

 drivers/mmc/host/sdhci-of-arasan.c | 21 +++++++----
 drivers/phy/phy-rockchip-emmc.c    | 71 ++++++++++++++++++++++++++------------
 2 files changed, 62 insertions(+), 30 deletions(-)

-- 
2.8.0.rc3.226.g39d4020
