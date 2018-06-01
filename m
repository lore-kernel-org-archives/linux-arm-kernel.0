From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri,  1 Jun 2018 11:28:21 +0200
Subject: [PATCH 3/4] serial: sh-sci: Stop using printk format %pCr
In-Reply-To: <1527845302-12159-1-git-send-email-geert+renesas@glider.be>
References: <1527845302-12159-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1527845302-12159-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Printk format "%pCr" will be removed soon, as clk_get_rate() must not be
called in atomic context.

Replace it by open-coding the operation.  This is safe here, as the code
runs in task context.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index b46b146524ce7495..c181eb37f98509e6 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2724,8 +2724,8 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 			dev_dbg(dev, "failed to get %s (%ld)\n", clk_names[i],
 				PTR_ERR(clk));
 		else
-			dev_dbg(dev, "clk %s is %pC rate %pCr\n", clk_names[i],
-				clk, clk);
+			dev_dbg(dev, "clk %s is %pC rate %lu\n", clk_names[i],
+				clk, clk_get_rate(clk));
 		sci_port->clks[i] = IS_ERR(clk) ? NULL : clk;
 	}
 	return 0;
-- 
2.7.4
