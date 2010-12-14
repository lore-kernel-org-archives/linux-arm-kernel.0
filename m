From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 14 Dec 2010 21:08:42 +0000
Subject: [PATCH 4/4] Do not call flush_cache_user_range with mmap_sem held
In-Reply-To: <20101214190503.GB24303@n2100.arm.linux.org.uk>
References: <1292302659-1863-1-git-send-email-john.stultz@linaro.org>
	<1292302659-1863-5-git-send-email-john.stultz@linaro.org>
	<20101214093002.GA18425@n2100.arm.linux.org.uk>
	<AANLkTim1Wspod2LnfVw7atzP921C6o7EiKRVqw9LeqhG@mail.gmail.com>
	<20101214190503.GB24303@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimw839TCrzY0X4n8_AcwwdT1kFxNQNNsFC9SRdb@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, 14 December 2010, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Dec 14, 2010 at 05:51:36PM +0000, Catalin Marinas wrote:
>> But what's the problem if such mapping disappears? The
>> flush_cache_user_range code should just skip such pages.
>
> That's only half the story.
>
> What if someone remaps something over that range before the cache
> maintainence has completed.

That someone remapping the same range can only be a thread of the same
process. If the code was so badly written as to unmap ranges of memory
when a thread actively uses it, then it probably deserves any
corruption.

OTOH, the cache flushing operations is pretty harmless even if you do
it on the wrong memory range. On ARM11MPCore we probably need to do
some read/write for ownership as in the DMA ops.

There are architectures at allow cache flushing from user space (no
invalidation as that's a bit dangerous) and they don't have any access
to the kernel semaphores. I don't see this any difference here, we
just need to make sure that the kernel can cope with invalid ranges.

-- 
Catalin
