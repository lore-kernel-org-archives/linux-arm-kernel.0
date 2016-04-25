From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Apr 2016 17:35:28 +0200
Subject: [PATCH 2/5] Kbuild: disable 'maybe-uninitialized' warning for
 CONFIG_PROFILE_ALL_BRANCHES
In-Reply-To: <1461598531-2190169-1-git-send-email-arnd@arndb.de>
References: <1461598531-2190169-1-git-send-email-arnd@arndb.de>
Message-ID: <1461598531-2190169-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_PROFILE_ALL_BRANCHES confuses gcc-5.x to the degree that it prints
incorrect warnings about a lot of variables that it thinks can be used
uninitialized, e.g.:

i2c/busses/i2c-diolan-u2c.c: In function 'diolan_usb_xfer':
i2c/busses/i2c-diolan-u2c.c:391:16: warning: 'byte' may be used uninitialized in this function
iio/gyro/itg3200_core.c: In function 'itg3200_probe':
iio/gyro/itg3200_core.c:213:6: warning: 'val' may be used uninitialized in this function
leds/leds-lp55xx-common.c: In function 'lp55xx_update_bits':
leds/leds-lp55xx-common.c:350:6: warning: 'tmp' may be used uninitialized in this function
misc/bmp085.c: In function 'show_pressure':
misc/bmp085.c:363:10: warning: 'pressure' may be used uninitialized in this function
power/ds2782_battery.c: In function 'ds2786_get_capacity':
power/ds2782_battery.c:214:17: warning: 'raw' may be used uninitialized in this function

These are all false positives that either rob someone's time when trying
to figure out whether they are real, or they get people to send wrong
patches to shut up the warnings.

Nobody normally wants to run a CONFIG_PROFILE_ALL_BRANCHES kernel in
production, so disabling the whole class of warnings for this configuration
has no serious downsides either.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Steven Rostedt <rostedtgoodmis.org>
---
 Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c5a3db5aebd1..e595d1f626b8 100644
--- a/Makefile
+++ b/Makefile
@@ -624,7 +624,11 @@ KBUILD_CFLAGS	+= $(call cc-option,-fno-delete-null-pointer-checks,)
 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
 KBUILD_CFLAGS	+= -Os $(call cc-disable-warning,maybe-uninitialized,)
 else
-KBUILD_CFLAGS	+= -O2
+ifdef CONFIG_PROFILE_ALL_BRANCHES
+KBUILD_CFLAGS	+= -O2 $(call cc-disable-warning,maybe-uninitialized,)
+else
+KBUILD_CFLAGS   += -O2
+endif
 endif
 
 # Tell gcc to never replace conditional load with a non-conditional one
-- 
2.7.0
