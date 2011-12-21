From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Dec 2011 17:27:16 +0000
Subject: [Linaro-mm-sig] [RFC v2 1/2] dma-buf: Introduce dma buffer
 sharing mechanism
In-Reply-To: <20111220171437.GC3883@phenom.ffwll.local>
References: <1322816252-19955-1-git-send-email-sumit.semwal@ti.com>
 <CAF6AEGtOjO6Z6yfHz-ZGz3+NuEMH2M-8=20U6+-xt-gv9XtzaQ@mail.gmail.com>
 <20111220171437.GC3883@phenom.ffwll.local>
Message-ID: <201112211727.17104.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 20 December 2011, Daniel Vetter wrote:
> > I'm thinking for a first version, we can get enough mileage out of it by saying:
> > 1) only exporter can mmap to userspace
> > 2) only importers that do not need CPU access to buffer..

Ok, that sounds possible. The alternative to this would be:

1) The exporter has to use dma_alloc_coherent() or dma_alloc_writecombine()
to allocate the buffer
2. Every user space mapping has to go through dma_mmap_coherent()
or dma_mmap_writecombine()

We can extend the rules later to allow either one after we have gained
some experience using it.

> > This way we can get dmabuf into the kernel, maybe even for 3.3.  I
> > know there are a lot of interesting potential uses where this stripped
> > down version is good enough.  It probably isn't the final version,
> > maybe more features are added over time to deal with importers that
> > need CPU access to buffer, sync object, etc.  But we have to start
> > somewhere.
> 
> I agree with Rob here - I think especially for the coherency discussion
> some actual users of dma_buf on a bunch of insane platforms (i915
> qualifies here too, because we do some cacheline flushing behind everyones
> back) would massively help in clarifying things.

Yes, agreed.

> It also sounds like that at least for proper userspace mmap support we'd
> need some dma api extensions on at least arm, and that might take a while
> ...

I think it's actually the opposite -- you'd need dma api extensions on
everything else other than arm, which already has dma_mmap_coherent()
and dma_mmap_writecombine() for this purpose.

	Arnd
