From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  6 Sep 2016 14:50:47 +0200
Subject: [PATCH] pwm: meson: handle unknown ID values
Message-ID: <20160906125106.1511562-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building with -Wmaybe-uninitialized, we get a couple of harmless
warnings about three functions in this new driver that don't look
safe to the compiler:

drivers/pwm/pwm-meson.c: In function 'meson_pwm_get_state':
drivers/pwm/pwm-meson.c:355:26: error: 'mask' may be used uninitialized in this function [-Werror=maybe-uninitialized]
drivers/pwm/pwm-meson.c: In function 'meson_pwm_disable':
drivers/pwm/pwm-meson.c:263:13: error: 'enable' may be used uninitialized in this function [-Werror=maybe-uninitialized]
drivers/pwm/pwm-meson.c: In function 'meson_pwm_apply':
drivers/pwm/pwm-meson.c:231:13: error: 'clk_shift' may be used uninitialized in this function [-Werror=maybe-uninitialized]
drivers/pwm/pwm-meson.c:231:36: error: 'enable' may be used uninitialized in this function [-Werror=maybe-uninitialized]
drivers/pwm/pwm-meson.c:231:24: error: 'clk_enable' may be used uninitialized in this function [-Werror=maybe-uninitialized]

Specifically, if we have a device with an id other than 0 or 1,
this would result in undefined behavior. This is currently not
possible, but the compiler cannot be expected to know this.

This patch adds a 'default' clause to let the compiler know
what to do instead, which shuts up the warning and makes the
code slightly more resiliant in case it gets extended to other
identifiers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pwm/pwm-meson.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 566f5cb81021..25abd95dcc7b 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -242,6 +242,9 @@ static void meson_pwm_enable(struct meson_pwm *meson,
 		clk_enable = MISC_B_CLK_EN;
 		enable = MISC_B_EN;
 		break;
+
+	default:
+		return;
 	}
 
 	value = readl(meson->base + REG_MISC_AB);
@@ -270,6 +273,9 @@ static void meson_pwm_disable(struct meson_pwm *meson, unsigned int id)
 	case 1:
 		enable = MISC_B_EN;
 		break;
+
+	default:
+		return;
 	}
 
 	value = readl(meson->base + REG_MISC_AB);
@@ -349,6 +355,10 @@ static void meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	case 1:
 		mask = MISC_B_EN;
 		break;
+
+	default:
+		state->enabled = 0;
+		return;
 	}
 
 	value = readl(meson->base + REG_MISC_AB);
-- 
2.9.0
