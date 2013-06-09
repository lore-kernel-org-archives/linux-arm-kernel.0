From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 09 Jun 2013 20:31:46 +0100
Subject: [PATCH RFC 4/8] drm/i2c: nxp-tda998x: ensure VIP output mux is
 properly set
In-Reply-To: <20130609190612.GM18614@n2100.arm.linux.org.uk>
References: <20130609190612.GM18614@n2100.arm.linux.org.uk>
Message-ID: <E1UllL8-00058Y-H3@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When switching between various drivers for this device, it's possible
that some critical registers are left containing values which affect
the device operation.  One such case encountered is the VIP output
mux register.  This defaults to 0x24 on powerup, but other drivers may
set this to 0x12.  This results in incorrect colours.

Fix this by ensuring that the register is always set to the power on
default setting.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/i2c/tda998x_drv.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index d71c408..dc0428d 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -110,6 +110,7 @@ struct tda998x_priv {
 #define REG_VIP_CNTRL_5           REG(0x00, 0x25)     /* write */
 # define VIP_CNTRL_5_CKCASE       (1 << 0)
 # define VIP_CNTRL_5_SP_CNT(x)    (((x) & 3) << 1)
+#define REG_MUX_VP_VIP_OUT        REG(0x00, 0x27)     /* read/write */
 #define REG_MAT_CONTRL            REG(0x00, 0x80)     /* write */
 # define MAT_CONTRL_MAT_SC(x)     (((x) & 3) << 0)
 # define MAT_CONTRL_MAT_BP        (1 << 2)
@@ -415,6 +416,9 @@ tda998x_reset(struct drm_encoder *encoder)
 	reg_write(encoder, REG_PLL_SCGR1,    0x5b);
 	reg_write(encoder, REG_PLL_SCGR2,    0x00);
 	reg_write(encoder, REG_PLL_SCG2,     0x10);
+
+	/* Ensure VP output bus muxes result in no swapping */
+	reg_write(encoder, REG_MUX_VP_VIP_OUT, 0x24);
 }
 
 /* DRM encoder functions */
-- 
1.7.4.4
