From: lee.booi.lim@gmail.com (Lee Booi Lim)
Date: Fri, 18 May 2012 10:18:12 +0800
Subject: Why DMA PL330 peripheral transfer does not support burst request?
In-Reply-To: <CAGe5uTByHp6BeN+sKNE8AySph_f9ZK6dEveGdt83+kw47p7Bag@mail.gmail.com>
References: <CAGe5uTBouMxJqX9yqizFNYkrNhb4jF=5=Y0NGV=tMDH+MqY25w@mail.gmail.com>
 <CAGe5uTCZXRMDcwHZPGMirwD3gjeOYGuAgHbYD7K3gCgyOEOvYQ@mail.gmail.com>
 <CABb+yY13K4Y3-Da0v8Af+j-7MKWU3ho9Ho4_qFtwZ0XUgWnYQw@mail.gmail.com>
 <CAGe5uTByHp6BeN+sKNE8AySph_f9ZK6dEveGdt83+kw47p7Bag@mail.gmail.com>
Message-ID: <CAGe5uTCDA8PxjNYwyqz3HsGdbMetWtSN9DFivWamvnrPXDEU2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Appreciate if you could share with me on what is the weird behaviour
seen. Is it because of DMA PL330 hardware bug? We have seen a problem
on DMA PL330 that happens in DMA burst mode. If a DMA channel is
programmed to wait for a burst from the peripheral (let's takes an
example of RX path), somehow transfer error happened in the middle due
to the peripheral is not able to trigger a burst as it does not have
enough data. In this case, the DMA channel will be killed if the
driver / application detects timeout on the transfer. However, the DMA
PL330 is not able to resume to normal even with DMAKILL and DMAFLUSHP,
that particular DMA channel will remain in waiting for burst mode. If
the DMA transfer is restarted with single transfer, the request will
be ignored. The waiting for burst state can only be reset if a cold
reset to the DMA PL330 controller happen or a burst is actually
happen.

May I know whether the similar behaviour is observed in 6440? If not,
could you please share with me on the behaviour you have observed so
that I can try to reproduce it.

As you have mentioned that the bottleneck is always at the
peripherals, may I know is this a fair assumption? Please correct me
if I get you wrong, you meant that the peripheral is always slower in
pulling out the data from DMAC or putting data into DMAC, right? You
are not saying that the peripheral cannot support burst mode, right?

Appreciate if you can share your views and experiences to me.

Thanks,
Lee Booi

On Tue, May 15, 2012 at 4:39 PM, Lee Booi Lim <lee.booi.lim@gmail.com> wrote:
> Are you referring to? S5P6440? May I know what is the weird behaviour?
> If this is related to 6440 only, can the driver be modified to support
> burst and yet allow to use single transfer to cater for 6440 case?
>
> Even the bottleneck is at peripherals, some peripherals do support
> burst mode. So that would be some performance gain if burst transfer
> is allowed.
>
> Thanks.
>
> On Tue, May 15, 2012 at 2:09 AM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
>>
>> On Mon, May 14, 2012 at 3:05 PM, Lee Booi Lim <lee.booi.lim@gmail.com> wrote:
>>
>> > Even though the code works, it constrains the DMA controller from
>> > performing burst transfer. The performance is going to be slower to
>> > perform multiple single transfer when compared to multiple burst
>> > transfer (for burst case, some data might still be transferred as
>> > single if remaining bytes < burst_len * burst_size).
>> >
>> > So my questions are as below:
>> > 1. Why the burst transfer mode is not supported? Is it for simplicity,
>> > so that it will work for all cases no matter the peripheral is
>> > requesting burst/single? Or is it because of hardware constraint that
>> > is not documented? Why the performance is sacrificed?
>> >
>> Yes, it was meant to cover every case. IIRC 6440(?) behaved a bit weirdly
>> with bursts despite me, I believed, doing the things rightly.
>> Anyways since it is for peripherals, dma wouldn't be the performance bottleneck.
>>
>>
>> > 2. By allowing the slave config to be passed in the burst length
>> > through device_control (pl330_control) function and yet the burst_len
>> > is always hard coded to 1 seems that misleading.
>> > ? ? ? ? ? ?pch->burst_sz = __ffs(slave_config->src_addr_width);
>> > ? ? ? ? ? ?pch->burst_len = slave_config->src_maxburst;
>> > ? ? ? ? ? ?pch->burst_sz = __ffs(slave_config->dst_addr_width);
>> > ? ? ? ? ? ?pch->burst_len = slave_config->dst_maxburst;
>> >
>> > ? ? ? ? ? desc->rqcfg.brst_size = pch->burst_sz;
>> > ? ? ? ? ? desc->rqcfg.brst_len = 1; (in pl330_prep_slave_sg and
>> > pl330_prep_dma_cyclic functions)
>> >
>> The unused pch->burst_len setting came with slave support to the pl330's
>> dmaengine driver, which was added later by Boojin Kim (CC'ed).
>>
>> > 3. May I know whether the DMARMB and DMAWMB are needed in PL330
>> > peripheral transfer functions? (Memory barriers are explicitly called
>> > in memory-to-memory transfer function.) We are doing a load and then
>> > store, without the read/write memory barrier will there be cases that
>> > the data store is executed first before valid data from DMALD is
>> > available?
>> >
>> No. By the PL330 manual
>> ?"These enable write-after-read/read-after-write sequences to the same address
>> location with no hazards".
>> Since peripherals' FIFO exchange data with memory, we don't run that risk.
>> Hence only Mem->Mem transfers have the barriers.
>>
>> > 4. DMA PL330 is programmed to do a flushp each time after a single
>> > transfer, what is the purpose of that? The DMAFLUSHP is being issued
>> > each round may degrade the performance of DMA transfer also. Is it to
>> > cater for DMA transfer with single in response to burst request? Why
>> > can't the flushp being issued before the start of any single transfer
>> > and issued again after all single transfer?
>> >> 997 ? ? ? ? ? ? ? ? off += _emit_WFP(dry_run, &buf[off], SINGLE, pxs->r->peri);
>> >> 998 ? ? ? ? ? ? ? ? off += _emit_LD(dry_run, &buf[off], ALWAYS);
>> >> 999 ? ? ? ? ? ? ? ? off += _emit_STP(dry_run, &buf[off], SINGLE, pxs->r->peri);
>> >> 1000 ? ? ? ? ? ? ? ? off += _emit_FLUSHP(dry_run, &buf[off], pxs->r->peri);
>> >
>> Again this was for robustness and to work with most peripherals.
>> Though I think we could do flush only once before the start of a transfer.
