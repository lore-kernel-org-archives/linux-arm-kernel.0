From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 17 May 2016 08:02:06 +0200
Subject: [PATCH] pinctrl: samsung: Suppress unbinding to prevent theoretical
 attacks
Message-ID: <1463464926-17482-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Although unbinding a pinctrl driver requires root privileges but it
still might be used theoretically in certain attacks (by triggering NULL
pointer exception or memory corruption).

Samsung pincontrol drivers are essential for system operation so their
removal is not expected. They do not implement remove() driver callback
and they are not buildable as modules.

Suppression of the unbinding will prevent triggering NULL pointer
exception like this (Odroid XU3):

  $ echo 13400000.pinctrl > /sys/bus/platform/drivers/samsung-pinctrl/unbind
  $ cat /sys/kernel/debug/gpio

  Unable to handle kernel NULL pointer dereference at virtual address 00000c44
  pgd = ec41c000
  [00000c44] *pgd=6d448835, *pte=00000000, *ppte=00000000
  Internal error: Oops: 17 [#1] PREEMPT SMP ARM
    (samsung_gpio_get) from [<c034f9a0>] (gpiolib_seq_show+0x1b0/0x26c)
    (gpiolib_seq_show) from [<c01fb8c0>] (seq_read+0x304/0x4b8)
    (seq_read) from [<c02dbc78>] (full_proxy_read+0x4c/0x64)
    (full_proxy_read) from [<c01d9fb0>] (__vfs_read+0x2c/0x110)
    (__vfs_read) from [<c01db400>] (vfs_read+0x8c/0x110)
    (vfs_read) from [<c01db4c4>] (SyS_read+0x40/0x8c)
    (SyS_read) from [<c01078c0>] (ret_fast_syscall+0x0/0x3c)

Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/pinctrl/samsung/pinctrl-exynos5440.c | 1 +
 drivers/pinctrl/samsung/pinctrl-samsung.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos5440.c b/drivers/pinctrl/samsung/pinctrl-exynos5440.c
index fb71fc3e5aa0..3000df80709f 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos5440.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos5440.c
@@ -998,6 +998,7 @@ static struct platform_driver exynos5440_pinctrl_driver = {
 	.driver = {
 		.name	= "exynos5440-pinctrl",
 		.of_match_table = exynos5440_pinctrl_dt_match,
+		.suppress_bind_attrs = true,
 	},
 };
 
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index ed0b70881e19..513fe6b23248 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -1274,6 +1274,7 @@ static struct platform_driver samsung_pinctrl_driver = {
 	.driver = {
 		.name	= "samsung-pinctrl",
 		.of_match_table = samsung_pinctrl_dt_match,
+		.suppress_bind_attrs = true,
 	},
 };
 
-- 
1.9.1
