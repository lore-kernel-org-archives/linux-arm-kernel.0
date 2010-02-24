From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 24 Feb 2010 11:08:24 +0100
Subject: [PATCH 29/39] arm/imx/iomux-v1: make base address a runtime choice
In-Reply-To: <20100224100649.GA6456@pengutronix.de>
References: <20100224100649.GA6456@pengutronix.de>
Message-ID: <1267006114-31743-29-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While at it move register modification to static inlines and
so make the relevant code more readable.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/iomux.h |    1 -
 arch/arm/plat-mxc/iomux-v1.c           |  193 +++++++++++++++++++++-----------
 2 files changed, 127 insertions(+), 67 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/iomux.h b/arch/arm/plat-mxc/include/mach/iomux.h
index 011cfcd..e15d28a 100644
--- a/arch/arm/plat-mxc/include/mach/iomux.h
+++ b/arch/arm/plat-mxc/include/mach/iomux.h
@@ -24,7 +24,6 @@
 *  GPIO Module and I/O Multiplexer
 *  x = 0..3 for reg_A, reg_B, reg_C, reg_D
 */
-#define VA_GPIO_BASE	IO_ADDRESS(GPIO_BASE_ADDR)
 #define MXC_DDIR(x)    (0x00 + ((x) << 8))
 #define MXC_OCR1(x)    (0x04 + ((x) << 8))
 #define MXC_OCR2(x)    (0x08 + ((x) << 8))
diff --git a/arch/arm/plat-mxc/iomux-v1.c b/arch/arm/plat-mxc/iomux-v1.c
index 0b74568..aeaf295 100644
--- a/arch/arm/plat-mxc/iomux-v1.c
+++ b/arch/arm/plat-mxc/iomux-v1.c
@@ -1,9 +1,8 @@
 /*
  * arch/arm/plat-mxc/iomux-v1.c
  *
- * author: Sascha Hauer
- * Created: april 20th, 2004
- * Copyright: Synertronixx GmbH
+ * Copyright (C) 2004 Sascha Hauer, Synertronixx GmbH
+ * Copyright (C) 2009 Uwe Kleine-Koenig, Pengutronix
  *
  * Common code for i.MX1, i.MX21 and i.MX27
  *
@@ -18,9 +17,8 @@
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
+ * along with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.
  */
 
 #include <linux/errno.h>
@@ -34,78 +32,119 @@
 #include <asm/mach/map.h>
 #include <mach/iomux.h>
 
+static void __iomem *imx_iomuxv1_baseaddr;
+
+static inline unsigned long imx_iomuxv1_readl(unsigned offset)
+{
+	return __raw_readl(imx_iomuxv1_baseaddr + offset);
+}
+
+static inline void imx_iomuxv1_writel(unsigned long val, unsigned offset)
+{
+	__raw_writel(val, imx_iomuxv1_baseaddr + offset);
+}
+
+static inline void imx_iomuxv1_rmwl(unsigned offset,
+		unsigned long mask, unsigned long value)
+{
+	unsigned long reg = imx_iomuxv1_readl(offset);
+
+	reg &= ~mask;
+	reg |= value;
+
+	imx_iomuxv1_writel(reg, offset);
+}
+
+static inline void imx_iomuxv1_set_puen(
+		unsigned int port, unsigned int pin, int on)
+{
+	unsigned long mask = 1 << pin;
+
+	imx_iomuxv1_rmwl(MXC_PUEN(port), mask, on ? mask : 0);
+}
+
+static inline void imx_iomuxv1_set_ddir(
+		unsigned int port, unsigned int pin, int out)
+{
+	unsigned long mask = 1 << pin;
+
+	imx_iomuxv1_rmwl(MXC_DDIR(port), mask, out ? mask : 0);
+}
+
+static inline void imx_iomuxv1_set_gpr(
+		unsigned int port, unsigned int pin, int af)
+{
+	unsigned long mask = 1 << pin;
+
+	imx_iomuxv1_rmwl(MXC_GPR(port), mask, af ? mask : 0);
+}
+
+static inline void imx_iomuxv1_set_gius(
+		unsigned int port, unsigned int pin, int inuse)
+{
+	unsigned long mask = 1 << pin;
+
+	imx_iomuxv1_rmwl(MXC_GIUS(port), mask, inuse ? mask : 0);
+}
+
+static inline void imx_iomuxv1_set_ocr(
+		unsigned int port, unsigned int pin, unsigned int ocr)
+{
+	unsigned long shift = (pin & 0xf) << 1;
+	unsigned long mask = 3 << shift;
+	unsigned long value = ocr << shift;
+	unsigned long offset = pin < 16 ? MXC_OCR1(port) : MXC_OCR2(port);
+
+	imx_iomuxv1_rmwl(offset, mask, value);
+}
+
+static inline void imx_iomuxv1_set_iconfa(
+		unsigned int port, unsigned int pin, unsigned int aout)
+{
+	unsigned long shift = (pin & 0xf) << 1;
+	unsigned long mask = 3 << shift;
+	unsigned long value = aout << shift;
+	unsigned long offset = pin < 16 ? MXC_ICONFA1(port) : MXC_ICONFA2(port);
+
+	imx_iomuxv1_rmwl(offset, mask, value);
+}
+
+static inline void imx_iomuxv1_set_iconfb(
+		unsigned int port, unsigned int pin, unsigned int bout)
+{
+	unsigned long shift = (pin & 0xf) << 1;
+	unsigned long mask = 3 << shift;
+	unsigned long value = bout << shift;
+	unsigned long offset = pin < 16 ? MXC_ICONFB1(port) : MXC_ICONFB2(port);
+
+	imx_iomuxv1_rmwl(offset, mask, value);
+}
+
 void mxc_gpio_mode(int gpio_mode)
 {
 	unsigned int pin = gpio_mode & GPIO_PIN_MASK;
 	unsigned int port = (gpio_mode & GPIO_PORT_MASK) >> GPIO_PORT_SHIFT;
 	unsigned int ocr = (gpio_mode & GPIO_OCR_MASK) >> GPIO_OCR_SHIFT;
-	unsigned int tmp;
+	unsigned int aout = (gpio_mode >> GPIO_AOUT_SHIFT) & 3;
+	unsigned int bout = (gpio_mode >> GPIO_BOUT_SHIFT) & 3;
 
 	/* Pullup enable */
-	tmp = __raw_readl(VA_GPIO_BASE + MXC_PUEN(port));
-	if (gpio_mode & GPIO_PUEN)
-		tmp |= (1 << pin);
-	else
-		tmp &= ~(1 << pin);
-	__raw_writel(tmp, VA_GPIO_BASE + MXC_PUEN(port));
+	imx_iomuxv1_set_puen(port, pin, gpio_mode & GPIO_PUEN);
 
 	/* Data direction */
-	tmp = __raw_readl(VA_GPIO_BASE + MXC_DDIR(port));
-	if (gpio_mode & GPIO_OUT)
-		tmp |= 1 << pin;
-	else
-		tmp &= ~(1 << pin);
-	__raw_writel(tmp, VA_GPIO_BASE + MXC_DDIR(port));
+	imx_iomuxv1_set_ddir(port, pin, gpio_mode & GPIO_OUT);
 
 	/* Primary / alternate function */
-	tmp = __raw_readl(VA_GPIO_BASE + MXC_GPR(port));
-	if (gpio_mode & GPIO_AF)
-		tmp |= (1 << pin);
-	else
-		tmp &= ~(1 << pin);
-	__raw_writel(tmp, VA_GPIO_BASE + MXC_GPR(port));
+	imx_iomuxv1_set_gpr(port, pin, gpio_mode & GPIO_AF);
 
 	/* use as gpio? */
-	tmp = __raw_readl(VA_GPIO_BASE + MXC_GIUS(port));
-	if (gpio_mode & (GPIO_PF | GPIO_AF))
-		tmp &= ~(1 << pin);
-	else
-		tmp |= (1 << pin);
-	__raw_writel(tmp, VA_GPIO_BASE + MXC_GIUS(port));
-
-	if (pin < 16) {
-		tmp = __raw_readl(VA_GPIO_BASE + MXC_OCR1(port));
-		tmp &= ~(3 << (pin * 2));
-		tmp |= (ocr << (pin * 2));
-		__raw_writel(tmp, VA_GPIO_BASE + MXC_OCR1(port));
-
-		tmp = __raw_readl(VA_GPIO_BASE + MXC_ICONFA1(port));
-		tmp &= ~(3 << (pin * 2));
-		tmp |= ((gpio_mode >> GPIO_AOUT_SHIFT) & 3) << (pin * 2);
-		__raw_writel(tmp, VA_GPIO_BASE + MXC_ICONFA1(port));
-
-		tmp = __raw_readl(VA_GPIO_BASE + MXC_ICONFB1(port));
-		tmp &= ~(3 << (pin * 2));
-		tmp |= ((gpio_mode >> GPIO_BOUT_SHIFT) & 3) << (pin * 2);
-		__raw_writel(tmp, VA_GPIO_BASE + MXC_ICONFB1(port));
-	} else {
-		pin -= 16;
-
-		tmp = __raw_readl(VA_GPIO_BASE + MXC_OCR2(port));
-		tmp &= ~(3 << (pin * 2));
-		tmp |= (ocr << (pin * 2));
-		__raw_writel(tmp, VA_GPIO_BASE + MXC_OCR2(port));
-
-		tmp = __raw_readl(VA_GPIO_BASE + MXC_ICONFA2(port));
-		tmp &= ~(3 << (pin * 2));
-		tmp |= ((gpio_mode >> GPIO_AOUT_SHIFT) & 3) << (pin * 2);
-		__raw_writel(tmp, VA_GPIO_BASE + MXC_ICONFA2(port));
-
-		tmp = __raw_readl(VA_GPIO_BASE + MXC_ICONFB2(port));
-		tmp &= ~(3 << (pin * 2));
-		tmp |= ((gpio_mode >> GPIO_BOUT_SHIFT) & 3) << (pin * 2);
-		__raw_writel(tmp, VA_GPIO_BASE + MXC_ICONFB2(port));
-	}
+	imx_iomuxv1_set_gius(port, pin, !(gpio_mode & (GPIO_PF | GPIO_AF)));
+
+	imx_iomuxv1_set_ocr(port, pin, ocr);
+
+	imx_iomuxv1_set_iconfa(port, pin, aout);
+
+	imx_iomuxv1_set_iconfb(port, pin, bout);
 }
 EXPORT_SYMBOL(mxc_gpio_mode);
 
@@ -151,6 +190,28 @@ void mxc_gpio_release_multiple_pins(const int *pin_list, int count)
 		gpio_free(gpio);
 		p++;
 	}
-
 }
 EXPORT_SYMBOL(mxc_gpio_release_multiple_pins);
+
+static int imx_iomuxv1_init(void)
+{
+#ifdef CONFIG_ARCH_MX1
+	if (cpu_is_mx1())
+		imx_iomuxv1_baseaddr = MX1_IO_ADDRESS(MX1_GPIO_BASE_ADDR);
+	else
+#endif
+#ifdef CONFIG_MACH_MX21
+	if (cpu_is_mx21())
+		imx_iomuxv1_baseaddr = MX21_IO_ADDRESS(MX21_GPIO_BASE_ADDR);
+	else
+#endif
+#ifdef CONFIG_MACH_MX27
+	if (cpu_is_mx27())
+		imx_iomuxv1_baseaddr = MX27_IO_ADDRESS(MX27_GPIO_BASE_ADDR);
+	else
+#endif
+		return -ENODEV;
+
+	return 0;
+}
+pure_initcall(imx_iomuxv1_init);
-- 
1.6.6.2
