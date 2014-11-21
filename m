From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Nov 2014 18:15:16 +0100
Subject: [PATCH 4/9] clk: Add clock driver for mb86s7x
In-Reply-To: <CAJe_Zhdg0tRx1SiACpCci3B2XaCxECGvkE7D=fne6vch4Bhk-w@mail.gmail.com>
References: <1416486442-25200-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <2147877.AXJukoovHQ@wuerfel>
 <CAJe_Zhdg0tRx1SiACpCci3B2XaCxECGvkE7D=fne6vch4Bhk-w@mail.gmail.com>
Message-ID: <5451217.D7Cssxh5Uh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 November 2014 22:06:51 Jassi Brar wrote:
> On 21 November 2014 20:04, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Friday 21 November 2014 18:52:47 Jassi Brar wrote:
> >> On 21 November 2014 18:33, Arnd Bergmann <arnd@arndb.de> wrote:
> >> > On Thursday 20 November 2014 20:36:15 Vincent Yang wrote:
> >> >> +#define __DTS_MB86S70_CLK_H
> >> >> +
> >> >> +#define MB86S70_CRG11_ALW      0
> >> >> +#define MB86S70_CRG11_DDR3     1
> >> >> +#define MB86S70_CRG11_MAIN     2
> >> >> +#define MB86S70_CRG11_CA15     3
> >> >> +#define MB86S70_CRG11_HDMI     4
> >> >> +#define MB86S70_CRG11_DPHY     5
> >> >> +
> >> >> +#define MB86S70_CRG11_UNGPRT   8
> >> >>
> >> >
> >> > The clock driver doesn't seem to use those macros at all, how does the
> >> > driver know which clock you are referring to?
> >> >
> >> That was just an attempt to make a bit verbose the controller
> >> instance. Instead of specifying controller:=4, it reads better
> >> controller:=MB86S70_CRG11_HDMI in the clock DT nodes. The clock driver
> >> simply fills in controller+domain+port of the given clock into mailbox
> >> payload.
> >
> > See my other comments on the clock nodes. If these are hardware properties,
> > just leave them as numbers in the DT, the header files are only used to
> > establish an interface between the binding and the driver in case there
> > is no sensible way to express which one you have.
> >
> OK, I'll hardcode numbers there.
> 
> >> Only MB86S70_CRG11_UNGPRT is marked to mean one special (non-maskable)
> >> port on the controller, which the clock driver does make use of.
> >
> > Is this the actual port number that is known to be non-maskable?
> >
> Yes the clock comes out of the controller and is also the parent of
> other 8 independently maskable clock ports of the domain.

I'm getting confused by the terminology here. Is MB86S70_CRG11_ALW
a port or a controller?

>  The firmware on remote master, lets say, don't wanna be bothered by
> the clock topology. Even for set-rate the onus is on Linux to request
> only appropriate rates at appropriate times so that other devices are
> not messed up.

Is there any code to validate that, or does Linux just treat all
clocks transparently?

> > How about adding a property to the clock node to mark the logical
> > controller nonmaskable (in case you go for #clock-cells=2)?
> >
> > For the #clock-cells=3 case, you should probably just hardcode this
> > in the driver based on the compatible string.
> >
> The SoC has 6 controllers, each controller has 16domains and each
> domain has 8+1 ports. Instead of 864 clocks, we wanted to populate
> only clocks that some device actually use (some clocks seem unused in
> this patchset but we have users that will be upstreamed later).
> The remote f/w can't manage inter-dependencies and expect Linux to
> send only appropriate requests on port basis, so we populate ports as
> tiny independent clock controllers with single clock output.

My impression is that it would be best to model each controller of the
SoC as a clock controller device node with #clock-cells=<2>, and hardcode
the behavior of the special port in the driver.

	Arnd
