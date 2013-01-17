From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 Jan 2013 16:25:42 +0000
Subject: [PATCH 2/2] ARM: use DEBUG_LL infrastructural for multiplatform
 uncompress debug
In-Reply-To: <1358436119-30808-3-git-send-email-shawn.guo@linaro.org>
References: <1358436119-30808-1-git-send-email-shawn.guo@linaro.org>
 <1358436119-30808-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <201301171625.42456.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 January 2013, Shawn Guo wrote:
> However, there is a problem with above approach.  DEBUG_LL routines
> will check MMU enable bit to decide whether physical or virtual address
> should be used to access debug port.  In case virtual address needs
> to be used, the address returned by addruart will not work for
> decompressor who uses a different mapping from what kernel uses.
> Fortunately, decompressor uses a flat mapping (same physical and virtual
> addresses).  So we can easily work it around by asking platform addruart
> return physical address as virtual address when it runs in decompressor.
> The macro UNCOMPRESS_DEBUG is defined for this use.

Can't you just create a new copy of kernel/debug.S in boot/compressed/
that provides only a putc() function and uses the physical address
unconditionally?

For all I can tell, that should be little more than just

#include CONFIG_DEBUG_LL_INCLUDE
ENTRY(putc)
	addruart r1, r2, r3
	waituart r3, r1
	senduart r0, r1
	busyuart r3, r1
	mov pc,lr
ENDPROC(putc)

(I'm not sure about the actual semantics of the above, take that
as an approximation)

	Arnd
