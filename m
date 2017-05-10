From: phil@raspberrypi.org (Phil Elwell)
Date: Wed, 10 May 2017 10:11:04 +0100
Subject: [PATCH] staging: vc04_services: Fix bulk cache maintenance
In-Reply-To: <20170510090626.GA21141@kroah.com>
References: <d0edaf52-45e2-6fda-bb86-1a9b5e1a5425@raspberrypi.org>
 <139394270.264573.1493920270267@email.1und1.de>
 <bd72cc29-140e-dfd7-eac5-01ccc8b844b1@raspberrypi.org>
 <20170510090626.GA21141@kroah.com>
Message-ID: <93d0bbb7-f682-8f5f-9491-f3ad1941d397@raspberrypi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/05/2017 10:06, Greg Kroah-Hartman wrote:
> On Wed, May 10, 2017 at 09:42:43AM +0100, Phil Elwell wrote:
>> On 04/05/2017 18:51, Stefan Wahren wrote:
>>>
>>>> Phil Elwell <phil@raspberrypi.org> hat am 4. Mai 2017 um 11:58 geschrieben:
>>>>
>>>>
>>>> vchiq_arm supports transfers less than one page and at arbitrary
>>>> alignment, using the dma-mapping API to perform its cache maintenance
>>>> (even though the VPU drives the DMA hardware). Read (DMA_FROM_DEVICE)
>>>> operations use cache invalidation for speed, falling back to
>>>> clean+invalidate on partial cache lines, with writes (DMA_TO_DEVICE)
>>>> using flushes.
>>>>
>>>> If a read transfer has ends which aren't page-aligned, performing cache
>>>> maintenance as if they were whole pages can lead to memory corruption
>>>> since the partial cache lines at the ends (and any cache lines before or
>>>> after the transfer area) will be invalidated. This bug was masked until
>>>> the disabling of the cache flush in flush_dcache_page().
>>>>
>>>> Honouring the requested transfer start- and end-points prevents the
>>>> corruption.
>>>>
>>>> Fixes: cf9caf192988 ("staging: vc04_services: Replace dmac_map_area with dmac_map_sg")
>>>> Signed-off-by: Phil Elwell <phil@raspberrypi.org>
>>>
>>> Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
>>> Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
>>>
>>> In order to clarify the context of this issue:
>>>
>>> http://lists.infradead.org/pipermail/linux-rpi-kernel/2017-April/006149.html
>>
>> Thanks, Stefan.
>>
>> Is there no feedback other on this patch? It's been in the rpi-4.11.y downstream
>> branch for a week now with favourable results - see issue
>> https://github.com/raspberrypi/linux/issues/1977 and pr
>> https://github.com/raspberrypi/linux/pull/1987.
> 
> It's the middle of the merge window, I can't do anything with this
> until after 4.12-rc1 comes out.  Please be patient...

Yes, of course - that's the kind of feedback I was looking for.

Thanks,

Phil
