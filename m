From: broonie@kernel.org (Mark Brown)
Date: Wed, 19 Jun 2013 19:23:54 +0100
Subject: [PATCH v1 2/3] spi: s3c64xx: Added provision for dedicated cs pin
In-Reply-To: <1369032694-13183-3-git-send-email-ks.giri@samsung.com>
References: <1369032694-13183-1-git-send-email-ks.giri@samsung.com>
 <1369032694-13183-3-git-send-email-ks.giri@samsung.com>
Message-ID: <20130619182354.GD1403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 20, 2013 at 12:21:33PM +0530, Girish K S wrote:
> From: Girish K S <girishks2000@gmail.com>
> 
> The existing driver supports gpio based /cs signal.
> For controller's that have one device per controller,
> the slave device's /cs signal might be internally controlled
> by the chip select bit of slave select register. They are not
> externally asserted/deasserted using gpio pin.
> 
> This patch adds support for controllers with dedicated /cs pin.
> if "cs-gpio" property doesnt exist in a spi dts node, the controller
> would treat the /cs pin as dedicated.

This breaks SPI operation on my s3c64xx based system since...

>  	if (pdev->dev.of_node) {
> +		if (of_find_property(pdev->dev.of_node, "cs-gpio", NULL))
> +			sdd->cs_gpio = true;
> +
>  		ret = of_alias_get_id(pdev->dev.of_node, "spi");
>  		if (ret < 0) {
>  			dev_err(&pdev->dev, "failed to get alias id, errno %d\n",

sdd->cs_gpio is only set to true by this code so if you're using a board
file then the GPIO will be ignored.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130619/c605248d/attachment.sig>
