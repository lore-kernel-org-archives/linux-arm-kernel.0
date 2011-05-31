From: jhnikula@gmail.com (Jarkko Nikula)
Date: Tue, 31 May 2011 11:27:01 +0300
Subject: [PATCHv2 2/2] omap: rx51: Don't power up speaker amplifier at bootup
In-Reply-To: <1306830421-25727-1-git-send-email-jhnikula@gmail.com>
References: <1306830421-25727-1-git-send-email-jhnikula@gmail.com>
Message-ID: <1306830421-25727-2-git-send-email-jhnikula@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Speaker amplifier is accidentally powered up in early TWL gpio setup. This
causes a few mA of needless battery current consumption. Without this patch
the amplifier can be shutdown only by having one active audio playback and
shutdown cycle to speaker output.

Thanks to Kalle Jokiniemi <kalle.jokiniemi@nokia.com> for noticing the issue.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
---
v2. Updated on top of commit bc593f5 ("arm: omap2plus: GPIO cleanup").
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 02a6587..9903667 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -583,7 +583,7 @@ static int rx51_twlgpio_setup(struct device *dev, unsigned gpio, unsigned n)
 {
 	/* FIXME this gpio setup is just a placeholder for now */
 	gpio_request_one(gpio + 6, GPIOF_OUT_INIT_LOW, "backlight_pwm");
-	gpio_request_one(gpio + 7, GPIOF_OUT_INIT_HIGH, "speaker_en");
+	gpio_request_one(gpio + 7, GPIOF_OUT_INIT_LOW, "speaker_en");
 
 	return 0;
 }
-- 
1.7.4.4
