From: segooon@gmail.com (Kulikov Vasiliy)
Date: Sat, 17 Jul 2010 19:19:33 +0400
Subject: [PATCH 2/5] arm: mach-pnx4008: fix sign bug
Message-ID: <1279379974-15192-1-git-send-email-segooon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'ret' is unsigned, so this code is wrong:

    ret = gpio_read_bit(...);
    ...
    if (ret > 0)

If gpio_read_bit() returns -EFAULT then (ret > 0) would be true.
Make 'ret' signed.


The semantic patch that finds this problem (many false-positive results):
(http://coccinelle.lip6.fr/)

// <smpl>
@ r1 @
identifier f;
@@
int f(...) { ... }

@@
identifier r1.f;
type T;
unsigned T x;
@@

*x = f(...)
 ...
*x > 0

Signed-off-by: Kulikov Vasiliy <segooon@gmail.com>
---
 arch/arm/mach-pnx4008/gpio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pnx4008/gpio.c b/arch/arm/mach-pnx4008/gpio.c
index f219914..4a0c0eb 100644
--- a/arch/arm/mach-pnx4008/gpio.c
+++ b/arch/arm/mach-pnx4008/gpio.c
@@ -199,7 +199,7 @@ EXPORT_SYMBOL(pnx4008_gpio_unregister_pin);
 
 unsigned long pnx4008_gpio_read_pin(unsigned short pin)
 {
-	unsigned long ret = -EFAULT;
+	int ret = -EFAULT;
 	int gpio = GPIO_BIT_MASK(pin);
 	gpio_lock();
 	if (GPIO_ISOUT(pin)) {
-- 
1.7.0.4
