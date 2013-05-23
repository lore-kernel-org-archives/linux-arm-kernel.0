From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 May 2013 11:04:09 +0100
Subject: [PATCH] arch: configuration, deleting 'CONFIG_BUG' since
 always need it.
In-Reply-To: <201305231139.38233.arnd@arndb.de>
References: <519DCBEF.3090208@asianux.com>
 <20130523090534.GJ18614@n2100.arm.linux.org.uk>
 <CAMuHMdWez-j1Maa3BD7ucmzv0_zFJnChERQiHFmkCaZUzG0_AA@mail.gmail.com>
 <201305231139.38233.arnd@arndb.de>
Message-ID: <20130523100409.GK18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 11:39:37AM +0200, Arnd Bergmann wrote:
> On Thursday 23 May 2013, Geert Uytterhoeven wrote:
> > > The problem is: trying to fix that will mean the result is a larger
> > > kernel than if you just do the usual arch-implemented thing of placing
> > > an defined faulting instruction at the BUG() site - which defeats the
> > > purpose of turning off CONFIG_BUG.
> > 
> > Is __builtin_unreachable() working well these days?
> > 
> 
> Hmm, I just tried the trivial patch below, which seemed to do the right thing.
> Needs a little more investigation, but that might actually be the correct
> solution. I thought that at some point __builtin_unreachable() was the same
> as "do {} while (1)", but this is not the case with the gcc I was using --
> it just tells gcc that we don't expect to ever get here.

All this is doing is hiding the warning, nothing more.

What the compiler does is this:

	beq	1f
	... some asm code ...
	__builtin_reachable() point
	maybe a literal table
1:	... some asm code doing some other part of the function ...

and what will happen is that the first block of asm will fall through the
(possibly present) literal table into the following asm code.  So, as
specified in the gcc manual, if you ever hit a __builtin_unreachable()
point, your program is undefined (as in, the behaviour of it can no longer
be known.)

We can't make that guarantee with BUG() - because sometimes they do fire
and sometimes in the most unlikely scenarios, particularly if you're not
looking, or at the most inconvenient time.

So, if you want to use this, then you should update the CONFIG_BUG text
to include a warning to this effect:

     Warning: if CONFIG_BUG is turned off, and control flow reaches
     a BUG(), the system behaviour will be undefined.

so that people can make an informed choice about this, because at the
moment:

          Disabling this option eliminates support for BUG and WARN, reducing
          the size of your kernel image and potentially quietly ignoring
          numerous fatal conditions. You should only consider disabling this
          option for embedded systems with no facilities for reporting errors.
          Just say Y.

will become completely misleading.  Turning this option off will _not_
result in "quietly ignoring numerous fatal conditions".

And I come back to one of my previous arguments - is it not better to
panic() if we hit one of these conditions so that the system can try to
do a panic-reboot rather than continue blindly into the unknown?
