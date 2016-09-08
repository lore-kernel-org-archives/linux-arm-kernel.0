From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 8 Sep 2016 20:40:58 +0100
Subject: [PATCH 4/7] phy: meson: add USB2 PHY support for Meson8b and GXBB
In-Reply-To: <m260q6jibf.fsf@baylibre.com>
References: <20160904213152.25837-1-martin.blumenstingl@googlemail.com>
 <20160904213152.25837-5-martin.blumenstingl@googlemail.com>
 <m260q6jibf.fsf@baylibre.com>
Message-ID: <7d631565-287c-ab38-c152-d65b5ace1e0e@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/16 20:35, Kevin Hilman wrote:
> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
>
>> This is a new driver for the USB PHY found in Meson8b and GXBB SoCs.
>>
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>
> I tested this on meson-gxbb-p200 with USB host and a mass storage
> device.
>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
>
> A minor question/comment below, for you and for Kishon...
>
> [...]
>
>> +static int phy_meson_usb2_probe(struct platform_device *pdev)
>> +{
>> +	struct phy_meson_usb2_priv *priv;
>> +	struct resource *res;
>> +	struct phy *phy;
>> +	struct phy_provider *phy_provider;
>> +	int ret;
>> +
>> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	priv->regs = devm_ioremap_resource(&pdev->dev, res);
>> +	if (IS_ERR(priv->regs))
>> +		return PTR_ERR(priv->regs);
>> +
>> +	priv->clk_usb_general = devm_clk_get(&pdev->dev, "usb_general");
>> +	if (IS_ERR(priv->clk_usb_general))
>> +		return PTR_ERR(priv->clk_usb_general);
>> +
>> +	priv->clk_usb = devm_clk_get(&pdev->dev, "usb");
>> +	if (IS_ERR(priv->clk_usb))
>> +		return PTR_ERR(priv->clk_usb);
>> +
>> +	priv->dr_mode = of_usb_get_dr_mode_by_phy(pdev->dev.of_node, -1);
>> +	if (priv->dr_mode == USB_DR_MODE_UNKNOWN) {
>> +		dev_err(&pdev->dev,
>> +			"missing dual role configuration of the controller\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	phy = devm_phy_create(&pdev->dev, NULL, &phy_meson_usb2_ops);
>> +	if (IS_ERR(phy)) {
>> +		dev_err(&pdev->dev, "failed to create PHY\n");
>> +		return PTR_ERR(phy);
>> +	}
>> +
>> +	if (usb_reset_refcnt++ == 0) {
>> +		ret = device_reset(&pdev->dev);
>> +		if (ret) {
>> +			dev_err(&phy->dev, "Failed to reset USB PHY\n");
>> +			return ret;
>> +		}
>> +	}
>
> The ref count + reset here looks like something that could/should be
> handled in a runtime PM callback.
>
> IOW, there should be a pm_runtime_get_sync() here, and in the
> ->runtime_resume() callback, the device_reset() would be called.
> Runtime PM does the refcounting, and only calls ->runtime_resume() on
> the 0 -> 1 transition.
>
> This isn't a big deal for now, so I'll let Kishon decide, but using
> runtime PM from the start will help enabling other PM features later.

I agree, pm_runtime would probably be the best place to handle >1
device with shared items such as reset.

The version I wrote, I simply enabled the clocks and reset the device
when probed to work around the shared reset.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
