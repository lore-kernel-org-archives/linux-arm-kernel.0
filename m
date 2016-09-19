From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 19 Sep 2016 16:24:57 +0100
Subject: [PATCH v3 2/8] scpi: Add alternative legacy structures, functions
 and macros
In-Reply-To: <1473262477-18045-3-git-send-email-narmstrong@baylibre.com>
References: <1473262477-18045-1-git-send-email-narmstrong@baylibre.com>
 <1473262477-18045-3-git-send-email-narmstrong@baylibre.com>
Message-ID: <da2f9471-4b54-c4cd-c3c2-de09fca52ab6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/09/16 16:34, Neil Armstrong wrote:
> In order to support the legacy SCPI protocol variant, add back the structures
> and macros that varies against the final specification.
> Add indirection table for legacy commands.
> Add bitmap field for channel selection
> Add support for legacy in scpi_send_message.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/firmware/arm_scpi.c | 218 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 211 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
> index 9a87687..9ba1020 100644
> --- a/drivers/firmware/arm_scpi.c
> +++ b/drivers/firmware/arm_scpi.c

[..]

> @@ -336,6 +424,39 @@ static void scpi_handle_remote_msg(struct mbox_client *c, void *msg)
>  	scpi_process_cmd(ch, cmd);
>  }
>
> +static void legacy_scpi_process_cmd(struct scpi_chan *ch)
> +{
> +	unsigned long flags;
> +	struct scpi_xfer *t;
> +
> +	spin_lock_irqsave(&ch->rx_lock, flags);
> +	if (list_empty(&ch->rx_pending)) {
> +		spin_unlock_irqrestore(&ch->rx_lock, flags);
> +		return;
> +	}
> +
> +	t = list_first_entry(&ch->rx_pending, struct scpi_xfer, node);
> +	list_del(&t->node);
> +

This is a bad assumption that it will be always first. The legacy SCPI
did support multiple commands at a time and they can be reordered when
SCP responds to them. Except this it's almost same scpi_process_cmd. You
should be able to use it as is if you pass the command.

> +	/* check if wait_for_completion is in progress or timed-out */
> +	if (t && !completion_done(&t->done)) {
> +		struct legacy_scpi_shared_mem *mem = ch->rx_payload;
> +		unsigned int len = t->rx_len;
> +
> +		t->status = le32_to_cpu(mem->status);
> +		memcpy_fromio(t->rx_buf, mem->payload, len);
> +		complete(&t->done);
> +	}
> +	spin_unlock_irqrestore(&ch->rx_lock, flags);
> +}
> +
> +static void legacy_scpi_handle_remote_msg(struct mbox_client *c, void *_msg)
> +{
> +	struct scpi_chan *ch = container_of(c, struct scpi_chan, cl);
> +
> +	legacy_scpi_process_cmd(ch);

You will get the command in *_msg IIRC. So you can just pass that to
scpi_process_cmd. You can even reuse scpi_handle_remote_msg

diff --git i/drivers/firmware/arm_scpi.c w/drivers/firmware/arm_scpi.c
index edf1a3327041..165f2fc3b627 100644
--- i/drivers/firmware/arm_scpi.c
+++ w/drivers/firmware/arm_scpi.c
@@ -419,7 +419,12 @@ static void scpi_handle_remote_msg(struct 
mbox_client *c, void *msg)
  {
         struct scpi_chan *ch = container_of(c, struct scpi_chan, cl);
         struct scpi_shared_mem *mem = ch->rx_payload;
-       u32 cmd = le32_to_cpu(mem->command);
+       u32 cmd;
+
+       if (ch->is_legacy)
+               cmd = *(u32 *)msg;
+       else
+               cmd = le32_to_cpu(mem->command);

         scpi_process_cmd(ch, cmd);
  }

> +}
> +
>  static void scpi_tx_prepare(struct mbox_client *c, void *msg)
>  {
>  	unsigned long flags;
> @@ -356,6 +477,21 @@ static void scpi_tx_prepare(struct mbox_client *c, void *msg)
>  	mem->command = cpu_to_le32(t->cmd);
>  }
>
> +static void legacy_scpi_tx_prepare(struct mbox_client *c, void *msg)
> +{
> +	unsigned long flags;
> +	struct scpi_xfer *t = msg;
> +	struct scpi_chan *ch = container_of(c, struct scpi_chan, cl);
> +
> +	if (t->tx_buf)
> +		memcpy_toio(ch->tx_payload, t->tx_buf, t->tx_len);
> +	if (t->rx_buf) {
> +		spin_lock_irqsave(&ch->rx_lock, flags);
> +		list_add_tail(&t->node, &ch->rx_pending);
> +		spin_unlock_irqrestore(&ch->rx_lock, flags);
> +	}
> +}

Again here the only difference is token addition. I think we should
retain that as it's helpful in debugging and I don't think it will have
any issues. Worst case we can make it conditional but let's check if we
can retain it first.

> @@ -386,15 +522,25 @@ static int scpi_send_message(u8 cmd, void *tx_buf, unsigned int tx_len,
>  	struct scpi_xfer *msg;
>  	struct scpi_chan *scpi_chan;
>
> -	chan = atomic_inc_return(&scpi_info->next_chan) % scpi_info->num_chans;
> +	if (scpi_info->is_legacy)
> +		chan = test_bit(cmd, scpi_info->cmd_priority) ? 1 : 0;
> +	else
> +		chan = atomic_inc_return(&scpi_info->next_chan) %
> +			scpi_info->num_chans;
>  	scpi_chan = scpi_info->channels + chan;
>
>  	msg = get_scpi_xfer(scpi_chan);
>  	if (!msg)
>  		return -ENOMEM;
>
> -	msg->slot = BIT(SCPI_SLOT);
> -	msg->cmd = PACK_SCPI_CMD(cmd, tx_len);
> +	if (scpi_info->is_legacy) {
> +		mutex_lock(&scpi_chan->xfers_lock);

Why does legacy need a different locking scheme ?

[...]

> @@ -635,6 +804,24 @@ static int scpi_sensor_get_value(u16 sensor, u64 *val)
>  	return ret;
>  }
>
> +static int legacy_scpi_sensor_get_value(u16 sensor, u64 *val)
> +{
> +	__le16 id = cpu_to_le16(sensor);
> +	struct sensor_value buf;
> +	int ret;
> +
> +	ret = check_cmd(CMD_SENSOR_VALUE);
> +	if (ret)
> +		return ret;
> +
> +	ret = scpi_send_message(scpi_info->scpi_cmds[CMD_SENSOR_VALUE],
> +				&id, sizeof(id), &buf, sizeof(buf));
> +	if (!ret)
> +		*val = (u64)le32_to_cpu(buf.lo_val);
> +

This is not needed as it's backward compatible as discussed before.
Any particular reason you retained it here ?

-- 
Regards,
Sudeep
