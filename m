From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Jan 2013 22:44:16 +0000
Subject: [PATCH 17/19] input/joystick: use get_cycles on ARM
In-Reply-To: <1359153858-31992-1-git-send-email-arnd@arndb.de>
References: <1359123276-15833-1-git-send-email-arnd@arndb.de>
 <1359153858-31992-1-git-send-email-arnd@arndb.de>
Message-ID: <1359153858-31992-18-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM normally has an accurate clock source, so
we can theoretically use analog joysticks more
accurately and at the same time avoid the
build warning

 #warning Precise timer not defined for this architecture.

from the joystick driver.

Now, why anybody would use that driver no ARM I have no
idea, but Ben Dooks enabled it in the s3c2410_defconfig
along with a bunch of other drivers, even though that
platform has neither ISA nor PCI support. It still
seems to be the right thing to fix this quirk.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>
Cc: Ben Dooks <ben-linux@fluff.org>
---
 drivers/input/joystick/analog.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
index 358cd7e..9c3e3c1 100644
--- a/drivers/input/joystick/analog.c
+++ b/drivers/input/joystick/analog.c
@@ -158,14 +158,10 @@ static unsigned int get_time_pit(void)
 #define GET_TIME(x)	rdtscl(x)
 #define DELTA(x,y)	((y)-(x))
 #define TIME_NAME	"TSC"
-#elif defined(__alpha__)
+#elif defined(__alpha__) || defined(CONFIG_MN10300) || defined(CONFIG_ARM)
 #define GET_TIME(x)	do { x = get_cycles(); } while (0)
 #define DELTA(x,y)	((y)-(x))
-#define TIME_NAME	"PCC"
-#elif defined(CONFIG_MN10300)
-#define GET_TIME(x)	do { x = get_cycles(); } while (0)
-#define DELTA(x, y)	((x) - (y))
-#define TIME_NAME	"TSC"
+#define TIME_NAME	"get_cycles"
 #else
 #define FAKE_TIME
 static unsigned long analog_faketime = 0;
-- 
1.8.0
