From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 12 Jan 2010 19:50:36 +1100
Subject: [RFC,PATCH 1/7] arm: add a common struct clk
In-Reply-To: <4B4C2C27.6030306@st.com>
References: <1262907852.736281.78480196040.1.gpush@pororo>
	<201001081426.09754.jk@ozlabs.org>
	<20100108094214.GA23420@n2100.arm.linux.org.uk>
	<201001111437.16404.jeremy.kerr@canonical.com>
	<4B4C2C27.6030306@st.com>
Message-ID: <1263286236.724.205.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-01-12 at 09:00 +0100, Francesco VIRLINZI wrote:
> struct clk_operations {
>         int (*init)(struct clk *);      /* used on clk_register and
> during resume from hibernation */
>         ...
> }

I believe this is unnecessary. 

The way I see things, the struct clk is provided by clk_get() in one of
two ways:

 - Some static structure the platform is keeping around. In that case
there should be nothing to do for init. In addition, regarding
suspend/resume, those core clocks are way too sensitive beasts to be
left to the generic PM framework. They are likely to require being
turned on/off in a specific sequence or need specific re-init on resume
that only the platform code knows about, so I would leave all of that
there (for SoC clocks at least)

 - Via calling into a "clock provider" which instanciate the struct clk
(or returns a pre-instanciated one). That could be using the device-tree
based infrastructure that I proposed for powerpc and that Jeremy is
attempting to use on ARM, clkdev, or some other mechanism the platform
provides. In this case, the provider's get() method is your init (or
rather whtever it does to instanciate a clock) and is private to a given
"subclass" of struct clk. Again, whatever is needed for suspend/resume
also remains into the realm of that specific implementation of a struct
clk.

> struct clk {
>         const struct clk_operations *ops;
>         spinlock_t      lock;   /* to serialize the clk_operations */
>         const           *name;
>         int             id;
>         unsigned long   rate;           /* used when ops->get_rate is
> NULL */
> };

Here again. Things like lock, name, id, ... are really unnecessary in
many cases and I'd happily leave them to the specific details of a given
struct clk "subclass".

If one wants to find a way to "expose" struct clk in the system into
sysfs or something like that, and as such as a name etc... I would
recommend keeping that a specific CONFIG option which can be disabled as
while I was teasing folks a bit on the "bloat" argument for adding a
couple of function pointers, your proposal would grow the footprint a
lot more significantly.

Besides, the overhead of a spinlock might be utterly uncecessary for a
few clk implementations so why add it to all ?

Cheers,
Ben.
