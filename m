From: jhnikula@gmail.com (Jarkko Nikula)
Date: Thu, 12 May 2011 14:30:58 +0300
Subject: [PATCH 2/2] omap: rx51: Don't power up speaker amplifier at bootup
In-Reply-To: <1305199858-32643-1-git-send-email-jhnikula@gmail.com>
References: <1305199858-32643-1-git-send-email-jhnikula@gmail.com>
Message-ID: <1305199858-32643-2-git-send-email-jhnikula@gmail.com>
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
 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 8242e99..0374562 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -561,7 +561,7 @@ static int rx51_twlgpio_setup(struct device *dev, unsigned gpio, unsigned n)
 	gpio_request(gpio + 6, "backlight_pwm");
 	gpio_direction_output(gpio + 6, 0);
 	gpio_request(gpio + 7, "speaker_en");
-	gpio_direction_output(gpio + 7, 1);
+	gpio_direction_output(gpio + 7, 0);
 
 	return 0;
 }
-- 
1.7.4.4
