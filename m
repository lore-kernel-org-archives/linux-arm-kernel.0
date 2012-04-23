From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 23 Apr 2012 09:28:39 +0200
Subject: [PATCH V2 1/3] lib: add support for stmp-style devices
In-Reply-To: <20120422235506.d3377f0e.akpm@linux-foundation.org>
References: <1332368519-22660-1-git-send-email-w.sang@pengutronix.de>
 <1332368519-22660-2-git-send-email-w.sang@pengutronix.de>
 <20120422235506.d3377f0e.akpm@linux-foundation.org>
Message-ID: <20120423072839.GC4568@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 22, 2012 at 11:55:06PM -0700, Andrew Morton wrote:
> On Wed, 21 Mar 2012 23:21:57 +0100 Wolfram Sang <w.sang@pengutronix.de> wrote:
> 
> > MX23/28 use IP cores which follow a register layout I have first seen on
> > STMP3xxx SoCs. In this layout, every register actually has four u32:
> > 
> >  1.) to store a value directly
> >  2.) a SET register where every 1-bit sets the corresponding bit,
> >      others are unaffected
> >  3.) same with a CLR register
> >  4.) same with a TOG (toggle) register
> > 
> > Also, the 2 MSBs in register 0 are always the same and can be used to reset
> > the IP core.
> > 
> > All this is strictly speaking not mach-specific (but IP core specific) and,
> > thus, doesn't need to be in mach-mxs/include. At least, mx6 and mx50 also
> > utilize IP cores following this stmp-style. So:
> > 
> > Introduce a stmp-style device, put the code and defines for that in a public
> > place (lib/), and let drivers for stmp-style devices select that code.
> > To avoid regressions and ease reviewing, the actual code is simply copied from
> > mach-mxs. It definately wants updates, but those need a seperate patch series.
> > 
> > Voila, mach dependency gone, reusable code introduced. Note that I didn't
> > remove the duplicated code from mach-mxs yet, first the drivers have to be
> > converted.
> > 
> > ...
> >
> >  include/linux/stmp_device.h |   20 +++++++++++
> >  lib/Kconfig                 |    3 ++
> >  lib/Makefile                |    2 +
> >  lib/stmp_device.c           |   80 +++++++++++++++++++++++++++++++++++++++++++
> 
> It's good that this is being presented as library code, rather than
> being buried in some device-specific directory then copied and pasted
> ten times.
> 
> But ./lib/ does seem rather a strange place for it.  Perhaps we need a
> drivers/lib/ or something.  We can use ./lib/ for now - it can always
> be moved later on.

The first version had it in drivers/base/ but that also felt strange.
I like drivers/lib/. Arnd, do you agree? Shall I resend?

> 
> > --- /dev/null
> > +++ b/lib/stmp_device.c
> 
> The functions in this file look terribly racy on SMP, or even with
> preemption or interrupts.  What happens if two CPUs or threads run
> stmp_reset_block() against the same device at the same time?
> 
> Perhaps the caller is supposed to prevent that, and the documentation
> which isn't there forgot to mention it ;)

The code needs even more cleanups, timeouts are terrible as well. But as
mentioned above, this series only moves existing code to a central
place. Improvements would be the next, seperate step.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120423/fc45f0e7/attachment.sig>
