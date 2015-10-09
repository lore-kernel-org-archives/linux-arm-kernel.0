From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Fri, 9 Oct 2015 19:17:16 +0200
Subject: [PATCH 3/3] fpga manager: Adding FPGA Manager support for Xilinx
 Zynq 7000
In-Reply-To: <20151009163336.GM10631@jcartwri.amer.corp.natinst.com>
References: <1444344307-22509-1-git-send-email-moritz.fischer@ettus.com>
 <1444344307-22509-4-git-send-email-moritz.fischer@ettus.com>
 <20151009163336.GM10631@jcartwri.amer.corp.natinst.com>
Message-ID: <CAAtXAHea7GZDLez5kYas2PFQ-=KmS_on8WxFDCuvVb4Nh05a_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh,

thanks for the review!

On Fri, Oct 9, 2015 at 6:33 PM, Josh Cartwright <joshc@ni.com> wrote:
> Hey Moritz-
>
> On Fri, Oct 09, 2015 at 12:45:07AM +0200, Moritz Fischer wrote:
>> This commit adds FPGA Manager support for the Xilinx Zynq chip.
>> The code heavily borrows from the xdevcfg driver in Xilinx'
>> vendor tree.
>>
>> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
> [..]
>> +++ b/drivers/fpga/zynq-fpga.c
> [..]
>> +static irqreturn_t zynq_fpga_isr(int irq, void *data)
>> +{
>> +     u32 intr_status;
>> +     struct zynq_fpga_priv *priv = data;
>> +
>> +     spin_lock(&priv->lock);
>
> I'm confused about the locking here.  You have this lock, but it's only
> used in the isr.  It's claimed purpose is to protect 'error', but that
> clearly isn't happening.

Ouch, yes ...
>
>> +     intr_status = zynq_fpga_read(priv, INT_STS_OFFSET);
>> +
>> +     if (!intr_status) {
>> +             spin_unlock(&priv->lock);
>> +             return IRQ_NONE;
>> +     }
>> +
>> +     zynq_fpga_write(priv, INT_STS_OFFSET, intr_status);
>> +
>> +     if ((intr_status & IXR_D_P_DONE_MASK) == IXR_D_P_DONE_MASK)
>> +             complete(&priv->dma_done);
>
> Just so I understand, wouldn't you also want to complete() in the error
> case, too?

Ehrm ... yes. Definitely.
>
>> +     if ((intr_status & IXR_ERROR_FLAGS_MASK) ==
>> +                     IXR_ERROR_FLAGS_MASK) {
>> +             priv->error = true;
>> +             dev_err(priv->dev, "%s dma error\n", __func__);
>> +     }
>> +     spin_unlock(&priv->lock);
>> +
>> +     return IRQ_HANDLED;
>> +}
>> +
>> +static int zynq_fpga_ops_write_init(struct fpga_manager *mgr, u32 flags,
>> +                                 const char *buf, size_t count)
>> +{
>> +     struct zynq_fpga_priv *priv;
>> +     u32 ctrl, status;
>> +     int err;
>> +
>> +     priv = mgr->priv;
>> +
>> +     err = clk_enable(priv->clk);
>> +     if (err)
>> +             return err;
>> +
>> +     /* only reset if we're not doing partial reconfig */
>> +     if (!(flags & FPGA_MGR_PARTIAL_RECONFIG)) {
>> +             /* assert AXI interface resets */
>> +             regmap_write(priv->slcr, SLCR_FPGA_RST_CTRL_OFFSET,
>> +                          FPGA_RST_ALL_MASK);
>> +
>> +             /* disable level shifters */
>> +             regmap_write(priv->slcr, SLCR_LVL_SHFTR_EN_OFFSET,
>> +                          LVL_SHFTR_DISABLE_ALL_MASK);
>> +             /* enable output level shifters */
>> +             regmap_write(priv->slcr, SLCR_LVL_SHFTR_EN_OFFSET,
>> +                          LVL_SHFTR_ENABLE_PS_TO_PL);
>> +
>> +             /* create a rising edge on PCFG_INIT. PCFG_INIT follows
>> +              * PCFG_PROG_B, so we need to poll it after setting PCFG_PROG_B
>> +              * to make sure the rising edge actually happens
>> +              */
>> +             ctrl = zynq_fpga_read(priv, CTRL_OFFSET);
>> +             ctrl |= CTRL_PCFG_PROG_B_MASK;
>> +
>> +             zynq_fpga_write(priv, CTRL_OFFSET, ctrl);
>> +
>> +             zynq_fpga_poll_timeout(priv, STATUS_OFFSET, status, status &
>> +                                    STATUS_PCFG_INIT_MASK, 20, 0);
>
> And if we timeout?

Ehrm ... then we should cleanup & return ...
>
>> +
>> +             ctrl = zynq_fpga_read(priv, CTRL_OFFSET);
>> +             ctrl &= ~CTRL_PCFG_PROG_B_MASK;
>> +
>> +             zynq_fpga_write(priv, CTRL_OFFSET, ctrl);
>> +
>> +             zynq_fpga_poll_timeout(priv, STATUS_OFFSET, status, !(status &
>> +                                    STATUS_PCFG_INIT_MASK), 20, 0);
>
> And if we timeout?

See above ...
>
>> +
>> +             ctrl = zynq_fpga_read(priv, CTRL_OFFSET);
>> +             ctrl |= CTRL_PCFG_PROG_B_MASK;
>> +
>> +             zynq_fpga_write(priv, CTRL_OFFSET, ctrl);
>> +
>> +             zynq_fpga_poll_timeout(priv, STATUS_OFFSET, status, status &
>> +                                    STATUS_PCFG_INIT_MASK, 20, 0);
>
> And if we timeout?

Ok ok ... got it...
>
>> +     }
>> +
>> +     clk_disable(priv->clk);
>> +
>> +     return 0;
>> +}
>> +
>> +static int zynq_fpga_ops_write(struct fpga_manager *mgr,
>> +                            const char *buf, size_t count)
>> +{
>> +     struct zynq_fpga_priv *priv;
>> +     int err;
>> +     char *kbuf;
>> +     size_t i, in_count;
>> +     dma_addr_t dma_addr;
>> +     u32 transfer_length = 0;
>> +     bool endian_swap = false;
>> +
>> +     in_count = count;
>> +     priv = mgr->priv;
>> +
>> +     kbuf = dma_alloc_coherent(priv->dev, count, &dma_addr, GFP_KERNEL);
>> +     if (!kbuf)
>> +             return -ENOMEM;
>> +
>> +     memcpy(kbuf, buf, count);
>> +
>> +     /* look for the sync word */
>> +     for (i = 0; i < count - 4; i++) {
>> +             if (memcmp(kbuf + i, "\x66\x55\x99\xAA", 4) == 0) {
>> +                     dev_dbg(priv->dev, "Found normal sync word\n");
>> +                     endian_swap = false;
>> +                     break;
>> +             }
>> +             if (memcmp(kbuf + i, "\xAA\x99\x55\x66", 4) == 0) {
>> +                     dev_dbg(priv->dev, "Found swapped sync word\n");
>> +                     endian_swap = true;
>> +                     break;
>> +             }
>> +     }
>
> How much control do we have over mandating the format of firmware at
> this point?  It'd be swell if we could just mandate a specific
> endianness, and leave this munging to usermode.

That's a good question. Personally I do only care about one of both,
but that's just because I get to decide for my targets...
Opinions from the Xilinx guys?

>
>> +     /* remove the header, align the data on word boundary */
>> +     if (i != count - 4) {
>> +             count -= i;
>> +             memmove(kbuf, kbuf + i, count);
>> +     }
>> +
>> +     /* fixup endianness of the data */
>> +     if (endian_swap) {
>> +             for (i = 0; i < count; i += 4) {
>
> Aren't we writing beyond the buffer, if count isn't word-aligned?
>
>> +                     u32 *p = (u32 *)&kbuf[i];
>> +                     *p = swab32(*p);
>> +             }
>> +     }
>> +
>> +     /* enable clock */
>> +     err = clk_enable(priv->clk);
>> +     if (err)
>> +             goto out_free;
>> +
>> +     zynq_fpga_write(priv, INT_STS_OFFSET, IXR_ALL_MASK);
>> +
>> +     /* enable DMA and error IRQs */
>> +     zynq_fpga_unmask_irqs(priv);
>> +
>> +     priv->error = false;
>> +
>> +     /* the +1 in the src addr is used to hold off on DMA_DONE IRQ */
>> +     /* until both AXI and PCAP are done */
>> +     if (count < PAGE_SIZE)
>> +             zynq_fpga_write(priv, DMA_SRC_ADDR_OFFSET, (u32)(dma_addr + 1));
>> +     else
>> +             zynq_fpga_write(priv, DMA_SRC_ADDR_OFFSET, (u32)(dma_addr));
>> +
>> +     zynq_fpga_write(priv, DMA_DEST_ADDR_OFFSET, (u32)DMA_INVALID_ADDRESS);
>> +
>> +     /* convert #bytes to #words */
>> +     transfer_length = (count + 3) / 4;
>> +
>> +     zynq_fpga_write(priv, DMA_SRC_LEN_OFFSET, transfer_length);
>> +     zynq_fpga_write(priv, DMA_DEST_LEN_OFFSET, 0);
>> +
>> +     wait_for_completion_interruptible(&priv->dma_done);
>
> And if we're interrupted?

One should deal with that ...
>
>> +     if (priv->error) {
>> +             dev_err(priv->dev, "Error configuring FPGA.\n");
>> +             err = -EFAULT;
>> +     }
>> +
>> +     /* disable DMA and error IRQs */
>> +     zynq_fpga_mask_irqs(priv);
>> +
>> +     clk_disable(priv->clk);
>> +
>> +out_free:
>> +     dma_free_coherent(priv->dev, in_count, kbuf, dma_addr);
>> +
>> +     return err;
>> +}
> [..]
>> +static int zynq_fpga_probe(struct platform_device *pdev)
>> +{
>> +     struct device *dev = &pdev->dev;
>> +     struct zynq_fpga_priv *priv;
>> +     struct resource *res;
>> +     u32 ctrl_reg;
>> +     int ret;
>> +
> [..]
>> +     priv->irq = platform_get_irq(pdev, 0);
>> +     if (priv->irq < 0) {
>> +             dev_err(dev, "No IRQ available");
>> +             return priv->irq;
>> +     }
>> +
>> +     ret = devm_request_irq(dev, priv->irq, zynq_fpga_isr, 0,
>> +                            dev_name(dev), priv);
>> +     if (IS_ERR_VALUE(ret))
>
> This is the wrong check for error in this case.  You should check 'ret'
> being non-zero.

Good catch, will fix ...
>
>> +             return ret;
>> +
>> +     priv->clk = devm_clk_get(dev, "ref_clk");
>> +     if (IS_ERR(priv->clk)) {
>> +             dev_err(dev, "input clock not found\n");
>> +             return PTR_ERR(priv->clk);
>> +     }
>> +
>> +     ret = clk_prepare_enable(priv->clk);
>> +     if (ret) {
>> +             dev_err(dev, "unable to enable clock\n");
>> +             return ret;
>> +     }
>> +
>> +     /* unlock the device */
>> +     zynq_fpga_write(priv, UNLOCK_OFFSET, UNLOCK_MASK);
>> +
>> +     /* set configuration register with following options:
>> +     * - reset FPGA
>> +     * - enable PCAP interface for partial reconfig
>> +     * - set throughput for maximum speed
>> +     * - set CPU in user mode
>> +     */
>> +     ctrl_reg = zynq_fpga_read(priv, CTRL_OFFSET);
>> +     zynq_fpga_write(priv, CTRL_OFFSET, (CTRL_PCFG_PROG_B_MASK |
>> +             CTRL_PCAP_PR_MASK | CTRL_PCAP_MODE_MASK | ctrl_reg));
>> +
>> +     /* ensure internal PCAP loopback is disabled */
>> +     ctrl_reg = zynq_fpga_read(priv, MCTRL_OFFSET);
>> +     zynq_fpga_write(priv, MCTRL_OFFSET, (~MCTRL_PCAP_LPBK_MASK & ctrl_reg));
>
> Why do all of this initialization in probe()?  Is it necessary to read
> FPGA state()?

Hmmm ... good catch, again. Will rework...
>>
>> +
>> +     ret = fpga_mgr_register(dev, "Xilinx Zynq FPGA Manager",
>> +                             &zynq_fpga_ops, priv);
>> +     if (ret) {
>> +             dev_err(dev, "unable to register FPGA manager");
>> +             clk_disable_unprepare(priv->clk);
>> +             return ret;
>> +     }
>
> I would have expected the clock to have been disabled after even a
> successful probe.

Yes, you're right. Will do.
>
>> +     return 0;
>> +}
>> +
>> +static int zynq_fpga_remove(struct platform_device *pdev)
>> +{
>> +     fpga_mgr_unregister(&pdev->dev);
>
> Your clock management is unbalanced.

Arghh
>
>   Josh

Thanks for reviewing, seems like I got one or two things to fix ;-)

Moritz
