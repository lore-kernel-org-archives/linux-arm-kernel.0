From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Mar 2011 08:48:58 +0000
Subject: [PATCH 1/4] amba: add name based matching
In-Reply-To: <AANLkTinrVeaGXhE8mUqMJCw0fzeEB7Ko+p6ViD3JWePX@mail.gmail.com>
References: <1300200116-12185-1-git-send-email-philippe.langlais@stericsson.com>
	<1300200116-12185-2-git-send-email-philippe.langlais@stericsson.com>
	<20110315144925.GG3921@n2100.arm.linux.org.uk>
	<AANLkTinrVeaGXhE8mUqMJCw0fzeEB7Ko+p6ViD3JWePX@mail.gmail.com>
Message-ID: <20110317084858.GB29758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 17, 2011 at 09:47:35AM +0100, Linus Walleij wrote:
> 2011/3/15 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> 
> > I really hate the idea of matching AMBA stuff by name. ?Isn't there any
> > other solution to this?
> 
> What do you think about this:
> 
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 6d2bb25..fcf355c 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -603,6 +603,10 @@ int amba_device_register(struct amba_device *dev,
> struct resource *parent)
>         if (ret)
>                 goto err_out;
> 
> +       /* Hard-coded primecell ID instead of plug-n-play */
> +       if (dev->periphid != 0)
> +               goto skip_probe;
> +
>         /*
>          * Dynamically calculate the size of the resource
>          * and use this for iomap
> @@ -643,6 +647,7 @@ int amba_device_register(struct amba_device *dev,
> struct resource *parent)
>         if (ret)
>                 goto err_release;
> 
> + skip_probe:
>         ret = device_add(&dev->dev);
>         if (ret)
>                 goto err_release;
> 
> This way, if we hardcode periphid in the platform, it will take
> precedence. Currently hardware will override such hard-codec
> values.
> 
> There are a few instances using this in the kernel I think, but
> to my memory they are all of the type where the hardcoded
> number and the ID found in hardware are actually identical,
> and eiher make no harm or should be patched away with.

This means we don't pick up on the hardware configuration when platforms
have set the ID, and since we always provide the ID that would be bad.
