From: andrea.merello@gmail.com (Andrea Merello)
Date: Fri, 28 Sep 2018 08:53:11 +0200
Subject: [PATCH v5 4/7] dmaengine: xilinx_dma: program hardware supported
 buffer length
In-Reply-To: <20180918162508.GD2613@vkoul-mobl>
References: <20180907062502.8241-1-andrea.merello@gmail.com>
 <20180907062502.8241-4-andrea.merello@gmail.com>
 <20180918162508.GD2613@vkoul-mobl>
Message-ID: <CAN8YU5OySuzAyQ=Buad=Jidhes28koV52Gi-QJ-qOiG5TFBO=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2018 at 6:25 PM Vinod <vkoul@kernel.org> wrote:
>
> On 07-09-18, 08:24, Andrea Merello wrote:
> > From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> >
> > AXI-DMA IP supports configurable (c_sg_length_width) buffer length
> > register width, hence read buffer length (xlnx,sg-length-width) DT
> > property and ensure that driver doesn't program buffer length
> > exceeding the supported limit. For VDMA and CDMA there is no change.
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: devicetree at vger.kernel.org
> > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> > Signed-off-by: Andrea Merello <andrea.merello@gmail.com> [rebase, reword]
> > ---
> > Changes in v2:
> >         - drop original patch and replace with the one in Xilinx tree
> > Changes in v3:
> >       - cc DT maintainers/ML
> > Changes in v4:
> >       - upper bound for the property should be 26, not 23
> >       - add warn for width > 23 as per xilinx original patch
> >       - rework due to changes introduced in 1/6
> > Changes in v5:
> >       None
> > ---
> >  drivers/dma/xilinx/xilinx_dma.c | 36 +++++++++++++++++++++++++--------
> >  1 file changed, 28 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> > index aaa6de8a70e4..b17f24e4ec35 100644
> > --- a/drivers/dma/xilinx/xilinx_dma.c
> > +++ b/drivers/dma/xilinx/xilinx_dma.c
> > @@ -158,7 +158,9 @@
> >  #define XILINX_DMA_REG_BTT           0x28
> >
> >  /* AXI DMA Specific Masks/Bit fields */
> > -#define XILINX_DMA_MAX_TRANS_LEN     GENMASK(22, 0)
> > +#define XILINX_DMA_MAX_TRANS_LEN_MIN 8
> > +#define XILINX_DMA_MAX_TRANS_LEN_MAX 23
> > +#define XILINX_DMA_V2_MAX_TRANS_LEN_MAX      26
> >  #define XILINX_DMA_CR_COALESCE_MAX   GENMASK(23, 16)
> >  #define XILINX_DMA_CR_CYCLIC_BD_EN_MASK      BIT(4)
> >  #define XILINX_DMA_CR_COALESCE_SHIFT 16
> > @@ -418,6 +420,7 @@ struct xilinx_dma_config {
> >   * @rxs_clk: DMA s2mm stream clock
> >   * @nr_channels: Number of channels DMA device supports
> >   * @chan_id: DMA channel identifier
> > + * @max_buffer_len: Max buffer length
> >   */
> >  struct xilinx_dma_device {
> >       void __iomem *regs;
> > @@ -437,6 +440,7 @@ struct xilinx_dma_device {
> >       struct clk *rxs_clk;
> >       u32 nr_channels;
> >       u32 chan_id;
> > +     u32 max_buffer_len;
> >  };
> >
> >  /* Macros */
> > @@ -964,7 +968,7 @@ static int xilinx_dma_calc_copysize(struct xilinx_dma_chan *chan,
> >                                   int size, int done)
> >  {
> >       size_t copy = min_t(size_t, size - done,
> > -                  XILINX_DMA_MAX_TRANS_LEN);
> > +                         chan->xdev->max_buffer_len);
>
> hmm why not add max_buffer_len in patch 1 again, and then use default
> len as XILINX_DMA_MAX_TRANS_LEN and add multiple lengths here :)

Sorry, I'm not getting your point. Could you please elaborate the "add
multiple lengths here" thing ?

> -
> ~Vinod
