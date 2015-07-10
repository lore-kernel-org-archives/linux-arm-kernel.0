From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 10 Jul 2015 10:18:01 +0200
Subject: [PATCH-v3 06/11] i2c:pxa: Use devm_ variants in probe function
In-Reply-To: <1436210695-19159-7-git-send-email-vaibhav.hiremath@linaro.org>
References: <1436210695-19159-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1436210695-19159-7-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <20150710081801.GD1528@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -	i2c = kzalloc(sizeof(struct pxa_i2c), GFP_KERNEL);
> +	i2c = devm_kzalloc(&dev->dev, sizeof(struct pxa_i2c), GFP_KERNEL);
>  	if (!i2c) {
> -		ret = -ENOMEM;
> -		goto emalloc;
> +		dev_err(&dev->dev, "memory allocation failed\n");

No message here, we get a dump anyhow.

> +	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&dev->dev, "no mem resource\n");
> +		return -ENODEV;
> +	}

You can skip this check, devm_ioremap_resource will do it.

> +		dev_err(&dev->dev, "failed to get the clk: %ld\n",
> +			PTR_ERR(i2c->clk));

Sidenote for all patches: I am not so strict with the 80 char limit. I'd
think the above code would be more readable if it was one line. But you
decide.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150710/b120f547/attachment.sig>
