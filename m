From: david.jander@protonic.nl (David Jander)
Date: Fri, 23 Jul 2010 12:18:07 +0200
Subject: ARM Machine SoC I/O setup and PAD initialization code
In-Reply-To: <20100722142043.GK4737@rakim.wolfsonmicro.main>
References: <201007211029.29529.david.jander@protonic.nl>
	<201007221531.58744.david.jander@protonic.nl>
	<20100722142043.GK4737@rakim.wolfsonmicro.main>
Message-ID: <201007231218.07379.david.jander@protonic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 22 July 2010 04:20:43 pm Mark Brown wrote:
> On Thu, Jul 22, 2010 at 03:31:58PM +0200, David Jander wrote:
> > On Thursday 22 July 2010 02:56:52 pm Mark Brown wrote:
> > > If you don't have JTAG access (either due to device limitations or due
> > > to lack of data from the vendor of a reference platform you're using)
> > > replacing a bootloader can be rather more stressful than it's worth.
> >
> > I agree, but I simply can't believe ARM platform designers all do such a
> > bad job at firmware (=bootloader) development in general, which is in
> > sharp contrast to what I have learned from previous PowerPC developments.
> >
> > Maybe the difference is in the market: PowerPC is more geared towards an
> > industrial embedded market (high demand of robustness and reliability),
> > while ARM comes from a pure consumer market, and is just lately making
> > inroads into industrial applications.
> 
> I suspect it's more that there are vastly fewer PowerPC vendors out
> there so much less independant development - compared to ARM the PowerPC
> devices are *very* homogenous.

That could indeed be part of the reason... but there are not _so_ few PowerPC 
vendors actually: Chips are made by Freescale, AMCC and IBM mainly (PASemi 
used to exist also), but boards and workstations are made by quite a lot of 
vendors (we are one ;-)

> > > Well, from the point of view of using systems like this all you need
> > > the bootloader to do is to set the system up enough to load the kernel
> > > and start it running.  You don't need it to understand anything else
> > > about the rest of the system, which means you're less reliant on the
> > > quality of the bootloader.
> >
> > How can you assume that kernel-developers know how to correcly set-up the
> > slew rate and drive-strength of an I/O-pin for a given platform if the
> > manufacturer itself didn't do it nor document it!??
> 
> Usually the people doing the kernel bringup on an actual end system will
> be part of the same organisation that does the hardware design - if
> there's a problem the kernel developer can usually locate the orginal
> hardware designer.

Then why can't they get the boot-loader fixed?
We develop and manufacture hardware and also do bootloader and kernel porting 
in one company.
First comes the board design, including design validation criteria and a lot 
of that information is used later during bootloader development. Then comes 
manufacturing of prototypes and work on porting u-boot. One of the design 
goals that also apply to u-boot is always standarization wherever that is 
practical. Until now we have mostly only worked on PowerPC platforms, and 
there things are fairly easy: Make u-boot initialize the hardware completely, 
write a DTS (Device-tree source file) for the chosen linux kernel, add 2 or 3 
lines of code into a generic BSP file for your SoC, configure and compile the 
kernel and everything just works.
Well, of course it always is some sort of iterative process before the DTS is 
100% correct, but it is faily simple. You can rely on all SoC drivers to be 
generic and independent of your specific board and that, provided the correct 
DT, drivers and hardware will find each other and work. I/O setup is the sole 
duty of u-boot.

There is a small chance that u-boot may need to get changed later on, but that 
chance always exists, even if I/O setup was done in the kernel. U-boot can 
easily be replaced by a running linux system, the only thing that has to be 
taken care of is not touching power while flashing, as well as verifying the 
flashed image before reboot. The boot-loader itself is supposed to be factory 
tested and shouldn't brick your device. Also, you usually don't need to change 
the boot-loader that often.
PC-manufacturers also ship BIOS upgrades every now and then.

> > Even if it works with one guessed setting, there is a potential EMC
> > impact that needs to be taken care of.
> 
> As I said, even if the bootloader *can* be updated at least some users
> are likely to refuse point blank to do so if they don't have a recovery
> mechanism that they trust and prefer to fix the code up in a part of the
> system they can recover easily if it fails.  The determination of these
> paramters may come after the original bootloader is written (since they
> may depend in part on measurement, for example).

Measurement for design-characterization is done on prototypes, not on 
production devices.
If you do your homework in the bootloader during the product prototype phase, 
chances that you ever need to change I/O-setup later are very small, so this 
doesn't seem a valid argument to me.

> Another issue can be
> that in development simultaneously deploying bootloader and kernel
> updates can be more difficult than deploying a single image so people
> prefer to keep everything in one place.

"In development" is when the product isn't finished yet, so what is the big 
deal of updating the bootloader then?
I would prefer a good architecture over a patched workaround any day.

> The reliability concerns also apply to updates done in the field (eg,
> when rolling out new functionality) - anything that may require fallback
> to JTAG is fail.

New functionality that hasn't been thought of during development would need 
different hardware anyway, and if that functional upgrade has been thought of 
during initial design, that thought should have included the boot-loader IMHO.

> > There are important hardware-design decisions after each of those
> > settings! If we continue this amateuristic approach, ARM-linux platforms
> > will never get taken seriously in more demanding environments. This
> > really needs to change.
> 
> I'm not sure what you believe is amateurish about this approach?

Clarification: Amateuristish was meant as much or even more for 
hardware/bootloader development as for the kernel part. Don't just feel 
offended, but you can't tell me that delivering hardware with a half-baked 
bootloader to a kernel developer and letting him hack/guess the I/O 
initialization together that the boot-loader got wrong doesn't sound very 
professional to me.

> Clearly if you think that the kernel should have no involvement in
> configuring the system then there's a problem but that's not a given.

Well, let's try to make it a given. I think we mostly agree that it would be 
better tha way.
On PC platforms it is that way also: There is the BIOS that needs to do all 
low-level setup stuff. It is never done in the linux kernel nor in the NT-
kernel.

> For various reasons ARM systems have pretty much ended up in a position
> like PCs where the bootloader is responsible for starting the kernel and
> not much else.

You forget the BIOS! ;-)
PC's have a BIOS that does HW init stuff, _that's_ why the bootloader doesn't 
have to do it there.
The problem is that on ARM the bootloader also has the task of the BIOS 
because there isn't any.

Best regards,

-- 
David Jander
Protonic Holland.
