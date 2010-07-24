From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 24 Jul 2010 19:50:22 +0100
Subject: ARM Machine SoC I/O setup and PAD initialization code
In-Reply-To: <61396.213.84.91.226.1279910330.squirrel@protonic.xs4all.nl>
References: <201007211029.29529.david.jander@protonic.nl>
	<201007221531.58744.david.jander@protonic.nl>
	<20100722142043.GK4737@rakim.wolfsonmicro.main>
	<201007231218.07379.david.jander@protonic.nl>
	<20100723141712.GC12300@rakim.wolfsonmicro.main>
	<61396.213.84.91.226.1279910330.squirrel@protonic.xs4all.nl>
Message-ID: <20100724185015.GA17738@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 23, 2010 at 08:38:50PM +0200, david at protonic.nl wrote:
> > On Fri, Jul 23, 2010 at 12:18:07PM +0200, David Jander wrote:

> > In extreme cases the bootloader may be provided as binary by the SoC
> > vendor and not changable, but there can also be the other concerns I
> > mentioned with things like deploying updates throughout the team.
> > Sometimes the bootloader code supplied with the BSP is entertainingly
> > baroque and discourages changes even if they are technically possible.

> Well, I know one manufacturer delivering such a bootloader with their
> evaluation kit, but I'd never expect anyone to actually use that one in
> production!? Isn't it meant as a mere example?

Well, if it already does the job why would you want to change it?  Given
that a large proportion of systems boot in an identical fashion it's
likely that an off the shelf bootloader is more than capable of doing
the job.  It certainly seems crazy to write one from scratch given the
rather large range of existing ones, at most a bit of customisation
might be expected.

> > Also remember that many of the people doing upstream work are doing it
> > on various generic reference platforms rather than boards they
> > themselves have manufactured and may therefore have problems getting the
> > access that you get with commercial devices.

> Wait a second... how can you do development of BSP stuff for a product on
> an essentially different evaluation platform?
> I am starting to finally understand why things are as they are now. My
> excuses if it upset someone in the way.... :-(

I'm talking about upstream work here - people working on the stuff that
ends up in the mainline kernel.  A large part of that is done on widely
available reference boards rather than custom systems since either
people are trying to use the reference systems in various applications 
or they wish to provide examples others can actually run here.

People working on consumer or industrial systems are much less likely to
contribute upstream, even if they are enthusiastic about that they may
be using an old BSP from the vendor or carrying sufficient out of tree
code to cause problems.  There may well be no interest at all in
contributing upstream.

> > In process terms this is generally true of ARM also, it's just that
> > everything tends to be included in the kernel.

> Well, if you want to include _everything_ in the kernel, that's fine, but
> then don't use a bootloader, and set the rules accordingly. My primary
> concern is about there not being a single place for this. It's in the BL
> and in the kernel, and sometimes things are setup differently in both
> places!

The bootloader is still useful in that it allows you to replace the
system images without JTAG and can provide a basic hardware diagnosis
environment (without things like VM or multitasking to worry about).

> > Technically being able to replace the bootloader and being willing to
> > take the risk of bricking the system are not the same thing.

> If a PC does not work correctly (especially with a new feature or OS),
> manufacturers publish BIOS upgrades. People accept them as long as it's
> not too often. Heck, even game-console manufacturers sometimes remotely
> upgrade their bootloaders, and users don't even have the option to say no.
> And yes, I mean the actual bootloader, not just the firmware of the
> console.

Mass production commercial hardware tends to get rather more testing and
better support from their vendors than chip reference boards do for most
users.  The support structure and expectations in the two environments
are totally different and can't really be compared.

> > You need a mechanism to ensure all the engineers are applying bootloader
> > updates to their systems when required.  It's not insurmountable, but
> > it's one more thing that needs doing.

> Sorry, I am still baffled at how that can be a problem... I mean they are
> engineers, developing a product together, right? I'll take your word, but
> I am surprised.

Think of teams of fifty or more developers, somtimes distributed
geographically or organisationally, of varying degrees of skill.  The
communication overheads alone aren't trivial.

> > Not at all, people do ship systems with hardware physically present but
> > no software support and then add software support later especially with
> > reference designs.

> Well, I was referring to actual products, not reference designs. When we
> develop a product, we use the datasheet and reference manuals for the

A very great proportion of upstream kernel work is done on reference
designs of one form or another.  This means that the needs of reference 
designs are important to kernel developers, and the fact that systems
are often based on reference designs and intended to boot initially with
the reference design BSP means that even users working off on their own
care about them.

> design, and the reference design schematics to get a better idea of what
> the chip maker intended or omitted from the datasheet. Then we make a
> prototype of our design, which is 95% identical to the actually shipped
> product most of the time, and then we write a bootloader for it (mostly
> just porting u-boot), after that we develop a linux BSP, if possible from
> a git-tree as close to mainline as possible for that chip. And just after
> that do application developers get a chance to try out the software on our
> board.

> I naively thought most manufacturers did something similar. I understand
> now that I was wrong. Sorry. But it does hurt!

That's *broadly* similar but much more waterfall than you'd see on a big
project.  You'd also expect to see more spins of the system as it
progresses from a probable development system to a form factor system
with plastics, and there may be substantial integration effort if
there's lots of vendor code to merge in.

> > This is only a problem if you assume the bootloader is responsible for
> > doing the pin setup - clearly if it was supposed to do that and it
> > didn't there's an issue.

> It seems the most logical place to do it. Has the linux kernel (on x86)
> ever cared about DRAM timings, or PCI slew-rate settings, delay trimming,
> etc...? I think not. And hopefully it shouldn't. But if it needs to (for
> ARM), then let's find a sane way of specifying the settings, hopefully in

Things like DRAM mostly need to be set up prior to boot since the
bootloader tends to need them to do anything, never mind the kernel.
It's mostly the pin mux stuff that the kernel deals with.

> a way that is not related to re-useable code (drivers and such stuff). See
> the example given in my original post.

That's exactly what pretty much everyone is doing - there's a pin
configuration API that's totally separate to the drivers except in cases
where you need to change function at runtime.

> This has been an interesting discussion, but I don't want to upset any
> more people here. I just want to ask one more question, being new to
> ARM-linux: What setup should I chose for our products then? What would be
> more in tune with the most desireable long-term goal of ARM-linux booting?
> 
> 1. u-boot doing all pad/IO setup and loading linux.
> 2. u-boot just loading linux and doing only the minimum IO-setup necessary
> for that job, and write a linux BSP that does ALL IO-init
> 3. Don't use u-boot at all, and investigate Magnus's Kexec technique?
> 4. Something else?

I'd go for option 2 as we currently are, though I do prefer a bootloader
that doesn't require uImages (if only because mkimage seems to do such
nasty things with I/O, must debug that sometime).
