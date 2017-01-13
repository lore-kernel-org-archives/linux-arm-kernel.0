From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 13 Jan 2017 11:52:41 +0000
Subject: [RFC] Kernel panic down to swiotlb when doing insmod a simple
 driver
In-Reply-To: <CAKv+Gu_5QC4=9SmyBWTZaQUcsJudKB=2g5Bs=MVyRPUGtWPJ4w@mail.gmail.com>
References: <d64931b6-8875-51ea-06a0-e0981e12f859@rock-chips.com>
 <99472068-069a-7759-8d6e-019fd875264d@arm.com>
 <CAKv+Gu-aaGuHmshi=aiexUD=dxuia7tHKm3LQt3RG-7D_3v9Mw@mail.gmail.com>
 <bf4b1861-7190-c888-b9be-646e2a2297bb@arm.com>
 <CAKv+Gu_5QC4=9SmyBWTZaQUcsJudKB=2g5Bs=MVyRPUGtWPJ4w@mail.gmail.com>
Message-ID: <039058a7-9e5a-d931-5bec-f0f3ccc86cf3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/01/17 11:49, Ard Biesheuvel wrote:
> On 13 January 2017 at 11:47, Robin Murphy <robin.murphy@arm.com> wrote:
>> On 13/01/17 11:25, Ard Biesheuvel wrote:
>>> On 13 January 2017 at 11:03, Robin Murphy <robin.murphy@arm.com> wrote:
>>>> On 13/01/17 10:00, Shawn Lin wrote:
>>>>> Hi,
>>>>>
>>>>> Sorry for sending this RFC for help as I couldn't find some useful hint
>>>>> to slove my issue by git-log the swiotlb commit from kernel v4.4 to
>>>>> v4.9 and I'm also not familar with these stuff. So could you kindly
>>>>> point me to the right direction to debug it? Thanks. :)
>>>>>
>>>>> --------------------------------------
>>>>> We just have a very simple wifi driver *built as ko module* which only
>>>>> have a probe function to do the basic init work and call SDIO API to
>>>>> transfer some bytes.
>>>>>
>>>>> Env: kernel 4.4 stable tree, ARM64(rk3399)
>>>>>
>>>>> Two cases are included:
>>>>
>>>> And they are both wrong :)
>>>>
>>>>> The crash case:
>>>>>
>>>>> u8 __aligned(32) buf[PAGE_SIZE]; //global here in ko driver file
>>>>
>>>> It is only valid to do DMA from linear map addresses - I'm not sure if
>>>> the modules area was in the linear map before, but either way it
>>>> probably isn't now (Ard, Mark?). Either way, I don't believe static data
>>>> honours ARCH_DMA_MINALIGN in general, so it's still highly inadvisable.
>>>>
>>>
>>> The __aligned() modifier should work fine: the alignment is propagated
>>> to the ELF section alignment, which in turn is honoured by the module
>>> loader. The problem is that '32' is too low for non-coherent DMA to be
>>> safe. In general, alignments up to 4 KB should work everywhere.
>>
>> Does that alignment also implicitly apply to the size, though? In other
>> words, given:
>>
>> static int X
>> static int __aligned(32) Y;
>> static int Z;
>>
>> is it guaranteed that if, say, X gets placed at .data + 0, so Y goes to
>> .data + 32, then Z *cannot* be placed at .data + 36?
>>
> 
> I'm not sure if I understand the question: why would it be incorrect
> for Z to be placed at .data + 36?

Because they'd then wind up in the same cache line, so non-coherent DMA
to Y will result in concurrent CPU updates to Z being lost/corrupted.
ARCH_DMA_MINALIGN isn't about alignemnt per se, it's about keeping
things in distinct cache writeback granules.

Robin.
