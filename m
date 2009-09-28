From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Sep 2009 14:23:28 +0100
Subject: arm_syscall cacheflush breakage on VIPT platforms
In-Reply-To: <20090928131624.GK30271@localhost>
References: <20090928092919.GA30271@localhost>
	<20090928124922.GA19778@shareable.org>
	<20090928131624.GK30271@localhost>
Message-ID: <20090928132328.GE10671@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 28, 2009 at 04:16:24PM +0300, Imre Deak wrote:
> On Mon, Sep 28, 2009 at 02:49:22PM +0200, ext Jamie Lokier wrote:
> > Imre Deak wrote:
> > > Hi,
> > > 
> > > the following test app will cause an unhandled kernel paging request
> > > on VIPT platforms. The triggering condition is the mmap_sem held by
> > > thread_func while the main thread performs cache flushing.
> > > 
> > > Since the likelihood of this to trigger is relatively low, a patch will
> > > follow that makes similar bugs more visible.
> > 
> > I would expect the likelihood of triggering would be higher for at
> > least one of Java, Mono, Parrot or any of the modern Javascript
> > engines.
> 
> True, the above statement is only valid for certain use patterns. I was
> mainly interested in applications that do user range cache flushing as
> part of their DMA requests and they didn't have threads with frequent
> syscalls that required mmap_sem, so the problem remained hidden for a
> long time.

Note that currently this API does not really support that action.  It's
there to synchronise the I and D caches when you want to write self
modifying code.

DMA coherency is going to be an extension to it which I'm going to be
looking at in the coming weeks - but I'm not entirely happy about
extending the API this way.  It has to be done because too many
people are demanding a way to do DMA from userspace, so I guess we're
going to have to forego the "lets do it properly" approach - esp. as
tha's been illustrated to fail already.
