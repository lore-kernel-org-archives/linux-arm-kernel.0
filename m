From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Nov 2014 15:34:05 +0100
Subject: [PATCH 4/9] clk: Add clock driver for mb86s7x
In-Reply-To: <CAJe_ZhcxHnoUeBUk3w=_xyk5oMAuena9RjDnyRvzLtV2=LpQxw@mail.gmail.com>
References: <1416486442-25200-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <2396055.pBuh1YtUHT@wuerfel>
 <CAJe_ZhcxHnoUeBUk3w=_xyk5oMAuena9RjDnyRvzLtV2=LpQxw@mail.gmail.com>
Message-ID: <2147877.AXJukoovHQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 November 2014 18:52:47 Jassi Brar wrote:
> On 21 November 2014 18:33, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thursday 20 November 2014 20:36:15 Vincent Yang wrote:
> >> +#define __DTS_MB86S70_CLK_H
> >> +
> >> +#define MB86S70_CRG11_ALW      0
> >> +#define MB86S70_CRG11_DDR3     1
> >> +#define MB86S70_CRG11_MAIN     2
> >> +#define MB86S70_CRG11_CA15     3
> >> +#define MB86S70_CRG11_HDMI     4
> >> +#define MB86S70_CRG11_DPHY     5
> >> +
> >> +#define MB86S70_CRG11_UNGPRT   8
> >>
> >
> > The clock driver doesn't seem to use those macros at all, how does the
> > driver know which clock you are referring to?
> >
> That was just an attempt to make a bit verbose the controller
> instance. Instead of specifying controller:=4, it reads better
> controller:=MB86S70_CRG11_HDMI in the clock DT nodes. The clock driver
> simply fills in controller+domain+port of the given clock into mailbox
> payload.

See my other comments on the clock nodes. If these are hardware properties,
just leave them as numbers in the DT, the header files are only used to
establish an interface between the binding and the driver in case there
is no sensible way to express which one you have.
 
> Only MB86S70_CRG11_UNGPRT is marked to mean one special (non-maskable)
> port on the controller, which the clock driver does make use of.

Is this the actual port number that is known to be non-maskable?
How about adding a property to the clock node to mark the logical
controller nonmaskable (in case you go for #clock-cells=2)?

For the #clock-cells=3 case, you should probably just hardcode this
in the driver based on the compatible string.

	Arnd
