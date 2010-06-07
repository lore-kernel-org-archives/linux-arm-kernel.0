From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Tue, 8 Jun 2010 00:27:01 +0400
Subject: [PATCH] ARM: Add PI/robust mutexes support for SMP kernels
In-Reply-To: <20100607194457.GC7220@n2100.arm.linux.org.uk>
References: <20100607173630.GA10489@oksana.dev.rtsoft.ru>
	<20100607194457.GC7220@n2100.arm.linux.org.uk>
Message-ID: <20100607202701.GA14529@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 07, 2010 at 08:44:57PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jun 07, 2010 at 09:36:30PM +0400, Anton Vorontsov wrote:
> > To support PI or robust mutexes, the kernel needs to perform some
> > operations atomically on userspace addresses, and yet ARM lacked
> > the support for the SMP case.
> > 
> > ARMv6 adds exclusive access variants of ldr and str instructions,
> > which means that support for PI/robust mutexes should now be
> > relatively straightforward.
> 
> It isn't this straight forward.  You're now bypassing the MMU protections
> in that 'strex' can bypass the read-only protection of the user page.
> This can result in the zero BSS page being corrupted, or worse corruption
> to page cache pages.

Interesting. I don't pretend I understand all MMU details, but arm.com
says "If a processor does an STR on a memory region that it has already
marked as exclusive, this does not clear the tag."

So, can we solve this by

ldrex
...
strt newval
   ^ may cause exception, but doesn't clear the tag, so we're still atomic
strex <- clears the tag

.fixup
	strex oldval <- just clear the tag
	return -EFAULT;

Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
