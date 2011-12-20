From: robdclark@gmail.com (Rob Clark)
Date: Tue, 20 Dec 2011 10:41:45 -0600
Subject: [Linaro-mm-sig] [RFC v2 1/2] dma-buf: Introduce dma buffer
 sharing mechanism
In-Reply-To: <201112201541.17904.arnd@arndb.de>
References: <1322816252-19955-1-git-send-email-sumit.semwal@ti.com>
 <201112121648.52126.arnd@arndb.de>
 <CAB2ybb_dU7BzJmPo6vA92pe1YCNerCLc+bv7Qi_EfkfGaik6bQ@mail.gmail.com>
 <201112201541.17904.arnd@arndb.de>
Message-ID: <CAF6AEGtOjO6Z6yfHz-ZGz3+NuEMH2M-8=20U6+-xt-gv9XtzaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2011 at 9:41 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 19 December 2011, Semwal, Sumit wrote:
>> I didn't see a consensus on whether dma_buf should enforce some form
>> of serialization within the API - so atleast for v1 of dma-buf, I
>> propose to 'not' impose a restriction, and we can tackle it (add new
>> ops or enforce as design?) whenever we see the first need of it - will
>> that be ok? [I am bending towards the thought that it is a problem to
>> solve at a bigger platform than dma_buf.]
>
> The problem is generally understood for streaming mappings with a
> single device using it: if you have a long-running mapping, you have
> to use dma_sync_*. This obviously falls apart if you have multiple
> devices and no serialization between the accesses.
>
> If you don't want serialization, that implies that we cannot have
> use the ?dma_sync_* API on the buffer, which in turn implies that
> we cannot have streaming mappings. I think that's ok, but then
> you have to bring back the mmap API on the buffer if you want to
> allow any driver to provide an mmap function for a shared buffer.

I'm thinking for a first version, we can get enough mileage out of it by saying:
1) only exporter can mmap to userspace
2) only importers that do not need CPU access to buffer..

This way we can get dmabuf into the kernel, maybe even for 3.3.  I
know there are a lot of interesting potential uses where this stripped
down version is good enough.  It probably isn't the final version,
maybe more features are added over time to deal with importers that
need CPU access to buffer, sync object, etc.  But we have to start
somewhere.

BR,
-R

> ? ? ? ?Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-media" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
