From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Tue, 8 Jun 2010 01:31:45 +0400
Subject: [PATCH] ARM: Add PI/robust mutexes support for SMP kernels
In-Reply-To: <1275944170.11056.7.camel@toshiba-laptop>
References: <20100607173630.GA10489@oksana.dev.rtsoft.ru>
	<20100607194457.GC7220@n2100.arm.linux.org.uk>
	<1275944170.11056.7.camel@toshiba-laptop>
Message-ID: <20100607213145.GA23421@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 07, 2010 at 09:56:10PM +0100, Catalin Marinas wrote:
> On Mon, 2010-06-07 at 20:44 +0100, Russell King - ARM Linux wrote:
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
> Do you mean STREX in SVC mode targeting user pages? I keep posting a
> patch for more than a year :) which removes the domains switching and
> makes user pages read-only for both kernel and user space.

Wow. Then I should just make PI/robust mutexes depend on
!CONFIG_CPU_USE_DOMAINS (which is actually always true for SMP :-).

Thanks!

-- 
Anton Vorontsov
email: cbouatmailru at gmail.com
irc://irc.freenode.net/bd2
