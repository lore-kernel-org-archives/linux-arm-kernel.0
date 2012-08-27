From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Mon, 27 Aug 2012 16:23:31 +0800
Subject: Question about ION carveout heap support partial cache flush
In-Reply-To: <CAN1soZyZ=4wjKkVrk5--2U_8SeT7qee9QAfhss7NgqtQAz+RrA@mail.gmail.com>
References: <CAMj5BkgffAW6azUjwz+iCF1tBLmBDRBvBjR-_fTr=4G=h+BLZw@mail.gmail.com>
 <CAN1soZyZ=4wjKkVrk5--2U_8SeT7qee9QAfhss7NgqtQAz+RrA@mail.gmail.com>
Message-ID: <CAMj5BkiVq9ayJjUrwh3S-gDfezUTNiPFW-xd_dsbTJYTyLv2WQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2012 at 1:46 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> On Mon, Aug 27, 2012 at 9:51 AM, zhangfei gao <zhangfei.gao@gmail.com> wrote:
>> Hi, All
>>
>> We met question about dmac_map_area & dmac_flush_range from user addr.
>> mcr would not return on armv7 processor.
>>
>> Existing ion carveout heap does not support partial cache flush.
>> Total cache will be flushed at all.
>>
>> There is only one dirty bit for carveout heap, as well as sg_table->nents.
>> drivers/gpu/ion/ion_carveout_heap.c
>> ion_carveout_heap_map_dma -> sg_alloc_table(table, 1, GFP_KERNEL);
>> ion_buffer_alloc_dirty -> pages = buffer->sg_table->nents;
>>
>> We want to support partial cache flush.
>> Align to cache line, instead of PAGE_SIZE, for efficiency consideration.
>> We have considered extended dirty bit, but looks like only align to PAGE_SIZE.
>>
>> For experiment we modify ioctl ION_IOC_SYNC on armv7.
>> And directly use dmac_map_area & dmac_flush_range with add from user space.
>> However, we find dmac_map_area can not work with this addr from user space.
>> In fact, it is  mcr can not work with addr from user space, it would hung.
>
> Let me summerize it. First, user space address is mapped. Then,
> flushing user space
> address is triggered. It's a workaround of fixing non-existed virtual
> address without fixing
> vmap() or any other solution. It's just a quick fix.
>
> Zhangfei,
> I doubt that the issue may be caused by missing memory barrier.
> Flushing is using
> coprocessor instructions. It's a little different.

Is there any limitation that dmac_map_area & dmac_flush_range
supporting addr mapped from user space?
And mcr can not return with user space addr.
While __davt_svc -> page fault happen, even the page table has already
been set up.

Thanks
