From: airlied@gmail.com (Dave Airlie)
Date: Wed, 12 Oct 2011 13:41:57 +0100
Subject: [Linaro-mm-sig] [RFC 1/2] dma-buf: Introduce dma buffer sharing
	mechanism
In-Reply-To: <1318325033-32688-2-git-send-email-sumit.semwal@ti.com>
References: <1318325033-32688-1-git-send-email-sumit.semwal@ti.com>
	<1318325033-32688-2-git-send-email-sumit.semwal@ti.com>
Message-ID: <CAPM=9tzHOa5Dbe=SQz+AURMMbio4L7qoS8kUT3Ek0+HdtkrH4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2011 at 10:23 AM, Sumit Semwal <sumit.semwal@ti.com> wrote:
> This is the first step in defining a dma buffer sharing mechanism.
>
> A new buffer object dma_buf is added, with operations and API to allow easy
> sharing of this buffer object across devices.
>
> The framework allows:
> - a new buffer-object to be created with fixed size.
> - different devices to 'attach' themselves to this buffer, to facilitate
> ?backing storage negotiation, using dma_buf_attach() API.
> - association of a file pointer with each user-buffer and associated
> ? allocator-defined operations on that buffer. This operation is called the
> ? 'export' operation.
> - this exported buffer-object to be shared with the other entity by asking for
> ? its 'file-descriptor (fd)', and sharing the fd across.
> - a received fd to get the buffer object back, where it can be accessed using
> ? the associated exporter-defined operations.
> - the exporter and user to share the scatterlist using get_scatterlist and
> ? put_scatterlist operations.
>
> Atleast one 'attach()' call is required to be made prior to calling the
> get_scatterlist() operation.
>
> Couple of building blocks in get_scatterlist() are added to ease introduction
> of sync'ing across exporter and users, and late allocation by the exporter.
>
> mmap() file operation is provided for the associated 'fd', as wrapper over the
> optional allocator defined mmap(), to be used by devices that might need one.

Why is this needed? it really doesn't make sense to be mmaping objects
independent of some front-end like drm or v4l.

how will you know what contents are in them, how will you synchronise
access. Unless someone has a hard use-case for this I'd say we drop it
until someone does.

Dave.
