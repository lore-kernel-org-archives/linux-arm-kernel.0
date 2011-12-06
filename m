From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 6 Dec 2011 13:16:58 +0000
Subject: [RFC v2 1/2] dma-buf: Introduce dma buffer sharing mechanism
In-Reply-To: <CAF6AEGto-+oSqguuWyPunUbtE65GpNiXh21srQzrChiBQMb1Nw@mail.gmail.com>
References: <1322816252-19955-1-git-send-email-sumit.semwal@ti.com>
 <CAKMK7uHw3OpMAtVib=e=s_us9Tx9TebzehGg59d4-g9dUXr+pQ@mail.gmail.com>
 <CAF6AEGto-+oSqguuWyPunUbtE65GpNiXh21srQzrChiBQMb1Nw@mail.gmail.com>
Message-ID: <201112061316.58858.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 December 2011, Rob Clark wrote:
> > On the topic of a coherency model for dmabuf, I think we need to look at
> > dma_buf_attachment_map/unmap (and also the mmap variants cpu_start and
> > cpu_finish or whatever they might get called) as barriers:
> >
> > So after a dma_buf_map, all previsously completed dma operations (i.e.
> > unmap already called) and any cpu writes (i.e. cpu_finish called) will be
> > coherent. Similar rule holds for cpu access through the userspace mmap,
> > only writes completed before the cpu_start will show up.
> >
> > Similar, writes done by the device are only guaranteed to show up after
> > the _unmap. Dito for cpu writes and cpu_finish.
> >
> > In short we always need two function calls to denote the start/end of the
> > "critical section".
> 
> Yup, this was exactly my assumption.  But I guess it is better to spell it out.

I still don't understand how this is going to help you if you let
multiple drivers enter and leave the critical section without serializing
against one another. That doesn't sound like what I know as critical
section.

Given some reasonable constraints (all devices must be in the same coherency
domain, for instance), you can probably define it in a way that you can
have multiple devices mapping the same buffer at the same time, and
when no device has mapped the buffer you can have as many concurrent
kernel and user space accesses on the same buffer as you like. But you
must still guarantee that no software touches a noncoherent buffer while
it is mapped into any device and vice versa.

Why can't we just mandate that all mappings into the kernel must be
coherent and that user space accesses must either be coherent as well
or be done by user space that uses explicit serialization with all
DMA accesses?

	Arnd
