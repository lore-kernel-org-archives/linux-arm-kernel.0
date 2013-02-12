From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 12 Feb 2013 17:28:42 +0100
Subject: [PATCH 08/32] clk: mvebu: create parent-child relation for PCIe
 clocks on Armada 370
In-Reply-To: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1360686546-24277-9-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 370 has two gatable clocks for each PCIe interface: pexY
and pexY_en. In order for a PCIe interface to be functional, we need
both of them to be enabled. Since there are no conditions in which
having one clock enabled and not the other would be useful, we simply
make those two clocks have a child-parent relationship.

So, the pex0 clock becomes a child of pex0_en (for the PCIe interface
0), and pex1 becomes a child of pex1_en (for the PCIe interface
1). This way, the DT node for the PCIe interface 0 only needs to grab
a reference to pex0, and the DT node for the PCIe interface 1 only
needs to grab a reference to pex1.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Mike Turquette <mturquette@linaro.org>
---
 drivers/clk/mvebu/clk-gating-ctrl.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mvebu/clk-gating-ctrl.c b/drivers/clk/mvebu/clk-gating-ctrl.c
index 8fa5408..fd52b5f 100644
--- a/drivers/clk/mvebu/clk-gating-ctrl.c
+++ b/drivers/clk/mvebu/clk-gating-ctrl.c
@@ -119,8 +119,8 @@ static const struct mvebu_soc_descr __initconst armada_370_gating_descr[] = {
 	{ "pex1_en", NULL,  2 },
 	{ "ge1", NULL, 3 },
 	{ "ge0", NULL, 4 },
-	{ "pex0", NULL, 5 },
-	{ "pex1", NULL, 9 },
+	{ "pex0", "pex0_en", 5 },
+	{ "pex1", "pex1_en", 9 },
 	{ "sata0", NULL, 15 },
 	{ "sdio", NULL, 17 },
 	{ "tdm", NULL, 25 },
-- 
1.7.9.5
