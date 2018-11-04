From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Sun,  4 Nov 2018 19:27:00 +0100
Subject: [PATCH v3 23/28] drm/sun4i: Initialize registers in tcon-top driver
In-Reply-To: <20181104182705.18047-1-jernej.skrabec@siol.net>
References: <20181104182705.18047-1-jernej.skrabec@siol.net>
Message-ID: <20181104182705.18047-24-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It turns out that TCON TOP registers in H6 SoC have non-zero reset
value. This may cause issues if bits are not changed during
configuration.

To prevent that, initialize registers to 0.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
index 3040a79f298f..37158548b447 100644
--- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
+++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
@@ -167,6 +167,13 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
 		goto err_assert_reset;
 	}
 
+	/*
+	 * At least on H6, some registers have some bits set by default
+	 * which may cause issues. Clear them here.
+	 */
+	writel(0, regs + TCON_TOP_PORT_SEL_REG);
+	writel(0, regs + TCON_TOP_GATE_SRC_REG);
+
 	/*
 	 * TCON TOP has two muxes, which select parent clock for each TCON TV
 	 * channel clock. Parent could be either TCON TV or TVE clock. For now
-- 
2.19.1
