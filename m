From: brian.starkey@arm.com (Brian Starkey)
Date: Tue, 1 Mar 2016 09:03:22 +0000
Subject: [PATCH v2 4/4] drivers: dma-coherent: use memset_io for
 DMA_MEMORY_IO mappings
In-Reply-To: <20160229151749.a972ae993adffb667140548d@linux-foundation.org>
References: <cover.1456225103.git.brian.starkey@arm.com>
 <7942c970d1071643f3763de6eaf6d55a3945a069.1456225103.git.brian.starkey@arm.com>
 <20160229151749.a972ae993adffb667140548d@linux-foundation.org>
Message-ID: <20160301090322.GA6013@e106950-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Mon, Feb 29, 2016 at 03:17:49PM -0800, Andrew Morton wrote:
>On Mon, 29 Feb 2016 16:09:24 +0000 Brian Starkey <brian.starkey@arm.com> wrote:
>
>> Use memset_io() for DMA_MEMORY_IO mappings which are mapped as I/O
>> memory, and regular memset() for DMA_MEMORY_MAP mappings.
>>
>> This fixes the below alignment fault on arm64 for DMA_MEMORY_IO
>> mappings, where memset() uses the DC ZVA instruction which is
>> invalid on device memory.
>
>What's the urgency of this fix?  "Hair on fire needed in stable asap"
>or "Nice to have in there for 4.6" or what?
>

No-one else is complaining so probably not the former. If it could
make 4.6 though that would be grand.

As for stable, anything before 3.15 doesn't hit the fault (on arm64)
because memset() is different, so probably not needed there.
For anything after that this patch in isolation isn't a full fix,
because dma_init_coherent_memory() will still use the wrong mapping
function for DMA_MEMORY_MAP. In that case, I think it needs to be the
whole series or nothing. I don't have a strong opinion either way, but
perhaps someone else does.

Thanks
Brian
