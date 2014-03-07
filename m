From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 7 Mar 2014 15:24:05 +0100
Subject: [PATCH] i2c: mv64xxx: Fix circular dependencies warning and
 compilation breakage
In-Reply-To: <1394199795-5516-1-git-send-email-maxime.ripard@free-electrons.com>
References: <20140307111858.GB12274@katana>
 <1394199795-5516-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140307142405.GB28943@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


New patch -> new thread, please.

> This patch fixes the circular dependency introduced by commit 370136bc67c3
> ("i2c: mv64xxx: Add reset deassert call"):
> 
> drivers/video/Kconfig:42:error: recursive dependency detected!

Please base it on i2c-next. I already applied my patch.
Your patch fixes the build error discovered by it.

> Since the reset framework doesn't define dummy stubs whenever
> CONFIG_RESET_CONTROLLER is not defined, it's the only sane way to have a driver
> that compiles in any cases.

Paragraph needs reformat. And please drop "sane". #ifdefs are not sane.
Fixing the reset framework would be sane.

> @@ -900,7 +902,8 @@ mv64xxx_i2c_probe(struct platform_device *pd)
>  exit_free_irq:
>  	free_irq(drv_data->irq, drv_data);
>  exit_reset:
> -	if (pd->dev.of_node && !IS_ERR(drv_data->rstc))
> +	if (pd->dev.of_node && IS_ENABLED(CONFIG_RESET_CONTROLLER) &&
> +	    !IS_ERR(drv_data->rstc))

Why don't you simply set rstc to some ERR_PTR above if not
RESET_CONTROLLER?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140307/a367f75e/attachment.sig>
