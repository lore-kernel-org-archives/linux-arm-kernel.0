From: vapier@gentoo.org (Mike Frysinger)
Date: Tue, 25 Oct 2011 19:44:14 -0400
Subject: [PATCH] gpiolib/arches: Centralise bolierplate asm/gpio.h
In-Reply-To: <1319528012-19006-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1319528012-19006-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <CAJaTeTp2w85UHnmH-PPMZsQGQMNa-93kw-tjmDxA_wjJXkYQcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 25, 2011 at 03:33, Mark Brown wrote:
> Rather than requiring architectures that use gpiolib but don't have any
> need to define anything custom to copy an asm/gpio.h provide a Kconfig
> symbol which architectures must select in order to include gpio.h and
> for other architectures just provide the trivial implementation directly.

i don't think this is generally how asm-generic is handled.  instead, how about:
 - move the duplicate code to asm-generic/gpio.h
 - have the arches which merely need asm-generic/gpio.h add "generic-y
+= gpio.h" to their include/asm/Kbuild
 - for arches which need to override these common funcs in some way,
add #ifdef protection to the asm-generic/gpio.h

and it seems like with slightly more work, this path allow you to
merge most of arch/sh/include/asm/gpio.h.  and it has the advantage of
not needing new Kconfig symbols.

for example, with asm-generic/atomic.h, it does:
#ifndef atomic_sub_return
static inline int atomic_sub_return(int i, atomic_t *v)
{ ... common implementation ... }
#endif

and then any arch that wants to override it does:
#define atomic_sub_return atomic_sub_return
static inline int atomic_sub_return(int i, atomic_t *v) { weirdness }
#include <asm-generic/atomic.h>
-mike
