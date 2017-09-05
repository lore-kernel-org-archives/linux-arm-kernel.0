From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 5 Sep 2017 11:26:16 +0100
Subject: [PATCH v2 03/18] firmware: arm_scmi: add basic driver
 infrastructure for SCMI
In-Reply-To: <e05e75d4-e4ec-41b0-6983-63afeddd82f6@arm.com>
References: <1501857104-11279-1-git-send-email-sudeep.holla@arm.com>
 <1501857104-11279-4-git-send-email-sudeep.holla@arm.com>
 <e05e75d4-e4ec-41b0-6983-63afeddd82f6@arm.com>
Message-ID: <e566e6b9-fc0e-bafd-4549-beb03d17adf5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julien,

Thanks for reviewing this.

On 05/09/17 11:03, Julien Thierry wrote:
> Hi Sudeep,
> 
> I am not sure what the patch does is correct when having a big endian
> kernel dealing with scmi_shared_mem. Unless there is a reason not to
> have SCMI with big endian kernel, please see remarks below.
> 

No the intention at least is to have it working even with big endian
kernel. I found couple of issues when testing after this was posted.
They are already fixed in [1]


[...]

>> +/**
>> + * scmi_rx_callback() - mailbox client callback for receive messages
>> + *
>> + * @cl: client pointer
>> + * @m: mailbox message
>> + *
>> + * Processes one received message to appropriate transfer information
>> and
>> + * signals completion of the transfer.
>> + *
>> + * NOTE: This function will be invoked in IRQ context, hence should be
>> + * as optimal as possible.
>> + */
>> +static void scmi_rx_callback(struct mbox_client *cl, void *m)
>> +{
>> +    u16 xfer_id;
>> +    struct scmi_xfer *xfer;
>> +    struct scmi_info *info = client_to_scmi_info(cl);
>> +    struct scmi_xfers_info *minfo = &info->minfo;
>> +    struct device *dev = info->dev;
>> +    struct scmi_shared_mem *mem = info->tx_payload;
>> +
>> +    xfer_id = MSG_XTRACT_TOKEN(mem->msg_header);
>> +
> 
> Don't we need to convert msg_header to cpu endian?
> 

Indeed, already fixed as mentioned above.

>> +    /*
>> +     * Are we even expecting this?
>> +     */
>> +    if (!test_bit(xfer_id, minfo->xfer_alloc_table)) {
>> +        dev_err(dev, "message for %d is not expected!\n", xfer_id);
>> +        return;
>> +    }
>> +
>> +    xfer = &minfo->xfer_block[xfer_id];
>> +
>> +    scmi_dump_header_dbg(dev, &xfer->hdr);
>> +    /* Is the message of valid length? */
>> +    if (xfer->rx.len > info->desc->max_msg_size) {
>> +        dev_err(dev, "unable to handle %zu xfer(max %d)\n",
>> +            xfer->rx.len, info->desc->max_msg_size);
>> +        return;
>> +    }
>> +
>> +    scmi_fetch_response(xfer, mem);
>> +    complete(&xfer->done);
>> +}
>> +
>> +/**
>> + * pack_scmi_header() - packs and returns 32-bit header
>> + *
>> + * @hdr: pointer to header containing all the information on message id,
>> + *    protocol id and sequence id.
>> + */
>> +static inline u32 pack_scmi_header(struct scmi_msg_hdr *hdr)
>> +{
>> +    return ((hdr->id & MSG_ID_MASK) << MSG_ID_SHIFT) |
>> +       ((hdr->seq & MSG_TOKEN_ID_MASK) << MSG_TOKEN_ID_SHIFT) |
>> +       ((hdr->protocol_id & MSG_PROTOCOL_ID_MASK) <<
>> MSG_PROTOCOL_ID_SHIFT);
>> +}
>> +
>> +/**
>> + * scmi_tx_prepare() - mailbox client callback to prepare for the
>> transfer
>> + *
>> + * @cl: client pointer
>> + * @m: mailbox message
>> + *
>> + * This function prepares the shared memory which contains the header
>> and the
>> + * payload.
>> + */
>> +static void scmi_tx_prepare(struct mbox_client *cl, void *m)
>> +{
>> +    struct scmi_xfer *t = m;
>> +    struct scmi_info *info = client_to_scmi_info(cl);
>> +    struct scmi_shared_mem *mem = info->tx_payload;
>> +
>> +    mem->channel_status = 0x0; /* Mark channel busy + clear error */
>> +    mem->flags = t->hdr.poll_completion ? 0 :
>> SCMI_SHMEM_FLAG_INTR_ENABLED;
>> +    mem->length = sizeof(mem->msg_header) + t->tx.len;
>> +    mem->msg_header = cpu_to_le32(pack_scmi_header(&t->hdr));
>> +    if (t->tx.buf)
>> +        memcpy_toio(mem->msg_payload, t->tx.buf, t->tx.len);
>> +}
> 
> I thought every member of scmi_shared_mem should be in le, not just the
> header.
> If that is the case, why do mem->length and mem->flags not get converted
> to le?
> If it is not the case, should they be of type __le32?
> 
> (same remark applies in scmi_fetch_response for mem->length)
> 

Agreed and already fixed, sorry for that. I am planning to repost after
4.14-rc1. and hence waiting with fixes.

>> +
>> +/**
>> + * scmi_one_xfer_get() - Allocate one message
>> + *
>> + * @handle: SCMI entity handle
>> + *
>> + * Helper function which is used by various command functions that are
>> + * exposed to clients of this driver for allocating a message traffic
>> event.
>> + *
>> + * This function can sleep depending on pending requests already in
>> the system
>> + * for the SCMI entity. Further, this also holds a spinlock to maintain
>> + * integrity of internal data structures.
>> + *
>> + * Return: 0 if all went fine, else corresponding error.
>> + */
>> +static struct scmi_xfer *scmi_one_xfer_get(const struct scmi_handle
>> *handle)
>> +{
>> +    u16 xfer_id;
>> +    int ret, timeout;
>> +    struct scmi_xfer *xfer;
>> +    unsigned long flags, bit_pos;
>> +    struct scmi_info *info = handle_to_scmi_info(handle);
>> +    struct scmi_xfers_info *minfo = &info->minfo;
>> +
>> +    /*
>> +     * Ensure we have only controlled number of pending messages.
>> +     * Ideally, we might just have to wait a single message, be
>> +     * conservative and wait 5 times that..
>> +     */
>> +    timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms) * 5;
>> +    ret = down_timeout(&minfo->sem_xfer_count, timeout);
>> +    if (ret < 0)
>> +        return ERR_PTR(ret);
>> +
>> +    /* Keep the locked section as small as possible */
>> +    spin_lock_irqsave(&minfo->xfer_lock, flags);
>> +    bit_pos = find_first_zero_bit(minfo->xfer_alloc_table,
>> +                      info->desc->max_msg);
>> +    if (bit_pos == info->desc->max_msg) {
>> +        spin_unlock_irqrestore(&minfo->xfer_lock, flags);
>> +        return ERR_PTR(-ENOMEM);
>> +    }
>> +    set_bit(bit_pos, minfo->xfer_alloc_table);
>> +    spin_unlock_irqrestore(&minfo->xfer_lock, flags);
>> +
> 
> Is it needed to disable IRQs here? Since the callback called in IRQ
> context only reads the xfer_alloc_table without modification nor taking
> locks, can't we just do spin_lock/spin_unlock?
> 

Yes we can for now. I started adding notification support where we may
need to allocate(i.e. assign from the pre-allocated buffer) in IRQ
context. I left it as is though I removed notifications as I haven't
tested it.

-- 
Regards,
Sudeep

[1] https://git.kernel.org/sudeep.holla/linux/h/for-list/arm_scmi
