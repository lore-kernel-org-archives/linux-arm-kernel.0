From: js1304@gmail.com (Joonsoo Kim)
Date: Fri, 30 Jan 2015 21:58:48 +0900
Subject: CMA related memory questions
In-Reply-To: <54CAF9A4.1040606@samsung.com>
References: <CABymUCNMjM2KHXXB-LM=x+FTcJL6S5_jhG3GbP7VRi2vBoW49g@mail.gmail.com>
 <CABymUCO+xaify95bUqfbCLsEjkLzEC0yT_fgkhV+qzC36JNgoA@mail.gmail.com>
 <CABymUCPgEh93QsBtRyg0S+FyE0FHwjAF75qk+NWh5TS8ehWuew@mail.gmail.com>
 <54CAF314.4070301@linaro.org> <54CAF9A4.1040606@samsung.com>
Message-ID: <CAAmzW4OfrKt0XK5bDO0TNR5Ofv=rLDkpS7HAOCk0NRV1WdOhNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-01-30 12:25 GMT+09:00 Heesub Shin <heesub.shin@samsung.com>:
>
>
> On 01/30/2015 11:57 AM, Jun Nie wrote:
>>
>> On 2015?01?30? 10:36, Jun Nie wrote:
>>>
>>> Hi Marek & Arnd,
>>>
>>> Did you ever know issue that free CMA memory is high, but system is
>>> hungry for memory and page cache is very low? I am enabling CMA in
>>> Android on my board with 512MB memory and see FreeMem in /proc/meminfo
>>> increase a lot with CMA comparing the reservation solution on boot. But
>>> I find system is not borrowing memory from CMA pool when running 3dmark
>>> (high webkit workload at start). Because the FreeMem size is high, but
>>> cache size decreasing significantly to several MB during benchmark run,
>>> I suppose system is trying to reclaim memory from pagecache for new
>>> allocation. My question is that what API that page cache and webkit
>>> related functionality are using to allocate memory. Maybe page cache
>>> require memory that is not movable/reclaimable memory, where we may have
>>> optimization to go thru dma_alloc_xxx to borrow CMA memory? I suppose
>>> app level memory allocation shall be movable/reclaimable memory and can
>>> borrow from CMA pool, but not sure whether the flag match the
>>> movable/reclaimable memory and go thru the right path.

Hello,

Maybe, you experienced the problem what I tried to solve.
CMA freepage allocation logic in mainline doesn't work well now since
they are only allocated in fallback case. See below link for detailed
explanation.

https://lkml.org/lkml/2014/5/28/64

This problem can be solved by aggressive allocation approach in that link, but,
there are too many issues left in CMA. So, I'm trying to implement ZONE_CMA
now. Prototyping is nearly finished so I will send it soon.

Thanks.
