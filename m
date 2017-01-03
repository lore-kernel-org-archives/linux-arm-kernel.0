From: Nehal-bakulchandra.Shah@amd.com (Shah, Nehal-bakulchandra)
Date: Tue, 3 Jan 2017 08:37:38 +0000
Subject: [PATCH] pinctrl: amd: fix compilation warning
In-Reply-To: <20170103082119.11958-1-linus.walleij@linaro.org>
References: <20170103082119.11958-1-linus.walleij@linaro.org>
Message-ID: <MWHPR12MB13571FD8C404270F47F5D9FBA06E0@MWHPR12MB1357.namprd12.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Linus for fixing this.

Nehal

-----Original Message-----
From: Linus Walleij [mailto:linus.walleij at linaro.org] 
Sent: Tuesday, January 3, 2017 1:51 PM
To: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org
Cc: linux-gpio at vger.kernel.org; Linus Walleij <linus.walleij@linaro.org>; S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>; Shah, Nehal-bakulchandra <Nehal-bakulchandra.Shah@amd.com>
Subject: [PATCH] pinctrl: amd: fix compilation warning

3bfd44306c65 ("pinctrl: amd: Add support for additional GPIO") created the following warning:

drivers/pinctrl/pinctrl-amd.c: In function 'amd_gpio_dbg_show':
drivers/pinctrl/pinctrl-amd.c:210:3: warning: 'pin_num' may be used uninitialized in this function [-Wmaybe-uninitialized]
   for (; i < pin_num; i++) {
   ^
drivers/pinctrl/pinctrl-amd.c:172:21: warning: 'i' may be used uninitialized in this function [-Wmaybe-uninitialized]
  unsigned int bank, i, pin_num;
                     ^
Fix this by adding a guarding default case for illegal bank numbers.

Cc: S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>
Cc: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-amd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c index 47b17100410e..c2203699f1ab 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -206,6 +206,9 @@ static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 			i = 192;
 			pin_num = AMD_GPIO_PINS_BANK3 + i;
 			break;
+		default:
+			/* Illegal bank number, ignore */
+			continue;
 		}
 		for (; i < pin_num; i++) {
 			seq_printf(s, "pin%d\t", i);
--
2.9.3
