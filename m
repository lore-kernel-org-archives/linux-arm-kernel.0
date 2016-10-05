From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Wed,  5 Oct 2016 15:05:30 +0200
Subject: [PATCH 0/2] ARM: davinci: initial infrastructure for LCDC
Message-ID: <1475672732-17111-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After discussing the matter with Laurent Pinchart it turned out that
using ti,tilcdc,panel was wrong and we should go with the new
simple-vga-dac driver proposed by Maxime Ripard and currently being
reviewed.

The da850-lcdk board on which I'm working has a THS8135 video DAC for
which the new driver seems to be best suited and we'll be able to
query the connected display for supported modes instead of hardcoding
them in the dt as is needed for the panel driver.

In the meantime I'm posting two patches based on Karl Beldan's
previous work that can already be merged.

The first one adds OF_DEV_AUXDATA entry to da8xx-dt.c. I changed the
compatible string to the new one we're introducing in the tilcdc
driver.

The second adds the lcd pins and the display node to da850.dtsi. As
suggested by Sekhar: I moved the pins node, which was previously in
da850-lcdk.dts, to da850.dtsi. I also squashed Karl's two patches and
removed the panel node.

Tested on a da850-lcdk with an LCD display connected over VGA with
two patches already posted to the drm mailing list:

  drm: tilcdc: add a da850-specific compatible string
  drm: tilcdc: add a workaround for failed clk_set_rate()

and some additional work-in-progress/hacks on top of that.

Karl Beldan (2):
  ARM: davinci: da8xx-dt: add OF_DEV_AUXDATA entry for lcdc
  ARM: dts: da850: add a node for the LCD controller

 arch/arm/boot/dts/da850.dtsi     | 29 +++++++++++++++++++++++++++++
 arch/arm/mach-davinci/da8xx-dt.c |  1 +
 2 files changed, 30 insertions(+)

-- 
2.9.3
