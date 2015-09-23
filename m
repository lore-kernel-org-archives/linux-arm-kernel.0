From: anurag.kumar.vulisha@xilinx.com (Anurag Kumar Vulisha)
Date: Wed, 23 Sep 2015 15:12:36 +0000
Subject: [PATCH v2] dmaengine: vdma: Add 64 bit addressing support to
 the driver
In-Reply-To: <20150921155712.GN2381@localhost>
References: <1440690558-39822-1-git-send-email-anuragku@xilinx.com>
 <20150921155712.GN2381@localhost>
Message-ID: <3802E9A6666DF54886E2B9CBF743BA9801C08CA1@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

Thanks for reviewing the patch

> -----Original Message-----
> From: Vinod Koul [mailto:vinod.koul at intel.com]
> Sent: Monday, September 21, 2015 9:27 PM
> To: Anurag Kumar Vulisha
> Cc: Rob Herring; Pawel Moll; Mark Rutland; Ian Campbell; Kumar Gala; Michal
> Simek; Soren Brinkmann; Dan Williams; afaerber at suse.de; Maxime Ripard;
> Laurent Pinchart; Appana Durga Kedareswara Rao; Anirudha Sarangi; Srikanth
> Vemula; devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org; dmaengine at vger.kernel.org; Anurag Kumar
> Vulisha
> Subject: Re: [PATCH v2] dmaengine: vdma: Add 64 bit addressing support to
> the driver
>
> On Thu, Aug 27, 2015 at 09:19:18PM +0530, Anurag Kumar Vulisha wrote:
> > This VDMA  is a soft ip, which can be programmed to support
> > 32 bit addressing or greater than 32 bit addressing.
> >
> > When the VDMA ip is configured for 32 bit address space the transfer
> > start address is specified by a single register.
>
> would be good to specfiy which one
>

Will change  this in v3

> > When the  VDMA core is configured for an address space greater than 32
> > then each start address is specified by a combination of two
> > registers. The first register specifies the LSB 32 bits of address,
> > while the next register specifies the MSB 32 bits of address.For
> > example,5Ch will specify the LSB 32 bits while 60h will specify the
> > MSB 32 bits of the first start address.So we need to program two
> > registers at a time.
>
> can we have spaces after full stops and commas!
>

Will take care of this in v3 patch.

> > +/* Since vdma driver is trying to write to a register offset which is
> > +not a
> > + * multiple of 64 bits(ex : 0x5c), we are writing as two separate 32
> > +bits
> > + * instead of a single 64 bit register write.
> > + */
>
> This is not kernel style for multi-lines, pls refer to
> Documentation/CodingStyle
>

Will address this in v3 patch

> > +
> > +static inline void vdma_desc_write_64(struct xilinx_vdma_chan *chan,
> u32 reg,
> > +                            u32 value_lsb, u32 value_msb)
> > +{
> > +   /* Write the lsb 32 bits*/
> > +   writel(value_lsb, chan->xdev->regs + chan->desc_offset + reg);
> > +
> > +   /* Write the msb 32 bits */
> > +   writel(value_msb, chan->xdev->regs + chan->desc_offset + reg + 4);
>
> why not writeq

We are trying to write at a register address(ex:0x5c) which is not aligned on 8 bytes  boundary.So if I try to use 64 bit write on it,unalignment  fault is getting  generated.To avoid that we are using two separate 32  bit writes.
We had this discussion in previous versions of this patch with Laurent Pinchart .I have also added this exaplanation in the comments above this function.

>
> > +   err = of_property_read_u32(node, "xlnx,addrwidth", &addr_width);
> > +
> > +   if (err < 0) {
> > +           /* Setting addr_width property to default 32 bits */
> > +           addr_width = 32;
> > +   }
>
> braces for a single line statement! Also space is redandant before if condition
>

Will take care of this in v3 patch

Thanks,
Anurag Kumar V

> --
> ~Vinod


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
