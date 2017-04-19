From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Apr 2017 12:10:58 +0200
Subject: [PATCH v3 5/7] ARM: NOMMU: Introduce dma operations for noMMU
In-Reply-To: <1489137839-549-6-git-send-email-vladimir.murzin@arm.com>
References: <1489137839-549-1-git-send-email-vladimir.murzin@arm.com>
 <1489137839-549-6-git-send-email-vladimir.murzin@arm.com>
Message-ID: <CAK8P3a37QAZNp9hvbM10EjMNnTsiiN-Z3u8o=883bev4Th-iOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 10, 2017 at 10:23 AM, Vladimir Murzin
<vladimir.murzin@arm.com> wrote:
> R/M classes of cpus can have memory covered by MPU which in turn might
> configure RAM as Normal i.e. bufferable and cacheable. It breaks
> dma_alloc_coherent() and friends, since data can stuck in caches now
> or be buffered.
>
> This patch factors out DMA support for NOMMU configuration into
> separate entity which provides dedicated dma_ops. We have to handle
> there several cases:
> - configurations with MMU/MPU setup
> - configurations without MMU/MPU setup
> - special case for M-class, since caches and MPU there are optional
>
> In general we rely on default DMA area for coherent allocations or/and
> per-device memory reserves suitable for coherent DMA, so if such
> regions are set coherent allocations go from there.
>
> In case MPU/MPU was not setup we fallback to normal page allocator for
> DMA memory allocation.
>
> In case we run M-class cpus, for configuration without cache support
> (like Cortex-M3/M4) dma operations are forced to be coherent and wired
> with dma-noop (such decision is made based on cacheid global
> variable); however, if caches are detected there and no DMA coherent
> region is given (either default or per-device), dma is disallowed even
> MPU is not set - it is because M-class implement system memory map
> which defines part of address space as Normal memory.
>
> Reported-by: Alexandre Torgue <alexandre.torgue@st.com>
> Reported-by: Andras Szemzo <sza@esh.hu>
> Tested-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Tested-by: Andras Szemzo <sza@esh.hu>
> Tested-by: Alexandre TORGUE <alexandre.torgue@st.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>

I thought I found a couple of problems with this, but after reading more
carefully I was wrong about all of them and I think the code is doing
exactly the right thing. I also like the way this is split out into a separate
set of dma_map_ops to simplify the normal MMU case.

Acked-by: Arnd Bergmann <arnd@arndb.de>
