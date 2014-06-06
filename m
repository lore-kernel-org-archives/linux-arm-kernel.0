From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Fri, 6 Jun 2014 13:59:32 +0200
Subject: [PATCH 4/9] usb: phy: add the Berlin USB PHY driver
In-Reply-To: <53919DCE.1050708@gmail.com>
References: <1401983326-19205-1-git-send-email-antoine.tenart@free-electrons.com>
 <1401983326-19205-5-git-send-email-antoine.tenart@free-electrons.com>
 <53919DCE.1050708@gmail.com>
Message-ID: <20140606115932.GB32416@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian,

On Fri, Jun 06, 2014 at 12:54:06PM +0200, Sebastian Hesselbarth wrote:
> On 06/05/2014 05:48 PM, Antoine T?nart wrote:
> >+
> >+#include <linux/gpio.h>
> >+#include <linux/io.h>
> >+#include <linux/module.h>
> >+#include <linux/of_gpio.h>
> >+#include <linux/usb/phy.h>
> >+#include <linux/platform_device.h>
> >+#include <linux/reset.h>
> 
> nit: keep above alphabetically sorted.

Oops. Sure.

> >+
> >+/* USB_PHY_PLL */
> >+#define CLK_REF_DIV(x)		((x) << 4)
> >+#define FEEDBACK_CLK_DIV(x)	((x) << 8)
> >+
> >+/* USB_PHY_PLL_CONTROL */
> >+#define CLK_STABLE		(0x1 << 0)
> >+#define PLL_CTRL_PIN		(0x1 << 1)
> >+#define PLL_CTRL_REG		(0x1 << 2)
> >+#define PLL_ON			(0x1 << 3)
> >+#define PHASE_OFF_TOL_125	(0x0 << 5)
> >+#define PHASE_OFF_TOL_250	(0x1 << 5)
> >+#define KVC0_CALIB		(0x0 << 9)
> >+#define KVC0_REG_CTRL		(0x1 << 9)
> >+#define KVC0_HIGH		(0x0 << 10)
> >+#define KVC0_LOW		(0x3 << 10)
> >+#define CLK_BLK_EN		(0x1 << 13)
> 
> BIT() for the single bit flags above and below.

I'll update with BIT().

> >+
> >+struct berlin_phy_priv {
> >+	void __iomem		*base;
> >+	struct usb_phy		phy;
> >+	struct reset_control	*rst_ctrl;
> >+	int			pwr_gpio;
> 
> Is the GPIO used for USB power? If so, we should not rely on
> GPIO at all but use regulator API. Thinking of Chromecast which
> is externally powered over USB, there will be no regulator nor
> GPIO at all.

[?]

> 
> As mentioned above, this should be using regulator API. And also, if
> there is no dummy regulator allowed, it should be optional.

I'll make this optional.

> 
> >+static int berlin_phy_probe(struct platform_device *pdev)
> >+{
> >+	struct device_node *np = pdev->dev.of_node;
> >+	struct berlin_phy_priv *priv;
> >+	struct resource *res;
> >+	int ret, gpio;
> >+
> >+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> >+	if (!priv)
> >+		return -ENOMEM;
> >+
> >+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >+	priv->base = devm_ioremap_resource(&pdev->dev, res);
> >+	if (IS_ERR(priv->base))
> >+		return PTR_ERR(priv->base);
> >+
> >+	priv->rst_ctrl = devm_reset_control_get(&pdev->dev, NULL);
> >+	if (IS_ERR(priv->rst_ctrl)) {
> >+		ret = PTR_ERR(priv->rst_ctrl);
> >+		dev_err(&pdev->dev, "cannot get reset controller: %d\n", ret);
> 
> Hmm, considering a non arch_init call registered reset driver, it does
> also spit out an error for -EPROBE_DEFER, does it?

Yes, it does.


Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
