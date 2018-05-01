From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 1 May 2018 11:48:53 -0700
Subject: [PATCH] Input: atmel_mxt_ts - add missing compatible strings to
 OF device table
In-Reply-To: <20180410095340.24074-1-javierm@redhat.com>
References: <20180410095340.24074-1-javierm@redhat.com>
Message-ID: <20180501184853.GB52077@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2018 at 11:53:40AM +0200, Javier Martinez Canillas wrote:
> Commit af503716ac14 ("i2c: core: report OF style module alias for devices
> registered via OF") fixed how the I2C core reports the module alias when
> devices are registered via OF.
> 
> But the atmel_mxt_ts driver only has an "atmel,maxtouch" compatible in its
> OF device ID table, so if a Device Tree is using a different one, autoload
> won't be working for the module (the matching works because the I2C device
> ID table is used as a fallback).
> 
> So add compatible strings for each of the entries in the I2C device table.
> 
> Fixes: af503716ac14 ("i2c: core: report OF style module alias for devices registered via OF")
> Reported-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
>  Documentation/devicetree/bindings/input/atmel,maxtouch.txt | 6 +++++-
>  drivers/input/touchscreen/atmel_mxt_ts.c                   | 4 ++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
> index 23e3abc3fdef..cd43fb8bc2ce 100644
> --- a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
> +++ b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
> @@ -1,8 +1,12 @@
>  Atmel maXTouch touchscreen/touchpad
>  
>  Required properties:
> -- compatible:
> +- compatible: Must be one of the following
> +    atmel,qt602240_ts
> +    atmel,atmel_mxt_ts
> +    atmel,atmel_mxt_tp
>      atmel,maxtouch
> +    atmel,mXT224

I do not think we should document ad-hoc compatible strings that were
introduced by various vendors as the documented ones, so I'd rather
dropped this chunk and leave only "atmel,maxtouch" as compatible that
everyone should be using.

The changes to the driver to support the existing DTSes can of course be
applied.

Rob, any objections?

>  
>  - reg: The I2C address of the device
>  
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 7659bc48f1db..e8ef83f168d6 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -3238,7 +3238,11 @@ static int __maybe_unused mxt_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(mxt_pm_ops, mxt_suspend, mxt_resume);
>  
>  static const struct of_device_id mxt_of_match[] = {
> +	{ .compatible = "atmel,qt602240_ts", },
> +	{ .compatible = "atmel,atmel_mxt_ts", },
> +	{ .compatible = "atmel,atmel_mxt_tp", },
>  	{ .compatible = "atmel,maxtouch", },
> +	{ .compatible = "atmel,mXT224", },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, mxt_of_match);
> -- 
> 2.14.3
> 

Thanks.

-- 
Dmitry
