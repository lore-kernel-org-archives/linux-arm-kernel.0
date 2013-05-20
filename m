From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 May 2013 17:31:18 +0100
Subject: [PATCH] include/linux/posix_acl.h: need 'return NULL' when
 BUG(), if neither CONFIG_BUG nor HAVE_ARCH_BUG is defined.
In-Reply-To: <97dada79-cd78-4799-8f18-ed2bf8eee508@email.android.com>
References: <5199DBE2.5080707@asianux.com>
 <97dada79-cd78-4799-8f18-ed2bf8eee508@email.android.com>
Message-ID: <20130520163118.GX18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 20, 2013 at 07:40:24AM -0700, Eric W. Biederman wrote:
> Seriously?  The correct fix it would seem is to give a useful default BUG
> definition.  Say *NULL.

Absolutely.

The real question is... how is this happening.  I've seen it occasionally
in the randconfig builds - though I don't have any logs to hand which
show that in the build system at the moment.  So, looking at the files:

arch/arm/include/asm/bug.h:
#ifdef CONFIG_BUG
#define BUG() _BUG(__FILE__, __LINE__, BUG_INSTR_VALUE)
#define _BUG(file, line, value) __BUG(file, line, value)
#ifdef CONFIG_DEBUG_BUGVERBOSE
#define __BUG(__file, __line, __value)                          \
...
        unreachable();                                          \
...
#else  /* not CONFIG_DEBUG_BUGVERBOSE */
#define __BUG(__file, __line, __value)                          \
...
        unreachable();                                          \
...
#endif  /* CONFIG_DEBUG_BUGVERBOSE */

#define HAVE_ARCH_BUG
#endif  /* CONFIG_BUG */

#include <asm-generic/bug.h>

So here, whenever we have CONFIG_BUG enabled, we always define a non-empty
BUG() macro to override the generic version.  So far so good.

include/asm-generic/bug.h:

#ifdef CONFIG_BUG
... we're providing our own version ...

#else /* !CONFIG_BUG */
#ifndef HAVE_ARCH_BUG
#define BUG() do {} while(0)
#endif

#ifndef HAVE_ARCH_BUG_ON
#define BUG_ON(condition) do { if (condition) ; } while(0)
#endif

So, the generic stuff becomes no-ops which just fall through.  Seriously?
Is this really what we want?

So either we need to fix the generic bug.h code, or fix every site which
uses BUG()/BUG_ON().

Note - I'm not saying *NULL as you did, because that isn't guaranteed to
fault on all platforms.  NoMMU may allow *NULL to succeed without causing
an exception.
