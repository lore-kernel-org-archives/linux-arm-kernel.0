From: lee.booi.lim@gmail.com (Lee Booi Lim)
Date: Fri, 11 May 2012 18:30:20 +0800
Subject: Why DMA PL330 peripheral transfer does not support burst request?
Message-ID: <CAGe5uTBouMxJqX9yqizFNYkrNhb4jF=5=Y0NGV=tMDH+MqY25w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I found that DMA driver for PL330 only supports single request and not
burst request. The burst length is by default set to 1 in both the
functions pl330_prep_slave_sg and pl330_prep_dma_cyclic
(linux/drivers/dma/pl330.c).

desc->rqcfg.brst_size = pch->burst_sz;

desc->rqcfg.brst_len = 1;


Even though the device_control (pl330_control) function allows the
client driver to pass in the burst length through slave DMA
configuration. The burst_len  is always default to 1.

pch->burst_len = slave_config->src_maxburst;


The peripheral transfer request is programmed such a way that it is
always waiting for single request (
linux/arch/arm/common/pl330.c)
. In this case, the burst request would not be handled.

976 static inline int _ldst_devtomem(unsigned dry_run, u8 buf[],
977                 const struct _xfer_spec *pxs, int cyc)
978 {
979         int off = 0;
980
981         while (cyc--) {
982                 off += _emit_WFP(dry_run, &buf[off], SINGLE, pxs->r->peri);
983                 off += _emit_LDP(dry_run, &buf[off], SINGLE, pxs->r->peri);
984                 off += _emit_ST(dry_run, &buf[off], ALWAYS);
985                 off += _emit_FLUSHP(dry_run, &buf[off], pxs->r->peri);
986         }
987
988         return off;
989 }
990
991 static inline int _ldst_memtodev(unsigned dry_run, u8 buf[],
992                 const struct _xfer_spec *pxs, int cyc)
993 {
994         int off = 0;
995
996         while (cyc--) {
997                 off += _emit_WFP(dry_run, &buf[off], SINGLE, pxs->r->peri);
998                 off += _emit_LD(dry_run, &buf[off], ALWAYS);
999                 off += _emit_STP(dry_run, &buf[off], SINGLE, pxs->r->peri);
1000                 off += _emit_FLUSHP(dry_run, &buf[off], pxs->r->peri);
1001         }
1002
1003         return off;
1004 }

May I know is there any reason to constraint the transfer to be single
and ignore the burst request? If the watermark of burst is hit then
the dr_type will be set to BURST, in this PL330 will not perform the
DMA transfer since that the DMASTPS or DMALDPS will be treated as
DMANOP.

Besides that, DMARMB and DMAWMB are not enforced for peripheral
transfer. Is it safe to do so?

Thanks,
Lee Booi
