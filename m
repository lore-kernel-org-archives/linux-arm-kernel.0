From: wxt@rock-chips.com (Caesar Wang)
Date: Tue,  2 Feb 2016 11:33:52 +0800
Subject: [PATCH v5 0/8] Add the family patches to support for kylin board
Message-ID: <1454384032-6794-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This series patches are based on kernel 4.5-rc1 version, also
is based on Heiko's branch.
(kernel/git/mmind/linux-rockchip.git -b for-next & v4.5-clk/fixes)

e.g: boot log..
Linux version 4.5.0-rc1+ (wxt at ubuntu) ....#60 SMP Thu Jan 28 12:54:50 CST 2016

1) The kylin history series patches:

V0:
https://lkml.org/lkml/2015/12/22/168
V1:
https://lkml.org/lkml/2015/12/17/319
V2:
https://lkml.org/lkml/2016/1/7/66
V3:
http://www.spinics.net/lists/arm-kernel/msg474796.html
V4:
https://lkml.org/lkml/2016/1/28/132

This series patches are verified on the following github:
https://github.com/Caesar-github/rockchip/tree/kylin/next

This series has 8 patches: (8--->1)
c455bf5 ARM: dts: rockchip: support the spi for rk3036
41bbd5d ASoC: rt5616: add the mclk for the codec driver
6ee2dc0 ASoC: rt5616: trivial: fix the typo
2775e41 ASoC: rt5616: add mclk property for rt5616 document
b4ec10b ARM: dts: rockchip: add mclk for rt5616 on kylin board
8d272a1 ARM: dts: rockchip: add support emac for RK3036
02e501f clk: rockchip: rk3036: fix and add node id for emac clock
b948f42 ARM: dts: rockchip: add hdmi/vop device node for rk3036
....

This series patches can apply into Heiko for-next branch.
(https://git.kernel.org/cgit/linux/kernel/git/mmind/linux-rockchip.git/log/?h=for-next)
Also, ths ASoC can apply into Mark branch.
---

2) This series patches have the following decriptions:

PATCH[1/8]: ====> add hdmi/vop display node for rk3036
ARM: dts: rockchip: add hdmi/vop device node for rk3036

This Patch is based on Ykk's Inno HDMI V7 patches. That's verified on
my github.

bd5ed3e ARM: dts: rockchip: add hdmi/vop device node for rk3036
438e7bd FROMLIST: dt-bindings: add document for Innosilicon HDMI on Rockchip platform
((am from https://patchwork.kernel.org/patch/8117611/))
ad0623b FROMLIST: drm/rockchip: hdmi: add Innosilicon HDMI support
((am https://patchwork.kernel.org/patch/8117571/))

PATCH[2/8-3/8]: Add the emac patch

The emac clock is depend APLL, That shoud be incorrect.
We should fix it on the DPLL.

df91ab ARM: dts: rockchip: add support emac for RK3036
d5c2781 clk: rockchip: rk3036: fix and add node id for emac clock

That's verified on kylin board with ubuntu os.

How to test and verify?

You can refer to the following wiki document.
http://rockchip.wikidot.com/linux-develop-guide

PATCH[4/8-7/8]: Make the codec work on kylin board

41bbd5d ASoC: rt5616: add the mclk for the codec driver
6ee2dc0 ASoC: rt5616: trivial: fix the typo
2775e41 ASoC: rt5616: add mclk property for rt5616 document
b4ec10b ARM: dts: rockchip: add mclk for rt5616 on kylin board

As the previous discussed on https://patchwork.kernel.org/patch/8041001/
Move the mclk into codec driver to enable and disable.

How to test and verify?

You can refer to the following wiki document.
http://rockchip.wikidot.com/linux-develop-guide

PATCH[8/8]: Make the codec work on kylin board

Add the spi node for rk3036 dts, that's seem not related to the kylin.
Maybe the future will support the spi on kylin board or connect the spi devices.

f0fff43 ARM: dts: rockchip: support the spi for rk3036
---

Thanks your reviewing! :)

-
Caesar


Changes in v5:
- remove unused commit content.
- Fix the wrong word, as the Rob comments on
  https://patchwork.kernel.org/patch/8147731/.
- Cc the related alsa experts.
-Cc releated alsa experts.
- Cc related alsa experts.
- Remove the unused, as Heiko comments on https://patchwork.kernel.org/patch/8147761/
- Modify the commit.

Changes in v4:
- solve the lastest conflict, picked up from
  https://patchwork.kernel.org/patch/8040961/.
- fix the commit, pick up from the
  https://patchwork.kernel.org/patch/7976631/.
- The emac parent shouldn't depend on the APLL. instead of DPLL.
- included in the kylin series patches.
- This patch picked up from https://patchwork.kernel.org/patch/7924971/
- Change to solve the conflict based on the Heiko's branch.
- Make the emac parent as the DPLL.
- AS the previous discussed by them, add the mclk for codec.
 (https://patchwork.kernel.org/patch/8041001/)
- Add this patch included in kylin series patches.
- Add this patch included in kylin series patches.
- AS the previous discussed by them, add the mclk for codec.
  (https://patchwork.kernel.org/patch/8041001/)
- Add this patch included in kylin series patches.

Caesar Wang (6):
  ARM: dts: rockchip: add hdmi/vop device node for rk3036
  ARM: dts: rockchip: add mclk for rt5616 on kylin board
  ASoC: rt5616: add mclk property for rt5616 document
  ASoC: rt5616: trivial: fix the typo
  ASoC: rt5616: add the mclk for the codec driver
  ARM: dts: rockchip: support the spi for rk3036

zhengxing (2):
  clk: rockchip: rk3036: fix and add node id for emac clock
  ARM: dts: rockchip: add support emac for RK3036

 Documentation/devicetree/bindings/sound/rt5616.txt |   6 +
 arch/arm/boot/dts/rk3036-evb.dts                   |  23 ++
 arch/arm/boot/dts/rk3036-kylin.dts                 |  35 ++
 arch/arm/boot/dts/rk3036.dtsi                      | 145 ++++++++
 drivers/clk/rockchip/clk-rk3036.c                  |   9 +-
 include/dt-bindings/clock/rk3036-cru.h             |   2 +
 sound/soc/codecs/rt5616.c                          | 410 +++++++++++----------
 7 files changed, 442 insertions(+), 188 deletions(-)

-- 
1.9.1
