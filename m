From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Mon, 8 Oct 2018 14:32:40 +0200
Subject: [PATCH v3 1/5] spi: spi-mem: Add driver for NXP FlexSPI controller
In-Reply-To: <AM2PR04MB1027555CED1534472C6B8A3C99E60@AM2PR04MB1027.eurprd04.prod.outlook.com>
References: <1537525323-20730-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1537525323-20730-2-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20180929174023.51b1e284@bbrezillon>
 <AM2PR04MB1027555CED1534472C6B8A3C99E60@AM2PR04MB1027.eurprd04.prod.outlook.com>
Message-ID: <20181008143240.00e784a8@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 8 Oct 2018 11:21:13 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> > > +static void nxp_fspi_read_ahb(struct nxp_fspi *f, const struct
> > > +spi_mem_op *op) {
> > > +	u32 len = op->data.nbytes;
> > > +
> > > +	/* Read out the data directly from the AHB buffer. */
> > > +	memcpy_fromio(op->data.buf.in, (f->ahb_addr + op->addr.val), len);  
> > 
> > Don't know if it's supported, but if it is, I recommend using DMA to do this copy,
> > because otherwise you might stall the CPU for quite a long time if the flash is
> > operating in a low-speed mode, and RT maintainers will complain about that at
> > some point ;-).
> >   
> Read using DMA is not supported by the controller in AHB mode, only supported in IP mode.
> Have to use memcpy_fromio() calls. Maximum data size can be read in single call is 0x800 using AHB read.
> 

Still, blocking the CPU until the SPI controller has read 0x800 bytes
is enough to make you miss a real-time deadline. Don't you have a
controller that supports mem2mem transfers (I'm pretty sure a mem2mem
DMA transfer would do the trick here)?

Regards,

Boris
