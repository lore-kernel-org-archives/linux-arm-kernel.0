From: vbabka@suse.cz (Vlastimil Babka)
Date: Fri, 23 Nov 2018 13:15:16 +0100
Subject: [PATCH v2 3/3] iommu/io-pgtable-arm-v7s: Request DMA32 memory,
 and improve debugging
In-Reply-To: <CANMq1KCHGZ2vEWg+OQQ-SwvHcU-oMp4qKzEYfLwRYD5ZmRdRsA@mail.gmail.com>
References: <20181111090341.120786-1-drinkcat@chromium.org>
 <20181111090341.120786-4-drinkcat@chromium.org>
 <20181121164638.GD24883@arm.com> <20181121180000.GU12932@dhcp22.suse.cz>
 <CANMq1KCHGZ2vEWg+OQQ-SwvHcU-oMp4qKzEYfLwRYD5ZmRdRsA@mail.gmail.com>
Message-ID: <f5411603-2d06-916c-473d-1a40a5463876@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/22/18 2:20 AM, Nicolas Boichat wrote:
> On Thu, Nov 22, 2018 at 2:02 AM Michal Hocko <mhocko@kernel.org> wrote:
>>
>> On Wed 21-11-18 16:46:38, Will Deacon wrote:
>>> On Sun, Nov 11, 2018 at 05:03:41PM +0800, Nicolas Boichat wrote:
>>>
>>> It's a bit grotty that GFP_DMA32 doesn't just map to GFP_DMA on 32-bit
>>> architectures, since then we wouldn't need this #ifdeffery afaict.
>>
>> But GFP_DMA32 should map to GFP_KERNEL on 32b, no? Or what exactly is
>> going on in here?
> 
> GFP_DMA32 will fail due to check_slab_flags (aka GFP_SLAB_BUG_MASK
> before patch 1/3 of this series)... But yes, it may be neater if there
> was transparent remapping of GFP_DMA32/SLAB_CACHE_DMA32 to
> GFP_DMA/SLAB_CACHE_DMA on 32-bit arch...

I don't know about ARM, but AFAIK on x86 DMA means within first 4MB of
physical memory, and DMA32 means within first 4GB. It doesn't matter if
the CPU is running in 32bit or 64bit mode. But, when it runs 32bit, the
kernel can direct map less than 4GB anyway, which means it doesn't need
the extra DMA32 zone, i.e. GFP_KERNEL can only get you memory that's
also acceptable for GFP_DMA32.
But, DMA is still DMA, i.e. first 4MB. Remapping GFP_DMA32 to GFP_DMA on
x86 wouldn't work, as the GFP_DMA32 allocations would then only use
those 4MB and exhaust it very fast.

>> --
>> Michal Hocko
>> SUSE Labs
