From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 14 Jan 2015 16:03:39 +0100
Subject: [PATCH RFC] pinctrl: at91
In-Reply-To: <CACRpkda9wTPcRy6nRGP08rDpHV=tRyYVuD80TeO2zFGzX+aJcg@mail.gmail.com>
References: <CACRpkdbkUUzVVMp14szY+vGNd+d+8bL066STh_XMGud-UsFBqA@mail.gmail.com>
 <1418637470-5839-1-git-send-email-ludovic.desroches@atmel.com>
 <54943933.60102@atmel.com>
 <20150106093706.GC26982@ldesroches-Latitude-E6320>
 <CACRpkda9wTPcRy6nRGP08rDpHV=tRyYVuD80TeO2zFGzX+aJcg@mail.gmail.com>
Message-ID: <20150114150339.GJ3625@ldesroches-Latitude-E6320>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 01:26:16PM +0100, Linus Walleij wrote:
> On Tue, Jan 6, 2015 at 10:37 AM, Ludovic Desroches
> <ludovic.desroches@atmel.com> wrote:
> 
> > Usage of of_gpiochip_add() only solves my issue about gpio but not about
> > pinctrl stuff, I still need a patch to manage the case when we have a gap if
> > a gpio controller is not enabled to not break the pin naming, etc.
> 
> This has been the topic of many threads today.
> I assume you are talking about keeping GPIO numbers
> consistent.
> 
> - My suggestion is to add alias handling of the GPIO chips
>   to the core so they can be probed in the right order.

We are already using aliases but it seems to not be the perfect
solution. For example, at the probe time, we wait for all gpio
controllers to be probed. We fill a gpio_chips table whose position in
this table is the alias id of the gpio controller. The at91 pinctrl driver
is waiting for 'maximum alias id' gpio controllers. What happens if
don't want to use a gpio controller and don't declare it or set it as
disabled?

> 
> - For consistency in sysfs use the "names" array in
>   struct gpio_chip so you can search for a symbolic
>   name in sysfs and don't have to rely on fragile stuff
>   like GPIO numbers.
> 
> - Partake in the development of a new GPIO ABI
>   that does not use the global GPIO numberspace.

I will have a look and bring my humble contribution if I can but I think
this topic is far away from the fix I am sending.

As you notice we can improve the at91 pinctrl driver, removing
pinctrl_add_gpio_range() and the range computation in the driver but it
won't solve my issue and it involves to add the gpio-range property to
all our devices so it breaks backward compatibility with old dtb.

>From my point of view, it is two distinct topics. One is a very
important fix because our SAMA5D4 device is not booting without it. The
other one is a proper way to manage gpio ranges but alone I don't think
it can solve my issue.


Regards

Ludovic
