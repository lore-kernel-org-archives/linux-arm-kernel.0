From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Mon, 14 May 2012 23:39:07 +0530
Subject: Why DMA PL330 peripheral transfer does not support burst request?
In-Reply-To: <CAGe5uTCZXRMDcwHZPGMirwD3gjeOYGuAgHbYD7K3gCgyOEOvYQ@mail.gmail.com>
References: <CAGe5uTBouMxJqX9yqizFNYkrNhb4jF=5=Y0NGV=tMDH+MqY25w@mail.gmail.com>
 <CAGe5uTCZXRMDcwHZPGMirwD3gjeOYGuAgHbYD7K3gCgyOEOvYQ@mail.gmail.com>
Message-ID: <CABb+yY13K4Y3-Da0v8Af+j-7MKWU3ho9Ho4_qFtwZ0XUgWnYQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2012 at 3:05 PM, Lee Booi Lim <lee.booi.lim@gmail.com> wrote:

> Even though the code works, it constrains the DMA controller from
> performing burst transfer. The performance is going to be slower to
> perform multiple single transfer when compared to multiple burst
> transfer (for burst case, some data might still be transferred as
> single if remaining bytes < burst_len * burst_size).
>
> So my questions are as below:
> 1. Why the burst transfer mode is not supported? Is it for simplicity,
> so that it will work for all cases no matter the peripheral is
> requesting burst/single? Or is it because of hardware constraint that
> is not documented? Why the performance is sacrificed?
>
Yes, it was meant to cover every case. IIRC 6440(?) behaved a bit weirdly
with bursts despite me, I believed, doing the things rightly.
Anyways since it is for peripherals, dma wouldn't be the performance bottleneck.


> 2. By allowing the slave config to be passed in the burst length
> through device_control (pl330_control) function and yet the burst_len
> is always hard coded to 1 seems that misleading.
> ? ? ? ? ? ?pch->burst_sz = __ffs(slave_config->src_addr_width);
> ? ? ? ? ? ?pch->burst_len = slave_config->src_maxburst;
> ? ? ? ? ? ?pch->burst_sz = __ffs(slave_config->dst_addr_width);
> ? ? ? ? ? ?pch->burst_len = slave_config->dst_maxburst;
>
> ? ? ? ? ? desc->rqcfg.brst_size = pch->burst_sz;
> ? ? ? ? ? desc->rqcfg.brst_len = 1; (in pl330_prep_slave_sg and
> pl330_prep_dma_cyclic functions)
>
The unused pch->burst_len setting came with slave support to the pl330's
dmaengine driver, which was added later by Boojin Kim (CC'ed).

> 3. May I know whether the DMARMB and DMAWMB are needed in PL330
> peripheral transfer functions? (Memory barriers are explicitly called
> in memory-to-memory transfer function.) We are doing a load and then
> store, without the read/write memory barrier will there be cases that
> the data store is executed first before valid data from DMALD is
> available?
>
No. By the PL330 manual
  "These enable write-after-read/read-after-write sequences to the same address
location with no hazards".
Since peripherals' FIFO exchange data with memory, we don't run that risk.
Hence only Mem->Mem transfers have the barriers.

> 4. DMA PL330 is programmed to do a flushp each time after a single
> transfer, what is the purpose of that? The DMAFLUSHP is being issued
> each round may degrade the performance of DMA transfer also. Is it to
> cater for DMA transfer with single in response to burst request? Why
> can't the flushp being issued before the start of any single transfer
> and issued again after all single transfer?
>> 997 ? ? ? ? ? ? ? ? off += _emit_WFP(dry_run, &buf[off], SINGLE, pxs->r->peri);
>> 998 ? ? ? ? ? ? ? ? off += _emit_LD(dry_run, &buf[off], ALWAYS);
>> 999 ? ? ? ? ? ? ? ? off += _emit_STP(dry_run, &buf[off], SINGLE, pxs->r->peri);
>> 1000 ? ? ? ? ? ? ? ? off += _emit_FLUSHP(dry_run, &buf[off], pxs->r->peri);
>
Again this was for robustness and to work with most peripherals.
Though I think we could do flush only once before the start of a transfer.
