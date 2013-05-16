From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 16 May 2013 20:26:18 +0100
Subject: [RFC 3/8] drm/i2c: nxp-tda998x: ensure VIP output mux is properly set
In-Reply-To: <20130516192510.GV18614@n2100.arm.linux.org.uk>
References: <20130516192510.GV18614@n2100.arm.linux.org.uk>
Message-ID: <E1Ud3og-0001qm-52@rmk-PC.arm.linux.org.uk>
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
 drivers/gpu/drm/i2c/tda998x_drv.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index d71c408..4b4db95 100644
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
@@ -438,6 +439,8 @@ tda998x_encoder_dpms(struct drm_encoder *encoder, int mode)
 
 	switch (mode) {
 	case DRM_MODE_DPMS_ON:
+		/* Write the default value MUX register */
+		reg_write(encoder, REG_MUX_VP_VIP_OUT, 0x24);
 		/* enable audio and video ports */
 		reg_write(encoder, REG_ENA_AP, 0xff);
 		reg_write(encoder, REG_ENA_VP_0, 0xff);
-- 
1.7.4.4
