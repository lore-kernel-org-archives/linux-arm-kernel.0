From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 10 Jan 2012 11:20:32 +0100
Subject: [RFC PATCH v2 4/8] media: videobuf2: introduce VIDEOBUF2_PAGE
 memops
In-Reply-To: <CACVXFVMrRTS7TUtj7bqCWeF4zx11yT6mOq4syOkZv=Ejoo0LMw@mail.gmail.com>
References: <1323871214-25435-1-git-send-email-ming.lei@canonical.com>
 <1323871214-25435-5-git-send-email-ming.lei@canonical.com>
 <010501ccc08c$1c7b7870$55726950$%szyprowski@samsung.com>
 <CACVXFVOqMmakPW-aAdp005RDLuV5oc6-JfjQHr-2bFRzZi2zDQ@mail.gmail.com>
 <015201ccc156$033f73a0$09be5ae0$%szyprowski@samsung.com>
 <CACVXFVNdczv=tu7VG24766myCnGDRWAjkthbdfMwTGzTwFCoBA@mail.gmail.com>
 <015301ccc15f$053e61d0$0fbb2570$%szyprowski@samsung.com>
 <CACVXFVMrRTS7TUtj7bqCWeF4zx11yT6mOq4syOkZv=Ejoo0LMw@mail.gmail.com>
Message-ID: <013701cccf81$7c0cdb90$742692b0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Friday, December 23, 2011 1:21 PM Ming Lei wrote:

> >> >> > Your current implementation also abuses the design and api of videobuf2 memory
> >> >> > allocators. If the allocator needs to return a custom structure to the driver
> >> >>
> >> >> I think returning vaddr is enough.
> >> >>
> >> >> > you should use cookie method. vaddr is intended to provide only a pointer to
> >> >> > kernel virtual mapping, but you pass a struct page * there.
> >> >>
> >> >> No, __get_free_pages returns virtual address instead of 'struct page *'.
> >> >
> >> > Then you MUST use cookie for it. vaddr method should return kernel virtual address
> >> > to the buffer video data. Some parts of videobuf2 relies on this - it is used by file
> >> > io emulator (read(), write() calls) and mmap equivalent for non-mmu systems.
> >> >
> >> > Manual casting in the driver is also a bad idea, that's why there are helper functions
> >>
> >> I don't see any casts are needed. The dma address can be got from vaddr with
> >> dma_map_* easily in drivers, see the usage on patch 8/8(media: video: introduce
> >> omap4 face detection module driver).
> >
> > Sorry, but I won't accept such driver/allocator which abuses the defined API. I've already
> > pointed what vaddr method is used for.
> 
> Sorry, could you describe the abuse problem in a bit detail?

Videobuf2 requires memory module handlers to provide vaddr method to provide a pointer in 
kernel virtual address space to video data (buffer content). It is used for example by 
read()/write() io method emulator. Memory allocator/handler should not be specific to any
particular use case in the device driver. That's the design. Simple.

I your case you want to give pointer to struct page from the memory allocator to the 
driver. The cookie method has been introduced exactly for this purpose. Memory allocator
also provides a simple inline function to convert generic 'void *' return type from cookie
method to allocator specific structure/pointer. vb2_dma_contig_plane_dma_addr() and 
vb2_dma_sg_plane_desc() were examples how does passing allocator specific type though the
cookie method works.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
