From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 May 2012 21:04:58 +0000
Subject: A good sub-architecture to base new ports on?
In-Reply-To: <CAB9v_DE-FRdyutcZL7EMpTv-9rXqoi+V15T_WyeP9CggrcMZdQ@mail.gmail.com>
References: <CAB9v_DFdTkAFQWFthLncx5frJX0jed11CUoKXJDT-ac6j3hWOQ@mail.gmail.com>
 <201205161557.45362.arnd@arndb.de>
 <CAB9v_DE-FRdyutcZL7EMpTv-9rXqoi+V15T_WyeP9CggrcMZdQ@mail.gmail.com>
Message-ID: <201205172104.59097.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 May 2012, Alexey Zaytsev wrote:
> On Wed, May 16, 2012 at 6:57 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday 16 May 2012, Alexey Zaytsev wrote:
> > Another good one would be highbank, but that contains a lot of stuff you
> > don't need.
> >
> > ixp4xx is not very actively maintained, so I would not use that as
> > a base.
> >
> > What platform are you talking about? I know of a few people that are
> > working on getting older platforms ported to Linux, so maybe someone
> > is already working on a port.
> 
> It's a 'Solos' soc from Connexant. They released kernel code for
> 2.6.11, and I'm up-porting it to the current kernel. I know at least
> two other people interested in the port, adding them to CC. If you
> know anyone else, it would be great to share the effort.

I haven't heard of that architecture before, but I just found the 2.6.11
source you mentioned. spear6xx is probably a good example in that case,
being from a similar age.

Most of the arch code has actually moved to other subsystems nowadays
and would not be considered part of the platform but instead goes to

timer -> drivers/clksource
watchdog -> drivers/watchdog
msc+crypto -> drivers/crypto
spi -> drivers/spi
defaultrestore -> use gpio-keys and a shell script in user space
gpio -> drivers/gpio
gpio-if -> use existing sysfs insterface rather than new driver
udc -> probably similar enough to one that is already there that you
       can resuse code
drivers/serial/solos-serial -> drivers/tty/serial (from /drivers/serial)
driver/net/arm/solos-ether -> drivers/net/ethernet/conexant

My guess is that getting basic functionality (serial, timer, gpio, spi,
watchdog) is all fairly straightforward when you do it right. Ethernet
is going to be harder but is just one driver, and it's hard to tell
how much work the crypto stuff needs.

	Arnd
