From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 6 Aug 2018 09:59:35 +0200
Subject: [PATCH v8 2/3] dmaengine: fsl-edma: add edma version and
 configurable registers
In-Reply-To: <20180803193244.12084-2-angelo@sysam.it>
References: <20180803193244.12084-1-angelo@sysam.it>
 <20180803193244.12084-2-angelo@sysam.it>
Message-ID: <CAJKOXPeBN16iGR980ZEC_ZJU86KzBPz=rT7Mb5QEKNFpafpMXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 August 2018 at 21:32, Angelo Dureghello <angelo@sysam.it> wrote:
> This patch adds configurable registers (using __iomem addresses)
> to allow the use of fsl-edma-common code with slightly different
> edma module versions, as Vybrid (v1) and ColdFire (v2) are.
>
> Removal of old membase-referenced registers, amd some fixes on
> macroes are included.
>
> Signed-off-by: Angelo Dureghello <angelo@sysam.it>
> ---
> Changes from v7:
> - patch rewritten from scratch, this patch (2/3) has just been added.
> ---
>  drivers/dma/fsl-edma-common.c | 138 ++++++++++++++++++++++++++--------
>  drivers/dma/fsl-edma-common.h | 115 ++++++++++++++--------------
>  drivers/dma/fsl-edma.c        |  32 ++++----
>  3 files changed, 182 insertions(+), 103 deletions(-)
>
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index 0ae7094f477a..948a3ee51bbb 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -9,6 +9,38 @@
>
>  #include "fsl-edma-common.h"
>
> +#define EDMA_CR                        0x00
> +#define EDMA_ES                        0x04
> +#define EDMA_ERQ               0x0C
> +#define EDMA_EEI               0x14
> +#define EDMA_SERQ              0x1B
> +#define EDMA_CERQ              0x1A
> +#define EDMA_SEEI              0x19
> +#define EDMA_CEEI              0x18
> +#define EDMA_CINT              0x1F
> +#define EDMA_CERR              0x1E
> +#define EDMA_SSRT              0x1D
> +#define EDMA_CDNE              0x1C
> +#define EDMA_INTR              0x24
> +#define EDMA_ERR               0x2C
> +
> +#define EDMA64_ERQH            0x08
> +#define EDMA64_EEIH            0x10
> +#define EDMA64_SERQ            0x18
> +#define EDMA64_CERQ            0x19
> +#define EDMA64_SEEI            0x1a
> +#define EDMA64_CEEI            0x1b
> +#define EDMA64_CINT            0x1c
> +#define EDMA64_CERR            0x1d
> +#define EDMA64_SSRT            0x1e
> +#define EDMA64_CDNE            0x1f
> +#define EDMA64_INTH            0x20
> +#define EDMA64_INTL            0x24
> +#define EDMA64_ERRH            0x28
> +#define EDMA64_ERRL            0x2c
> +
> +#define EDMA_TCD               0x1000
> +
>  /*
>   * R/W functions for big- or little-endian registers:
>   * The eDMA controller's endian is independent of the CPU core's endian.
> @@ -67,20 +99,20 @@ EXPORT_SYMBOL_GPL(to_fsl_edma_desc);
>
>  static void fsl_edma_enable_request(struct fsl_edma_chan *fsl_chan)
>  {
> -       void __iomem *addr = fsl_chan->edma->membase;
> +       struct edma_regs *regs = &fsl_chan->edma->regs;
>         u32 ch = fsl_chan->vchan.chan.chan_id;
>
> -       edma_writeb(fsl_chan->edma, EDMA_SEEI_SEEI(ch), addr + EDMA_SEEI);
> -       edma_writeb(fsl_chan->edma, ch, addr + EDMA_SERQ);
> +       edma_writeb(fsl_chan->edma, EDMA_SEEI_SEEI(ch), regs->seei);
> +       edma_writeb(fsl_chan->edma, ch, regs->serq);
>  }
>
>  void fsl_edma_disable_request(struct fsl_edma_chan *fsl_chan)
>  {
> -       void __iomem *addr = fsl_chan->edma->membase;
> +       struct edma_regs *regs = &fsl_chan->edma->regs;
>         u32 ch = fsl_chan->vchan.chan.chan_id;
>
> -       edma_writeb(fsl_chan->edma, ch, addr + EDMA_CERQ);
> -       edma_writeb(fsl_chan->edma, EDMA_CEEI_CEEI(ch), addr + EDMA_CEEI);
> +       edma_writeb(fsl_chan->edma, ch, regs->cerq);
> +       edma_writeb(fsl_chan->edma, EDMA_CEEI_CEEI(ch), regs->ceei);
>  }
>  EXPORT_SYMBOL_GPL(fsl_edma_disable_request);
>
> @@ -208,7 +240,7 @@ static size_t fsl_edma_desc_residue(struct fsl_edma_chan *fsl_chan,
>                 struct virt_dma_desc *vdesc, bool in_progress)
>  {
>         struct fsl_edma_desc *edesc = fsl_chan->edesc;
> -       void __iomem *addr = fsl_chan->edma->membase;
> +       struct edma_regs *regs = &fsl_chan->edma->regs;
>         u32 ch = fsl_chan->vchan.chan.chan_id;
>         enum dma_transfer_direction dir = fsl_chan->fsc.dir;
>         dma_addr_t cur_addr, dma_addr;
> @@ -224,11 +256,9 @@ static size_t fsl_edma_desc_residue(struct fsl_edma_chan *fsl_chan,
>                 return len;
>
>         if (dir == DMA_MEM_TO_DEV)
> -               cur_addr = edma_readl(
> -                       fsl_chan->edma, addr + EDMA_TCD_SADDR(ch));
> +               cur_addr = edma_readl(fsl_chan->edma, &regs->tcd[ch].saddr);
>         else
> -               cur_addr = edma_readl(
> -                       fsl_chan->edma, addr + EDMA_TCD_DADDR(ch));
> +               cur_addr = edma_readl(fsl_chan->edma, &regs->tcd[ch].daddr);
>
>         /* figure out the finished and calculate the residue */
>         for (i = 0; i < fsl_chan->edesc->n_tcds; i++) {
> @@ -285,7 +315,7 @@ static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
>                                   struct fsl_edma_hw_tcd *tcd)
>  {
>         struct fsl_edma_engine *edma = fsl_chan->edma;
> -       void __iomem *addr = fsl_chan->edma->membase;
> +       struct edma_regs *regs = &fsl_chan->edma->regs;
>         u32 ch = fsl_chan->vchan.chan.chan_id;
>
>         /*
> @@ -293,24 +323,24 @@ static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
>          * endian format. However, we need to load the TCD registers in
>          * big- or little-endian obeying the eDMA engine model endian.
>          */
> -       edma_writew(edma, 0, addr + EDMA_TCD_CSR(ch));
> -       edma_writel(edma, le32_to_cpu(tcd->saddr), addr + EDMA_TCD_SADDR(ch));
> -       edma_writel(edma, le32_to_cpu(tcd->daddr), addr + EDMA_TCD_DADDR(ch));
> +       edma_writew(edma, 0,  &regs->tcd[ch].csr);
> +       edma_writel(edma, le32_to_cpu(tcd->saddr), &regs->tcd[ch].saddr);
> +       edma_writel(edma, le32_to_cpu(tcd->daddr), &regs->tcd[ch].daddr);
>
> -       edma_writew(edma, le16_to_cpu(tcd->attr), addr + EDMA_TCD_ATTR(ch));
> -       edma_writew(edma, le16_to_cpu(tcd->soff), addr + EDMA_TCD_SOFF(ch));
> +       edma_writew(edma, le16_to_cpu(tcd->attr), &regs->tcd[ch].attr);
> +       edma_writew(edma, le16_to_cpu(tcd->soff), &regs->tcd[ch].soff);
>
> -       edma_writel(edma, le32_to_cpu(tcd->nbytes), addr + EDMA_TCD_NBYTES(ch));
> -       edma_writel(edma, le32_to_cpu(tcd->slast), addr + EDMA_TCD_SLAST(ch));
> +       edma_writel(edma, le32_to_cpu(tcd->nbytes), &regs->tcd[ch].nbytes);
> +       edma_writel(edma, le32_to_cpu(tcd->slast), &regs->tcd[ch].slast);
>
> -       edma_writew(edma, le16_to_cpu(tcd->citer), addr + EDMA_TCD_CITER(ch));
> -       edma_writew(edma, le16_to_cpu(tcd->biter), addr + EDMA_TCD_BITER(ch));
> -       edma_writew(edma, le16_to_cpu(tcd->doff), addr + EDMA_TCD_DOFF(ch));
> +       edma_writew(edma, le16_to_cpu(tcd->citer), &regs->tcd[ch].citer);
> +       edma_writew(edma, le16_to_cpu(tcd->biter), &regs->tcd[ch].biter);
> +       edma_writew(edma, le16_to_cpu(tcd->doff), &regs->tcd[ch].doff);
>
> -       edma_writel(edma,
> -                   le32_to_cpu(tcd->dlast_sga), addr + EDMA_TCD_DLAST_SGA(ch));
> +       edma_writel(edma, le32_to_cpu(tcd->dlast_sga),
> +                       &regs->tcd[ch].dlast_sga);
>
> -       edma_writew(edma, le16_to_cpu(tcd->csr), addr + EDMA_TCD_CSR(ch));
> +       edma_writew(edma, le16_to_cpu(tcd->csr), &regs->tcd[ch].csr);
>  }
>
>  static inline
> @@ -332,15 +362,15 @@ void fsl_edma_fill_tcd(struct fsl_edma_hw_tcd *tcd, u32 src, u32 dst,
>
>         tcd->attr = cpu_to_le16(attr);
>
> -       tcd->soff = cpu_to_le16(EDMA_TCD_SOFF_SOFF(soff));
> +       tcd->soff = cpu_to_le16(soff);
>
> -       tcd->nbytes = cpu_to_le32(EDMA_TCD_NBYTES_NBYTES(nbytes));
> -       tcd->slast = cpu_to_le32(EDMA_TCD_SLAST_SLAST(slast));
> +       tcd->nbytes = cpu_to_le32(nbytes);
> +       tcd->slast = cpu_to_le32(slast);
>
>         tcd->citer = cpu_to_le16(EDMA_TCD_CITER_CITER(citer));
> -       tcd->doff = cpu_to_le16(EDMA_TCD_DOFF_DOFF(doff));
> +       tcd->doff = cpu_to_le16(doff);
>
> -       tcd->dlast_sga = cpu_to_le32(EDMA_TCD_DLAST_SGA_DLAST_SGA(dlast_sga));
> +       tcd->dlast_sga = cpu_to_le32(dlast_sga);
>
>         tcd->biter = cpu_to_le16(EDMA_TCD_BITER_BITER(biter));
>         if (major_int)
> @@ -573,4 +603,52 @@ void fsl_edma_cleanup_vchan(struct dma_device *dmadev)
>  }
>  EXPORT_SYMBOL_GPL(fsl_edma_cleanup_vchan);
>
> +/*
> + * On the 32 channels Vybrid/mpc577x edma version (here called "v1"),
> + * register offsets are different compared to ColdFire mcf5441x 64 channels
> + * edma (here called "v2").
> + *
> + * This function sets up register offsets as per proper declared version
> + * so must be called in xxx_edma_probe() just after setting the
> + * edma "version" and "membase" appropriately.
> + */
> +void fsl_edma_setup_regs(struct fsl_edma_engine *edma)
> +{
> +       edma->regs.cr = edma->membase + EDMA_CR;
> +       edma->regs.es = edma->membase + EDMA_ES;
> +       edma->regs.erql = edma->membase + EDMA_ERQ;
> +       edma->regs.eeil = edma->membase + EDMA_EEI;
> +
> +       edma->regs.serq = edma->membase + ((edma->version == v1) ?
> +                       EDMA_SERQ : EDMA64_SERQ);
> +       edma->regs.cerq = edma->membase + ((edma->version == v1) ?
> +                       EDMA_CERQ : EDMA64_CERQ);
> +       edma->regs.seei = edma->membase + ((edma->version == v1) ?
> +                       EDMA_SEEI : EDMA64_SEEI);
> +       edma->regs.ceei = edma->membase + ((edma->version == v1) ?
> +                       EDMA_CEEI : EDMA64_CEEI);
> +       edma->regs.cint = edma->membase + ((edma->version == v1) ?
> +                       EDMA_CINT : EDMA64_CINT);
> +       edma->regs.cerr = edma->membase + ((edma->version == v1) ?
> +                       EDMA_CERR : EDMA64_CERR);
> +       edma->regs.ssrt = edma->membase + ((edma->version == v1) ?
> +                       EDMA_SSRT : EDMA64_SSRT);
> +       edma->regs.cdne = edma->membase + ((edma->version == v1) ?
> +                       EDMA_CDNE : EDMA64_CDNE);
> +       edma->regs.intl = edma->membase + ((edma->version == v1) ?
> +                       EDMA_INTR : EDMA64_INTL);
> +       edma->regs.errl = edma->membase + ((edma->version == v1) ?
> +                       EDMA_ERR : EDMA64_ERRL);
> +
> +       if (edma->version == v2) {
> +               edma->regs.erqh = edma->membase + EDMA64_ERQH;
> +               edma->regs.eeih = edma->membase + EDMA64_EEIH;
> +               edma->regs.errh = edma->membase + EDMA64_ERRH;
> +               edma->regs.inth = edma->membase + EDMA64_INTH;
> +       }
> +
> +       edma->regs.tcd = edma->membase + EDMA_TCD;
> +}
> +EXPORT_SYMBOL_GPL(fsl_edma_setup_regs);
> +
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
> index f3ea68e15b23..7a9231e7639f 100644
> --- a/drivers/dma/fsl-edma-common.h
> +++ b/drivers/dma/fsl-edma-common.h
> @@ -8,35 +8,6 @@
>
>  #include "virt-dma.h"
>
> -#define EDMA_CR                        0x00
> -#define EDMA_ES                        0x04
> -#define EDMA_ERQ               0x0C
> -#define EDMA_EEI               0x14
> -#define EDMA_SERQ              0x1B
> -#define EDMA_CERQ              0x1A
> -#define EDMA_SEEI              0x19
> -#define EDMA_CEEI              0x18
> -#define EDMA_CINT              0x1F
> -#define EDMA_CERR              0x1E
> -#define EDMA_SSRT              0x1D
> -#define EDMA_CDNE              0x1C
> -#define EDMA_INTR              0x24
> -#define EDMA_ERR               0x2C
> -
> -#define EDMA_TCD_SADDR(x)      (0x1000 + 32 * (x))
> -#define EDMA_TCD_SOFF(x)       (0x1004 + 32 * (x))
> -#define EDMA_TCD_ATTR(x)       (0x1006 + 32 * (x))
> -#define EDMA_TCD_NBYTES(x)     (0x1008 + 32 * (x))
> -#define EDMA_TCD_SLAST(x)      (0x100C + 32 * (x))
> -#define EDMA_TCD_DADDR(x)      (0x1010 + 32 * (x))
> -#define EDMA_TCD_DOFF(x)       (0x1014 + 32 * (x))
> -#define EDMA_TCD_CITER_ELINK(x)        (0x1016 + 32 * (x))
> -#define EDMA_TCD_CITER(x)      (0x1016 + 32 * (x))
> -#define EDMA_TCD_DLAST_SGA(x)  (0x1018 + 32 * (x))
> -#define EDMA_TCD_CSR(x)                (0x101C + 32 * (x))
> -#define EDMA_TCD_BITER_ELINK(x)        (0x101E + 32 * (x))
> -#define EDMA_TCD_BITER(x)      (0x101E + 32 * (x))
> -
>  #define EDMA_CR_EDBG           BIT(1)
>  #define EDMA_CR_ERCA           BIT(2)
>  #define EDMA_CR_ERGA           BIT(3)
> @@ -47,34 +18,29 @@
>  #define EDMA_CR_ECX            BIT(16)
>  #define EDMA_CR_CX             BIT(17)
>
> -#define EDMA_SEEI_SEEI(x)      ((x) & 0x1F)
> -#define EDMA_CEEI_CEEI(x)      ((x) & 0x1F)
> -#define EDMA_CINT_CINT(x)      ((x) & 0x1F)
> -#define EDMA_CERR_CERR(x)      ((x) & 0x1F)
> -
> -#define EDMA_TCD_ATTR_DSIZE(x)         (((x) & 0x0007))
> -#define EDMA_TCD_ATTR_DMOD(x)          (((x) & 0x001F) << 3)
> -#define EDMA_TCD_ATTR_SSIZE(x)         (((x) & 0x0007) << 8)
> -#define EDMA_TCD_ATTR_SMOD(x)          (((x) & 0x001F) << 11)
> -#define EDMA_TCD_ATTR_SSIZE_8BIT       (0x0000)
> -#define EDMA_TCD_ATTR_SSIZE_16BIT      (0x0100)
> -#define EDMA_TCD_ATTR_SSIZE_32BIT      (0x0200)
> -#define EDMA_TCD_ATTR_SSIZE_64BIT      (0x0300)
> -#define EDMA_TCD_ATTR_SSIZE_32BYTE     (0x0500)
> -#define EDMA_TCD_ATTR_DSIZE_8BIT       (0x0000)
> -#define EDMA_TCD_ATTR_DSIZE_16BIT      (0x0001)
> -#define EDMA_TCD_ATTR_DSIZE_32BIT      (0x0002)
> -#define EDMA_TCD_ATTR_DSIZE_64BIT      (0x0003)
> -#define EDMA_TCD_ATTR_DSIZE_32BYTE     (0x0005)
> -
> -#define EDMA_TCD_SOFF_SOFF(x)          (x)
> -#define EDMA_TCD_NBYTES_NBYTES(x)      (x)
> -#define EDMA_TCD_SLAST_SLAST(x)                (x)
> -#define EDMA_TCD_DADDR_DADDR(x)                (x)
> -#define EDMA_TCD_CITER_CITER(x)                ((x) & 0x7FFF)
> -#define EDMA_TCD_DOFF_DOFF(x)          (x)
> -#define EDMA_TCD_DLAST_SGA_DLAST_SGA(x)        (x)
> -#define EDMA_TCD_BITER_BITER(x)                ((x) & 0x7FFF)
> +#define EDMA_SEEI_SEEI(x)      ((x) & GENMASK(4, 0))
> +#define EDMA_CEEI_CEEI(x)      ((x) & GENMASK(4, 0))
> +#define EDMA_CINT_CINT(x)      ((x) & GENMASK(4, 0))
> +#define EDMA_CERR_CERR(x)      ((x) & GENMASK(4, 0))
> +
> +#define EDMA_TCD_ATTR_DSIZE(x)         (((x) & GENMASK(2, 0)))
> +#define EDMA_TCD_ATTR_DMOD(x)          (((x) & GENMASK(4, 0)) << 3)
> +#define EDMA_TCD_ATTR_SSIZE(x)         (((x) & GENMASK(2, 0)) << 8)
> +#define EDMA_TCD_ATTR_SMOD(x)          (((x) & GENMASK(4, 0)) << 11)

This looks like a change for its own commit.

> +
> +#define EDMA_TCD_ATTR_DSIZE_8BIT       0
> +#define EDMA_TCD_ATTR_DSIZE_16BIT      BIT(0)
> +#define EDMA_TCD_ATTR_DSIZE_32BIT      BIT(1)
> +#define EDMA_TCD_ATTR_DSIZE_64BIT      (BIT(0) | BIT(1))
> +#define EDMA_TCD_ATTR_DSIZE_32BYTE     (BIT(3) | BIT(0))
> +#define EDMA_TCD_ATTR_SSIZE_8BIT       0
> +#define EDMA_TCD_ATTR_SSIZE_16BIT      (EDMA_TCD_ATTR_DSIZE_16BIT << 8)
> +#define EDMA_TCD_ATTR_SSIZE_32BIT      (EDMA_TCD_ATTR_DSIZE_32BIT << 8)
> +#define EDMA_TCD_ATTR_SSIZE_64BIT      (EDMA_TCD_ATTR_DSIZE_64BIT << 8)
> +#define EDMA_TCD_ATTR_SSIZE_32BYTE     (EDMA_TCD_ATTR_DSIZE_32BYTE << 8)
> +
> +#define EDMA_TCD_CITER_CITER(x)                ((x) & GENMASK(14, 0))
> +#define EDMA_TCD_BITER_BITER(x)                ((x) & GENMASK(14, 0))
>
>  #define EDMA_TCD_CSR_START             BIT(0)
>  #define EDMA_TCD_CSR_INT_MAJOR         BIT(1)
> @@ -87,7 +53,7 @@
>
>  #define EDMAMUX_CHCFG_DIS              0x0
>  #define EDMAMUX_CHCFG_ENBL             0x80
> -#define EDMAMUX_CHCFG_SOURCE(n)                ((n) & 0x3F)
> +#define EDMAMUX_CHCFG_SOURCE(n)                ((n) & GENMASK(6, 0))
>
>  #define DMAMUX_NR      2
>
> @@ -114,6 +80,31 @@ struct fsl_edma_hw_tcd {
>         __le16  biter;
>  };
>
> +/*
> + * This are iomem pointers, for both v32 and v64.

s/This/These/

Tested-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
