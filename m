From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue,  5 Jul 2016 22:19:50 +0200
Subject: [PATCH 0/3] ARM: dts: pinctrl-imx: some cleanups and fixes
Message-ID: <1467749993-14533-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

when I asked Andreas F?rber to drop the function device nodes in his
patch that added support for the Udoo Neo boards, he rightfully said:
"OK, will do. Adopted from imx6sx-sdb.dtsi and imx6sx-sabreauto.dts -
please update the existing files to be like you expect new ones to be.".
This is done in patch 1. While the short stat for this patch is

	87 files changed, 7717 insertions(+), 7899 deletions(-)

it was really easier, because most of the changes are indention, and
with -b I just get:

	87 files changed, 182 deletions(-)

which matches reality much better.

After that I noticed (with a tool I wrote for a customer) that some
pinctrl settings in the i.MX25 device trees are broken. (That doesn't
mean all others are ok, my tool just understands i.MX25 pinmuxing. :-)
These are fixed in patch 2.

Then in the third patch I substituted most occurrences of 0x80000000 in
the pad config values by the reset default value. (Just pads that don't
have a pad config register must stay with 0x80000000.)

I admit the patches don't fit together to justify putting them in a
series, but as they conflict each other I still put them together.

Testing is very welcome as I don't have access to (most of) the affected
machines.

These patches base on 4.7-rc6. Please advise if I should rebase to a
different version.

Best regards
Uwe

Uwe Kleine-K?nig (3):
  ARM: dts: drop function device nodes for pinctrl-imx nodes
  ARM: dts: imx25: don't configure reserved pad settings
  ARM: dts: imx25: substitute NO_PAD_CTL by the respective reset value

 arch/arm/boot/dts/imx1-ads.dts                     | 100 ++--
 arch/arm/boot/dts/imx1-apf9328.dts                 |  92 ++--
 arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi       |  38 +-
 .../imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts  |   6 +-
 .../boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts  | 134 +++---
 arch/arm/boot/dts/imx25-karo-tx25.dts              |  50 +-
 arch/arm/boot/dts/imx25-pdk.dts                    | 190 ++++----
 arch/arm/boot/dts/imx27-apf27.dts                  |  56 ++-
 arch/arm/boot/dts/imx27-apf27dev.dts               | 194 ++++----
 arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi       | 228 +++++-----
 .../boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts  | 194 ++++----
 arch/arm/boot/dts/imx27-pdk.dts                    | 132 +++---
 arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts   |  92 ++--
 arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi  |  78 ++--
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts     | 206 +++++----
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi    | 154 ++++---
 arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi       |  62 ++-
 .../boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts  |  88 ++--
 arch/arm/boot/dts/imx35-pdk.dts                    |  36 +-
 arch/arm/boot/dts/imx50-evk.dts                    |  62 ++-
 arch/arm/boot/dts/imx51-apf51.dts                  |  56 ++-
 arch/arm/boot/dts/imx51-apf51dev.dts               | 176 ++++---
 arch/arm/boot/dts/imx51-babbage.dts                | 418 +++++++++--------
 arch/arm/boot/dts/imx51-digi-connectcore-jsk.dts   |  78 ++--
 arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi  | 266 ++++++-----
 arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi       |  68 ++-
 .../boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts  | 192 ++++----
 arch/arm/boot/dts/imx53-ard.dts                    | 116 +++--
 arch/arm/boot/dts/imx53-m53.dtsi                   |  64 ++-
 arch/arm/boot/dts/imx53-m53evk.dts                 | 268 ++++++-----
 arch/arm/boot/dts/imx53-mba53.dts                  | 114 +++--
 arch/arm/boot/dts/imx53-qsb-common.dtsi            | 244 +++++-----
 arch/arm/boot/dts/imx53-qsrb.dts                   |  10 +-
 arch/arm/boot/dts/imx53-smd.dts                    | 196 ++++----
 arch/arm/boot/dts/imx53-tqma53.dtsi                | 246 +++++-----
 arch/arm/boot/dts/imx53-tx53-x03x.dts              | 112 +++--
 arch/arm/boot/dts/imx53-tx53-x13x.dts              |  74 ++-
 arch/arm/boot/dts/imx53-tx53.dtsi                  | 436 +++++++++---------
 arch/arm/boot/dts/imx53-voipac-bsb.dts             | 106 +++--
 arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi        | 124 +++--
 arch/arm/boot/dts/imx6dl-riotboard.dts             | 360 ++++++++-------
 arch/arm/boot/dts/imx6q-arm2.dts                   | 198 ++++----
 arch/arm/boot/dts/imx6q-cm-fx6.dts                 |  94 ++--
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts            | 232 +++++-----
 arch/arm/boot/dts/imx6q-gk802.dts                  |  92 ++--
 arch/arm/boot/dts/imx6q-gw5400-a.dts               | 215 +++++----
 arch/arm/boot/dts/imx6q-marsboard.dts              |   1 -
 arch/arm/boot/dts/imx6q-sbc6x.dts                  |  82 ++--
 arch/arm/boot/dts/imx6qdl-apf6.dtsi                | 112 +++--
 arch/arm/boot/dts/imx6qdl-apf6dev.dtsi             | 306 +++++++------
 arch/arm/boot/dts/imx6qdl-aristainetos.dtsi        | 404 ++++++++--------
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi             | 136 +++---
 arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi       | 176 ++++---
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi              | 238 +++++-----
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi              | 348 +++++++-------
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi              | 334 +++++++-------
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi              | 356 +++++++--------
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi              | 162 ++++---
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi              | 154 ++++---
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi        | 152 +++----
 arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi     |  84 ++--
 arch/arm/boot/dts/imx6qdl-microsom.dtsi            |  98 ++--
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi           | 378 ++++++++-------
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi       | 506 ++++++++++-----------
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          | 398 ++++++++--------
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi       | 288 ++++++------
 arch/arm/boot/dts/imx6qdl-rex.dtsi                 | 264 ++++++-----
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           | 412 +++++++++--------
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi           | 360 ++++++++-------
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             | 294 ++++++------
 arch/arm/boot/dts/imx6qdl-udoo.dtsi                | 186 ++++----
 arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi     |  32 +-
 arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi     |  32 +-
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi           | 191 ++++----
 arch/arm/boot/dts/imx6qp-sabreauto.dts             |  40 +-
 arch/arm/boot/dts/imx6qp-sabresd.dts               |  56 ++-
 arch/arm/boot/dts/imx6sl-evk.dts                   | 460 ++++++++++---------
 arch/arm/boot/dts/imx6sl-warp.dts                  | 208 +++++----
 arch/arm/boot/dts/imx6sx-sabreauto.dts             | 134 +++---
 arch/arm/boot/dts/imx6sx-sdb.dtsi                  | 482 ++++++++++----------
 arch/arm/boot/dts/imx7d-sdb.dts                    | 351 +++++++-------
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi          |  10 +-
 arch/arm/boot/dts/vf-colibri.dtsi                  | 334 +++++++-------
 arch/arm/boot/dts/vf500-colibri.dtsi               |  44 +-
 arch/arm/boot/dts/vf610-cosmic.dts                 |  60 ++-
 arch/arm/boot/dts/vf610-twr.dts                    | 228 +++++-----
 arch/arm/boot/dts/vf610m4-colibri.dts              |  16 +-
 arch/arm/boot/dts/vf610m4-cosmic.dts               |  12 +-
 88 files changed, 7742 insertions(+), 7924 deletions(-)

-- 
2.8.1
