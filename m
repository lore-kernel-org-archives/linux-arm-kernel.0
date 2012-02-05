From: balbi@ti.com (Felipe Balbi)
Date: Sun, 5 Feb 2012 11:08:06 +0200
Subject: [PATCH v9 01/25] gpio/omap: remove dependency on gpio_bank_count
In-Reply-To: <CA+HSevqvHAgA+PPLm8BH5vfWkc8yY8W+fRpqjT2urq2EWtSYiA@mail.gmail.com>
References: <20120202191630.GT15343@ponder.secretlab.ca>
 <20120202194545.GA29351@legolas.emea.dhcp.ti.com>
 <4F2AF68D.1000505@ti.com>
 <20120202214907.GA22888@legolas.emea.dhcp.ti.com>
 <20120202215350.GB22888@legolas.emea.dhcp.ti.com>
 <4F2B078B.1040709@ti.com>
 <20120202220744.GA23092@legolas.emea.dhcp.ti.com>
 <87liojajs4.fsf@ti.com>
 <20120204160802.GA10818@legolas.emea.dhcp.ti.com>
 <CA+HSevqvHAgA+PPLm8BH5vfWkc8yY8W+fRpqjT2urq2EWtSYiA@mail.gmail.com>
Message-ID: <20120205090805.GA13300@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Feb 05, 2012 at 12:37:55PM +0530, Varadarajan, Charulatha wrote:
> Felipe,
> 
> On Sat, Feb 4, 2012 at 21:38, Felipe Balbi <balbi@ti.com> wrote:
> >
> > Hi,
> >
> > On Fri, Feb 03, 2012 at 09:50:19AM -0800, Kevin Hilman wrote:
> > > Felipe Balbi <balbi@ti.com> writes:
> > >
> > > [...]
> > >
> > > >> >This question remains. Why do we need those funtions ?
> > > >>
> > > >> These functions are called from the CPUIdle path so outside the scope
> > > >> of the GPIO driver. These are part of a bunch of nasty PM hacks we
> > > >> are doing in the CPU idle loop. We are in the process of getting rid
> > > >> of most of them, but it looks like some are still needed.
> > > >
> > > > Too bad. I can see that the gpio pm implementation seems a bit
> > > > "peculiar". I mean, pm does reference counting and yet the driver has
> > > > checks to prevent multiple gets and puts on a single bank (meaning that
> > > > pm counter will be either 0 or 1 at any point in time).
> > > >
> > > > To me it looks like those functions are there in order to forcefully put
> > > > PER power domain in OFF because drivers are always holding a reference
> > > > to their gpios (drivers generally gpio_request() on probe() and
> > > > gpio_free() on remove()).
> > > >
> > > > Looks like the entire pm implementation on OMAP gpio driver has always
> > > > considered only the fact that gpios can be requested and freed, but
> > > > never that we want the system to go to OFF even while gpios are
> > > > requested, because we have I/O PAD wakeups. At some point that has to be
> > > > sorted out because that HACK is quite ugly :-)
> > > >
> > > > I'll see if I find some time to go over the interactions between
> > > > gpio-omap.c and pm24x.c and pm34xx.c any of these days, but I can't
> > > > promise anything ;-)
> > >
> > > If you look at the state of these prepare/resume hacks at the end of
> > > this series, you'll see that they are significantly cleaner and do
> > > nothing but call the runtime PM hooks.
> >
> > sure, definitely.
> >
> > > We have explored several ways to get rid of them completely in the idle
> > > path but have not yet come up with a clean way, but this series gets us
> > > a long ways towards that goal.
> >
> > have you thought about being a bit more aggressive at when to
> > runtime_get and runtime_put ?
> >
> > I didn't test below (will do probably on monday), but I think this will
> > help keeping GPIO block always suspended, and only wake it up when truly
> > needed. That way, you could, at some point, remove that list_head
> > because by the time you reach CPUIdle path, GPIO module is already
> > suspended. That's the theory at least, gotta run it first on silicon to
> > be sure
> >
> > diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> > index 4273401..2dd9ced 100644
> > --- a/drivers/gpio/gpio-omap.c
> > +++ b/drivers/gpio/gpio-omap.c
> > @@ -537,12 +537,7 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
> > ? ? ? ?struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
> > ? ? ? ?unsigned long flags;
> >
> > - ? ? ? /*
> > - ? ? ? ?* If this is the first gpio_request for the bank,
> > - ? ? ? ?* enable the bank module.
> > - ? ? ? ?*/
> > - ? ? ? if (!bank->mod_usage)
> > - ? ? ? ? ? ? ? pm_runtime_get_sync(bank->dev);
> > + ? ? ? pm_runtime_get_sync(bank->dev);
> 
> bank->mod_usage check is used to take care of doing pm_runtime_get*/put* only
> if all the GPIOs in a particular bank are enabled or disabled respectively.

and why should you care about that ? The first get will enable the
resources you need, the second get will just increase a counter and so
on. So if you have 32 gets, you will disable the module when you have 32
puts.

> With the above change, pm_runtime_put*/get* would be called for every
> gpio_request()
> /_free() (that is, for upto 32 pins in OMAP3/4) in a bank irrespective
> of whether other

so ?

> GPIO pins are enabled or disabled in the same bank. Hence it is
> required to have a
> check based on mod_usage.

unnecessary.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120205/e599a8dd/attachment.sig>
