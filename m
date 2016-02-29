From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Mon, 29 Feb 2016 15:48:36 -0500
Subject: [PATCH 0/8] drivers/pinctrl: remove truly orphaned module code
Message-ID: <1456778924-20730-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of commits is a part of a larger project to ensure
people don't reference modular support functions in non-modular
code.  Overall there was roughly 5k lines of dead code in the
kernel due to this.  So far we've fixed several areas, like tty,
x86, net, ... and we continue to work on other areas.

There are several reasons to not use module support for code that
can never be built as a module, but the big ones are:

 (1) it is easy to accidentally write unused module_exit and remove code
 (2) it can be misleading when reading the source, thinking it can be
     modular when the Makefile and/or Kconfig prohibit it
 (3) it requires the include of the module.h header file which in turn
     includes nearly everything else, thus adding to CPP overhead.
 (4) it gets copied/replicated into other code and spreads like weeds.

This group represents roughly 1/2 of the pinctrl commits I've got under
testing locally.  The commonality within this group is that there should
be zero runtime changes with this series, because none of the drivers
here deployed a ".remove" field which in turn would cause me to add the
".suppress_bind_attrs = true," to the driver struct.  Similarly there is
no change in the initcall ordering either.

So hopefully with that in mind it eases review.

I'm happy to have this go in via the maintainer's tree and reduce the
(large) number of patches I'm carrying locally.
---

Cc: Antoine Tenart <antoine.tenart@free-electrons.com>
Cc: Beniamino Galvani <b.galvani@gmail.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Carlo Caione <carlo@endlessm.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Hongzhou Yang <hongzhou.yang@mediatek.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Vishnu Patekar <vishnupatekar0510@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-gpio at vger.kernel.org
Cc: linux-mediatek at lists.infradead.org
Cc: linux-renesas-soc at vger.kernel.org
Cc: linux-samsung-soc at vger.kernel.org


Paul Gortmaker (8):
  drivers/pinctrl: sunxi/pinctrl-sunxi.c does not need module.h
  drivers/pinctrl: make mediatek/pinctrl-mt6397 driver explicitly non-modular
  drivers/pinctrl: make meson/pinctrl-meson.c explicitly non-modular
  drivers/pinctrl: make sh-pfc/core.c explicitly non-modular
  drivers/pinctrl: make stm32/pinctrl-stm32f429.c explicitly non-modular
  drivers/pinctrl: make sunxi/pinctrl-sun[4-9]* explicitly non-modular
  drivers/pinctrl: make sunxi/pinctrl-sun9i-a80-r.c explicitly non-modular
  drivers/pinctrl: clean up samsung modular vs. non-modular distinctions

 drivers/pinctrl/mediatek/pinctrl-mt6397.c    | 10 ++--------
 drivers/pinctrl/meson/pinctrl-meson.c        |  8 +-------
 drivers/pinctrl/samsung/pinctrl-exynos.c     |  1 -
 drivers/pinctrl/samsung/pinctrl-exynos5440.c | 15 +++------------
 drivers/pinctrl/samsung/pinctrl-s3c24xx.c    |  2 +-
 drivers/pinctrl/samsung/pinctrl-s3c64xx.c    |  2 +-
 drivers/pinctrl/samsung/pinctrl-samsung.c    | 12 +-----------
 drivers/pinctrl/sh-pfc/core.c                | 18 ++++--------------
 drivers/pinctrl/stm32/pinctrl-stm32f429.c    |  9 +--------
 drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c    |  9 ++-------
 drivers/pinctrl/sunxi/pinctrl-sun5i-a10s.c   |  9 ++-------
 drivers/pinctrl/sunxi/pinctrl-sun5i-a13.c    |  9 ++-------
 drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c  | 10 ++--------
 drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c    |  9 ++-------
 drivers/pinctrl/sunxi/pinctrl-sun6i-a31s.c   |  9 ++-------
 drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c    |  9 ++-------
 drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c  | 11 ++---------
 drivers/pinctrl/sunxi/pinctrl-sun8i-a23.c    | 10 ++--------
 drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c    |  9 ++-------
 drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c  |  9 ++-------
 drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c    |  9 ++-------
 drivers/pinctrl/sunxi/pinctrl-sunxi.c        |  2 +-
 22 files changed, 39 insertions(+), 152 deletions(-)

-- 
2.6.1
