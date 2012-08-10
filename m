From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 10 Aug 2012 16:37:05 +0100
Subject: Why the region area don't decrease 1 in function
 sanity_check_meminfo?
In-Reply-To: <5025253D.3010007@arm.com>
References: <CAKvkGKeqzAiqRAj+H+E-eoN9SOOMP-aMhUJYmUb0UK4ei=jouA@mail.gmail.com>
 <5025253D.3010007@arm.com>
Message-ID: <20120810153705.GZ18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 10, 2012 at 04:14:05PM +0100, Jonathan Austin wrote:
> From: Jonathan Austin <jonathan.austin@arm.com>
> Date: Thu, 9 Aug 2012 15:59:16 +0100
> Subject: [PATCH] arm: mm: Fix vmalloc overlap check for !HIGHMEM
> 
> With !HIGHMEM, sanity_check_meminfo checks for banks that completely or
> partially overlap the vmalloc region. The check for partial overlap checks
> __va(bank->start + bank->size) > vmalloc_min, but the last address of the
> bank is (bank->start + bank->size -1).

Erm.

Let's say you have a bank at 0x80000000, which maps to 0xc0000000 virtual.
This is 512MB in size (so it's last byte address is 0x9fffffff).  That
places it at at 0xdfffffff.  Now, let's say vmalloc_min is 0xe0000000.

"bank->start + bank->size" would be 0xa0000000, right ?

So, "__va(bank->start + bank->size)" would be 0xe0000000.

And "0xe0000000 > vmalloc_min" would be false.

> However, theoretically, if using using SPARSEMEM in a situation where the
> physical to virtual address conversion is not monotonic increasing, the
> incorrect test could result in a bank not being truncated when it should be.

Right, so what you're actually talking about is a non-linear translation
by __va() and friends.  In that case, what you actually need is:

	(__va(bank->start + bank->size - 1) + 1) > vmalloc_min
or
	__va(bank->start + bank->size - 1) >= vmalloc_min

and not

	__va(bank->start + bank->size - 1) > vmalloc_min
