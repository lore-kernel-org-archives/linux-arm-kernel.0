From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 23 Jul 2010 15:17:14 +0100
Subject: ARM Machine SoC I/O setup and PAD initialization code
In-Reply-To: <201007231218.07379.david.jander@protonic.nl>
References: <201007211029.29529.david.jander@protonic.nl>
	<201007221531.58744.david.jander@protonic.nl>
	<20100722142043.GK4737@rakim.wolfsonmicro.main>
	<201007231218.07379.david.jander@protonic.nl>
Message-ID: <20100723141712.GC12300@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 23, 2010 at 12:18:07PM +0200, David Jander wrote:
> On Thursday 22 July 2010 04:20:43 pm Mark Brown wrote:

> > I suspect it's more that there are vastly fewer PowerPC vendors out
> > there so much less independant development - compared to ARM the PowerPC
> > devices are *very* homogenous.

> That could indeed be part of the reason... but there are not _so_ few PowerPC 
> vendors actually: Chips are made by Freescale, AMCC and IBM mainly (PASemi 
> used to exist also), but boards and workstations are made by quite a lot of 
> vendors (we are one ;-)

This is a vanishingly small number of chip vendors (and hence original
BSPs, which are the main issue here) in comparison with the ARM market.

> > Usually the people doing the kernel bringup on an actual end system will
> > be part of the same organisation that does the hardware design - if
> > there's a problem the kernel developer can usually locate the orginal
> > hardware designer.

> Then why can't they get the boot-loader fixed?

In extreme cases the bootloader may be provided as binary by the SoC
vendor and not changable, but there can also be the other concerns I
mentioned with things like deploying updates throughout the team.
Sometimes the bootloader code supplied with the BSP is entertainingly
baroque and discourages changes even if they are technically possible.

Also remember that many of the people doing upstream work are doing it
on various generic reference platforms rather than boards they
themselves have manufactured and may therefore have problems getting the
access that you get with commercial devices.

> Well, of course it always is some sort of iterative process before the DTS is 
> 100% correct, but it is faily simple. You can rely on all SoC drivers to be 
> generic and independent of your specific board and that, provided the correct 
> DT, drivers and hardware will find each other and work. I/O setup is the sole 
> duty of u-boot.

In process terms this is generally true of ARM also, it's just that
everything tends to be included in the kernel.

> There is a small chance that u-boot may need to get changed later on, but that 
> chance always exists, even if I/O setup was done in the kernel. U-boot can 
> easily be replaced by a running linux system, the only thing that has to be 
> taken care of is not touching power while flashing, as well as verifying the 
> flashed image before reboot. The boot-loader itself is supposed to be factory 
> tested and shouldn't brick your device. Also, you usually don't need to change 
> the boot-loader that often.

Technically being able to replace the bootloader and being willing to
take the risk of bricking the system are not the same thing. 

> > As I said, even if the bootloader *can* be updated at least some users
> > are likely to refuse point blank to do so if they don't have a recovery
> > mechanism that they trust and prefer to fix the code up in a part of the
> > system they can recover easily if it fails.  The determination of these
> > paramters may come after the original bootloader is written (since they
> > may depend in part on measurement, for example).

> Measurement for design-characterization is done on prototypes, not on 
> production devices.
> If you do your homework in the bootloader during the product prototype phase, 
> chances that you ever need to change I/O-setup later are very small, so this 
> doesn't seem a valid argument to me.

You need to at lest reverify all this stuff in form factor, and
obviously if you're using a reference board from a manufacturer rather
than an actual system the concept of production is somewhat vauge.

> > Another issue can be
> > that in development simultaneously deploying bootloader and kernel
> > updates can be more difficult than deploying a single image so people
> > prefer to keep everything in one place.

> "In development" is when the product isn't finished yet, so what is the big 
> deal of updating the bootloader then?
> I would prefer a good architecture over a patched workaround any day.

You need a mechanism to ensure all the engineers are applying bootloader
updates to their systems when required.  It's not insurmountable, but
it's one more thing that needs doing.

> > The reliability concerns also apply to updates done in the field (eg,
> > when rolling out new functionality) - anything that may require fallback
> > to JTAG is fail.

> New functionality that hasn't been thought of during development would need 
> different hardware anyway, and if that functional upgrade has been thought of 
> during initial design, that thought should have included the boot-loader IMHO.

Not at all, people do ship systems with hardware physically present but
no software support and then add software support later especially with
reference designs.

> Clarification: Amateuristish was meant as much or even more for 
> hardware/bootloader development as for the kernel part. Don't just feel 
> offended, but you can't tell me that delivering hardware with a half-baked 
> bootloader to a kernel developer and letting him hack/guess the I/O 
> initialization together that the boot-loader got wrong doesn't sound very 
> professional to me.

This is only a problem if you assume the bootloader is responsible for
doing the pin setup - clearly if it was supposed to do that and it
didn't there's an issue.  If instead you merely expect the bootloader to
load and start the kernel then so long as the kernel is running the
bootloader did what it was supposed to do.

> > Clearly if you think that the kernel should have no involvement in
> > configuring the system then there's a problem but that's not a given.

> Well, let's try to make it a given. I think we mostly agree that it would be 
> better tha way.

I don't actually see a problem with the current situation.

As others have said you're welcome to try, but it's not the most
tractable problem ever and it's not immediately obvious that it's the
best use of time.  Given the concerns that exist about bootloader
quality it's not clear that there's much enthusiasm for increasing the
level of reliance on the bootloader.

> On PC platforms it is that way also: There is the BIOS that needs to do all 
> low-level setup stuff. It is never done in the linux kernel nor in the NT-
> kernel.

This isn't entirely true, the BIOS is handing off a partially
initialised system and init is completed by the kernel.
