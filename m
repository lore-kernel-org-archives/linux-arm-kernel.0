From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 5 Dec 2013 10:33:52 +0000
Subject: [GIT PULL for-next] ARM: mm: Switch ARM port to NO_BOOTMEM for
 3.14
In-Reply-To: <1386017539-10295-1-git-send-email-santosh.shilimkar@ti.com>
References: <1386017539-10295-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20131205103352.GD4360@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 02, 2013 at 03:52:19PM -0500, Santosh Shilimkar wrote:
> Russell,
> 
> Here is the pull request for-next so that the series gets wider testing
> to catch any regression early in the cycle.

This unfortunately adds a new warning to all the ARM builds:

mm/nobootmem.c: In function '__free_pages_memory':
mm/nobootmem.c:88:201: warning: comparison of distinct pointer types lacks a cast

I don't think it's your change which is causing this, but it does
introduce this new code.  The problem is this:

        while (start < end) {
                order = min(MAX_ORDER - 1UL, __ffs(start));

The types of "MAX_ORDER - 1UL" and "__ffs(start)" differ, which may leads
to min() having unexpected behaviour.  This isn't helped by:

arch/x86/include/asm/bitops.h:static inline unsigned long __ffs(unsigned long word)

vs

static inline int fls(int x)
...
#define ffs(x) ({ unsigned long __t = (x); fls(__t & -__t); })
#define __ffs(x) (ffs(x) - 1)

So on ARM, we have a different return type.  We need to fix ARM's
definition of __ffs() et.al. to have comparable return types to x86.
