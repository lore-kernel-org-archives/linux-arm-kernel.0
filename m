From: linux@roeck-us.net (Guenter Roeck)
Date: Wed,  6 Jan 2016 16:20:10 -0800
Subject: [PATCH -next] gpio: xilinx: Do not use gpiochip_get_data() in
 xgpio_save_regs()
Message-ID: <1452126010-1111-1-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 097d88e94c44 ("gpio: xilinx: use gpiochip data pointer") replaces
the use of container_of() with gpiochip_get_data(). Unfortunately, the
data pointer is not yet set by the time xgpio_save_regs() is called,
causing a system hang.

Fixes: 097d88e94c44 ("gpio: xilinx: use gpiochip data pointer")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
It might make sense to merge this patch with the patch introducing the problem.

 drivers/gpio/gpio-xilinx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
index 3345ab0ba1b3..d0fbb7f99523 100644
--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -207,7 +207,8 @@ static int xgpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
  */
 static void xgpio_save_regs(struct of_mm_gpio_chip *mm_gc)
 {
-	struct xgpio_instance *chip = gpiochip_get_data(&mm_gc->gc);
+	struct xgpio_instance *chip =
+		container_of(mm_gc, struct xgpio_instance, mmchip);
 
 	xgpio_writereg(mm_gc->regs + XGPIO_DATA_OFFSET,	chip->gpio_state[0]);
 	xgpio_writereg(mm_gc->regs + XGPIO_TRI_OFFSET, chip->gpio_dir[0]);
-- 
2.1.4
