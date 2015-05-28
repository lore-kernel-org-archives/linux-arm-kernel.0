From: noralf@tronnes.org (=?UTF-8?B?Tm9yYWxmIFRyw7hubmVz?=)
Date: Thu, 28 May 2015 23:42:20 +0200
Subject: [PATCH 2/3 v4] ARM: bcm2835: Add the Raspberry Pi firmware driver
In-Reply-To: <1432837987-22861-1-git-send-email-eric@anholt.net>
References: <20150528114500.GP11677@x1>
 <1432837987-22861-1-git-send-email-eric@anholt.net>
Message-ID: <55678BBC.5090507@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Den 28.05.2015 20:33, skrev Eric Anholt:
> This gives us a function for making mailbox property channel requests
> of the firmware, which is most notable in that it will let us get and
> set clock rates.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
...
> +static int rpi_firmware_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct rpi_firmware *fw;
> +
> +	fw = devm_kzalloc(dev, sizeof(*fw), GFP_KERNEL);
> +	if (!fw)
> +		return -ENOMEM;
> +
> +	fw->cl.dev = dev;
> +	fw->cl.rx_callback = response_callback;
> +	fw->cl.tx_block = true;
> +
> +	fw->chan = mbox_request_channel(&fw->cl, 0);
> +	if (IS_ERR(fw->chan)) {
> +		int ret = PTR_ERR(fw->chan);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to get mbox channel: %d\n", ret);
> +		return ret;
> +	}
> +
> +	init_completion(&fw->c);
> +
> +	platform_set_drvdata(pdev, fw);
> +
> +	rpi_firmware_print_firmware_revision(dev);
> +
> +	return 0;
> +}
> +
> +static int rpi_firmware_remove(struct platform_device *pdev)
> +{
> +	struct rpi_firmware *fw = platform_get_drvdata(pdev);
> +
> +	mbox_free_channel(fw->chan);

I guess driver data has to be reset here:
platform_set_drvdata(pdev, NULL);

> +
> +	return 0;
> +}
