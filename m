From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 16 May 2010 03:00:01 +0200
Subject: [PATCH] PXA DMA-capable PATA driver
In-Reply-To: <877hn4ao32.fsf@free.fr>
References: <1273460525-25662-1-git-send-email-marek.vasut@gmail.com>
	<201005150023.45336.marek.vasut@gmail.com> <877hn4ao32.fsf@free.fr>
Message-ID: <201005160300.02076.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne So 15. kv?tna 2010 22:48:17 Robert Jarzmik napsal(a):
> Marek Vasut <marek.vasut@gmail.com> writes:
> > Dne So 15. kv?tna 2010 00:03:45 Jeff Garzik napsal(a):
> >> On 05/09/2010 11:02 PM, Marek Vasut wrote:
> >> > This patch adds a driver for a harddrive attached to PXA address and
> >> > data bus. Unlike pata_platform, this driver allows usage of PXA DMA
> >> > controller, making the transmission speed 3x higher.
> 
> ...
> zip
> ...
> 
> >> > +static void pxa_bmdma_setup(struct ata_queued_cmd *qc)
> >> > +{
> >> > +	struct pata_pxa_data *pd = qc->ap->private_data;
> >> > +	int si = 0;
> >> > +	struct scatterlist *sg;
> >> > +
> >> > +	pd->dma_desc_id = 0;
> >> > +
> >> > +	DCSR(pd->dma_channel) = 0;
> >> > +	DALGN&= ~(1<<  pd->dma_dreq);
> >> > +
> >> > +	for_each_sg(qc->sg, sg, qc->n_elem, si)
> >> > +		pxa_load_dmac(sg, qc);
> >> > +
> >> > +	pd->dma_desc[pd->dma_desc_id - 1].ddadr = DDADR_STOP;
> >> > +
> >> > +	/* Fire IRQ only at the end of last block */
> >> > +	pd->dma_desc[pd->dma_desc_id - 1].dcmd |= DCMD_ENDIRQEN;
> >> > +
> >> > +	DDADR(pd->dma_channel) = pd->dma_desc_addr;
> >> > +	DRCMR(pd->dma_dreq) = DRCMR_MAPVLD | pd->dma_channel;
> >> > +	qc->ap->ops->sff_exec_command(qc->ap,&qc->tf);
> >> > +}
> 
> I don't know the ATA infrastructure well here, but I wonder how cache
> consistency is handled here. Normally, once the sg is ready, you have to
> call dma_map_sg() to map the scatter/gather _and_ to flush any stale cache
> entry the CPU(s) might have over the memory used for the transfer.
> 
> Once the transfer is over, you have to call dma_unmap_sg() to give back the
> memory (ie. ensure cache consistency once the peripheral has finished
> pushing data to the memory).

This should be taken care of by the libata code, shouldn't it ?
> 
> I didn't see that is this piece of code. Did I miss something ?
> 
> > BUG() doesn't happen here so the user won't come into any contact with it
> > unless he sets the drive on fire or something. And in case user comes in
> > contact with it, this is all I need to know to help him. Or maybe
> > dev_err() would be good here ?
> > 
> >> > + * Read DMA status. The bmdma_stop() will take care of properly
> >> > finishing the + * DMA transfer so we always have DMA-complete
> >> > interrupt here.
> >> > + */
> >> > +static unsigned char pxa_bmdma_status(struct ata_port *ap)
> >> > +{
> >> > +	return ATA_DMA_INTR;
> >> > +}
> >> 
> >> are you able to detect bus error?
> > 
> > Sadly, no. Nor can I detect any other condition.
> 
> Wouldn't the DCSR_BUSERR bit of DCSR report a bus error ?

I have doubts, check the PXA270 TRM for example for description of that bit.
> 
> +/*
> + * DMA interrupt handler.
> + */
> +static void pxa_ata_dma_irq(int dma, void *port)
> +{
> +	uint32_t dcsr;
> +	struct ata_port *ap = port;
> +	struct pata_pxa_data *pd = ap->private_data;
> +
> +	dcsr = DCSR(dma);
> +	DCSR(dma) = dcsr;
> +	if (dcsr & DCSR_STOPSTATE)
> +		complete(&pd->dma_done);
> +}
> 
> Cheers.
> 
> --
> Robert
