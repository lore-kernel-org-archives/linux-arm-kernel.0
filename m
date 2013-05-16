From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 16 May 2013 20:26:38 +0100
Subject: [RFC 4/8] drm/i2c: nxp-tda998x: fix npix/nline programming
In-Reply-To: <20130516192510.GV18614@n2100.arm.linux.org.uk>
References: <20130516192510.GV18614@n2100.arm.linux.org.uk>
Message-ID: <E1Ud3p0-0001qq-8v@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The npix/nline registers are supposed to be programmed with the total
number of pixels/lines, not the displayed pixels/lines, and not minus
one either.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/i2c/tda998x_drv.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 4b4db95..da2917b 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -586,8 +586,8 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 		reg_set(encoder, REG_VIP_CNTRL_3, VIP_CNTRL_3_H_TGL);
 
 	reg_write(encoder, REG_VIDFORMAT, 0x00);
-	reg_write16(encoder, REG_NPIX_MSB, mode->hdisplay - 1);
-	reg_write16(encoder, REG_NLINE_MSB, mode->vdisplay - 1);
+	reg_write16(encoder, REG_NPIX_MSB, mode->htotal);
+	reg_write16(encoder, REG_NLINE_MSB, mode->vtotal);
 	reg_write16(encoder, REG_VS_LINE_STRT_1_MSB, line_start);
 	reg_write16(encoder, REG_VS_LINE_END_1_MSB, line_end);
 	reg_write16(encoder, REG_VS_PIX_STRT_1_MSB, hs_start);
-- 
1.7.4.4
