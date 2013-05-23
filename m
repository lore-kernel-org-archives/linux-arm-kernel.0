From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 May 2013 11:29:34 +0100
Subject: [PATCH] arch: configuration, deleting 'CONFIG_BUG' since
 always need it.
In-Reply-To: <878v369fdd.fsf@xmission.com>
References: <519DCBEF.3090208@asianux.com>
 <20130523090534.GJ18614@n2100.arm.linux.org.uk>
 <CAMuHMdWez-j1Maa3BD7ucmzv0_zFJnChERQiHFmkCaZUzG0_AA@mail.gmail.com>
 <201305231139.38233.arnd@arndb.de> <878v369fdd.fsf@xmission.com>
Message-ID: <20130523102934.GN18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 03:09:50AM -0700, Eric W. Biederman wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > On Thursday 23 May 2013, Geert Uytterhoeven wrote:
> >> > The problem is: trying to fix that will mean the result is a larger
> >> > kernel than if you just do the usual arch-implemented thing of placing
> >> > an defined faulting instruction at the BUG() site - which defeats the
> >> > purpose of turning off CONFIG_BUG.
> >> 
> >> Is __builtin_unreachable() working well these days?
> >> 
> >
> > Hmm, I just tried the trivial patch below, which seemed to do the right thing.
> > Needs a little more investigation, but that might actually be the correct
> > solution. I thought that at some point __builtin_unreachable() was the same
> > as "do {} while (1)", but this is not the case with the gcc I was using --
> > it just tells gcc that we don't expect to ever get here.
> 
> Yes.
> 
> We already have this abstracted in compiler.h as the macro unreachable,
> so the slight modification of your patch below should handle this case.
> 
> For compilers without __builtin_unreachable() unreachable() expands to
> do {} while(1) but an infinite loop seems reasonable and preserves the
> semantics of the code, unlike the current noop that is do {} while(0).

Semantics of the code really don't come in to it if you use unreachable().
unreachable() is an effective do { } while (0) to the compiler.  It just
doesn't warn about it anymore.  It's actually worse than that - it's
permission to the compiler to just stop considering flow control at that
point and do anything it likes with the following instruction slot.

What __builtin_unreachable() means to the compiler is "we will *never*
get here".  That isn't the case for BUG() - BUG() means "we hope that
we will never get here, but we might, and if we do your data is in
grave danger."

We should either have something at that point (like a call to a function
which panics) or remove the ability to turn off CONFIG_BUG and anyone who
cares about kernel size needs to come up with a single trapping
instruction BUG() implementation.
