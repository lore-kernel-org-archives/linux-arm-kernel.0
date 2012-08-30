From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 30 Aug 2012 17:52:33 +0100
Subject: [PATCH 00/10] Make mach/gpio.h optional
In-Reply-To: <503F8653.40908@gmail.com>
References: <1346279496-26286-1-git-send-email-robherring2@gmail.com>
 <20120829234030.GV18957@n2100.arm.linux.org.uk> <503F8653.40908@gmail.com>
Message-ID: <20120830165233.GZ18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2012 at 10:27:15AM -0500, Rob Herring wrote:
> On 08/29/2012 06:40 PM, Russell King - ARM Linux wrote:
> > On Wed, Aug 29, 2012 at 05:31:26PM -0500, Rob Herring wrote:
> >> From: Rob Herring <rob.herring@calxeda.com>
> >>
> >> This series makes mach/gpio.h optional like we have done for other mach
> >> headers in preparation for multi-platform kernel images. Unfortunately,
> >> it adds more mach includes to drivers/, but really they are just now
> >> explicitly included and easily found.
> > 
> > This in general looks like a complete backwards step rather than a forwards
> > step for multi-platform kernels.  All these drivers are not going to be
> > usable in multi-platform kernel images, because with mach/ includes they're
> > not going to be picking up the correct set of headers.
> 
> These drivers are already not usable. I'm just making that obvious.

Yes, by undoing all the work I did cleaning up the gpio shite, which I
object to.

> > So all these SoC types might as well not be part of the multi-platform
> > project until they get their act together with their headers.
> 
> Precisely the point. It is pushing the problem to the sub-arches so they
> can clean-up their stuff if they want to get into a multi-plat image. I
> expect we will see some clean starting in parallel with this. The omap
> folks are working omap headers and there were some clean-ups for Marvell
> parts posted. Arnd has platform_data header series he is working on.

No, it is undoing the work I did getting rid of mach/gpio.h includes, and
tidying up the asm/gpio.h & mach/gpio.h crap, ensuring that stuff won't
work properly with mach/gpio.h includes, and encouraging everyone to move
to the right include - linux/gpio.h.  You're undoing all that work by
effectively saying "we want you to start using mach/gpio.h because this
patch is re-introducing it".

So, a very strong NAK against that from me.

If they're not able to be part of a multi-platform kernel as they stand,
and they're still not able after your patch series, you've not achieved
anything material, and the changes you propose are just pure churn.

If you're thinking that your patch series will spark cleanup work, then
you're mistaken - no one cares about gpio header files, if they did then
my cleanup to make stuff use asm/gpio.h or linux/gpio.h would have also
sparked cleanup, which it didn't.  So please stop daydreaming that patches
spark other people to do cleanups.

What sparks people into life is when you tell them that their favourite
arch can't be part of new feature Y because Z is incompatible.  They'll
then fix Z if they want feature Y.

Sure, no problem with getting rid of the empty gpio.h headers, and
ifdef'ing the mach/gpio.h include - but don't then go around changing
all those asm/gpio.h's into mach/gpio.h's.
