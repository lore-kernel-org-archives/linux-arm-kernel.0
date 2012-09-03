From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 3 Sep 2012 12:11:06 +0100
Subject: [PATCH] gpio/omap: fix possible memory leak in
 omap2_gpio_dev_init()
In-Reply-To: <CAPgLHd9A0-Esqt8D87RunMWFFG7uTCERksia26DSO1xw8OUfmg@mail.gmail.com>
References: <CAPgLHd9A0-Esqt8D87RunMWFFG7uTCERksia26DSO1xw8OUfmg@mail.gmail.com>
Message-ID: <20120903111106.GA24189@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 03, 2012 at 06:13:33PM +0800, Wei Yongjun wrote:
> @@ -130,6 +132,7 @@ static int __init omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
>  
>  	pdev = omap_device_build(name, id - 1, oh, pdata,
>  				sizeof(*pdata),	NULL, 0, false);
> +	kfree(pdata->regs);
>  	kfree(pdata);

This one looks wrong.  pdata is copied by the internals of
omap_device_build(), which includes the 'regs' pointer, so it should not
be freed after a successful call to omap_device_build().  (It should,
however, be freed after an unsuccessful call.)

BTW, you want to copy Paul Walmsley with this patch (address in Cc).
