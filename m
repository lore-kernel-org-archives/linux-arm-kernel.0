From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 20 Jul 2012 19:35:38 +0200
Subject: [PATCH 3/16] ARM: Kirkwood: Ensure runit clock always ticks.
In-Reply-To: <1342805751-18048-1-git-send-email-andrew@lunn.ch>
References: <1342805751-18048-1-git-send-email-andrew@lunn.ch>
Message-ID: <1342805751-18048-4-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marvell engineers tell us:

	It seems that many units use the RUNIT clock.
	SPI, UART, NAND, TWSI, ...
	So it's not possible to clock gate it.

Currently the SPI, NAND and TWSI driver will clk_prepaure_enable()
this clk, but since we have no idea what ... is, and turning this clk
off results in a hard lock, unconditionally enable runit.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Simon Baatz <gmbnomis@gmail.com>
---
 arch/arm/mach-kirkwood/common.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index f261cd2..3de2d6d 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -241,6 +241,11 @@ void __init kirkwood_clk_init(void)
 	orion_clkdev_add("0", "pcie", pex0);
 	orion_clkdev_add("1", "pcie", pex1);
 	orion_clkdev_add(NULL, "kirkwood-i2s", audio);
+
+	/* Marvell says runit is used by SPI, UART, NAND, TWSI, ...,
+	 * so should never be gated.
+	 */
+	clk_prepare_enable(runit);
 }
 
 /*****************************************************************************
-- 
1.7.10
