From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 22 Oct 2015 22:59:09 +0200
Subject: [PATCH 1/3] i2c: uniphier: add UniPhier FIFO-less I2C driver
In-Reply-To: <1438243942-26401-2-git-send-email-yamada.masahiro@socionext.com>
References: <1438243942-26401-1-git-send-email-yamada.masahiro@socionext.com>
 <1438243942-26401-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20151022205908.GA1516@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 30, 2015 at 05:12:20PM +0900, Masahiro Yamada wrote:
> Add support for on-chip I2C controller used on old UniPhier SoCs
> such as PH1-LD4, PH1-sLD8, etc..  This adapter is so simple that
> it has no FIFO in it.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Finally! Mostly looking good.

> +static u32 uniphier_i2c_functionality(struct i2c_adapter *adap)
> +{
> +	return I2C_FUNC_I2C;
> +}

No I2C_FUNC_SMBUS_EMUL? But check if SMBUS_QUICK is supported by your
adapter.

> +	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!regs) {
> +		dev_err(dev, "failed to get memory resource");
> +		return -EINVAL;
> +	}

This 'if'-block can go. devm_ioremap_resource will check it for you.

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151022/801d0c1a/attachment.sig>
