From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Thu, 21 Nov 2013 19:40:14 +0400
Subject: [PATCH 6/6] arm: sa1100: h3xxx: drop hand-coded gpio_request_array
 analogue
In-Reply-To: <1385048414-9812-1-git-send-email-dbaryshkov@gmail.com>
References: <1385048414-9812-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1385048414-9812-7-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

h3xxx_init_gpio() behaves alsmost like gpio_request_array. Also after
all GPIO refactoring it is unused. Drop it now.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/h3xxx.c              | 31 -------------------------------
 arch/arm/mach-sa1100/include/mach/h3xxx.h | 11 -----------
 2 files changed, 42 deletions(-)

diff --git a/arch/arm/mach-sa1100/h3xxx.c b/arch/arm/mach-sa1100/h3xxx.c
index 82e8702..c79bf46 100644
--- a/arch/arm/mach-sa1100/h3xxx.c
+++ b/arch/arm/mach-sa1100/h3xxx.c
@@ -28,37 +28,6 @@
 
 #include "generic.h"
 
-void h3xxx_init_gpio(struct gpio_default_state *s, size_t n)
-{
-	while (n--) {
-		const char *name = s->name;
-		int err;
-
-		if (!name)
-			name = "[init]";
-		err = gpio_request(s->gpio, name);
-		if (err) {
-			printk(KERN_ERR "gpio%u: unable to request: %d\n",
-				s->gpio, err);
-			continue;
-		}
-		if (s->mode >= 0) {
-			err = gpio_direction_output(s->gpio, s->mode);
-		} else {
-			err = gpio_direction_input(s->gpio);
-		}
-		if (err) {
-			printk(KERN_ERR "gpio%u: unable to set direction: %d\n",
-				s->gpio, err);
-			continue;
-		}
-		if (!s->name)
-			gpio_free(s->gpio);
-		s++;
-	}
-}
-
-
 /*
  * H3xxx flash support
  */
diff --git a/arch/arm/mach-sa1100/include/mach/h3xxx.h b/arch/arm/mach-sa1100/include/mach/h3xxx.h
index c810620..603d434 100644
--- a/arch/arm/mach-sa1100/include/mach/h3xxx.h
+++ b/arch/arm/mach-sa1100/include/mach/h3xxx.h
@@ -79,17 +79,6 @@
 #define H3600_EGPIO_LCD_5V_ON		(H3XXX_EGPIO_BASE + 14) /* enable 5V to LCD. active high. */
 #define H3600_EGPIO_LVDD_ON		(H3XXX_EGPIO_BASE + 15) /* enable 9V and -6.5V to LCD. */
 
-struct gpio_default_state {
-	int gpio;
-	int mode;
-	const char *name;
-};
-
-#define GPIO_MODE_IN	-1
-#define GPIO_MODE_OUT0	0
-#define GPIO_MODE_OUT1	1
-
-void h3xxx_init_gpio(struct gpio_default_state *s, size_t n);
 void __init h3xxx_map_io(void);
 void __init h3xxx_mach_init(void);
 
-- 
1.8.4.2
