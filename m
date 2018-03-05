From: Jonathan.Cameron@huawei.com (Jonathan Cameron)
Date: Mon, 5 Mar 2018 14:47:42 +0000
Subject: [PATCH v6 03/20] firmware: arm_scmi: add basic driver
 infrastructure for SCMI
In-Reply-To: <9d6e431e-fa07-63b6-81fc-6b00c7e8267e@arm.com>
References: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
 <1519403030-21189-4-git-send-email-sudeep.holla@arm.com>
 <20180305145253.00004247@huawei.com>
 <9d6e431e-fa07-63b6-81fc-6b00c7e8267e@arm.com>
Message-ID: <20180305154742.000029c0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> >> +/**
> >> + * scmi_one_xfer_get() - Allocate one message
> >> + *
> >> + * @handle: SCMI entity handle
> >> + *
> >> + * Helper function which is used by various command functions that are
> >> + * exposed to clients of this driver for allocating a message traffic event.
> >> + *
> >> + * This function can sleep depending on pending requests already in the system
> >> + * for the SCMI entity. Further, this also holds a spinlock to maintain
> >> + * integrity of internal data structures.
> >> + *
> >> + * Return: 0 if all went fine, else corresponding error.
> >> + */
> >> +static struct scmi_xfer *scmi_one_xfer_get(const struct scmi_handle *handle)  
> > Maybe it's just me, but I think this would be more clearly named as
> > scmi_xfer_alloc.
> >   
> 
> Agreed to some extent. The reason I didn't have it as alloc as they are
> preallocated and this just returns a reference to free slot in that
> preallocated array.
> 
> > I'd assume we were dealing with one anyway as it's not called scmi_xfers_get
> > and the get to my mind implies a reference counter rather than allocating
> > an xfer for use...
> >   
> 
> Ah OK, I get your concerne with _get/_put but _alloc/_free is equally
> bad then in the contect of preallocated buffers.
Sure, this is always a fun question.  Lots of other options
_assign _deassign works but never feels nice.

> 
...
> 
> >> +	.max_msg = 20,		/* Limited by MBOX_TX_QUEUE_LEN */
> >> +	.max_msg_size = 128,
> >> +};
> >> +
> >> +/* Each compatible listed below must have descriptor associated with it */
> >> +static const struct of_device_id scmi_of_match[] = {
> >> +	{ .compatible = "arm,scmi", .data = &scmi_generic_desc },
> >> +	{ /* Sentinel */ },
> >> +};
> >> +
> >> +MODULE_DEVICE_TABLE(of, scmi_of_match);
> >> +
> >> +static int scmi_xfer_info_init(struct scmi_info *sinfo)
> >> +{
> >> +	int i;
> >> +	struct scmi_xfer *xfer;
> >> +	struct device *dev = sinfo->dev;
> >> +	const struct scmi_desc *desc = sinfo->desc;
> >> +	struct scmi_xfers_info *info = &sinfo->minfo;
> >> +
> >> +	/* Pre-allocated messages, no more than what hdr.seq can support */
> >> +	if (WARN_ON(desc->max_msg >= (MSG_TOKEN_ID_MASK + 1))) {
> >> +		dev_err(dev, "Maximum message of %d exceeds supported %d\n",
> >> +			desc->max_msg, MSG_TOKEN_ID_MASK + 1);
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	info->xfer_block = devm_kcalloc(dev, desc->max_msg,
> >> +					sizeof(*info->xfer_block), GFP_KERNEL);
> >> +	if (!info->xfer_block)
> >> +		return -ENOMEM;
> >> +
> >> +	info->xfer_alloc_table = devm_kcalloc(dev, BITS_TO_LONGS(desc->max_msg),
> >> +					      sizeof(long), GFP_KERNEL);
> >> +	if (!info->xfer_alloc_table)
> >> +		return -ENOMEM;  
> > Hmm. I wonder if it is worth adding a devm_bitmap_alloc?
> >   
> 
> OK
> 
> >> +
> >> +	bitmap_zero(info->xfer_alloc_table, desc->max_msg);  
> > kcalloc zeros the memory.
> >   
> >> +
> >> +	/* Pre-initialize the buffer pointer to pre-allocated buffers */
> >> +	for (i = 0, xfer = info->xfer_block; i < desc->max_msg; i++, xfer++) {
> >> +		xfer->rx.buf = devm_kcalloc(dev, sizeof(u8), desc->max_msg_size,
> >> +					    GFP_KERNEL);
> >> +		if (!xfer->rx.buf)
> >> +			return -ENOMEM;
> >> +
> >> +		xfer->tx.buf = xfer->rx.buf;
> >> +		init_completion(&xfer->done);
> >> +	}
> >> +
> >> +	spin_lock_init(&info->xfer_lock);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int scmi_mailbox_check(struct device_node *np)
> >> +{
> >> +	struct of_phandle_args arg;
> >> +
> >> +	return of_parse_phandle_with_args(np, "mboxes", "#mbox-cells", 0, &arg);
> >> +}
> >> +
> >> +static int scmi_mbox_free_channel(struct scmi_info *info)  
> > Some of the naming in here could do with being adjusted to be obviously
> > 'balanced'.  The moment I see a free I expect a matched alloc but in this
> > case the alloc is done in scmi_mbox_chan_setup which at very least
> > should be scmi_mbox_setup_channel and should really imply that it is
> > doing allocation as well.
> >   
> 
> That's inline with mailbox APIs.

oh goody.  Fair enough if ugly
> 
...
> OK
