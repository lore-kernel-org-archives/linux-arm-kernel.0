From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 1 Sep 2010 22:01:14 +0200
Subject: ARM926EJ-S TLB lockdown
In-Reply-To: <20100901151920.GA6019@sig21.net>
References: <20100901151920.GA6019@sig21.net>
Message-ID: <AANLkTinPN1gYoq6xLCynFmYG+3Zkje=rzHzXKvvGJGeC@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Interesting stuff Johannes!

2010/9/1 Johannes Stezenbach <js@sig21.net>:

> ? ? ? ? ? ? ? ?tlb_lockdown(0xffff0000); ? ? ? // exception vectors

This is probably clever to put in the lockdown TLB

> ? ? ? ? ? ? ? ?tlb_lockdown(0xc0000000); ? ? ? // kernel code / data
> ? ? ? ? ? ? ? ?tlb_lockdown(0xc0100000); ? ? ? // kernel code / data
> ? ? ? ? ? ? ? ?tlb_lockdown(0xc0200000); ? ? ? // kernel code / data
> ? ? ? ? ? ? ? ?tlb_lockdown(0xc0300000); ? ? ? // kernel code / data
> ? ? ? ? ? ? ? ?tlb_lockdown(0xc0400000); ? ? ? // kernel code / data
> ? ? ? ? ? ? ? ?tlb_lockdown(0xc0500000); ? ? ? // kernel code / data
> ? ? ? ? ? ? ? ?tlb_lockdown(0xc0600000); ? ? ? // kernel code / data

But are these really most relevant to lock down?

Since you have a JTAG debugger, can't you profile what
memory pages are actually accessed most often and lock down
these?

But it can be even more elaborate. Profile out the *functions*
most used.

When I've worked with TCM I played with the idea to be able to
tag functions like this:

#define __hotfunc __attribute__((long_call)) __section(.hot.text) noinline
(...)
int __hotfunc foo();

Then have the linker put the hotfuncs into separate pages and
link that.

You can use the same scheme for locked-down TLB:s I believe?
Up to 8 pages of code tagged "hotfunc" will be diverted to these
pages and locked down.

See the stuff in arch/arm/include/asm/tcm.h for the compiler
directives and check the link script in
arch/arm/kernel/vmlinux.lds.S to see how I'm separating the
TCM stuff to separate pages.

Just my ?0.01...

Yours,
Linus Walleij
