From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 Jan 2013 10:08:44 +0000
Subject: [PATCH 0/4] gpio: introduce descriptor-based interface
In-Reply-To: <2270940.DTxEYMZtED@percival>
References: <1357629535-26033-1-git-send-email-acourbot@nvidia.com>
 <201301091046.13020.arnd@arndb.de> <2270940.DTxEYMZtED@percival>
Message-ID: <201301101008.45091.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 January 2013, Alex Courbot wrote:
> On Wednesday 09 January 2013 18:46:12 Arnd Bergmann wrote:
> > 
> > Only legacy users did this. Initially there was only the header file,
> > with the API declared but several different implementations of it.
> > gpiolib was introduced later to reduce code duplication and allow having
> > multiple implementations in the same kernel.
> 
> Does the following sound reasonable?
> 1) Make sure every target that uses GENERIC_GPIO also implements its drivers 
> using gpiolib, convert the (hopefully) few ones that don't to use gpiolib
> 2) Make GENERIC_GPIO require GPIOLIB or just merge both options into a single 
> one
> 3) Turn gpio into a full subsystem (like pinctrl)
> 
> This should make things less blurry and easier to maintain (less header files, 
> only one interface, etc.) GPIO controllers would also be better integrated 
> into the driver model.

Yes, I think that would be good.

I've tried to find platforms that don't yet use GPIOLIB and fortunately
there are very few left:

I found two that provide the generic gpio interfaces when gpiolib
is disabled, but use gpiolib otherwise for the same hardware,
arch/m68k/include/asm/mcfgpio.h and arch/blackfin/include/asm/gpio.h.
I would assume that we can simply remove the non-gpiolib shortcut
here at cost of a small overhead.

Then there are a bunch that use gpiolib but have a nontrivial
implementation of gpio_get_value and other functions. I'm not sure
if these are a problematic with your code.

> > Regarding the integration of pinctrl with gpio,
> > I was thinking in the past that we could make pinctrl provide everything
> > that gpiolib does, and have a generic gpiolib driver on top of pinctrl
> > so that platforms don't need to implement both interfaces but only need
> > to provide a pure pinctrl driver. Not sure if this makes any sense.
> 
> That would work if all GPIOs were connected to a ball, but how about GPIO 
> expanders that are external to the chip? They have no use for pinctrl AFAICT. 
> On the other hand, maybe we can have one pinctrl-gpio driver for those chips 
> where pinctrl alone can emulate all the functionality of a GPIO controller. 
> Maybe such a driver exists already?

I don't think we have that yet, but it would be another option: rather
than putting a generic gpiolib driver on top of pinctrl, we could have
pinctrl support for all gpios that go through gpiolib, and move device
drivers over to use pinctrl as the way to manage gpios rather than the
classic gpio drivers. That would be a larger change though, and require
that we pull in the pinctrl subsystem on a lot of machines that don't
need it today.

	Arnd
