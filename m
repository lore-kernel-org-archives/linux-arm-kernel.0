From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Mon, 28 Mar 2016 10:35:45 -0400
Subject: [PATCH 3/4] drivers/bus: make simple-pm-bus.c explicitly
 non-modular
In-Reply-To: <CAMuHMdVjbQZWFqk23=GX1NF-aTKz9SU+c2DUs-BV-zcTqhoqwQ@mail.gmail.com>
References: <1459113058-14340-1-git-send-email-paul.gortmaker@windriver.com>
 <1459113058-14340-4-git-send-email-paul.gortmaker@windriver.com>
 <CAMuHMdVjbQZWFqk23=GX1NF-aTKz9SU+c2DUs-BV-zcTqhoqwQ@mail.gmail.com>
Message-ID: <20160328143545.GN16831@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Re: [PATCH 3/4] drivers/bus: make simple-pm-bus.c explicitly non-modular] On 28/03/2016 (Mon 10:28) Geert Uytterhoeven wrote:

> Hi Paul,
> 
> On Sun, Mar 27, 2016 at 11:10 PM, Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:
> > The Kconfig currently controlling compilation of this code is:
> >
> > config SIMPLE_PM_BUS
> >         bool "Simple Power-Managed Bus Driver"
> >
> > ...meaning that it currently is not being built as a module by anyone.
> >
> > Lets remove the modular code that is essentially orphaned, so that
> > when reading the driver there is no doubt it is builtin-only.
> >
> > We explicitly disallow a driver unbind, since that doesn't have a
> > sensible use case anyway, and it allows us to drop the ".remove"
> > code for non-modular drivers.
> 
> Be prepared for the fallout. There are test farms running bind/unbind cycles
> on random drivers.

If you say so.  I find that a rather odd assertion.  Can you point me at
some automated test results showing bind/unbind being cycled across
all drivers at random?  I would expect many instances of runtime failures.

A while back even LinusW suggested in passing that a blanket blocking
unbind for built-in might make sense ; he was worried that bad things
would happen if people unbind drivers supplying core resources.[1]  But
I noted the PCI pass through case is one valid use case for unbind while
built-in.

The point being that yes there are some valid use cases, but on the
whole they mostly don't make sense for an end user or for most drivers.
So we deal with it case by case currently.

> 
> > Since module_init translates to device_initcall in the non-modular
> > case, the init ordering remains unchanged with this commit.
> >
> > Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
> >
> > We also delete the MODULE_LICENSE tag etc. since all that information
> > was (or is now) contained at the top of the file in the comments.
> >
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Kevin Hilman <khilman@linaro.org>
> > Cc: Simon Horman <horms+renesas@verge.net.au>
> > Cc: linux-arm-kernel at lists.infradead.org
> > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> NAK.
> 
> IIRC, I did test unbind.
> 
> The real and productive fix is to change "bool" to "tristate" in Kconfig.

Fine, I'll drop this patch and welcome your conversion to tristate.  As
I've said several times in the past, authors and/or people with hardware
to test are welcome to convert to tristate, but I personally can't be
extending that functionality myself to all these drivers that are
currently limited to bool/built-in only, but misrepresenting as modular.

> 
> All of these "make ... explicitly non-modular" may have to be reverted again
> when our kernels become too big to boot.

I think that is alarmist and not based on reality, but lets say for the
sake of argument that a handful of drivers do get converted to tristate
down the road.  If that is done on demand, i.e. where the need and
testing is provided by someone who cares, then great!  The code remains
consistent with the Makefile/Kconfig infrastructure in such a change.

But currently there is a significant disconnect between driver code and
the controlling Makefile/Kconfig -- and people just copy that disconnect
into their new driver without even thinking whether they want modular
support or not.  We need to fix that, and we need to be asking as part
of the review of new drivers "Did you actually mean/want tristate here?"
We also should be asking if they expect a valid bind/unbind use case.

Paul.
--

[1] http://lkml.iu.edu/hypermail/linux/kernel/1506.0/02323.html

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
