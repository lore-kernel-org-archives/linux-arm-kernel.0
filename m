From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Jul 2010 14:54:31 +0100
Subject: ARM Machine SoC I/O setup and PAD initialization code
In-Reply-To: <201007221531.58744.david.jander@protonic.nl>
References: <201007211029.29529.david.jander@protonic.nl>
	<201007221410.10087.david.jander@protonic.nl>
	<20100722125652.GL10930@sirena.org.uk>
	<201007221531.58744.david.jander@protonic.nl>
Message-ID: <20100722135431.GS31293@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 22, 2010 at 03:31:58PM +0200, David Jander wrote:
> On Thursday 22 July 2010 02:56:52 pm Mark Brown wrote:
> > Well, from the point of view of using systems like this all you need the
> > bootloader to do is to set the system up enough to load the kernel and
> > start it running.  You don't need it to understand anything else about
> > the rest of the system, which means you're less reliant on the quality
> > of the bootloader.
> 
> How can you assume that kernel-developers know how to correcly set-up the
> slew rate and drive-strength of an I/O-pin for a given platform if the
> manufacturer itself didn't do it nor document it!??
> Even if it works with one guessed setting, there is a potential EMC impact 
> that needs to be taken care of.

You're making some assumptions there - you're assuming that the people
doing the kernel aren't connected with the vendor.

This is rarely the case - as the vendor wants their end product to work.
If they take a random boot loader, and a random kernel, and hopes that
the final combination falls within EMC limits, then they're failing in
their duty.

They need to test that their final product meets the EMC regulations
before marketing it, and if it doesn't then they need to rework it in
some way to make it meet the regulations - be that by hardware redesign,
or getting the software configuration correct.

But sadly, "getting the software configuration correct" normally means
modifying the kernel rather than fixing the boot loader - because it's
easier and less risky to put fix the (vendor) kernels than it is to
touch the boot loader.

> There are important hardware-design decisions after each of those
> settings! If we continue this amateuristic approach, ARM-linux
> platforms will never get taken seriously in more demanding
> environments. This really needs to change.

"we continue this amateuristic approach" - you think we really have some
choice in this?  We have very little influence on this point.

If boot loaders were coded in such a way that it was very difficult to
get stuff wrong, then there'd be less of an issue.  By that I mean basic
stuff such as taking the results of the RAM detection function(s) (which
are platform specific, and presumably the boot loader does know how much
RAM it has to deal with for its own internal malloc etc) and ensuring
this gets passed to the kernel boot handler in an arch specific way.

I'm sure that uboot knows how much memory is present already.  It's
just that for whatever reason, the code which sets up the tagged list
isn't implemented in such a way that it always gets passed to the
kernel independently of board specifics.
