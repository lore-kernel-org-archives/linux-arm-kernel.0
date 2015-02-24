From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 24 Feb 2015 15:27:29 +0100
Subject: [PATCH] spi: sirf: add reset controller dependency
In-Reply-To: <6951359.9Y8ugYfjuJ@wuerfel>
References: <4553005.HBquOfbqXe@wuerfel> <6170208.Z0Upu48JrX@wuerfel>
 <20150224075018.GM6236@finisterre.sirena.org.uk>
 <6951359.9Y8ugYfjuJ@wuerfel>
Message-ID: <1424788049.3957.38.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

thanks for taking the time to clean this up.

Am Dienstag, den 24.02.2015, 14:02 +0100 schrieb Arnd Bergmann:
> On Tuesday 24 February 2015 16:50:18 Mark Brown wrote:
> > On Mon, Feb 23, 2015 at 11:01:18PM +0100, Arnd Bergmann wrote:
> > > On Saturday 21 February 2015 18:44:58 Mark Brown wrote:
> > 
> > > > In that case a dependency seems wrong, I'd expect to see a select - it's
> > > > a bit obscure to have to grovel around to figure out what magic options
> > > > are needed to make things turn on and resets feel more like a utility
> > > > thing than a control bus (which tend to be the things we depend on).
> > > > Dunno, perhaps I'm wrong?
> > 
> > > Mixing 'select' and 'depends on' causes recursive dependencies, and
> > > there are already lots of drivers that do 'depends on RESET_CONTROLLER'.
> > 
> > Well, perhaps that's the cleanup we should be doing then...  one of the
> > big problems with some of the other randconfig work there's been is that
> > a lot of the patches just add dependencies without looking at if that
> > makes sense.
> 
> I've tried sanitizing the logic more globally now. The approach below
> gets rid of most of the Kconfig logic and just ensures that things work
> out of the box, by having drivers that call reset_controller_register
> 'select RESET_CONTROLLER', but letting drivers that use the API
> link correctly all the time.
> 
> At the same time, I try to improve the behavior of device_reset_optional(),
> which now returns success if the subsystem is disabled and no 'resets'
> property is present, while the device_reset() call always fails if
> the subsystem is disabled.
> 
> Any comments?

My motivation to not provide (devm_)reset_control_get stubs if
RESET_CONTROLLER is disabled was that drivers using it incorrectly
already fail at build time. If I understand correctly people
overwhelmingly dislike this because it shifts complexity into the build
system instead. With this in mind, I'm ok to let us build drivers that
are effectively broken when RESET_CONTROLLER is disabled, as long as
(devm_)reset_control_get and device_reset cause appropriate warnings.

[...]
> diff --git a/include/linux/reset.h b/include/linux/reset.h
> index da5602bd77d7..72b9d4b67023 100644
> --- a/include/linux/reset.h
> +++ b/include/linux/reset.h
> @@ -40,50 +40,73 @@ struct reset_control *of_reset_control_get(struct device_node *node,
>  
>  #else
>  
> +static inline struct reset_control *reset_control_get(struct device *dev, const char *id)
> +{
> +	return ERR_PTR(-ENOSYS);
> +}
> +
> +static inline struct reset_control *devm_reset_control_get(struct device *dev, const char *id)
> +{
> +	return ERR_PTR(-ENOSYS);
> +}
> +
> +static inline int __must_check device_reset(struct device *dev)
> +{
> +	return -ENOSYS;
> +}
> +

These are never supposed to be called. I'd prefer them to at least print
a warning similar to the stubs below.

>  static inline int reset_control_reset(struct reset_control *rstc)
>  {
> -	WARN_ON(1);
> +	WARN_ON(rstc != NULL);
>  	return 0;
>  }
>  
>  static inline int reset_control_assert(struct reset_control *rstc)
>  {
> -	WARN_ON(1);
> +	WARN_ON(rstc != NULL);
>  	return 0;
>  }
>  
>  static inline int reset_control_deassert(struct reset_control *rstc)
>  {
> -	WARN_ON(1);
> +	WARN_ON(rstc != NULL);
>  	return 0;
>  }
>  
>  static inline int reset_control_status(struct reset_control *rstc)
>  {
> -	WARN_ON(1);
> +	WARN_ON(rstc != NULL);
>  	return 0;
>  }
>  
>  static inline void reset_control_put(struct reset_control *rstc)
>  {
> -	WARN_ON(1);
> +	WARN_ON(rstc != NULL);
>  }
>  
>  static inline int device_reset_optional(struct device *dev)
>  {
> -	return -ENOSYS;
> +	if (of_property_read_bool(dev->of_node, "resets"))
> +		return -ENOSYS;
> +
> +	return 0;
>  }

I approve of these changes.

> +/*
> + * We intentionally return NULL here when no resets are specified
> + * or when building without DT, which is interpreted as 'success'
> + * if reset controller support is left out from the kernel.
> + */
>  static inline struct reset_control *reset_control_get_optional(
>  					struct device *dev, const char *id)
>  {
> -	return ERR_PTR(-ENOSYS);
> +	return ERR_PTR(device_reset_optional(dev));
>  }
>  
>  static inline struct reset_control *devm_reset_control_get_optional(
>  					struct device *dev, const char *id)
>  {
> -	return ERR_PTR(-ENOSYS);
> +	return reset_control_get_optional(dev, id);
>  }

This is a bit indirect, but with the comment it's clear enough.

regards
Philipp
