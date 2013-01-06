From: andrew@lunn.ch (Andrew Lunn)
Date: Sun,  6 Jan 2013 11:10:37 +0100
Subject: [PATCH 04/11] ARM: Kirkwood: Fix missing sdio clock
In-Reply-To: <1357467044-4914-1-git-send-email-andrew@lunn.ch>
References: <1357467044-4914-1-git-send-email-andrew@lunn.ch>
Message-ID: <1357467044-4914-5-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We moved to declaring clk gates in DT. However, device which do not
yet have a DT binding need to have a clkdev alias. This was missing
for SDIO.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Stefan Peter <s.peter@mplch>
---
 arch/arm/mach-kirkwood/board-dt.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index ff4150a..de4fd2b 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -67,6 +67,10 @@ static void __init kirkwood_legacy_clk_init(void)
 	orion_clkdev_add(NULL, "mv643xx_eth_port.1",
 			 of_clk_get_from_provider(&clkspec));
 
+	clkspec.args[0] = CGC_BIT_SDIO;
+	orion_clkdev_add(NULL, "mvsdio",
+			 of_clk_get_from_provider(&clkspec));
+
 }
 
 static void __init kirkwood_of_clk_init(void)
-- 
1.7.10.4
