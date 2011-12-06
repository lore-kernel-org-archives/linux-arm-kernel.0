From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 6 Dec 2011 16:28:59 +0100
Subject: [RFC v2 1/2] dma-buf: Introduce dma buffer sharing mechanism
In-Reply-To: <201112061316.58858.arnd@arndb.de>
References: <1322816252-19955-1-git-send-email-sumit.semwal@ti.com>
 <CAKMK7uHw3OpMAtVib=e=s_us9Tx9TebzehGg59d4-g9dUXr+pQ@mail.gmail.com>
 <CAF6AEGto-+oSqguuWyPunUbtE65GpNiXh21srQzrChiBQMb1Nw@mail.gmail.com>
 <201112061316.58858.arnd@arndb.de>
Message-ID: <CAKMK7uHeXYn-v_8cmpLNWsFY14KtmuRZy8YRKR5Xst2-2WdFSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2011 at 01:16:58PM +0000, Arnd Bergmann wrote:
> On Monday 05 December 2011, Rob Clark wrote:
> > > On the topic of a coherency model for dmabuf, I think we need to look at
> > > dma_buf_attachment_map/unmap (and also the mmap variants cpu_start and
> > > cpu_finish or whatever they might get called) as barriers:
> > >
> > > So after a dma_buf_map, all previsously completed dma operations (i.e.
> > > unmap already called) and any cpu writes (i.e. cpu_finish called) will be
> > > coherent. Similar rule holds for cpu access through the userspace mmap,
> > > only writes completed before the cpu_start will show up.
> > >
> > > Similar, writes done by the device are only guaranteed to show up after
> > > the _unmap. Dito for cpu writes and cpu_finish.
> > >
> > > In short we always need two function calls to denote the start/end of the
> > > "critical section".
> >
> > Yup, this was exactly my assumption.  But I guess it is better to spell it out.
>
> I still don't understand how this is going to help you if you let
> multiple drivers enter and leave the critical section without serializing
> against one another. That doesn't sound like what I know as critical
> section.

I already regret to having added that last "critical section" remark.
Think barriers. It's just that you need a barrier in both directions that
bracket the actual usage. In i915-land we call the first one generally
invalidate (so that caches on the target domain don't contain stale data)
and that second one flush (to get any data out of caches).

> Given some reasonable constraints (all devices must be in the same coherency
> domain, for instance), you can probably define it in a way that you can
> have multiple devices mapping the same buffer at the same time, and
> when no device has mapped the buffer you can have as many concurrent
> kernel and user space accesses on the same buffer as you like. But you
> must still guarantee that no software touches a noncoherent buffer while
> it is mapped into any device and vice versa.
>
> Why can't we just mandate that all mappings into the kernel must be
> coherent and that user space accesses must either be coherent as well
> or be done by user space that uses explicit serialization with all
> DMA accesses?

I agree with your points here, afaics the contentious issue is just
whether dma_buf should _enforce_ this strict ordering. I'm leading towards
a "no" for the following reasons:

- gpu people love nonblocking interfaces (and love to come up with
  abuses). In the generic case we'd need some more functions to properly
  flush everything while 2 devices access a buffer concurrently (which is
  imo a bit unrealistic). But e.g. 2 gpus rendering in SLI mode very much
  want to access the same buffer at the same time (and the
  kernel+userspace gpu driver already needs all the information about
  caches to make that happen, at least on x86).

- Buffer sharing alone has already some great potential for deadlock and
  lock recursion issues. Making dma_buf into something that very much acts
  like a new locking primitive itself (even exposed to userspace) will
  make this much worse. I've seen some of the kernel/userspace shared
  hwlock code of dri1 yonder, and it's horrible (and at least for the case
  of the dri1 hwlock, totally broken).

- All current subsystem already have the concept to pass the ownership of
  a buffer between the device and userspace (sometimes even more than just
  2 domains, like in i915 ...). Userspace already needs to use this
  interface to get anything resembling correct data. I don't see any case
  where userspace can't enforce passing around buffer ownership if
  multiple devices are involved (we obviously need to clarify subsystem
  interfaces to make it clear when a buffer is in use and when another
  device taking part in the sharing could use it). So I don't see how the
  kernel enforcing strict access ordering helps implementing correct
  userspace.

- I don't see any security needs that would make it necessary for the
  kernel to enforce any consistency guarantees for concurrent access -
  we're only dealing with pixel data in all the currently discussed
  generic use-cases. So I think garbage as an end-result is acceptable if
  userspace does stupid things (or fails at trying to be clever).

Cheers, Daniel
-- 
Daniel Vetter
Mail: daniel at ffwll.ch
Mobile: +41 (0)79 365 57 48
