From: lost.distance@yahoo.com (Paul Parsons)
Date: Mon, 27 Feb 2012 14:45:30 +0000 (GMT)
Subject: [PATCH] pxa/hx4700: Avoid unbalanced irq wakeup enables/disables
In-Reply-To: <CAN1soZy4V++oGi9ZuLsC=FS3MaSLRkBRAoQHqAd=3enyNY5WQg@mail.gmail.com>
Message-ID: <1330353930.69282.YahooMailClassic@web29008.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> > On my hx4700 iPAQ running Windows Mobile 5,
> gpio button wakeup is
> >> > configurable under "Start -> Settings ->
> Personal -> Buttons -> Lock".
> >> > There is a checkbox "Disable all buttons
> except power button" which
> >> > enables/disables the keypad and ASIC3 GPIO
> buttons as wakeup sources.
> >> >
> >> > To achieve the same functionality on linux, we
> could split the power
> >> > button and the other buttons into separate
> gpio_keys devices and let
> >> > userspace disable the other buttons as wakeup
> sources via the device's
> >> > pm_wakeup interface.
> >>
> >> It seems that this patch is only enable powerup key
> as wakeup source.
> >
> > Yes. This is temporary until ASIC3 GPIO wakeup support
> is in place.
> >
> >> Other gpio keys could be configured as wakeup
> source in user space. So could
> >> you help to figure out the interface of configuring
> gpio key as wakeup source
> >> in user space?
> >
> > I was thinking of the /sys/devices/.../power/wakeup
> interface, as
> > documented in
> Documentation/ABI/testing/sysfs-devices-power.
> >
> > Put the power button into its own gpio-keys device:
> >
> > diff --git a/arch/arm/mach-pxa/hx4700.c
> b/arch/arm/mach-pxa/hx4700.c
> > index 06ec926..21d26a3 100644
> > --- a/arch/arm/mach-pxa/hx4700.c
> > +++ b/arch/arm/mach-pxa/hx4700.c
> > @@ -166,11 +166,26 @@ static struct
> pxaficp_platform_data ficp_info = {
> > ? ? ? ? ? ? ? ?.active_low = _active_low, ? ?
> ? ? ? ? ?\
> > ? ? ? ? ? ? ? ?.desc ? ? ? = _desc, ? ? ?
> ? ? ? ? ? ? ?\
> > ? ? ? ? ? ? ? ?.type ? ? ? = EV_KEY, ? ?
> ? ? ? ? ? ? ? \
> > - ? ? ? ? ? ? ? .wakeup ? ? = KEY_##_code ==
> KEY_POWER, \
> > + ? ? ? ? ? ? ? .wakeup ? ? = 1, ? ? ? ?
> ? ? ? ? ? ? ? ?\
> > ? ? ? ?}
> >
> > +static struct gpio_keys_button gpio_keys_power_button
> =
> > + ? ? ? INIT_KEY(POWER, ? ? ?
> GPIO0_HX4700_nKEY_POWER, ? 1, "Power button");
> > +
> > +static struct gpio_keys_platform_data
> gpio_keys_power_data = {
> > + ? ? ? .buttons = gpio_keys_power_button,
> > + ? ? ? .nbuttons = 1,
> > +};
> > +
> > +static struct platform_device gpio_keys_power = {
> > + ? ? ? .name = "gpio-keys",
> > + ? ? ? .dev ?= {
> > + ? ? ? ? ? ? ? .platform_data =
> &gpio_keys_power_data,
> > + ? ? ? },
> > + ? ? ? .id ? = 0,
> > +};
> > +
> > ?static struct gpio_keys_button gpio_keys_buttons[] =
> {
> > - ? ? ? INIT_KEY(POWER, ? ? ?
> GPIO0_HX4700_nKEY_POWER, ? 1, "Power button"),
> > ? ? ? ?INIT_KEY(MAIL, ? ? ?
> ?GPIO94_HX4700_KEY_MAIL, ? ?0, "Mail button"),
> > ? ? ? ?INIT_KEY(ADDRESSBOOK,
> GPIO99_HX4700_KEY_CONTACTS,0, "Contacts button"),
> > ? ? ? ?INIT_KEY(RECORD, ? ? ?GPIOD6_nKEY_RECORD,
> ? ? ? ?1, "Record button"),
> > @@ -188,7 +203,7 @@ static struct platform_device
> gpio_keys = {
> > ? ? ? ?.dev ?= {
> > ? ? ? ? ? ? ? ?.platform_data =
> &gpio_keys_data,
> > ? ? ? ?},
> > - ? ? ? .id ? = -1,
> > + ? ? ? .id ? = 1,
> > ?};
> >
> > ?/*
> > @@ -836,6 +851,7 @@ static struct platform_device audio
> = {
> >
> > ?static struct platform_device *devices[] __initdata =
> {
> > ? ? ? ?&asic3,
> > + ? ? ? &gpio_keys_power,
> > ? ? ? ?&gpio_keys,
> > ? ? ? ?&navpoint,
> > ? ? ? ?&backlight,
> >
> > And then let userspace disable wakeup for the other
> keys via
> > echo disabled >
> /sys/devices/platform/gpio-keys.1/power/wakeup
> >
> > The gpio-keys driver will check this setting with
> device_may_wakeup()
> > during gpio_keys_suspend() and decide whether to call
> enable_irq_wake()
> > for its button GPIOs.
> >
> > regards
> > Philipp
> >
> >
> If one of gpio keys wakeup is enabled, every gpio keys in
> this device can
> wakeup system. So your patch is better than original one
> that only keeping
> power key as wakeup source.
> 
> You overwrite Paul's patch. I think that you can format a
> new patch that is
> based on current code base not Paul's patch.

I'm not sure if allowing user space software to define which buttons can
be used as wakeup sources is a really problem which needs to be solved.

Windows Mobile 5 may provide this functionality, but is there any Linux
mobile software which attempts to do this?
