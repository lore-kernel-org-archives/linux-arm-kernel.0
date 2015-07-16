From: slash.tmp@free.fr (Mason)
Date: Thu, 16 Jul 2015 14:41:23 +0200
Subject: Where to define platform-specific ndelay
Message-ID: <55A7A673.50906@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

arch/arm64 defines ndelay, but arch/arm does not.

With my current setup, ndelay resolves to the generic implementation
from include/linux/delay.h

#ifndef ndelay
static inline void ndelay(unsigned long x)
{
	udelay(DIV_ROUND_UP(x, 1000));
}
#define ndelay(x) ndelay(x)
#endif


I want to provide a different implementation for my platform.

Something along the lines of

#define NDELAY_MULT	((2199 * HZ) >> 11)
#define ndelay(n)	__const_udelay((n) * NDELAY_MULT)

Where should I put these definitions?

(I don't want to pollute the generic namespace, so it should
probably go inside platform-specific files, such as perhaps
mach-foo/include/mach/timex.h ??)

Although, I'm not sure how it would be supposed to work
with CONFIG_ARCH_MULTIPLATFORM (which is the default, IIUC?)

Regards.
