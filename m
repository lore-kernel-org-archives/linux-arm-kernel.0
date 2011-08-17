From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 17 Aug 2011 11:22:48 +0200
Subject: [RFC,PATCH] arch/arm: compute and export NR_syscalls
In-Reply-To: <20043.28045.613130.691498@pilspetsen.it.uu.se>
References: <1313529267-4428-1-git-send-email-wad@chromium.org>
	<CABqD9hYavCxA38GbBhbCmBT+PEQQsvhbF4U7xY8P8ygbFy+=Ag@mail.gmail.com>
	<20043.28045.613130.691498@pilspetsen.it.uu.se>
Message-ID: <201108171122.49009.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 17 August 2011, Mikael Pettersson wrote:
>  > I proposed this approach based solely on prior threads I've seen. E.g.,
>  > - https://lkml.org/lkml/2007/6/1/427
>  >   (don't just #define)
>  > - https://lkml.org/lkml/2009/8/27/280
>  >   (todo: x86-32 to move to x86-64)
>  > 
>  > If a single line #define is good enough, then it certainly works for me.
> 
> Yes, the one-line #define NR_syscalls in unistd.h is a perfectly adequate,
> if not entirely elegant, solution.  Adding asm-export.c just for this is
> waaay overkill.

Right. While the main problem with having the constant in asm/unistd.h
(needs to be kept in sync when adding new syscalls) is an annoyance,
the suggested approach is adding more complexity than necessary.

If you want to have the value automatically computed, I'd suggest
moving the format of unistd.h over to a method like the one used
by x86-64 and asm-generic, which is to combine the syscall number
definitions with the list of syscall pointers that currently reside
in arch/arm/kernel/calls.S, for the added benefit that it's easier to
keep the two in sync as well.

The main question is what Russell's preference is on the alternatives.

	Arnd
