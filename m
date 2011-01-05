From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Wed, 05 Jan 2011 13:36:09 -0600
Subject: still nfs problems [Was: Linux 2.6.37-rc8]
In-Reply-To: <AANLkTi=VZUxNFd7n-qwf5aiOeK5rkk8qBmo+kOpgg7up@mail.gmail.com>
References: <1294254337.16957.13.camel@mulgrave.site>
	<AANLkTi=VZUxNFd7n-qwf5aiOeK5rkk8qBmo+kOpgg7up@mail.gmail.com>
Message-ID: <1294256169.16957.18.camel@mulgrave.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-01-05 at 11:18 -0800, Linus Torvalds wrote:
> On Wed, Jan 5, 2011 at 11:05 AM, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> >
> > I think the solution for the kernel direct mapping problem is to take
> > the expected flushes and invalidates into kmap/kunmap[_atomic].
> 
> No, we really can't do that. Most of the time, the kmap() is the only
> way we access the page anyway, so flushing things would just be
> stupid. Why waste time and energy on doing something pointless?

It's hardly pointless.  The kmap sets up an inequivalent alias in the
cache.  When you write to the kmap region, you dirty the CPU caches for
that alias.  If you tear down the mapping without flushing, the CPU will
write out the cache lines at its leisure.  If you access the line via
the other mapping *before* the CPU does writeout, you see stale data.

When the kernel dirties a kmap region, it always has to flush somehow
before kunmap.  One of the problems here is that that flush isn't in the
NFS code.

> In fact, kmap() here is a total non-issue. It's not the kmap() that
> introduces any virtual aliases, and never has been. It's the
> "vm_map_ram()" that is the problem. Unlike the kmap(), that really
> _does_ introduce a virtual alias, and is a problem for any virtual
> cache.
> 
> So don't blame kmap(). It's innocent and irrelevant - the bug could
> happen entirely without it (think a 64-bit address space that doesn't
> even _have_ kmap, but has software that mixes vm_map_ram() with
> non-mapped accesses).

I didn't say it was kmap's entire problem ... I just said, can't we
simplify some of this by consolidating the flushing into the interfaces.

James
