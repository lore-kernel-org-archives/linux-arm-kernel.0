From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 13 Nov 2014 15:30:42 +0100
Subject: gcc 4.9 build warnings (was: Re: next build: 2674 warnings 1
 failures (next/next-20141022))
In-Reply-To: <20141113141950.GA17287@gate.crashing.org>
References: <5447442c.a9ca440a.2060.5e09@mx.google.com>
 <2480226.26bJjjL2fl@wuerfel> <20141113141950.GA17287@gate.crashing.org>
Message-ID: <6784061.8EN2cd5fF5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 November 2014 08:19:50 Segher Boessenkool wrote:
> On Tue, Nov 11, 2014 at 10:32:23PM +0100, Arnd Bergmann wrote:
> > I've decided to investigate it further. It seems that your change to
> > 'arm-linux-eabi' did not have the intended effect.
> 
> "It worked for me", i.e., it did build kernels.  I don't build arm terribly
> often, does it show?

It builds most kernels, but produces extra warnings because some of the
types are different and a handful of drivers don't build if the __linux__
macro is not set. Any user ABI that depends on the size of an enum is
potentially broken.

> > What happens in gcc apparently is that the configuration logic gets confused
> > and uses this entry in gcc/config.gcc:
> > 
> > arm*-*-eabi*)
> >         default_use_cxa_atexit=yes
> >         tm_file="dbxelf.h elfos.h arm/unknown-elf.h arm/elf.h arm/bpabi.h"
> >         tmake_file="${tmake_file} arm/t-arm arm/t-arm-elf"
> >         tm_file="$tm_file newlib-stdint.h"
> >         tmake_file="${tmake_file} arm/t-bpabi"
> >         use_gcc_stdint=wrap
> >         tm_file="${tm_file} arm/aout.h vxworks-dummy.h arm/arm.h"
> >         ;;
> > 
> > instead of this one:
> > 
> > arm*-*-linux-*)                 # ARM GNU/Linux with ELF
> 
> That one would match arm-unknown-linux-eabi (as it does
> arm-unknown-linux-gnueabi), not arm-linux-eabi.  "triples" ;-)

Right, but config.sub thinks that is invalid.

> arm-linux-eabi canonicalises to arm-linux-eabi;
> arm-linux-gnueabi canonicalises to arm-unknown-linux-gnueabi.

Yes, that's what I found too.

	Arnd
