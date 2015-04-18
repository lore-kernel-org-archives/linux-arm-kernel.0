From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 18 Apr 2015 21:38:53 +0200
Subject: Allowing reset controllers before SMP initialization (on ARM)?
In-Reply-To: <552F83F0.1090403@st.com>
References: <552F0786.2000505@gmail.com> <2592960.UsK4Hr7GSl@wuerfel>
 <552F83F0.1090403@st.com>
Message-ID: <3152529.IOPeCrhLBg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 April 2015 11:42:08 Maxime Coquelin wrote:
> Hi Florian, Arnd,
> 
> On 04/16/2015 10:04 AM, Arnd Bergmann wrote:
> > On Wednesday 15 April 2015 17:51:18 Florian Fainelli wrote:
> >> Hi,
> >>
> >> In order to support initialization of the secondary core on BCM63138
> >> SoCs, I would want to utilize a reset controller to release the
> >> secondary CPU from reset [1].
> >>
> >> Here are multiple options:
> >>
> >> - expose a custom function which registers the reset controller platform
> >> driver as early as possible, which is probably acceptable, but also
> >> requires the DT machine descriptor to populate the platform bus earlier,
> >> which we could completely avoid
> > I think populating the platform bus earlier is not realistic, that
> > would break lots of existing dependencies. In particular, we can't
> > do it much earlier because it has to be done after the platform bus
> > itself is instantiated.
> >
> >> - have a OF_DECLARE_RESET_CONTROLLER() which is running fairly early
> >> during boot, such that we can utilize reset controllers are early as
> >> possible,  before any initcall level, and before SMP initialization is
> >> kicking in
> > We've added a couple of those, and it could be done here, but putting
> > them in the right order is a bit tricky, and I think we can avoid it.
> 
> I have already proposed a OF_DECLARE_RESET_CONTROLLER() implementation:
> https://lkml.org/lkml/2015/2/20/395
> 
> I needed it for the STM32 timers, but it was not accepted.
> Now, I perform the timers reset in the bootloader, but it shouldn't work 
> in your case.

I guess if there is enough interest in this, we will eventually do it.
This is something we can change at any time without user-visible changes
or DT binding changes. The tradeoff is mainly that without 
OF_DECLARE_RESET_CONTROLLER(), we need a couple of hacks in early init
code, while adding too many of those OF_DECLARE_*() macros has the risk
that we won't be able to order them in a sane way that works on
all platforms, so I'm always reluctant about adding an extra one.

	Arnd
