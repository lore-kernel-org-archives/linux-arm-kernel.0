From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Jul 2010 13:35:24 +0100
Subject: ARM Machine SoC I/O setup and PAD initialization code
In-Reply-To: <201007221410.10087.david.jander@protonic.nl>
References: <201007211029.29529.david.jander@protonic.nl>
	<20100722072034.GA6802@n2100.arm.linux.org.uk>
	<AANLkTinQS3vkua2dW0iPpXKDJizVIIKgqcBol2FhuRW_@mail.gmail.com>
	<201007221410.10087.david.jander@protonic.nl>
Message-ID: <20100722123524.GQ31293@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 22, 2010 at 02:10:09PM +0200, David Jander wrote:
> 
> Hi all,
> 
> Thanks for all the reactions.
> 
> On Thursday 22 July 2010 10:16:17 am Magnus Damm wrote: 
> > <linux@arm.linux.org.uk> wrote:
> > > On Thu, Jul 22, 2010 at 11:32:53AM +0900, Simon Horman wrote:
> > >> Would it be feasible to  use Linux + kexec as the boot loader as
> > >> a long term solution to fixing boot loaders by eliminating them?
> > >
> > > So what you're proposing is that a broken boot loader should boot a
> > > version of Linux to fix the pin MUX, which then kexecs a kernel which
> > > doesn't have that code?
> > 
> > I think Simon was proposing to remove the broken boot loader.
> 
> IMO, if a bootloader is broken (in any way), it needs replacing. Be it with 
> another bootloader or directly with the kernel.

We've just been discussing the boot loader on Versatile Express which
doesn't pass memory information to the kernel.  I'm of the opinion that
this should be fixed.

Unfortunately, there's always a great deal of resistance to fixing boot
loaders, and instead work-arounds get submitted to the kernel (as has
been tried today with Versatile Express).  It almost never happens that
the boot loader(s) get fixed - even if the workaround is refused to be
merged.

> Why? If there's a boot-loader, it should know the correct hardware setup much 
> better than any other piece of software.
> Its fundamental role _IS_ basic hardware setup!

The more you trust the boot loader, the more problems you are going to
have, it's as simple as that.  These things aren't extensively tested.
They're generally not tested past "oh, we got a boot loader prompt.
oh, it can load a kernel.  oh, it can call into the kernel.  ok, job
done, ship it."

That's about as far as boot loader development goes.

This is one reason why I wrote the ARM Linux kernel booting document
some 8 years ago, which specifies the _minimum_ of information that a
boot loader needs to supply the kernel needs to be able to boot.  Fat
lot of good that did - as far as I'm concerned, writing documentation
is a total and utter waste of my time and resources.  It just gets
ignored.

So I now just don't bother with any documentation _at_ _all_.

> @Russell: I know, I am being optimistic and arrogant here, my excuses if that 
> offends you, but I simply can't believe the general state of bootloaders and 
> hardware platforms for ARM is so terribly broken, that it can't be fixed in 
> "the right way".

I've been on at people for _years_ about it.  It doesn't matter who you
moan at, there's very little change.  I've come to the conclusion that
for the vast majority of cases, it's simply impossible to change this
sorry state of affairs.

It's one reason why I'm quietly horrified but the thought of DT on ARM.
Given that vendors are the ones responsible for creating the current
situation with boot loaders, and the same vendors will be responsible
for creating the DTs, I forsee that DT will be a similar pile of crap
as the current boot loaders are - and we will end up either ignoring
the DT information, or we'll end up with lots of work-arounds in the
kernel to fix up broken DT information.
