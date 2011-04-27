From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 27 Apr 2011 10:52:25 +0100
Subject: [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <201104212129.17013.arnd@arndb.de>
References: <201104212129.17013.arnd@arndb.de>
Message-ID: <BANLkTinPbZZS9F1tRCA73fgoD-y__jSfCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On 21 April 2011 20:29, Arnd Bergmann <arnd@arndb.de> wrote:
> I think the recent discussions on linaro-mm-sig and the BoF last week
> at ELC have been quite productive, and at least my understanding
> of the missing pieces has improved quite a bit. This is a list of
> things that I think need to be done in the kernel. Please complain
> if any of these still seem controversial:
>
> 1. Fix the arm version of dma_alloc_coherent. It's in use today and
> ? is broken on modern CPUs because it results in both cached and
> ? uncached mappings. Rebecca suggested different approaches how to
> ? get there.

It's not broken since we moved to using Normal non-cacheable memory
for the coherent DMA buffers (as long as you flush the cacheable alias
before using the buffer, as we already do). The ARM ARM currently says
unpredictable for such situations but this is being clarified in
future updates and the Normal non-cacheable vs cacheable aliases can
be used (given correct cache maintenance before using the buffer).

> 2. Implement dma_alloc_noncoherent on ARM. Marek pointed out
> ? that this is needed, and it currently is not implemented, with
> ? an outdated comment explaining why it used to not be possible
> ? to do it.

As Russell pointed out, there are 4 main combinations with iommu and
some coherency support (i.e. being able to snoop the CPU caches). But
in an SoC you can have different devices with different iommu and
coherency configurations. Some of them may even be able to see the L2
cache but not the L1 (in which case it would help if we can get an
inner non-cacheable outer cacheable mapping).

Anyway, we end up with different DMA ops per device via dev_archdata.

-- 
Catalin
