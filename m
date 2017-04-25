From: dingtianhong@huawei.com (Ding Tianhong)
Date: Tue, 25 Apr 2017 14:42:30 +0800
Subject: [PATCH] Revert "arm64: Increase the max granular size"
In-Reply-To: <CA+sq2Cc8tqpGcUKkLh22e7_TZqu5jmrV9XKddVnxGfDsoSBf3A@mail.gmail.com>
References: <10fef112-37f1-0a1b-b5af-435acd032f01@codeaurora.org>
 <4525901c-45d4-6bd8-eec6-ae92977f16d1@codeaurora.org>
 <20170406155825.GA7705@e104818-lin.cambridge.arm.com>
 <CADAEsF_Hr=mPspvuPsQtKWiSDu6oCjfyy0rGwWrF9EJo-ZO1JA@mail.gmail.com>
 <08fa98de-760b-15bc-5220-fa449b08c118@codeaurora.org>
 <725F073F-025B-48B9-9935-24EFEBF2B7DC@caviumnetworks.com>
 <93d2819a-95b1-6606-74d4-0bc0a64db29e@codeaurora.org>
 <CA+sq2CeTZyTrc3kC-kJEyrT5Tt5Wr47F=OVaCHwMRZk96qo4HA@mail.gmail.com>
 <20170418144839.GF27592@e104818-lin.cambridge.arm.com>
 <CA+sq2Ccf9K=to7rFAmWqWe-oXqNOGhZ+UQKui+ea+rSkR2pcbg@mail.gmail.com>
 <20170419120114.GB3238@e104818-lin.cambridge.arm.com>
 <CA+sq2Cc8tqpGcUKkLh22e7_TZqu5jmrV9XKddVnxGfDsoSBf3A@mail.gmail.com>
Message-ID: <8404ae8e-9bfa-5280-32ea-ac7475c67cae@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2017/4/19 21:11, Sunil Kovvuri wrote:
> On Wed, Apr 19, 2017 at 5:31 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
>> On Tue, Apr 18, 2017 at 10:35:02PM +0530, Sunil Kovvuri wrote:
>>> On Tue, Apr 18, 2017 at 8:18 PM, Catalin Marinas
>>> <catalin.marinas@arm.com> wrote:
>>>> On Mon, Apr 17, 2017 at 04:08:52PM +0530, Sunil Kovvuri wrote:
>>>>>>>     >> Do you have an explanation on the performance variation when
>>>>>>>     >> L1_CACHE_BYTES is changed? We'd need to understand how the network stack
>>>>>>>     >> is affected by L1_CACHE_BYTES, in which context it uses it (is it for
>>>>>>>     >> non-coherent DMA?).
>>>>>>>     >
>>>>>>>     > network stack use SKB_DATA_ALIGN to align.
>>>>>>>     > ---
>>>>>>>     > #define SKB_DATA_ALIGN(X) (((X) + (SMP_CACHE_BYTES - 1)) & \
>>>>>>>     > ~(SMP_CACHE_BYTES - 1))
>>>>>>>     >
>>>>>>>     > #define SMP_CACHE_BYTES L1_CACHE_BYTES
>>>>>>>     > ---
>>>>>>>     > I think this is the reason of performance regression.
>>>>>>>     >
>>>>>>>
>>>>>>>     Yes this is the reason for performance regression. Due to increases L1 cache alignment the
>>>>>>>     object is coming from next kmalloc slab and skb->truesize is changing from 2304 bytes to
>>>>>>>     4352 bytes. This in turn increases sk_wmem_alloc which causes queuing of less send buffers.
>>>>>
>>>>> With what traffic did you check 'skb->truesize' ? Increase from
>>>>> 2304 to 4352 bytes doesn't seem to be real. I checked with ICMP
>>>>> pkts with maximum size possible with 1500byte MTU and I don't see
>>>>> such a bump. If the bump is observed with Iperf sending TCP packets
>>>>> then I suggest to check if TSO is playing a part over here.
>>>>
>>>> I haven't checked truesize but I added some printks to __alloc_skb() (on
>>>> a Juno platform) and the size argument to this function is 1720 on many
>>>> occasions. With sizeof(struct skb_shared_info) of 320, the actual data
>>>> allocation is exactly 2048 when using 64 byte L1_CACHE_SIZE. With a
>>>> 128 byte cache size, it goes slightly over 2K, hence the 4K slab
>>>> allocation.
>>>
>>> Understood but still in my opinion this '4K slab allocation' cannot be
>>> considered as an issue with cache line size, there are many network
>>> drivers out there which do receive buffer or page recycling to
>>> minimize (sometimes almost to zero) the cost of buffer allocation.
>>
>> The slab allocation shouldn't make much difference (unless you are
>> running on a memory constrained system) but I don't understand how
>> skb->truesize (which is almost half unused) affects the sk_wmem_alloc
>> and its interaction with other bits in the network stack (e.g.
>> tcp_limit_output_bytes).
>>
>> However, I do think it's worth investigating further to fully understand
>> the issue.
> 
> Absolutely.
> 
>>
>>>> The 1720 figure surprised me a bit as well since I was
>>>> expecting something close to 1500.
>>>>
>>>> The thing that worries me is that skb->data may be used as a buffer to
>>>> DMA into. If that's the case, skb_shared_info is wrongly aligned based
>>>> on SMP_CACHE_BYTES only and can lead to corruption on a non-DMA-coherent
>>>> platform. It should really be ARCH_DMA_MINALIGN.
>>>
>>> I didn't get this, if you see __alloc_skb()
>>>
>>> 229         size = SKB_DATA_ALIGN(size);
>>> 230         size += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>>>
>>> both DMA buffer and skb_shared_info are aligned to a cacheline separately,
>>> considering 128byte alignment guarantees 64byte alignment as well, how
>>> will this lead to corruption ?
>>
>> It's the other way around: you align only to 64 byte while running on a
>> platform with 128 byte cache lines and non-coherent DMA.
> 
> Okay, I mistook your statement. This is indeed a valid statement.
> 
>>> And if platform is non-DMA-coherent then again it's the driver which
>>> should take of coherency by using appropriate map/unmap APIs and
>>> should avoid any cacheline sharing btw DMA buffer and skb_shared_info.
>>
>> The problem is that the streaming DMA API can only work correctly on
>> cacheline-aligned buffers (because of the cache invalidation it performs
>> for DMA ops; even with clean&invalidate, the operation isn't always safe
>> if a cacheline is shared between DMA and CPU buffers). In the skb case,
>> we could have the data potentially sharing the last addresses of a DMA
>> buffer with struct skb_shared_info.
>>
>> We may be able to get away with SKB_DATA_ALIGN not using
>> ARCH_DMA_MINALIGN *if* skb_shared_info is *not* written before or during
>> an inbound DMA transfer (though such tricks are arch specific).
>>
>>>> IIUC, the Cavium platform has coherent DMA, so it shouldn't be an issue
>>>> if we go back to 64 byte cache lines.
>>>
>>> Yes, Cavium platform is DMA coherent and there is no issue with reverting back
>>> to 64byte cachelines. But do we want to do this because some platform has a
>>> performance issue and this is an easy way to solve it. IMHO there seems
>>> to be many ways to solve performance degradation within the driver itself, and
>>> if those doesn't work then probably it makes sense to revert this.
>>
>> My initial thought was to revert the change because it was causing a
>> significant performance regression on certain SoC. But given that it
>> took over a year for people to follow up, it doesn't seem too urgent, so
>> we should rather try to understand the issue and potential side effects
>> of moving back to a 64 byte cache line.
> 
> Yes.
> 
> Thanks,
> Sunil.
> 

Hi, continue this discussion, I have test this patch on hisilicon D05 board,
the lmbench looks much better after applying this patch, my kernel version is 4.1:

Lmbench?	128B/1core	128B/4core	128B/16core	128B/32core	64B/1core	64B/4core	64B/16core	64B/32core
rd		9393.81		9118.1		23693.96	42026.32	8433.26		8635.96		11563.52	20142.34
frd		7748.18		7003.02		23336.95	42271.16	7269.42		7091.55		11211.67	19188.03
wr		7880.8		7403.61		12471.28	22545.83	7453.13		7066.01		11140.08	19625.04
fwr		8783.97		8911.85		25318.05	46540		8953.55		8894.28		19094.92	30646.38
bzero		8848.33		8873.43		25416.46	46620.68	8998.88		8877.64		19092.39	32537.9
rdwr		5854.37		5759.17		12346.27	22928.25	5601.26		5517.21		6608.84		11717.91
cp		5251.07		5118.19		8324.99		15616.85	4997.66		4964.38		5833.04		9600.68
fcp		6883.94		5446.19		11588.7		21534.58	6766.76		6625.98		8757.97		15844.67
bcopy		6561.41		6402.99		9070.05		17076.24	6839.07		6959.03		8900.73		15868.25

you could see that when use the 32 cores, the 128B L1 cache line is much better than the 64B, up 200%.
I think the performance would be shown difference on different chip, so I suggest not to revert this patch and test more about it.

Some details about the hisilicon D05 board chip:
L1/L2: 	64B
L3:	128B

Thanks
Ding

>>
>> --
>> Catalin
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> .
> 
