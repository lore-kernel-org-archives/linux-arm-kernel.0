From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 18 Dec 2012 07:04:15 +0100
Subject: [PATCH 1/2] gpiolib: add gpio_export_with_name
In-Reply-To: <20121128201907.GF4398@game.jcrosoft.org>
References: <20121121101259.GQ4398@game.jcrosoft.org>
 <1353492849-29397-1-git-send-email-plagnioj@jcrosoft.com>
 <20121126135911.2F1D33E187C@localhost>
 <20121128201907.GF4398@game.jcrosoft.org>
Message-ID: <20121218060415.GM23971@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21:19 Wed 28 Nov     , Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 13:59 Mon 26 Nov     , Grant Likely wrote:
> > On Wed, 21 Nov 2012 11:14:08 +0100, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> wrote:
> > > allow to specify a name to an exported gpio
> > > 
> > > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > 
> > The gpio sysfs ABI is already horrible, racy, and unsafe. Really, we
> > need a proper chrdev interface for controlling gpios. Sysfs is fine for
> > poking around and experimenting, but we cannot provide any fine grained
> > access control, locking or faster IO with the one-file-per-gpio sysfs
> > model.
> I do agree on this and mention it on the ML multiple times but this an ABI
> and we can not change it anymore we need to support it
> > So, no, I don't think this is a good idea to extend gpiolib in
> > this way.
> > 
> > However, I would be okay with making gpiochips first-class kobjects or
> > struct devices that appear as a child of the gpio controller device so
> > that userspace could interrogate the device tree node associated with
> > the device.
> the problem here is that I do not want the user space to become smart
> 
> I want the user space to known which gpio use for a specific feature
> as example you just want to read lack restistor to detect a hw features
> 
> you known the encoding it does not change cross hw but the pin to read do
> 
> So the idea is just to tell the user space use this pin to get your
> information
> 
> how to do you want to solve this?
> 
> This apply to other case:
>  - chip poweron/off
>  - reset
>  etc... all control by userspace

ping
> 
> Best Regards,
> J.
> > 
> > g.
> > 
> > > ---
> > >  arch/mips/include/asm/mach-au1x00/gpio-au1000.h |    3 ++-
> > >  arch/mips/include/asm/mach-au1x00/gpio-au1300.h |    3 ++-
> > >  drivers/gpio/gpiolib.c                          |   12 +++++++-----
> > >  include/asm-generic/gpio.h                      |    6 ++++--
> > >  include/linux/gpio.h                            |   23 ++++++++++++++++++++++-
> > >  5 files changed, 37 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/arch/mips/include/asm/mach-au1x00/gpio-au1000.h b/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
> > > index 73853b5a..af4accb 100644
> > > --- a/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
> > > +++ b/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
> > > @@ -633,7 +633,8 @@ static inline int gpio_set_debounce(unsigned gpio, unsigned debounce)
> > >  	return -ENOSYS;
> > >  }
> > >  
> > > -static inline int gpio_export(unsigned gpio, bool direction_may_change)
> > > +static inline int gpio_export_with_name(unsigned gpio,
> > > +	bool direction_may_change, const char *name)
> > >  {
> > >  	return -ENOSYS;
> > >  }
> > > diff --git a/arch/mips/include/asm/mach-au1x00/gpio-au1300.h b/arch/mips/include/asm/mach-au1x00/gpio-au1300.h
> > > index fb9975c..fcd152e 100644
> > > --- a/arch/mips/include/asm/mach-au1x00/gpio-au1300.h
> > > +++ b/arch/mips/include/asm/mach-au1x00/gpio-au1300.h
> > > @@ -234,7 +234,8 @@ static inline void gpio_unexport(unsigned gpio)
> > >  {
> > >  }
> > >  
> > > -static inline int gpio_export(unsigned gpio, bool direction_may_change)
> > > +static inline int gpio_export_with_name(unsigned gpio,
> > > +	bool direction_may_change, const char *name)
> > >  {
> > >  	return -ENOSYS;
> > >  }
> > > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > > index b667f76..2141165 100644
> > > --- a/drivers/gpio/gpiolib.c
> > > +++ b/drivers/gpio/gpiolib.c
> > > @@ -714,9 +714,10 @@ static struct class gpio_class = {
> > >  
> > >  
> > >  /**
> > > - * gpio_export - export a GPIO through sysfs
> > > + * gpio_export_with_name - export a GPIO through sysfs
> > >   * @gpio: gpio to make available, already requested
> > >   * @direction_may_change: true if userspace may change gpio direction
> > > + * @name: gpio name
> > >   * Context: arch_initcall or later
> > >   *
> > >   * When drivers want to make a GPIO accessible to userspace after they
> > > @@ -728,7 +729,7 @@ static struct class gpio_class = {
> > >   *
> > >   * Returns zero on success, else an error.
> > >   */
> > > -int gpio_export(unsigned gpio, bool direction_may_change)
> > > +int gpio_export_with_name(unsigned gpio, bool direction_may_change, const char *name)
> > >  {
> > >  	unsigned long		flags;
> > >  	struct gpio_desc	*desc;
> > > @@ -766,7 +767,9 @@ int gpio_export(unsigned gpio, bool direction_may_change)
> > >  		direction_may_change = false;
> > >  	spin_unlock_irqrestore(&gpio_lock, flags);
> > >  
> > > -	if (desc->chip->names && desc->chip->names[gpio - desc->chip->base])
> > > +	if (name)
> > > +		ioname = name;
> > > +	else if (desc->chip->names && desc->chip->names[gpio - desc->chip->base])
> > >  		ioname = desc->chip->names[gpio - desc->chip->base];
> > >  
> > >  	dev = device_create(&gpio_class, desc->chip->dev, MKDEV(0, 0),
> > > @@ -804,7 +807,7 @@ fail_unlock:
> > >  	pr_debug("%s: gpio%d status %d\n", __func__, gpio, status);
> > >  	return status;
> > >  }
> > > -EXPORT_SYMBOL_GPL(gpio_export);
> > > +EXPORT_SYMBOL_GPL(gpio_export_with_name);
> > >  
> > >  static int match_export(struct device *dev, void *data)
> > >  {
> > > @@ -856,7 +859,6 @@ done:
> > >  }
> > >  EXPORT_SYMBOL_GPL(gpio_export_link);
> > >  
> > > -
> > >  /**
> > >   * gpio_sysfs_set_active_low - set the polarity of gpio sysfs value
> > >   * @gpio: gpio to change
> > > diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
> > > index b6516f3..d04fc55 100644
> > > --- a/include/asm-generic/gpio.h
> > > +++ b/include/asm-generic/gpio.h
> > > @@ -204,7 +204,8 @@ void devm_gpio_free(struct device *dev, unsigned int gpio);
> > >   * A sysfs interface can be exported by individual drivers if they want,
> > >   * but more typically is configured entirely from userspace.
> > >   */
> > > -extern int gpio_export(unsigned gpio, bool direction_may_change);
> > > +extern int gpio_export_with_name(unsigned gpio, bool direction_may_change,
> > > +			const char *name);
> > >  extern int gpio_export_link(struct device *dev, const char *name,
> > >  			unsigned gpio);
> > >  extern int gpio_sysfs_set_active_low(unsigned gpio, int value);
> > > @@ -249,7 +250,8 @@ struct device;
> > >  
> > >  /* sysfs support is only available with gpiolib, where it's optional */
> > >  
> > > -static inline int gpio_export(unsigned gpio, bool direction_may_change)
> > > +static inline int gpio_export_with_name(unsigned gpio,
> > > +	bool direction_may_change, const char *name)
> > >  {
> > >  	return -ENOSYS;
> > >  }
> > > diff --git a/include/linux/gpio.h b/include/linux/gpio.h
> > > index 7ba2762..6e01b8c 100644
> > > --- a/include/linux/gpio.h
> > > +++ b/include/linux/gpio.h
> > > @@ -189,7 +189,8 @@ static inline void gpio_set_value_cansleep(unsigned gpio, int value)
> > >  	WARN_ON(1);
> > >  }
> > >  
> > > -static inline int gpio_export(unsigned gpio, bool direction_may_change)
> > > +static inline int gpio_export_with_name(unsigned gpio,
> > > +	bool direction_may_change, const char *name)
> > >  {
> > >  	/* GPIO can never have been requested or set as {in,out}put */
> > >  	WARN_ON(1);
> > > @@ -247,4 +248,24 @@ gpiochip_remove_pin_ranges(struct gpio_chip *chip)
> > >  
> > >  #endif /* ! CONFIG_GENERIC_GPIO */
> > >  
> > > +/**
> > > + * gpio_export - export a GPIO through sysfs
> > > + * @gpio: gpio to make available, already requested
> > > + * @direction_may_change: true if userspace may change gpio direction
> > > + * Context: arch_initcall or later
> > > + *
> > > + * When drivers want to make a GPIO accessible to userspace after they
> > > + * have requested it -- perhaps while debugging, or as part of their
> > > + * public interface -- they may use this routine.  If the GPIO can
> > > + * change direction (some can't) and the caller allows it, userspace
> > > + * will see "direction" sysfs attribute which may be used to change
> > > + * the gpio's direction.  A "value" attribute will always be provided.
> > > + *
> > > + * Returns zero on success, else an error.
> > > + */
> > > +static inline int gpio_export(unsigned gpio,bool direction_may_change)
> > > +{
> > > +	return gpio_export_with_name(gpio, direction_may_change, NULL);
> > > +}
> > > +
> > >  #endif /* __LINUX_GPIO_H */
> > > -- 
> > > 1.7.10.4
> > > 
> > > 
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel at lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 
> > -- 
> > Grant Likely, B.Sc, P.Eng.
> > Secret Lab Technologies, Ltd.
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
