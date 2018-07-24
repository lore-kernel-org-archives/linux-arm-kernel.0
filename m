From: appanad@xilinx.com (Appana Durga Kedareswara Rao)
Date: Tue, 24 Jul 2018 18:31:44 +0000
Subject: [PATCH v3 2/2] fpga: zynq-fpga: Add support for readback
In-Reply-To: <CAAtXAHeVXw4BT7XF+Mu=nR9U9nK=nR_+x+JKSQU1owwPbt_HPA@mail.gmail.com>
References: <1532441858-13507-1-git-send-email-appana.durga.rao@xilinx.com>
 <1532441858-13507-2-git-send-email-appana.durga.rao@xilinx.com>
 <CAAtXAHeVXw4BT7XF+Mu=nR9U9nK=nR_+x+JKSQU1owwPbt_HPA@mail.gmail.com>
Message-ID: <CY1PR02MB169273A09D4E675A7671375CDC550@CY1PR02MB1692.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Moritz,

	Thanks for the review...

<Snip> 
> Can you please make the commit message such that you have full sentences?
> 
> "Add support for readback of FPGA configuration data and registers" of 
> example.

Sure will fix in v4.

> 
> >
> > Usage:
> > Readback of PL configuration registers
> >         cat /sys/kernel/debug/fpga/fpga0/image
> > Readback of PL configuration data
> >         echo 1 > /sys/module/zynqmp_fpga/parameters/readback_type
> 
> The patch below is for Zynq if I'm not mistaken, not ZynqMP?

Yes it is for Zynq not ZynqMP by mistake I have kept zynqmp here, thanks for pointing  will fix in v4...

<Snip> 
> > +static bool readback_type;
> > +module_param(readback_type, bool, 0644); 
> > +MODULE_PARM_DESC(readback_type,
> > +               "readback_type 0-configuration register read "
> > +               "1- configuration data read (default: 0)");
> 
> Not sure a module param is the best solution here.

Need to provide flexibility to the user to switch between reading of FPGA registers and configuration data.
One other option is sysfs. Do you want me to implement sysfs path??? 
Any other suggestions??? 

<Snip> 
> > +/* Masks for Configuration registers */
> > +#define FAR_ADDR_MASK          0x00000000
> > +#define RCFG_CMD_MASK          0x00000004
> > +#define START_CMD_MASK         0x00000005
> > +#define RCRC_CMD_MASK          0x00000007
> 
> BIT() and GENMASK() would work here.

Sure will fix in v4... 

> 
> > +#define SHUTDOWN_CMD_MASK      0x0000000B
> > +#define DESYNC_WORD_MASK       0x0000000D
> > +#define BUSWIDTH_SYNCWORD_MASK 0x000000BB
> > +#define NOOP_WORD_MASK         0x20000000
> > +#define BUSWIDTH_DETECT_MASK   0x11220044
> > +#define SYNC_WORD_MASK         0xAA995566
> > +#define DUMMY_WORD_MASK                0xFFFFFFFF
> 
> GENMASK() would probably work for most of the above ones

Sure will use GENMAK wherever applicable will fix in v4.

<Snip> 
> > +        * Generating the Type 1 packet header which involves 
> > +sifting of Type1
> Shifting? Maybe you can just reference the section that documents this 
> in the TRM?

Sure will fix in v4... 

<Snip>
> ******
> > +********/ static int zynq_type2_pkt(u8 OpCode, u32 Size)
> 
> No camel case please, can you make Size and OpCode small caps please?
> Also please make the two functions consistent.

Sure will fix in v4...

> > +{
> > +       /*
> > +        * Type 2 Packet Header Format
> > +        * The header section is always a 32-bit word.
> > +        *
> > +        * HeaderType | Opcode |  Word Count
> > +        * [31:29]      [28:27]         [26:0]
> > +        * --------------------------------------------------------------
> > +        *   010          xx      xxxxxxxxxxxxx
> > +        *
> > +        * @R: means the bit is not used and reserved for future use.
> > +        * The reserved bits should be written as 0s.
> > +        *
> > +        * Generating the Type 2 packet header which involves 
> > +sifting of Type 2
> 
> s/sifting/shifting/

Sure will fix in v4...

> > +        * Header Mask, OpCode and then performing OR
> > +        * operation with the Word Length.
> > +        */
> > +       return (((2 << TYPE_HDR_SHIFT) |
> > +               (OpCode << TYPE_OP_SHIFT)) | Size); }
> > +
> > +static int zynq_fpga_read_cfgdata(struct fpga_manager *mgr,
> > +                                 struct seq_file *s) {
> > +       struct zynq_fpga_priv *priv;
> > +       int ret = 0, i, cmdindex, clk_rate;
> > +       unsigned int *buf;
> > +       dma_addr_t dma_addr;
> > +       u32 intr_status, status;
> > +       size_t size;
> 
> Reverse xmas tree please

Ok sure will v4... 

> > +
> > +       priv = mgr->priv;
> > +       size = priv->size + READ_DMA_SIZE + DUMMY_FRAMES_SIZE;
> > +       buf = dma_zalloc_coherent(mgr->dev.parent, size,
> > +                                &dma_addr, GFP_KERNEL);
> > +       if (!buf)
> > +               return -ENOMEM;
> > +
> > +       seq_puts(s, "zynq FPGA Configuration data contents are\n");
> > +
> > +       /*
> > +        * There is no h/w flow control for pcap read
> > +        * to prevent the FIFO from over flowing, reduce
> > +        * the PCAP operating frequency.
> > +        */
> > +       clk_rate = clk_get_rate(priv->clk);
> > +       ret = clk_set_rate(priv->clk, SLCR_PCAP_FREQ);
> > +       if (ret) {
> > +               dev_err(&mgr->dev, "Unable to reduce the PCAP freq\n");
> > +               goto free_dmabuf;
> > +       }
> > +
> > +       ret = zynq_fpga_poll_timeout(priv, STATUS_OFFSET, status,
> > +                                    status & STATUS_PCFG_INIT_MASK,
> > +                                    INIT_POLL_DELAY,
> > +                                    INIT_POLL_TIMEOUT);
> > +       if (ret) {
> > +               dev_err(&mgr->dev, "Timeout waiting for PCFG_INIT\n");
> > +               goto restore_pcap_clk;
> > +       }
> > +
> > +       cmdindex = 0;
> > +       buf[cmdindex++] = DUMMY_WORD_MASK;
> > +       buf[cmdindex++] = BUSWIDTH_SYNCWORD_MASK;
> > +       buf[cmdindex++] = BUSWIDTH_DETECT_MASK;
> > +       buf[cmdindex++] = DUMMY_WORD_MASK;
> > +       buf[cmdindex++] = SYNC_WORD_MASK;
> > +       buf[cmdindex++] = NOOP_WORD_MASK;
> > +       buf[cmdindex++] = zynq_type1_pkt(TYPE_CMD_OFFSET,
> TYPE_OPCODE_WRITE,
> > +                                        1);
> > +       buf[cmdindex++] = SHUTDOWN_CMD_MASK;
> > +       buf[cmdindex++] = NOOP_WORD_MASK;
> > +       buf[cmdindex++] = zynq_type1_pkt(TYPE_CMD_OFFSET,
> TYPE_OPCODE_WRITE,
> > +                                        1);
> > +       buf[cmdindex++] = RCRC_CMD_MASK;
> > +       for (i = 0; i < 6; i++)
> Magic constant?

Sure will fix in v4....

> > +               buf[cmdindex++] = NOOP_WORD_MASK;
> > +       buf[cmdindex++] = zynq_type1_pkt(TYPE_CMD_OFFSET,
> TYPE_OPCODE_WRITE,
> > +                                        1);
> > +       buf[cmdindex++] = RCFG_CMD_MASK;
> > +       buf[cmdindex++] = NOOP_WORD_MASK;
> > +       buf[cmdindex++] = zynq_type1_pkt(TYPE_FAR_OFFSET,
> TYPE_OPCODE_WRITE,
> > +                                        1);
> > +       buf[cmdindex++] = FAR_ADDR_MASK;
> > +       buf[cmdindex++] = zynq_type1_pkt(TYPE_FDRO_OFFSET,
> TYPE_OPCODE_READ,
> > +                                        0);
> > +       buf[cmdindex++] = zynq_type2_pkt(TYPE_OPCODE_READ, priv-
> >size/4);
> > +       for (i = 0; i < 32; i++)
> Magic constant?

Sure will fix in v4....

> > +               buf[cmdindex++] = NOOP_WORD_MASK;
> > +
> > +       intr_status = zynq_fpga_read(priv, INT_STS_OFFSET);
> > +       zynq_fpga_write(priv, INT_STS_OFFSET, intr_status);
> > +
> > +       /* Write to PCAP */
> > +       zynq_fpga_dma_xfer(priv, dma_addr, cmdindex,
> > +                          DMA_INVALID_ADDRESS, 0);
> > +       ret = zynq_fpga_wait_fordone(priv);
> > +       if (ret) {
> > +               dev_err(&mgr->dev, "SRCDMA: Timeout waiting for
> D_P_DONE\n");
> > +               goto restore_pcap_clk;
> > +       }
> > +       intr_status = zynq_fpga_read(priv, INT_STS_OFFSET);
> > +       zynq_fpga_write(priv, INT_STS_OFFSET, intr_status);
> > +
> > +       /* READ From PACP */
> > +       zynq_fpga_dma_xfer(priv, DMA_INVALID_ADDRESS, 0,
> > +                          dma_addr + READ_DMA_SIZE, priv->size/4);
> > +       ret = zynq_fpga_wait_fordone(priv);
> > +       if (ret) {
> > +               dev_err(&mgr->dev, "DSTDMA: Timeout waiting for
> D_P_DONE\n");
> > +               goto restore_pcap_clk;
> > +       }
> > +       intr_status = zynq_fpga_read(priv, INT_STS_OFFSET);
> > +       zynq_fpga_write(priv, INT_STS_OFFSET, intr_status);
> > +
> > +       /* Write to PCAP */
> > +       cmdindex = 0;
> > +       buf[cmdindex++] = NOOP_WORD_MASK;
> > +       buf[cmdindex++] = zynq_type1_pkt(TYPE_CMD_OFFSET,
> > +                                        TYPE_OPCODE_WRITE, 1);
> > +       buf[cmdindex++] = START_CMD_MASK;
> > +       buf[cmdindex++] = NOOP_WORD_MASK;
> > +
> > +       buf[cmdindex++] = zynq_type1_pkt(TYPE_CMD_OFFSET,
> > +                                        TYPE_OPCODE_WRITE, 1);
> > +       buf[cmdindex++] = RCRC_CMD_MASK;
> > +       buf[cmdindex++] = NOOP_WORD_MASK;
> > +       buf[cmdindex++] = zynq_type1_pkt(TYPE_CMD_OFFSET,
> > +                                        TYPE_OPCODE_WRITE, 1);
> > +       buf[cmdindex++] = DESYNC_WORD_MASK;
> > +       buf[cmdindex++] = NOOP_WORD_MASK;
> > +       buf[cmdindex++] = NOOP_WORD_MASK;
> > +
> > +       zynq_fpga_dma_xfer(priv, dma_addr, cmdindex,
> > +                          DMA_INVALID_ADDRESS, 0);
> > +       ret = zynq_fpga_wait_fordone(priv);
> > +       if (ret) {
> > +               dev_err(&mgr->dev, "SRCDMA1: Timeout waiting for
> D_P_DONE\n");
> > +               goto restore_pcap_clk;
> > +       }
> > +
> > +       seq_write(s, &buf[READ_DMA_SIZE/4], priv->size);
> > +
> > +restore_pcap_clk:
> > +       clk_set_rate(priv->clk, clk_rate);
> > +free_dmabuf:
> > +       dma_free_coherent(mgr->dev.parent, size, buf,
> > +                         dma_addr);
> > +       return ret;
> > +}
> > +
> > +static int zynq_fpga_getconfigreg(struct fpga_manager *mgr, u8 reg,
> > +                                 dma_addr_t dma_addr, int *buf)
> zynq_fpga_get_config_reg maybe?

Ok will fix in v4...

> > +{
> > +       struct zynq_fpga_priv *priv;
> > +       int ret = 0, cmdindex, src_dmaoffset;
> > +       u32 intr_status, status;
> 
> Same here.

Sure will fix in v4....

> > +
> > +       priv = mgr->priv;
> > +
> > +       src_dmaoffset = 0x8;
> > +       cmdindex = 2;
> > +       buf[cmdindex++] = DUMMY_WORD_MASK;
> > +       buf[cmdindex++] = BUSWIDTH_SYNCWORD_MASK;
> > +       buf[cmdindex++] = BUSWIDTH_DETECT_MASK;
> > +       buf[cmdindex++] = DUMMY_WORD_MASK;
> > +       buf[cmdindex++] = SYNC_WORD_MASK;
> > +       buf[cmdindex++] = NOOP_WORD_MASK;
> > +       buf[cmdindex++] = zynq_type1_pkt(reg, TYPE_OPCODE_READ, 1);
> > +       buf[cmdindex++] = NOOP_WORD_MASK;
> > +       buf[cmdindex++] = NOOP_WORD_MASK;
> > +
> > +       ret = zynq_fpga_poll_timeout(priv, STATUS_OFFSET, status,
> > +                                    status & STATUS_PCFG_INIT_MASK,
> > +                                    INIT_POLL_DELAY,
> > +                                    INIT_POLL_TIMEOUT);
> > +       if (ret) {
> > +               dev_err(&mgr->dev, "Timeout waiting for PCFG_INIT\n");
> > +               goto out;
> > +       }
> > +
> > +       /* Write to PCAP */
> > +       intr_status = zynq_fpga_read(priv, INT_STS_OFFSET);
> > +       zynq_fpga_write(priv, INT_STS_OFFSET, IXR_ALL_MASK);
> > +
> > +       zynq_fpga_dma_xfer(priv, dma_addr + src_dmaoffset, cmdindex,
> > +                          DMA_INVALID_ADDRESS, 0);
> > +       ret = zynq_fpga_wait_fordone(priv);
> > +       if (ret) {
> > +               dev_err(&mgr->dev, "SRCDMA: Timeout waiting for
> D_P_DONE\n");
> > +               goto out;
> > +       }
> > +       zynq_fpga_set_irq(priv, intr_status);
> > +
> > +       /* READ From PACP */
> 
> READ -> Read ?

Ok sure will fix in v4....

> > +       zynq_fpga_dma_xfer(priv, DMA_INVALID_ADDRESS, 0, dma_addr, 1);
> > +       ret = zynq_fpga_wait_fordone(priv);
> > +       if (ret) {
> > +               dev_err(&mgr->dev, "DSTDMA: Timeout waiting for
> D_P_DONE\n");
> > +               goto out;
> > +       }
> > +
> > +       /* Write to PCAP */
> > +       cmdindex = 2;
> > +       buf[cmdindex++] = zynq_type1_pkt(TYPE_CMD_OFFSET,
> > +                                        TYPE_OPCODE_WRITE, 1);
> > +       buf[cmdindex++] = DESYNC_WORD_MASK;
> > +       buf[cmdindex++] = NOOP_WORD_MASK;
> > +       buf[cmdindex++] = NOOP_WORD_MASK;
> > +       zynq_fpga_dma_xfer(priv, dma_addr + src_dmaoffset, cmdindex,
> > +                          DMA_INVALID_ADDRESS, 0);
> > +       ret = zynq_fpga_wait_fordone(priv);
> > +       if (ret)
> > +               dev_err(&mgr->dev, "SRCDMA1: Timeout waiting for 
> > +D_P_DONE\n");
> > +out:
> > +       return ret;
> > +}
> > +
> > +static int zynq_fpga_read_cfgreg(struct fpga_manager *mgr,
> > +                                struct seq_file *s) {
> > +       int ret = 0;
> > +       unsigned int *buf;
> > +       dma_addr_t dma_addr;
> > +       struct zynq_configreg *p = cfgreg;
> 
> And here.

Sure will fix in v4....

> > +
> > +       buf = dma_zalloc_coherent(mgr->dev.parent, READ_DMA_SIZE,
> > +                                &dma_addr, GFP_KERNEL);
> > +       if (!buf)
> > +               return -ENOMEM;
> > +
> > +       seq_puts(s, "zynq FPGA Configuration register contents 
> > + are\n");
> 
> Zynq FPGA, maybe caps here...

Sure will fix in v4....

Thanks and Regards,
Kedar.

> > +
> > +       while (p->reg) {
> > +               ret = zynq_fpga_getconfigreg(mgr, p->offset, dma_addr, buf);
> > +               if (ret)
> > +                       goto free_dmabuf;
> > +               seq_printf(s, "%s --> \t %x \t\r\n", p->reg, buf[0]);
> > +               p++;
> > +       }
> > +
> > +free_dmabuf:
> > +       dma_free_coherent(mgr->dev.parent, READ_DMA_SIZE, buf,
> > +                         dma_addr);
> > +       return ret;
> > +}
> > +
> > +static int zynq_fpga_ops_read(struct fpga_manager *mgr, struct 
> > +seq_file *s) {
> > +       struct zynq_fpga_priv *priv;
> > +       int ret;
> > +
> > +       priv = mgr->priv;
> > +
> > +       ret = clk_enable(priv->clk);
> > +       if (ret)
> > +               return ret;
> > +
> > +       if (readback_type)
> > +               ret = zynq_fpga_read_cfgdata(mgr, s);
> > +       else
> > +               ret = zynq_fpga_read_cfgreg(mgr, s);
> > +
> > +       clk_disable(priv->clk);
> > +
> > +       return ret;
> > +}
> > +
> >  static const struct fpga_manager_ops zynq_fpga_ops = {
> >         .initial_header_size = 128,
> >         .state = zynq_fpga_ops_state,
> >         .write_init = zynq_fpga_ops_write_init,
> >         .write_sg = zynq_fpga_ops_write,
> >         .write_complete = zynq_fpga_ops_write_complete,
> > +       .read = zynq_fpga_ops_read,
> >  };
> >
> >  static int zynq_fpga_probe(struct platform_device *pdev)
> > --
> > 2.7.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-fpga"
> > in the body of a message to majordomo at vger.kernel.org More
> majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
> 
> Thanks,
> 
> Moritz
