From: t.stanislaws@samsung.com (Tomasz Stanislawski)
Date: Fri, 04 Apr 2014 16:53:17 +0200
Subject: [PATCH 0/4] Update to Exynos clocks
Message-ID: <1396623201-26000-1-git-send-email-t.stanislaws@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds some updates to clocks for Exynos4 platform and to the clock
core.  The patches are rebased on linux/next.

An interesting part might be 'propagation of clk_set_parent()'.  This feature
simplifies configuration of complex topologyof clocks by drivers.  Such a
situation happens for Exynos HDMI driver.

The HDMI device is clocked by sclk_hdmi clock. In older versions of SoC and its
driver, the clock had two parent clocks: sclk_hdmiphy and sclk_pixel.
The sclk_hdmi was a gated clock.

In the recent version of Exynos clock provider this topology was slightly
changed. A new clock named mout_hdmi was introduced.  This new clock represents
the output of multiplexer that selects between sclk_hdmiphy and sclk_pixel.

After the change the sclk_hdmi is still gated but has a single parent -
mout_hdmi.

This change caused interesting situation in Exynos HDMI driver because this
driver used only sclk_hdmi.  Now clk_set_parent(sclk_hdmi, ...) fails because
sclk_hdmi has a single parent now.  Using mout_hdmi instead of sclk_hdmi will
not work because clk_enable(mout_hdmi) is not propagated to sclk_hdmi.

To solve this problem, the setup of mout_hdmi was added to Exynos HDMI in the
patch: "drm/exynos: add mout_hdmi clock in hdmi driver to change parent"

IMO, this change breaks abstraction of clock API reveling too detailed
information about clock topology to the driver.

Moreover, the driver no longer works with old DT bindings because they provide
no mout_hdmi clock.

The clock set_parent propagation can be used to fix this.  The clk_set_parent()
is propagated to a parent as long as the current clock has a single parent and
has the flag CLK_SET_PARENT_PARENT set.

Now Exynos HDMI can use only sclk_hdmi clock. The clk_enable() gates this clock
directly and clk_set_parent() is propagated to mout_hdmi.

This new behaviour does not break DT bindings because mout_hdmi would be simply
ignored.

After this change the 'add mout_hdmi clock' is no longer needed.

Regards,
Tomasz Stanislawski

Tomasz Stanislawski (4):
  clk: propagate parent change up one level
  clk: exynos4: export sclk_hdmiphy clock
  clk: exynos4: enable clk_set_parent() propagation for sclk_hdmi and
    sclk_mixer clocks
  Revert "drm/exynos: add mout_hdmi clock in hdmi driver to change
    parent"

 drivers/clk/clk.c                    |    6 ++++++
 drivers/clk/samsung/clk-exynos4.c    |    8 +++++---
 drivers/gpu/drm/exynos/exynos_hdmi.c |   14 ++++----------
 include/dt-bindings/clock/exynos4.h  |    1 +
 include/linux/clk-provider.h         |    1 +
 5 files changed, 17 insertions(+), 13 deletions(-)

-- 
1.7.9.5
