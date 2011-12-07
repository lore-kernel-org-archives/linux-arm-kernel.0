From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Dec 2011 13:40:35 +0000
Subject: [RFC v2 1/2] dma-buf: Introduce dma buffer sharing mechanism
In-Reply-To: <CAB2ybb-0mTdNXN82O1TUGVjhMZUQtQb07A3EVmmdxg3ngEc3Dw@mail.gmail.com>
References: <1322816252-19955-1-git-send-email-sumit.semwal@ti.com>
 <CAF6AEGto-+oSqguuWyPunUbtE65GpNiXh21srQzrChiBQMb1Nw@mail.gmail.com>
 <CAB2ybb-0mTdNXN82O1TUGVjhMZUQtQb07A3EVmmdxg3ngEc3Dw@mail.gmail.com>
Message-ID: <201112071340.35267.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 December 2011, Semwal, Sumit wrote:
> Thanks for the excellent discussion - it indeed is very good learning
> for the relatively-inexperienced me :)
> 
> So, for the purpose of dma-buf framework, could I summarize the
> following and rework accordingly?:
> 1. remove mmap() dma_buf_op [and mmap fop], and introduce cpu_start(),
> cpu_finish() ops to bracket cpu accesses to the buffer. Also add
> DMABUF_CPU_START / DMABUF_CPU_FINI IOCTLs?

I think we'd be better off for now without the extra ioctls and
just document that a shared buffer must not be exported to user
space using mmap at all, to avoid those problems. Serialization
between GPU and CPU is on a higher level than the dma_buf framework
IMHO.

> 2. remove sg_sync* ops for now (and we'll see if we need to add them
> later if needed)

Just removing the sg_sync_* operations is not enough. We have to make
the decision whether we want to allow
a) only coherent mappings of the buffer into kernel memory (requiring
an extension to the dma_map_ops on ARM to not flush caches at map/unmap
time)
b) not allowing any in-kernel mappings (same requirement on ARM, also
limits the usefulness of the dma_buf if we cannot access it from the
kernel or from user space)
c) only allowing streaming mappings, even if those are non-coherent
(requiring strict serialization between CPU (in-kernel) and dma users of
the buffer)

This issue has to be solved or we get random data corruption.

	Arnd
