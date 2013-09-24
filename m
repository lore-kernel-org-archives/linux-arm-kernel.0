From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 24 Sep 2013 08:01:52 -0400
Subject: [PATCH RESEND] ARM: add dtbImage.<dt> and dtbuImage.<dt> rules
In-Reply-To: <52416F97.802@keymile.com>
References: <504DFBBF.5010202@free-electrons.com>
 <1348733441-11626-1-git-send-email-richard.genoud@gmail.com>
 <20120927082955.GR17667@game.jcrosoft.org>
 <CACQ1gAgwv4pBFZBrVZiWM2_=OneUO-s16LufSENx27gMC3DUig@mail.gmail.com>
 <52416F97.802@keymile.com>
Message-ID: <20130924120152.GI11119@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gerlando,

On Tue, Sep 24, 2013 at 12:55:19PM +0200, Gerlando Falauto wrote:
> We're in the position where we'd like to have FDT support just
> because it simplifies our code a whole lot;

Great!

> yet we want to be able to run such a kernel on older u-boots
> (completely unaware of FTDs) as well.
> I believe this must be a very common use case indeed.

Yes, very much so.  With the understanding that this is an artifact of
the transition, hopefully not a permanent state. ;-)

> So a dtbuImage.<dtb> would be very useful in this case.

well...

> If I understand it correctly, dtbImage.<dtb> is indeed just a cat of
> zImage+dtb, whereas dtbuImage.<dtb> is the uimage of such a
> dtbImage.<dtb>.

Yes.

> So it shouldn't be such a crazy idea to create a dtbuImage.<dtb>
> within Kbuild (as opposed to from an external wrapper for make).

Yes :)  The problem is that we are moving to multiplatform zImages.  In
that scenario, the uImage target isn't very helpful because it needs to
be custom to each board.  Additionally, appended-dtb was intended as a
developer tool and isn't intended as a deployable item.  It also
defeats the purpose of multiplatform.

> Is there any reason why nothing like that was ever mainlined?
> Or maybe I'm just missing something?

We are strongly encouraging all vendors to upgrade their bootloaders to
support field upgradeable dtbs.  eg having the dtb on a separate
partition of the flash (or whereever the bootloader environment is)

iirc, keymile is using an odd flavor of Kirkwood.  Have you tried kwboot
over serial?  It can be found in barebox and u-boot source repositories.

The above is the long-term goal, in the short term, please take a look
at:

https://github.com/zonque/pxa-impedance-matcher

You can use this to boot a modern fdt kernel on a legacy bootloader,
with one or more dtb's linked in.  I tested it on the dreamplug, so it's
mostly there for you.

The big outstanding TODO I have on it is to parse the atags and modify
the selected dtb before passing off to the kernel.  Patches welcome! :)

hth,

Jason.
