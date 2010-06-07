From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 07 Jun 2010 22:05:57 +0100
Subject: [PATCH] ARM: Add PI/robust mutexes support for SMP kernels
In-Reply-To: <20100607202701.GA14529@oksana.dev.rtsoft.ru>
References: <20100607173630.GA10489@oksana.dev.rtsoft.ru>
	<20100607194457.GC7220@n2100.arm.linux.org.uk>
	<20100607202701.GA14529@oksana.dev.rtsoft.ru>
Message-ID: <1275944757.11056.16.camel@toshiba-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-06-07 at 21:27 +0100, Anton Vorontsov wrote:
> On Mon, Jun 07, 2010 at 08:44:57PM +0100, Russell King - ARM Linux wrote:
> > On Mon, Jun 07, 2010 at 09:36:30PM +0400, Anton Vorontsov wrote:
> > > To support PI or robust mutexes, the kernel needs to perform some
> > > operations atomically on userspace addresses, and yet ARM lacked
> > > the support for the SMP case.
> > >
> > > ARMv6 adds exclusive access variants of ldr and str instructions,
> > > which means that support for PI/robust mutexes should now be
> > > relatively straightforward.
> >
> > It isn't this straight forward.  You're now bypassing the MMU protections
> > in that 'strex' can bypass the read-only protection of the user page.
> > This can result in the zero BSS page being corrupted, or worse corruption
> > to page cache pages.
> 
> Interesting. I don't pretend I understand all MMU details, but arm.com
> says "If a processor does an STR on a memory region that it has already
> marked as exclusive, this does not clear the tag."

Russell is probably referring to a STR or STREX in kernel mode that
writes to a read-only user page (currently mapped as kernel read/write).
Such write would succeed and it breaks the copy-on-write mechanism that
Linux uses for duplicating various pages. The original futex code uses
STRT which is executed with user permissions even if in kernel mode, so
it won't succeed (but raise a data abort which is handled by the
kernel).

But as I said, we already have patches to change the kernel R/W
permission for RO user pages.

-- 
Catalin
