From: vichy.kuo@gmail.com (vichy)
Date: Thu, 12 Mar 2015 05:54:59 +0800
Subject: some question about Set bit 22 in the PL310 (cache controller)
 AuxCtlr register
In-Reply-To: <CAOVJa8EneaXA5bX2_f4JBjKyG2G2subWPd3Vf9d_S-QxG9iO5g@mail.gmail.com>
References: <CAOVJa8Euj-VC-r0uQdyxqRtU7v23t3UW=wWTbrTCz_6gSp4x6g@mail.gmail.com>
 <20150310163133.GC13687@e104818-lin.cambridge.arm.com>
 <CAOVJa8EneaXA5bX2_f4JBjKyG2G2subWPd3Vf9d_S-QxG9iO5g@mail.gmail.com>
Message-ID: <CAOVJa8Gi4JRT=VDXG_nec30PCJoWUiA-9dE56NrGeE48Lww+Hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Catalin:

2015-03-11 22:35 GMT+08:00 vichy <vichy.kuo@gmail.com>:
> hi Catalin:
>
> 2015-03-11 0:31 GMT+08:00 Catalin Marinas <catalin.marinas@arm.com>:
>> On Sun, Mar 08, 2015 at 08:31:45PM +0800, vichy wrote:
>>> Recently we bumped into the same issue like below path:
>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/245908.html
>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-November/031810.html
>>>
>>> We have some question about this patch:
>>> a. Under what circumstances, there will be memory returned by
>>> dma_alloc_coherent and friends mapped as normal, cacheable mappings?
>>
>> dma_alloc_coherent() allocating from ZONE_DMA (or ZONE_NORMAL) which is
>> already mapped in the kernel linear mapping as Normal Cacheable.
>>
>>> b. why "with CMA enabled, it should be safe not to set this bit."
>>
>> It's not entirely safe either. I guess the assumption is that CMA
>> allocates from highmem which is not mapped in the kernel linear mapping.
>> However, to be able to flush the caches for such highmem pages, they
>> need to be mapped (kmap_atomic() in __dma_clear_buffer()) but there is a
>> small window between dmac_flush_range() and kunmap_atomic() where
>> speculative cache line fills can still happen.
>>
>> Bit 22 in PL310 AuxCtlr must be set for most (all) uses of the coherent
>> DMA API in Linux.
Sorry for not describing my question more clear.
Not only the above 2 links I pasted in the mail, I also found other
threads has the issue as mine.
(about L2C_AUX_CTRL_SHARED_OVERRIDE)
And all of them(so far I see) suggest to set this bit on.
if so, under what circumstance, the Bit22 in PL310 AuxCtlr will be cleared?
thanks your kind help,
