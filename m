From: lee.booi.lim@gmail.com (Lee Booi Lim)
Date: Mon, 14 May 2012 17:35:40 +0800
Subject: Why DMA PL330 peripheral transfer does not support burst request?
In-Reply-To: <CAGe5uTBouMxJqX9yqizFNYkrNhb4jF=5=Y0NGV=tMDH+MqY25w@mail.gmail.com>
References: <CAGe5uTBouMxJqX9yqizFNYkrNhb4jF=5=Y0NGV=tMDH+MqY25w@mail.gmail.com>
Message-ID: <CAGe5uTCZXRMDcwHZPGMirwD3gjeOYGuAgHbYD7K3gCgyOEOvYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The DMA can be programmed to receive burst or single request. For
DMAWFPS, the DMA controller will proceed to execute the rest of
microcode even if the peripheral is requesting a burst request. The
request_type in the DMA PL330 will be set to single in this case and
the request type from peripheral is ignored. I misinterpreted that the
DMASTP[S/B] or DMALDP[S/B] is based on peripheral request type. Even
though the code works, it constrains the DMA controller from
performing burst transfer. The performance is going to be slower to
perform multiple single transfer when compared to multiple burst
transfer (for burst case, some data might still be transferred as
single if remaining bytes < burst_len * burst_size).

So my questions are as below:
1. Why the burst transfer mode is not supported? Is it for simplicity,
so that it will work for all cases no matter the peripheral is
requesting burst/single? Or is it because of hardware constraint that
is not documented? Why the performance is sacrificed?

2. By allowing the slave config to be passed in the burst length
through device_control (pl330_control) function and yet the burst_len
is always hard coded to 1 seems that misleading.
            pch->burst_sz = __ffs(slave_config->src_addr_width);
            pch->burst_len = slave_config->src_maxburst;
            pch->burst_sz = __ffs(slave_config->dst_addr_width);
            pch->burst_len = slave_config->dst_maxburst;

           desc->rqcfg.brst_size = pch->burst_sz;
           desc->rqcfg.brst_len = 1; (in pl330_prep_slave_sg and
pl330_prep_dma_cyclic functions)

3. May I know whether the DMARMB and DMAWMB are needed in PL330
peripheral transfer functions? (Memory barriers are explicitly called
in memory-to-memory transfer function.) We are doing a load and then
store, without the read/write memory barrier will there be cases that
the data store is executed first before valid data from DMALD is
available?

4. DMA PL330 is programmed to do a flushp each time after a single
transfer, what is the purpose of that? The DMAFLUSHP is being issued
each round may degrade the performance of DMA transfer also. Is it to
cater for DMA transfer with single in response to burst request? Why
can't the flushp being issued before the start of any single transfer
and issued again after all single transfer?
> 997                 off += _emit_WFP(dry_run, &buf[off], SINGLE, pxs->r->peri);
> 998                 off += _emit_LD(dry_run, &buf[off], ALWAYS);
> 999                 off += _emit_STP(dry_run, &buf[off], SINGLE, pxs->r->peri);
> 1000                 off += _emit_FLUSHP(dry_run, &buf[off], pxs->r->peri);

5. DMAFLUSHP is used to initialize and resync the particular
peripheral to the DMA PL330 controller. Why the DMAFLUSHP is not
issued at the beginning of peripheral to/from memory transfer before
any data transfer is carried out?

Appreciate if anybody who are the maintainer of the code or who has
run the code before to share your knowledge on this to me as I am new
to DMA PL330.

Thanks,
Lee Booi

On Fri, May 11, 2012 at 6:30 PM, Lee Booi Lim <lee.booi.lim@gmail.com> wrote:
> Hi,
>
> I found that DMA driver for PL330 only supports single request and not
> burst request. The burst length is by default set to 1 in both the
> functions pl330_prep_slave_sg and pl330_prep_dma_cyclic
> (linux/drivers/dma/pl330.c).
>
> desc->rqcfg.brst_size = pch->burst_sz;
>
> desc->rqcfg.brst_len = 1;
>
>
> Even though the device_control (pl330_control) function allows the
> client driver to pass in the burst length through slave DMA
> configuration. The burst_len ?is always default to 1.
>
> pch->burst_len = slave_config->src_maxburst;
>
>
> The peripheral transfer request is programmed such a way that it is
> always waiting for single request (
> linux/arch/arm/common/pl330.c)
> . In this case, the burst request would not be handled.
>
> 976 static inline int _ldst_devtomem(unsigned dry_run, u8 buf[],
> 977 ? ? ? ? ? ? ? ? const struct _xfer_spec *pxs, int cyc)
> 978 {
> 979 ? ? ? ? int off = 0;
> 980
> 981 ? ? ? ? while (cyc--) {
> 982 ? ? ? ? ? ? ? ? off += _emit_WFP(dry_run, &buf[off], SINGLE, pxs->r->peri);
> 983 ? ? ? ? ? ? ? ? off += _emit_LDP(dry_run, &buf[off], SINGLE, pxs->r->peri);
> 984 ? ? ? ? ? ? ? ? off += _emit_ST(dry_run, &buf[off], ALWAYS);
> 985 ? ? ? ? ? ? ? ? off += _emit_FLUSHP(dry_run, &buf[off], pxs->r->peri);
> 986 ? ? ? ? }
> 987
> 988 ? ? ? ? return off;
> 989 }
> 990
> 991 static inline int _ldst_memtodev(unsigned dry_run, u8 buf[],
> 992 ? ? ? ? ? ? ? ? const struct _xfer_spec *pxs, int cyc)
> 993 {
> 994 ? ? ? ? int off = 0;
> 995
> 996 ? ? ? ? while (cyc--) {
> 997 ? ? ? ? ? ? ? ? off += _emit_WFP(dry_run, &buf[off], SINGLE, pxs->r->peri);
> 998 ? ? ? ? ? ? ? ? off += _emit_LD(dry_run, &buf[off], ALWAYS);
> 999 ? ? ? ? ? ? ? ? off += _emit_STP(dry_run, &buf[off], SINGLE, pxs->r->peri);
> 1000 ? ? ? ? ? ? ? ? off += _emit_FLUSHP(dry_run, &buf[off], pxs->r->peri);
> 1001 ? ? ? ? }
> 1002
> 1003 ? ? ? ? return off;
> 1004 }
>
> May I know is there any reason to constraint the transfer to be single
> and ignore the burst request? If the watermark of burst is hit then
> the dr_type will be set to BURST, in this PL330 will not perform the
> DMA transfer since that the DMASTPS or DMALDPS will be treated as
> DMANOP.
>
> Besides that, DMARMB and DMAWMB are not enforced for peripheral
> transfer. Is it safe to do so?
>
> Thanks,
> Lee Booi
