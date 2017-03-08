From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Wed, 08 Mar 2017 13:54:07 +0900
Subject: [PATCH v5 0/5] Fix the parse_dt of exynos dsi and remove the OF graph
References: <CGME20170308045502epcas1p29b871888e32bb1e2f870b9fd399d0b06@epcas1p2.samsung.com>
Message-ID: <1488948852-5380-1-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

The dsi + panel is a parental relationship, so OF grpah is not needed.
Therefore, the current dsi_parse_dt function will throw an error,
because there is no linked OF graph for case such as fimd + dsi +
panel.

So the 1/5 patch parse the Pll, burst and esc clock frequency
properties in dsi_parse_dt and modified to create a bridge_node only
if there is an OF graph associated with dsi.

Also fixed the dts, which depend on the 1/5 patch. So removed the
ports node and move burst and esc clock frequency properties to the
parent (DSI node).

Changes for V5:
- Added Reviewed-by: Andi Shyti <andi.shyti@samsung.com> (all patches).
- Reworded commit messages.

Changes for V4:
- Squashed patch 2, 3 and 4.
- Added Reviewed-by: Andrzej Hajda <a.hajda@samsung.com> (all patches).

Changes for V3:
- Split the patches considering the bisectability problem.

Changes for V2:
- Added the clear explanation for commit. (1/5 patch)
- Fixed it to the same subject as the actual work. (2/5 ~ 5/5 patches)

Best Regards,
Hoegeun

Hoegeun Kwon (5):
  arm64: dts: exynos: Add the burst and esc clock frequency properties
    to DSI node
  arm: dts: Add the burst and esc clock frequency properties to DSI node
  drm/exynos: dsi: Fix the parse_dt function
  arm64: dts: exynos: Remove the OF graph from DSI node
  arm: dts: Remove the OF graph from DSI node

 arch/arm/boot/dts/exynos3250-rinato.dts            | 23 ++--------------
 arch/arm/boot/dts/exynos4210-trats.dts             | 23 ++--------------
 arch/arm/boot/dts/exynos4412-trats2.dts            | 23 ++--------------
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 16 ++---------
 drivers/gpu/drm/exynos/exynos_drm_dsi.c            | 32 ++++++----------------
 5 files changed, 16 insertions(+), 101 deletions(-)

-- 
1.9.1
