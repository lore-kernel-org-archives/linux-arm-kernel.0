From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Tue, 17 Oct 2017 16:26:50 +0200
Subject: [PATCH v1] dmaengine: stm32_mdma: activate pack/unpack feature
In-Reply-To: <1508247827-31741-1-git-send-email-pierre-yves.mordret@st.com>
References: <1508247827-31741-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <CA+M3ks4EymJ2aR5Fm1G1mTgyiOaGUcQgWMvDp0K4Hvue+M7rbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Arnd since it should also fix 64 bits division issue

2017-10-17 15:43 GMT+02:00 Pierre-Yves MORDRET <pierre-yves.mordret@st.com>:
> If source and destination bus width differs pack/unpack MDMA
> feature has to be activated for alignment.
> This pack/unpack feature implies to have both source/destination address
> and buffer length aligned on bus width.
>
> Fixes: a4ffb13c8946 ("dmaengine: Add STM32 MDMA driver")
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>  drivers/dma/stm32-mdma.c | 84 ++++++++++++++++++++++++++++--------------------
>  1 file changed, 50 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
> index d3be6bf..daa1602 100644
> --- a/drivers/dma/stm32-mdma.c
> +++ b/drivers/dma/stm32-mdma.c
> @@ -387,14 +387,20 @@ static int stm32_mdma_get_width(struct stm32_mdma_chan *chan,
>         }
>  }
>
> -static enum dma_slave_buswidth stm32_mdma_get_max_width(u32 buf_len, u32 tlen)
> +static enum dma_slave_buswidth stm32_mdma_get_max_width(dma_addr_t addr,
> +                                                       u32 buf_len, u32 tlen)
>  {
>         enum dma_slave_buswidth max_width = DMA_SLAVE_BUSWIDTH_8_BYTES;
>
>         for (max_width = DMA_SLAVE_BUSWIDTH_8_BYTES;
>              max_width > DMA_SLAVE_BUSWIDTH_1_BYTE;
>              max_width >>= 1) {
> -               if (((buf_len % max_width) == 0) && (tlen >= max_width))
> +               /*
> +                * Address and buffer length both have to be aligned on
> +                * bus width
> +                */
> +               if ((((buf_len | addr) & (max_width - 1)) == 0) &&
> +                   tlen >= max_width)
>                         break;
>         }
>
> @@ -486,7 +492,8 @@ static void stm32_mdma_set_bus(struct stm32_mdma_device *dmadev, u32 *ctbr,
>  static int stm32_mdma_set_xfer_param(struct stm32_mdma_chan *chan,
>                                      enum dma_transfer_direction direction,
>                                      u32 *mdma_ccr, u32 *mdma_ctcr,
> -                                    u32 *mdma_ctbr, u32 buf_len)
> +                                    u32 *mdma_ctbr, dma_addr_t addr,
> +                                    u32 buf_len)
>  {
>         struct stm32_mdma_device *dmadev = stm32_mdma_get_dev(chan);
>         struct stm32_mdma_chan_config *chan_config = &chan->chan_config;
> @@ -520,6 +527,9 @@ static int stm32_mdma_set_xfer_param(struct stm32_mdma_chan *chan,
>         ctcr &= ~STM32_MDMA_CTCR_LEN2_MSK;
>         ctcr |= STM32_MDMA_CTCR_TLEN((tlen - 1));
>
> +       /* Disable Pack Enable */
> +       ctcr &= ~STM32_MDMA_CTCR_PKE;
> +
>         /* Check burst size constraints */
>         if (src_maxburst * src_addr_width > STM32_MDMA_MAX_BURST ||
>             dst_maxburst * dst_addr_width > STM32_MDMA_MAX_BURST) {
> @@ -551,6 +561,8 @@ static int stm32_mdma_set_xfer_param(struct stm32_mdma_chan *chan,
>
>         switch (direction) {
>         case DMA_MEM_TO_DEV:
> +               dst_addr = chan->dma_config.dst_addr;
> +
>                 /* Set device data size */
>                 dst_bus_width = stm32_mdma_get_width(chan, dst_addr_width);
>                 if (dst_bus_width < 0)
> @@ -567,7 +579,7 @@ static int stm32_mdma_set_xfer_param(struct stm32_mdma_chan *chan,
>                 ctcr |= STM32_MDMA_CTCR_DBURST((ilog2(dst_best_burst)));
>
>                 /* Set memory data size */
> -               src_addr_width = stm32_mdma_get_max_width(buf_len, tlen);
> +               src_addr_width = stm32_mdma_get_max_width(addr, buf_len, tlen);
>                 chan->mem_width = src_addr_width;
>                 src_bus_width = stm32_mdma_get_width(chan, src_addr_width);
>                 if (src_bus_width < 0)
> @@ -587,15 +599,19 @@ static int stm32_mdma_set_xfer_param(struct stm32_mdma_chan *chan,
>                 ctcr |= STM32_MDMA_CTCR_SBURST((ilog2(src_best_burst)));
>
>                 /* Select bus */
> -               dst_addr = chan->dma_config.dst_addr;
>                 stm32_mdma_set_bus(dmadev, &ctbr, STM32_MDMA_CTBR_DBUS,
>                                    dst_addr);
>
> +               if (dst_bus_width != src_bus_width)
> +                       ctcr |= STM32_MDMA_CTCR_PKE;
> +
>                 /* Set destination address */
>                 stm32_mdma_write(dmadev, STM32_MDMA_CDAR(chan->id), dst_addr);
>                 break;
>
>         case DMA_DEV_TO_MEM:
> +               src_addr = chan->dma_config.src_addr;
> +
>                 /* Set device data size */
>                 src_bus_width = stm32_mdma_get_width(chan, src_addr_width);
>                 if (src_bus_width < 0)
> @@ -611,7 +627,7 @@ static int stm32_mdma_set_xfer_param(struct stm32_mdma_chan *chan,
>                 ctcr |= STM32_MDMA_CTCR_SBURST((ilog2(src_best_burst)));
>
>                 /* Set memory data size */
> -               dst_addr_width = stm32_mdma_get_max_width(buf_len, tlen);
> +               dst_addr_width = stm32_mdma_get_max_width(addr, buf_len, tlen);
>                 chan->mem_width = dst_addr_width;
>                 dst_bus_width = stm32_mdma_get_width(chan, dst_addr_width);
>                 if (dst_bus_width < 0)
> @@ -630,10 +646,12 @@ static int stm32_mdma_set_xfer_param(struct stm32_mdma_chan *chan,
>                 ctcr |= STM32_MDMA_CTCR_DBURST((ilog2(dst_best_burst)));
>
>                 /* Select bus */
> -               src_addr = chan->dma_config.src_addr;
>                 stm32_mdma_set_bus(dmadev, &ctbr, STM32_MDMA_CTBR_SBUS,
>                                    src_addr);
>
> +               if (dst_bus_width != src_bus_width)
> +                       ctcr |= STM32_MDMA_CTCR_PKE;
> +
>                 /* Set source address */
>                 stm32_mdma_write(dmadev, STM32_MDMA_CSAR(chan->id), src_addr);
>                 break;
> @@ -719,23 +737,27 @@ static int stm32_mdma_setup_xfer(struct stm32_mdma_chan *chan,
>                         return -EINVAL;
>                 }
>
> -               ret = stm32_mdma_set_xfer_param(chan, direction, &ccr, &ctcr,
> -                                               &ctbr, sg_dma_len(sg));
> -               if (ret < 0)
> -                       return ret;
> -
>                 if (direction == DMA_MEM_TO_DEV) {
>                         src_addr = sg_dma_address(sg);
>                         dst_addr = dma_config->dst_addr;
> +                       ret = stm32_mdma_set_xfer_param(chan, direction, &ccr,
> +                                                       &ctcr, &ctbr, src_addr,
> +                                                       sg_dma_len(sg));
>                         stm32_mdma_set_bus(dmadev, &ctbr, STM32_MDMA_CTBR_SBUS,
>                                            src_addr);
>                 } else {
>                         src_addr = dma_config->src_addr;
>                         dst_addr = sg_dma_address(sg);
> +                       ret = stm32_mdma_set_xfer_param(chan, direction, &ccr,
> +                                                       &ctcr, &ctbr, dst_addr,
> +                                                       sg_dma_len(sg));
>                         stm32_mdma_set_bus(dmadev, &ctbr, STM32_MDMA_CTBR_DBUS,
>                                            dst_addr);
>                 }
>
> +               if (ret < 0)
> +                       return ret;
> +
>                 stm32_mdma_setup_hwdesc(chan, desc, direction, i, src_addr,
>                                         dst_addr, sg_dma_len(sg), ctcr, ctbr,
>                                         i == sg_len - 1, i == 0, false);
> @@ -830,27 +852,29 @@ stm32_mdma_prep_dma_cyclic(struct dma_chan *c, dma_addr_t buf_addr,
>         if (!desc)
>                 return NULL;
>
> -       ret = stm32_mdma_set_xfer_param(chan, direction, &ccr, &ctcr, &ctbr,
> -                                       period_len);
> -       if (ret < 0)
> -               goto xfer_setup_err;
> -
> -       /* Enable interrupts */
> -       ccr &= ~STM32_MDMA_CCR_IRQ_MASK;
> -       ccr |= STM32_MDMA_CCR_TEIE | STM32_MDMA_CCR_CTCIE | STM32_MDMA_CCR_BTIE;
> -       desc->ccr = ccr;
> -
>         /* Select bus */
>         if (direction == DMA_MEM_TO_DEV) {
>                 src_addr = buf_addr;
> +               ret = stm32_mdma_set_xfer_param(chan, direction, &ccr, &ctcr,
> +                                               &ctbr, src_addr, period_len);
>                 stm32_mdma_set_bus(dmadev, &ctbr, STM32_MDMA_CTBR_SBUS,
>                                    src_addr);
>         } else {
>                 dst_addr = buf_addr;
> +               ret = stm32_mdma_set_xfer_param(chan, direction, &ccr, &ctcr,
> +                                               &ctbr, dst_addr, period_len);
>                 stm32_mdma_set_bus(dmadev, &ctbr, STM32_MDMA_CTBR_DBUS,
>                                    dst_addr);
>         }
>
> +       if (ret < 0)
> +               goto xfer_setup_err;
> +
> +       /* Enable interrupts */
> +       ccr &= ~STM32_MDMA_CCR_IRQ_MASK;
> +       ccr |= STM32_MDMA_CCR_TEIE | STM32_MDMA_CCR_CTCIE | STM32_MDMA_CCR_BTIE;
> +       desc->ccr = ccr;
> +
>         /* Configure hwdesc list */
>         for (i = 0; i < count; i++) {
>                 if (direction == DMA_MEM_TO_DEV) {
> @@ -956,9 +980,7 @@ stm32_mdma_prep_dma_memcpy(struct dma_chan *c, dma_addr_t dest, dma_addr_t src,
>                 ctcr |= STM32_MDMA_CTCR_TLEN((tlen - 1));
>
>                 /* Set source best burst size */
> -               max_width = stm32_mdma_get_max_width(len, tlen);
> -               if (src % max_width)
> -                       max_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
> +               max_width = stm32_mdma_get_max_width(src, len, tlen);
>                 src_bus_width = stm32_mdma_get_width(chan, max_width);
>
>                 max_burst = tlen / max_width;
> @@ -971,9 +993,7 @@ stm32_mdma_prep_dma_memcpy(struct dma_chan *c, dma_addr_t dest, dma_addr_t src,
>                         STM32_MDMA_CTCR_SINCOS(src_bus_width);
>
>                 /* Set destination best burst size */
> -               max_width = stm32_mdma_get_max_width(len, tlen);
> -               if (dest % max_width)
> -                       max_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
> +               max_width = stm32_mdma_get_max_width(dest, len, tlen);
>                 dst_bus_width = stm32_mdma_get_width(chan, max_width);
>
>                 max_burst = tlen / max_width;
> @@ -1014,9 +1034,7 @@ stm32_mdma_prep_dma_memcpy(struct dma_chan *c, dma_addr_t dest, dma_addr_t src,
>                                            STM32_MDMA_MAX_BLOCK_LEN);
>
>                         /* Set source best burst size */
> -                       max_width = stm32_mdma_get_max_width(len, tlen);
> -                       if (src % max_width)
> -                               max_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
> +                       max_width = stm32_mdma_get_max_width(src, len, tlen);
>                         src_bus_width = stm32_mdma_get_width(chan, max_width);
>
>                         max_burst = tlen / max_width;
> @@ -1030,9 +1048,7 @@ stm32_mdma_prep_dma_memcpy(struct dma_chan *c, dma_addr_t dest, dma_addr_t src,
>                                 STM32_MDMA_CTCR_SINCOS(src_bus_width);
>
>                         /* Set destination best burst size */
> -                       max_width = stm32_mdma_get_max_width(len, tlen);
> -                       if (dest % max_width)
> -                               max_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
> +                       max_width = stm32_mdma_get_max_width(dest, len, tlen);
>                         dst_bus_width = stm32_mdma_get_width(chan, max_width);
>
>                         max_burst = tlen / max_width;
> --
> 2.7.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Benjamin Gaignard

Graphic Study Group

Linaro.org ? Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
