From: david@protonic.nl (david at protonic.nl)
Date: Fri, 23 Jul 2010 20:38:50 +0200 (CEST)
Subject: ARM Machine SoC I/O setup and PAD initialization code
In-Reply-To: <20100723141712.GC12300@rakim.wolfsonmicro.main>
References: <201007211029.29529.david.jander@protonic.nl>
	<201007221531.58744.david.jander@protonic.nl>
	<20100722142043.GK4737@rakim.wolfsonmicro.main>
	<201007231218.07379.david.jander@protonic.nl>
	<20100723141712.GC12300@rakim.wolfsonmicro.main>
Message-ID: <61396.213.84.91.226.1279910330.squirrel@protonic.xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Fri, Jul 23, 2010 at 12:18:07PM +0200, David Jander wrote:
>> That could indeed be part of the reason... but there are not _so_ few
>> PowerPC
>> vendors actually: Chips are made by Freescale, AMCC and IBM mainly
>> (PASemi
>> used to exist also), but boards and workstations are made by quite a lot
>> of
>> vendors (we are one ;-)
>
> This is a vanishingly small number of chip vendors (and hence original
> BSPs, which are the main issue here) in comparison with the ARM market.

Ok I agree.

>> > Usually the people doing the kernel bringup on an actual end system
>> will
>> > be part of the same organisation that does the hardware design - if
>> > there's a problem the kernel developer can usually locate the orginal
>> > hardware designer.
>
>> Then why can't they get the boot-loader fixed?
>
> In extreme cases the bootloader may be provided as binary by the SoC
> vendor and not changable, but there can also be the other concerns I
> mentioned with things like deploying updates throughout the team.
> Sometimes the bootloader code supplied with the BSP is entertainingly
> baroque and discourages changes even if they are technically possible.

Well, I know one manufacturer delivering such a bootloader with their
evaluation kit, but I'd never expect anyone to actually use that one in
production!? Isn't it meant as a mere example?

> Also remember that many of the people doing upstream work are doing it
> on various generic reference platforms rather than boards they
> themselves have manufactured and may therefore have problems getting the
> access that you get with commercial devices.

Wait a second... how can you do development of BSP stuff for a product on
an essentially different evaluation platform?
I am starting to finally understand why things are as they are now. My
excuses if it upset someone in the way.... :-(

>> Well, of course it always is some sort of iterative process before the
>> DTS is
>> 100% correct, but it is faily simple. You can rely on all SoC drivers to
>> be
>> generic and independent of your specific board and that, provided the
>> correct
>> DT, drivers and hardware will find each other and work. I/O setup is the
>> sole
>> duty of u-boot.
>
> In process terms this is generally true of ARM also, it's just that
> everything tends to be included in the kernel.

Well, if you want to include _everything_ in the kernel, that's fine, but
then don't use a bootloader, and set the rules accordingly. My primary
concern is about there not being a single place for this. It's in the BL
and in the kernel, and sometimes things are setup differently in both
places!

>> There is a small chance that u-boot may need to get changed later on,
>> but that
>> chance always exists, even if I/O setup was done in the kernel. U-boot
>> can
>> easily be replaced by a running linux system, the only thing that has to
>> be
>> taken care of is not touching power while flashing, as well as verifying
>> the
>> flashed image before reboot. The boot-loader itself is supposed to be
>> factory
>> tested and shouldn't brick your device. Also, you usually don't need to
>> change
>> the boot-loader that often.
>
> Technically being able to replace the bootloader and being willing to
> take the risk of bricking the system are not the same thing.

If a PC does not work correctly (especially with a new feature or OS),
manufacturers publish BIOS upgrades. People accept them as long as it's
not too often. Heck, even game-console manufacturers sometimes remotely
upgrade their bootloaders, and users don't even have the option to say no.
And yes, I mean the actual bootloader, not just the firmware of the
console.

>[...]
>> Measurement for design-characterization is done on prototypes, not on
>> production devices.
>> If you do your homework in the bootloader during the product prototype
>> phase,
>> chances that you ever need to change I/O-setup later are very small, so
>> this
>> doesn't seem a valid argument to me.
>
> You need to at lest reverify all this stuff in form factor, and
> obviously if you're using a reference board from a manufacturer rather
> than an actual system the concept of production is somewhat vauge.

Ok. I never expected so many developers actually developing on evaluation
platforms instead of real prototypes. At least not BSP stuff.

>> > Another issue can be
>> > that in development simultaneously deploying bootloader and kernel
>> > updates can be more difficult than deploying a single image so people
>> > prefer to keep everything in one place.
>
>> "In development" is when the product isn't finished yet, so what is the
>> big
>> deal of updating the bootloader then?
>> I would prefer a good architecture over a patched workaround any day.
>
> You need a mechanism to ensure all the engineers are applying bootloader
> updates to their systems when required.  It's not insurmountable, but
> it's one more thing that needs doing.

Sorry, I am still baffled at how that can be a problem... I mean they are
engineers, developing a product together, right? I'll take your word, but
I am surprised.

>> > The reliability concerns also apply to updates done in the field (eg,
>> > when rolling out new functionality) - anything that may require
>> fallback
>> > to JTAG is fail.
>
>> New functionality that hasn't been thought of during development would
>> need
>> different hardware anyway, and if that functional upgrade has been
>> thought of
>> during initial design, that thought should have included the boot-loader
>> IMHO.
>
> Not at all, people do ship systems with hardware physically present but
> no software support and then add software support later especially with
> reference designs.

Well, I was referring to actual products, not reference designs. When we
develop a product, we use the datasheet and reference manuals for the
design, and the reference design schematics to get a better idea of what
the chip maker intended or omitted from the datasheet. Then we make a
prototype of our design, which is 95% identical to the actually shipped
product most of the time, and then we write a bootloader for it (mostly
just porting u-boot), after that we develop a linux BSP, if possible from
a git-tree as close to mainline as possible for that chip. And just after
that do application developers get a chance to try out the software on our
board.
I naively thought most manufacturers did something similar. I understand
now that I was wrong. Sorry. But it does hurt!

>> Clarification: Amateuristish was meant as much or even more for
>> hardware/bootloader development as for the kernel part. Don't just feel
>> offended, but you can't tell me that delivering hardware with a
>> half-baked
>> bootloader to a kernel developer and letting him hack/guess the I/O
>> initialization together that the boot-loader got wrong doesn't sound
>> very
>> professional to me.
>
> This is only a problem if you assume the bootloader is responsible for
> doing the pin setup - clearly if it was supposed to do that and it
> didn't there's an issue.

It seems the most logical place to do it. Has the linux kernel (on x86)
ever cared about DRAM timings, or PCI slew-rate settings, delay trimming,
etc...? I think not. And hopefully it shouldn't. But if it needs to (for
ARM), then let's find a sane way of specifying the settings, hopefully in
a way that is not related to re-useable code (drivers and such stuff). See
the example given in my original post.

> If instead you merely expect the bootloader to
> load and start the kernel then so long as the kernel is running the
> bootloader did what it was supposed to do.

In the light of that, linux bootling linux seems a smart thing to do.
Makes me think of RedBoot, which is the HAL from eCos (which once was
Linux, remember) and a bootloader on top of that.

>[...]
>> On PC platforms it is that way also: There is the BIOS that needs to do
>> all
>> low-level setup stuff. It is never done in the linux kernel nor in the
>> NT-
>> kernel.
>
> This isn't entirely true, the BIOS is handing off a partially
> initialised system and init is completed by the kernel.

Device/driver initialization, but never low-level stuff like DRAM timing
or PCI delay calibration, drive strength an slew-rates. And at least
things are standardized to a safe degree and agreed upon (or pushed down
the developers throat, however you may want to call it).

This has been an interesting discussion, but I don't want to upset any
more people here. I just want to ask one more question, being new to
ARM-linux: What setup should I chose for our products then? What would be
more in tune with the most desireable long-term goal of ARM-linux booting?

1. u-boot doing all pad/IO setup and loading linux.
2. u-boot just loading linux and doing only the minimum IO-setup necessary
for that job, and write a linux BSP that does ALL IO-init
3. Don't use u-boot at all, and investigate Magnus's Kexec technique?
4. Something else?

On PowerPC, anyone would probably have said 1. eyes closed. Now I am not
so sure anymore... please help.
Thanks to everyone for answering so far.

Best regards,

-- 
David Jander.
