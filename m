From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Wed, 16 Nov 2016 22:10:35 -0800
Subject: [PATCH fpga 4/9] fpga zynq: Check for errors after completing DMA
In-Reply-To: <1478732303-13718-5-git-send-email-jgunthorpe@obsidianresearch.com>
References: <1478732303-13718-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <1478732303-13718-5-git-send-email-jgunthorpe@obsidianresearch.com>
Message-ID: <CAAtXAHeGJjQ22d=OP6cEt8Ssg1bhAEVQ5_GWFFd26xp-j8EUFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

couple of minor things inline below:

On Wed, Nov 9, 2016 at 2:58 PM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> The completion did not check the interrupt status to see if any error
> bits were asserted, check error bits and dump some registers if things
> went wrong.
>
> A few fixes are needed to make this work, the IXR_ERROR_FLAGS_MASK was
> wrong, it included the done bits, which shows a bug in mask/unmask_irqs
> which were using the wrong bits, simplify all of this stuff.
>
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> ---
>  drivers/fpga/zynq-fpga.c | 55 +++++++++++++++++++++++++++---------------------
>  1 file changed, 31 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index 40cf0feaca7c..3ffc5fcc3072 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -89,7 +89,7 @@
>  #define IXR_D_P_DONE_MASK              BIT(12)
>   /* FPGA programmed */
>  #define IXR_PCFG_DONE_MASK             BIT(2)
> -#define IXR_ERROR_FLAGS_MASK           0x00F0F860
> +#define IXR_ERROR_FLAGS_MASK           0x00F0C860

True. Ouch.

>  #define IXR_ALL_MASK                   0xF8F7F87F
>
>  /* Miscellaneous constant values */
> @@ -144,23 +144,10 @@ static inline u32 zynq_fpga_read(const struct zynq_fpga_priv *priv,
>         readl_poll_timeout(priv->io_base + addr, val, cond, sleep_us, \
>                            timeout_us)
>
> -static void zynq_fpga_mask_irqs(struct zynq_fpga_priv *priv)
> +static inline void zynq_fpga_set_irq_mask(struct zynq_fpga_priv *priv,
> +                                         u32 enable)
>  {
> -       u32 intr_mask;
> -
> -       intr_mask = zynq_fpga_read(priv, INT_MASK_OFFSET);
> -       zynq_fpga_write(priv, INT_MASK_OFFSET,
> -                       intr_mask | IXR_DMA_DONE_MASK | IXR_ERROR_FLAGS_MASK);
> -}
> -
> -static void zynq_fpga_unmask_irqs(struct zynq_fpga_priv *priv)
> -{
> -       u32 intr_mask;
> -
> -       intr_mask = zynq_fpga_read(priv, INT_MASK_OFFSET);
> -       zynq_fpga_write(priv, INT_MASK_OFFSET,
> -                       intr_mask
> -                       & ~(IXR_D_P_DONE_MASK | IXR_ERROR_FLAGS_MASK));
> +       zynq_fpga_write(priv, INT_MASK_OFFSET, ~enable);

Not a fan of this ~enable here. Function name indicates you're doing
the opposite
(see below comment).

>  }
>
>  static irqreturn_t zynq_fpga_isr(int irq, void *data)
> @@ -168,7 +155,7 @@ static irqreturn_t zynq_fpga_isr(int irq, void *data)
>         struct zynq_fpga_priv *priv = data;
>
>         /* disable DMA and error IRQs */
> -       zynq_fpga_mask_irqs(priv);
> +       zynq_fpga_set_irq_mask(priv, 0);
>
>         complete(&priv->dma_done);
>
> @@ -314,6 +301,7 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr,
>                                const char *buf, size_t count)
>  {
>         struct zynq_fpga_priv *priv;
> +       const char *why;
>         int err;
>         char *kbuf;
>         dma_addr_t dma_addr;
> @@ -337,7 +325,7 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr,
>         reinit_completion(&priv->dma_done);
>
>         /* enable DMA and error IRQs */
> -       zynq_fpga_unmask_irqs(priv);
> +       zynq_fpga_set_irq_mask(priv, IXR_D_P_DONE_MASK | IXR_ERROR_FLAGS_MASK);

I find the naming here confusing. This sets ~(IXR_D_P_DONE_MASK |
IXR_ERROR_FLAGS_MASK)
as mask value, to enable the D_P_DONE and error IRQs yet the function
name indicates the opposite.
>
>         /* the +1 in the src addr is used to hold off on DMA_DONE IRQ
>          * until both AXI and PCAP are done ...
> @@ -352,16 +340,35 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr,
>         intr_status = zynq_fpga_read(priv, INT_STS_OFFSET);
>         zynq_fpga_write(priv, INT_STS_OFFSET, intr_status);
>
> +       if (intr_status & IXR_ERROR_FLAGS_MASK) {
> +               why = "DMA reported error";
> +               err = -EIO;
> +               goto out_report;
> +       }
> +
>         if (!((intr_status & IXR_D_P_DONE_MASK) == IXR_D_P_DONE_MASK)) {
> -               dev_err(priv->dev, "Error configuring FPGA\n");
> -               err = -EFAULT;
> +               why = "DMA did not complete";
> +               err = -EIO;
> +               goto out_report;
>         }
>
> +       err = 0;
> +       goto out_clk;
> +
> +out_report:
> +       dev_err(priv->dev,
> +               "%s: INT_STS:0x%x CTRL:0x%x LOCK:0x%x INT_MASK:0x%x STATUS:0x%x MCTRL:0x%x\n",
> +               why,
> +               intr_status,
> +               zynq_fpga_read(priv, CTRL_OFFSET),
> +               zynq_fpga_read(priv, LOCK_OFFSET),
> +               zynq_fpga_read(priv, INT_MASK_OFFSET),
> +               zynq_fpga_read(priv, STATUS_OFFSET),
> +               zynq_fpga_read(priv, MCTRL_OFFSET));
> +out_clk:
>         clk_disable(priv->clk);
> -

Personally found it more readable with newline.

>  out_free:
>         dma_free_coherent(priv->dev, count, kbuf, dma_addr);
> -

Same here.
>         return err;
>  }
>
> @@ -475,7 +482,7 @@ static int zynq_fpga_probe(struct platform_device *pdev)
>         /* unlock the device */
>         zynq_fpga_write(priv, UNLOCK_OFFSET, UNLOCK_MASK);
>
> -       zynq_fpga_write(priv, INT_MASK_OFFSET, 0xFFFFFFFF);
> +       zynq_fpga_set_irq_mask(priv, 0);
>         zynq_fpga_write(priv, INT_STS_OFFSET, IXR_ALL_MASK);
>         err = devm_request_irq(dev, priv->irq, zynq_fpga_isr, 0, dev_name(dev),
>                                priv);
> --
> 2.1.4
>

Thanks,

Moritz
