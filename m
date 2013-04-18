From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 18 Apr 2013 07:58:02 +0200
Subject: [PATCH] ARM: mach-imx6q: Remove code for setting up cko clock
In-Reply-To: <CAOMZO5AynVOfSq_duGrAkaUtwyx1XjGQQY4558b4GOoMqa7TiQ@mail.gmail.com>
References: <1366224182-29285-1-git-send-email-festevam@gmail.com>
 <20130417195744.GX1906@pengutronix.de>
 <CAOMZO5AynVOfSq_duGrAkaUtwyx1XjGQQY4558b4GOoMqa7TiQ@mail.gmail.com>
Message-ID: <20130418055802.GY1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 17, 2013 at 05:21:25PM -0300, Fabio Estevam wrote:
> Hi Sascha,
> 
> On Wed, Apr 17, 2013 at 4:57 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > On Wed, Apr 17, 2013 at 03:43:02PM -0300, Fabio Estevam wrote:
> >> From: Fabio Estevam <fabio.estevam@freescale.com>
> >>
> >> Let the bootloader setup the cko clock that drives the audio codec.
> >>
> >
> > I really don't like such stuff. Where is documented what's expected from
> > the bootloader? Which versions of which bootloader do implement this?
> 
> As far as I know such documentation does not exist. It would be nice
> to have it, especially now that
> we are recently moving some ARM errata stuff out of the multi plaform kernel.

Yes, that's another thing that should be documented. Without even
documenting it we go into an area where things happen to work in certain
combinations and we won't have good answers when somebody asks on the
list why something doesn't work for him (other than: update your
bootloader and see if that helps)

> 
> I sent patches today for enabling CLKO for sabrelite in Barebox and U-boot.
> 
> > The code you remove is not particularly nice, but just removing it is no
> > solution to the problem.
> 
> Please let me know what is your preferred solution then.
> 
> There was some discussion here:
> https://patchwork.kernel.org/patch/2303011/
> 
> ,but I didn't see this come into any conclusion of what is the
> preferred way to handle this.

It may seemed like I bashed upon putting configuration data in the
devicetree. This wasn't really my intention, I more hoped that there
would be some more discussion about this topic.

I still think that it's a bad idea to just mix the configuration data
with the hardware description, because the hardware doesn't change, but
the confguration data is a matter of usecase and sometimes even personal
taste.
I also think that the devicetree format as such is a good format to
describe such (hardware specific) configuration data.

I'm perfectly fine with having configuration data in the devicetree, but
there should be some strict rules:

- configuration data should be in a separate source dts
- configuration data should be in a separate subtree (/chosen)
- configuration data should *not* be in the board dts files in the
  kernel.
- ideally it should be possible to distribute configuration data and
  hardware description separately. hardware description doesn't change
  (as long as we don't change the bindings of course), but configuration
  data often changes with the usecase or kernel version.

Particularly currently the dts files in the Kernel often enforce a
partition layout for mtd devices. Such things shouldn't happen.

> 
> >
> >> This simplifies a lot the code and when a new board needs to add audio support,
> >> it will not have to add all this amount of code again.
> >
> > It shouldn't be necessary to duplicate the code for each board.
> 
> Yes, some code could be factored out, but every time we need to add
> audio support for a new board we would need to keep polluting
> arch/arm/mach-imx/mach-imx6q.c with things like:
> 
> if (of_machine_is_compatible("fsl,imx6q-xxx"))
>     cko_setup()

We already have the necessary bindings to encode that the SGTL5000 clock
parent is the CLKO pin. That's hardware description and nobody would
object to that. That would only leave the problem of finding the correct
parent.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
