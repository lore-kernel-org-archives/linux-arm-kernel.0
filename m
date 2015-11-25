From: dcashman@android.com (Daniel Cashman)
Date: Wed, 25 Nov 2015 11:07:09 -0800
Subject: [PATCH v3 0/4] Allow customizable random offset to mmap_base
 address.
In-Reply-To: <20151124163907.1a406b79458b1bb0d3519684@linux-foundation.org>
References: <1447888808-31571-1-git-send-email-dcashman@android.com>
 <20151124163907.1a406b79458b1bb0d3519684@linux-foundation.org>
Message-ID: <565606DD.2090502@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/24/2015 04:39 PM, Andrew Morton wrote:

> mips, powerpc and s390 also implement arch_mmap_rnd().  Are there any
> special considerations here, or it just a matter of maintainers wiring
> it up and testing it?

I had not yet looked at those at all, as I had no way to do even a
rudimentary "does it boot" test and opted to post v3 first.  Upon first
glance, it should just be a matter of wiring it up:

Mips is divided into 12/16 bits for 32/64 bit (assume baseline 4k page)
w/COMPAT kconfig,  powerpc is 11/18 w/COMPAT, s390 is 11/11 w/COMPAT.
s390 is a bit strange as COMPAT is for a 31-bit address space, although
is_32bit_task() is used to determine which mask to use, and the mask
itself for 64-bit only introduces 11 bits of entropy, but while still
affecting larger chunks of the address space (mask is 0x3ff80, resulting
in an effective 0x7ff shift of PAGE_SIZE + 7 bits).

I could go ahead and add these to patchset v4 and as with the previous
architectures, rely on feedback from arch-specific maintainers to help
tune and test the values.

-Dan
