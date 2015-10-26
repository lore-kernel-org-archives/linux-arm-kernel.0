From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 26 Oct 2015 11:28:34 +0100
Subject: [PATCH 2/3] nvmem: mediatek: Add Mediatek EFUSE driver
In-Reply-To: <562DF8C8.8060600@linaro.org>
References: <1444984751-4572-1-git-send-email-andrew-ct.chen@mediatek.com>
 <1444984751-4572-3-git-send-email-andrew-ct.chen@mediatek.com>
 <562DF8C8.8060600@linaro.org>
Message-ID: <20151026102834.GE25308@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 26, 2015 at 09:56:24AM +0000, Srinivas Kandagatla wrote:
> >+	.val_bits = 32,
> >+	.reg_stride = 4,
> >+};
> >+
> >+static int mtk_efuse_probe(struct platform_device *pdev)
> >+{
> >+	struct device *dev = &pdev->dev;
> >+	struct resource *res;
> >+	struct nvmem_device *nvmem;
> >+	struct nvmem_config *econfig;
> >+	struct regmap *regmap;
> >+	void __iomem *base;
> >+
> >+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >+	base = devm_ioremap_resource(dev, res);
> >+	if (IS_ERR(base))
> >+		return PTR_ERR(base);
> >+
> >+	econfig = devm_kzalloc(dev, sizeof(*econfig), GFP_KERNEL);
> >+	if (!econfig)
> >+		return -ENOMEM;
> Why not use static econfig variable?

Because drivers should not assume there is only one instance of them in
the system. The qfprom driver does this and it's only a matter of
putting a second qcom,qfprom node into the device tree to break the
driver.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
