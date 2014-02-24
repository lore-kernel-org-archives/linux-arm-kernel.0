From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 24 Feb 2014 09:42:52 +0100
Subject: [PATCH 00/10] pinctrl: mvebu: remove hard-coded addresses from Dove
 pinctrl
Message-ID: <1393231382-11078-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a patches separated from one sent earlier [1] with just the
removal of any hard-coded reg addresses from Dove pinctrl stub. This
is a required step for Dove to leave mach-dove, hop into mach-mvebu,
and become part of multi_v7.

In the meantime, support for new Armada 375/38x was added that also
contain patches for pinctrl [2]. The cleanup patches [3] split off from
the original patch set take care of pinctrl-related changes for Armada
375/38x. Since this patch set now already depends on Armada 375/38x
pinctrl through those cleanup patches, we take care of Armada 375/38x
binding updates here, too.

For Dove, this patch set removes all hardcoded addresses from
pinctrl-dove by either requesting additional resources or a syscon
provided regmap for global config registers. As this changes existing
driver to DT binding relationship, all additional resources are probed
in a backward compatible way. If the corresponding resource cannot be
found, we derive it from the existing pinctrl resource and warn about
the old DTB firmware.

Patches 1-2 add or update binding documentation for dove, global config
syscon, and pinctrl-dove. Patch 2 also documents missing reg property
requirement for other mvebu pinctrl nodes, including new Armada 375/38x.

Patch 3 and 4 add the new pinctrl reg property values and global config
register syscon to exisiting dove.dtsi.

Patches 5-6 request either additional reg ranges or the syscon regmap
in a DT-backward compatible way. If any resource cannot be derived from
DT node, we warn about an old DTB firmware.

Patches 7-10 finally remove any hardcoded addresses from Dove SoC
pinctrl driver and use the iomap/regmap resources instead.

DT and binding related patches have also been sent to DT maintainers
and corresponding lists, additional pinctrl related patches have been
sent to pinctrl/mvebu maintainers and LAKML only.

This patch set is based on v3.14-rc1 and depends on some cleanup patches
that will go into v3.15. We have a lot of stuff for v3.15 already in
mvebu, so I am okay with postponing this and/or the following dove-to-
mvebu patches for v3.16. As Jason prepares mvebu pinctrl PRs for LinusW,
it is up to him when to take it with LinusW's Acked-by.

Nevertheless, there is an *unstable* branch based on v3.14-rc1, with
mvebu/pinctrl-3xx and mvebu/pinctrl merged in at (still named -for-3.15)

https://github.com/shesselba/linux-dove.git unstable/dove-pinctrl-for-3.15_v1

[1] http://www.spinics.net/lists/arm-kernel/msg303496.html
[2] http://www.spinics.net/lists/arm-kernel/msg306409.html
[3] http://lkml.org/lkml/2014/2/23/43

Sebastian Hesselbarth (10):
  devicetree: bindings: add missing Marvell Dove SoC documentation
  devicetree: bindings: update MVEBU pinctrl binding documentation
  ARM: dove: add additional pinctrl registers
  ARM: dove: add global-config register node
  pinctrl: mvebu: dove: request additional resources
  pinctrl: mvebu: dove: request syscon regmap for global registers
  pinctrl: mvebu: dove: use remapped mpp base registers
  pinctrl: mvebu: dove: use remapped mpp4 register
  pinctrl: mvebu: dove: use remapped pmu_mpp registers
  pinctrl: mvebu: dove: use global register regmap

 .../devicetree/bindings/arm/marvell,dove.txt       |  22 ++
 .../pinctrl/marvell,armada-370-pinctrl.txt         |   1 +
 .../pinctrl/marvell,armada-375-pinctrl.txt         |   1 +
 .../pinctrl/marvell,armada-38x-pinctrl.txt         |   1 +
 .../bindings/pinctrl/marvell,armada-xp-pinctrl.txt |   1 +
 .../bindings/pinctrl/marvell,dove-pinctrl.txt      |   1 +
 .../bindings/pinctrl/marvell,kirkwood-pinctrl.txt  |   1 +
 .../bindings/pinctrl/marvell,mvebu-pinctrl.txt     |   2 +-
 arch/arm/boot/dts/dove.dtsi                        |  10 +-
 drivers/pinctrl/mvebu/Kconfig                      |   1 +
 drivers/pinctrl/mvebu/pinctrl-dove.c               | 286 +++++++++++++--------
 11 files changed, 213 insertions(+), 114 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell,dove.txt

---
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Rob Landley <rob@landley.net>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: devicetree at vger.kernel.org
Cc: linux-doc at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
-- 
1.8.5.3
