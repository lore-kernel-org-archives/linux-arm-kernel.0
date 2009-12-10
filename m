From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 Dec 2009 10:20:48 +0000
Subject: [PATCH V2] ARM: NUC900: add GDMA driver support for nuc900
	platform
In-Reply-To: <713d0d430912090737k47e1206am57050061a533f52a@mail.gmail.com>
References: <713d0d430911260242j579d86b3r7eeade0007d2a94c@mail.gmail.com>
	<20091129121614.GA11445@n2100.arm.linux.org.uk>
	<713d0d430912070753o28a8d538qa71b8af8c4415d73@mail.gmail.com>
	<20091207171851.GD26821@n2100.arm.linux.org.uk>
	<713d0d430912071011w76600af1l867d8f52b61d53da@mail.gmail.com>
	<e68bb3470912071903u4657b911nc56bf0f667c37e9e@mail.gmail.com>
	<713d0d430912080747n58369b5dt1b91a1d4a1aa8e23@mail.gmail.com>
	<e68bb3470912090650q77a831c5x98532234ec1b41ec@mail.gmail.com>
	<713d0d430912090737k47e1206am57050061a533f52a@mail.gmail.com>
Message-ID: <20091210102048.GA6207@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 09, 2009 at 11:37:50PM +0800, Hu Ruihuan wrote:
> +static void match_dmachan_fromname(const char *dev_name,
> +					struct nuc900_dma  **dma)
> +{
> +	BUG_ON(!dev_name);
> +
> +	if (dmachan1->device) {
> +		if (strcmp(dmachan1->device, dev_name) == 0)
> +			*dma = dmachan1;
> +	} else if (dmachan0->device) {
> +		if (strcmp(dmachan0->device, dev_name) == 0)
> +			*dma = dmachan0;
> +	}
> +}

Never write functions like this without explaination of why you're doing
it this way: having a void function returning something through a
double pointer is just silly, and leads to bugs (when someone forgets
to NULL-initialize before-hand.)

static struct nuc900_dma *match_dmachan_fromname(const char *dev_name)
{
	BUG_ON(!dev_name);

	if (dmachan1->device) {
		if (strcmp(dmachan1->device, dev_name) == 0)
			return dmachan1;
	} else if (dmachan0->device) {
		if (strcmp(dmachan0->device, dev_name) == 0)
			return dmachan0;
	}
	return NULL;
}

This way, whenever you do:

	dmachan = match_dmachan_fromname(foo);

you know that dmachan will always be initialized, whereas:

	match_dmachan_fromname(foo, &dmachan);

there's little to tell the compiler that dmachan will be initialized -
in fact, the compiler _can't_ tell you whether you're possibly using it
without it having been initialized.

> +int nuc900_request_dma(const char *dev_name, dma_callback_t callback,
> +								void *data)
> +{
> +	struct nuc900_dma  *dma = NULL;
> +	int err, irq_request;
> +	err = 0;
> +	irq_request = 0;
> +	spin_lock(&dma_chan_lock);
> +	dma = register_dmachan_fromname(dev_name, &irq_request);

It seems that the irq_request handling is now unnecessary, please remove.

> +	if (IS_ERR(dma)) {
> +		err = PTR_ERR(dma);
> +		spin_unlock(&dma_chan_lock);
> +		return err;
> +	}
> +	dma->device = dev_name;
> +	atomic_inc(&shared_irq_using);

shared_irq_using is not required anymore.

> +	dma->callback = callback;
> +	dma->data = data;
> +	spin_unlock(&dma_chan_lock);
> +	return 0;
> +}
> +EXPORT_SYMBOL(nuc900_request_dma);
> +
> +int nuc900_free_dma(const char *dev_name)
> +{
> +	struct nuc900_dma  *dma = NULL;
> +
> +	BUG_ON(!dev_name);
> +	WARN_ON(shared_irq_using.counter == 0);

This is buggy, never go inside an 'atomic' object - use the accessor
functions.  In any case, shared_irq_using is not required so this can
be deleted.

> +	spin_lock(&dma_chan_lock);
> +	match_dmachan_fromname(dev_name, &dma);
> +
> +	if (!dma)
> +		return -ENXIO;
> +
> +	dma->device = NULL;
> +	spin_unlock(&dma_chan_lock);
> +
> +	atomic_dec(&shared_irq_using);

Can be removed.

> +
> +	kzfree(dma->descp);
> +	return 0;
> +}
> +EXPORT_SYMBOL(nuc900_free_dma);
> +
> +static unsigned int set_start_cmd(unsigned int start)
> +{
> +	unsigned int dscp_cmd;
> +
> +	dscp_cmd = 0;
> +
> +	if (start) {
> +		dscp_cmd = (ORDEN|RUN);
> +		dscp_cmd &= ~(NON_DSCRIP|RESET);
> +	} else {
> +		dscp_cmd = (NON_DSCRIP);
> +	}
> +		dscp_cmd &= DSCRIPMASK;

Weird formatting - is this correctly placed?  It looks like it should
be within the else { } clause.

> +
> +	return dscp_cmd;
> +}
