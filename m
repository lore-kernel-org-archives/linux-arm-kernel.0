From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 10 Oct 2016 15:36:34 +0100
Subject: [PATCH v4 2/8] scpi: Add alternative legacy structures, functions
 and macros
In-Reply-To: <1475652814-30619-3-git-send-email-narmstrong@baylibre.com>
References: <1475652814-30619-1-git-send-email-narmstrong@baylibre.com>
 <1475652814-30619-3-git-send-email-narmstrong@baylibre.com>
Message-ID: <7bf3b68c-19aa-85c3-8b20-66b7380eaf3f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

Sorry, I could not reply to your response on v3. Anyways I will review v4.

On 05/10/16 08:33, Neil Armstrong wrote:
> This patch adds support for the Legacy SCPI protocol in early JUNO versions and
> shipped Amlogic ARMv8 based SoCs. Some Rockchip SoC are also known to use this
> version of protocol with extended vendor commands
> .
> In order to support the legacy SCPI protocol variant, add back the structures
> and macros that varies against the final specification.
> Then add indirection table for legacy commands.
> Finally Add bitmap field for channel selection since the Legacy protocol mandates to
> send a selected subset of the commands on the high priority channel instead of the
> low priority channel.
>
> The message sending path differs from the final SCPI procotocol because the
> Amlogic SCP firmware always reply 1 instead of a special value containing the command
> byte and replied rx data length.
> For this reason commands queuing cannot be used and we assume the reply command is
> the head of the rx_pending list since we ensure sequential command sending with a
> separate dedicated mutex.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/firmware/arm_scpi.c | 221 +++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 199 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
> index 498afa0..6244eb1 100644
> --- a/drivers/firmware/arm_scpi.c
> +++ b/drivers/firmware/arm_scpi.c

[...]

> @@ -307,21 +398,46 @@ static void scpi_process_cmd(struct scpi_chan *ch, u32 cmd)
>  		return;
>  	}
>
> -	list_for_each_entry(t, &ch->rx_pending, node)
> -		if (CMD_XTRACT_UNIQ(t->cmd) == CMD_XTRACT_UNIQ(cmd)) {
> -			list_del(&t->node);
> -			match = t;
> -			break;
> -		}
> +	/* Command type is not replied by the SCP Firmware in legacy Mode
> +	 * We should consider that command is the head of pending RX commands
> +	 * if the list is not empty. In TX only mode, the list would be empty.
> +	 */
> +	if (scpi_info->is_legacy) {
> +		match = list_first_entry(&ch->rx_pending, struct scpi_xfer,
> +					 node);
> +		list_del(&match->node);
> +	} else {
> +		list_for_each_entry(t, &ch->rx_pending, node)
> +			if (CMD_XTRACT_UNIQ(t->cmd) == CMD_XTRACT_UNIQ(cmd)) {
> +				list_del(&t->node);
> +				match = t;
> +				break;
> +			}
> +	}
>  	/* check if wait_for_completion is in progress or timed-out */
>  	if (match && !completion_done(&match->done)) {
> -		struct scpi_shared_mem *mem = ch->rx_payload;
> -		unsigned int len = min(match->rx_len, CMD_SIZE(cmd));
> +		unsigned int len;
> +
> +		if (scpi_info->is_legacy) {
> +			struct legacy_scpi_shared_mem *mem = ch->rx_payload;
> +
> +			/* RX Length is not replied by the lagcy Firmware */
> +			len = match->rx_len;
> +
> +			match->status = le32_to_cpu(mem->status);
> +			memcpy_fromio(match->rx_buf, mem->payload, len);

The above 2 seems common to both, no ?

> +		} else {
> +			struct scpi_shared_mem *mem = ch->rx_payload;
> +
> +			len = min(match->rx_len, CMD_SIZE(cmd));
> +
> +			match->status = le32_to_cpu(mem->status);
> +			memcpy_fromio(match->rx_buf, mem->payload, len);
> +		}
>
> -		match->status = le32_to_cpu(mem->status);
> -		memcpy_fromio(match->rx_buf, mem->payload, len);
>  		if (match->rx_len > len)
>  			memset(match->rx_buf + len, 0, match->rx_len - len);
> +

Spurious ?

>  		complete(&match->done);
>  	}
>  	spin_unlock_irqrestore(&ch->rx_lock, flags);
> @@ -331,7 +447,12 @@ static void scpi_handle_remote_msg(struct mbox_client *c, void *msg)
>  {
>  	struct scpi_chan *ch = container_of(c, struct scpi_chan, cl);
>  	struct scpi_shared_mem *mem = ch->rx_payload;
> -	u32 cmd = le32_to_cpu(mem->command);
> +	u32 cmd;
> +
> +	if (scpi_info->is_legacy)
> +		cmd = *(u32 *)msg;

Do we need do this if it doesn't contain command ?

> +	else
> +		cmd = le32_to_cpu(mem->command);
>
>  	scpi_process_cmd(ch, cmd);
>  }
> @@ -343,17 +464,26 @@ static void scpi_tx_prepare(struct mbox_client *c, void *msg)
>  	struct scpi_chan *ch = container_of(c, struct scpi_chan, cl);
>  	struct scpi_shared_mem *mem = (struct scpi_shared_mem *)ch->tx_payload;
>
> -	if (t->tx_buf)
> -		memcpy_toio(mem->payload, t->tx_buf, t->tx_len);
> +	if (t->tx_buf) {
> +		if (scpi_info->is_legacy)
> +			memcpy_toio(ch->tx_payload, t->tx_buf, t->tx_len);
> +		else
> +			memcpy_toio(mem->payload, t->tx_buf, t->tx_len);
> +	}
> +
>  	if (t->rx_buf) {
>  		if (!(++ch->token))
>  			++ch->token;
>  		ADD_SCPI_TOKEN(t->cmd, ch->token);
> +		if (scpi_info->is_legacy)
> +			t->slot = t->cmd;

I thought passing token was not an issue from your previous response,
but you are overriding it here, why ?

>  		spin_lock_irqsave(&ch->rx_lock, flags);
>  		list_add_tail(&t->node, &ch->rx_pending);
>  		spin_unlock_irqrestore(&ch->rx_lock, flags);
>  	}
> -	mem->command = cpu_to_le32(t->cmd);
> +
> +	if (!scpi_info->is_legacy)
> +		mem->command = cpu_to_le32(t->cmd);
>  }
>
>  static struct scpi_xfer *get_scpi_xfer(struct scpi_chan *ch)
> @@ -396,21 +526,37 @@ static int scpi_send_message(unsigned int offset, void *tx_buf,
>
>  	cmd = scpi_info->scpi_cmds[offset];
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
> +		msg->cmd = PACK_LEGACY_SCPI_CMD(cmd, tx_len);
> +		msg->slot = msg->cmd;
> +	} else {
> +		msg->slot = BIT(SCPI_SLOT);
> +		msg->cmd = PACK_SCPI_CMD(cmd, tx_len);
> +	}
>  	msg->tx_buf = tx_buf;
>  	msg->tx_len = tx_len;
>  	msg->rx_buf = rx_buf;
>  	msg->rx_len = rx_len;
>  	init_completion(&msg->done);
>
> +	/* Since we cannot distinguish the original command in the
> +	 * MHU reply stat value from a Legacy SCP firmware, ensure
> +	 * sequential command sending to the firmware.
> +	 */

OK this comment now questions the existence of this extra lock.
The mailbox will always send the commands in the sequential order.
It's only firmware that can re-order the response. Since that can't
happen in you case, I really don't see the need for this.

Please explain the race you would see without this locking. Yes I
understand that only one command is supposed to be sent to firmware at a
time. Suppose you allow more callers here, all will wait on the
completion flags and the first in the list gets unblocked right ?
I am just trying to understand if there's real need for this extra
lock when we already have that from the list.

> +	if (scpi_info->is_legacy)
> +		mutex_lock(&scpi_chan->legacy_lock);
> +
>  	ret = mbox_send_message(scpi_chan->chan, msg);
>  	if (ret < 0 || !rx_buf)
>  		goto out;
> @@ -421,9 +567,13 @@ static int scpi_send_message(unsigned int offset, void *tx_buf,
>  		/* first status word */
>  		ret = msg->status;
>  out:
> -	if (ret < 0 && rx_buf) /* remove entry from the list if timed-out */
> +	if (ret < 0 && rx_buf)
> +		/* remove entry from the list if timed-out */
>  		scpi_process_cmd(scpi_chan, msg->cmd);
>
> +	if (scpi_info->is_legacy)
> +		mutex_unlock(&scpi_chan->legacy_lock);
> +
>  	put_scpi_xfer(msg, scpi_chan);
>  	/* SCPI error codes > 0, translate them to Linux scale*/
>  	return ret > 0 ? scpi_to_linux_errno(ret) : ret;

[...]

> @@ -525,7 +687,6 @@ static struct scpi_dvfs_info *scpi_dvfs_get_info(u8 domain)
>
>  	info->count = DVFS_OPP_COUNT(buf.header);
>  	info->latency = DVFS_LATENCY(buf.header) * 1000; /* uS to nS */
> -

Spurious ?

>  	info->opps = kcalloc(info->count, sizeof(*opp), GFP_KERNEL);
>  	if (!info->opps) {
>  		kfree(info);
> @@ -580,9 +741,13 @@ static int scpi_sensor_get_value(u16 sensor, u64 *val)
>
>  	ret = scpi_send_message(CMD_SENSOR_VALUE, &id, sizeof(id),
>  				&buf, sizeof(buf));
> -	if (!ret)
> -		*val = (u64)le32_to_cpu(buf.hi_val) << 32 |
> -			le32_to_cpu(buf.lo_val);
> +	if (!ret) {
> +		if (scpi_info->is_legacy)
> +			*val = (u64)le32_to_cpu(buf.lo_val);
> +		else
> +			*val = (u64)le32_to_cpu(buf.hi_val) << 32 |
> +				le32_to_cpu(buf.lo_val);
> +	}

Not required as I have mentioned couple of times in previous versions,
it's zero filled by the driver.

-- 
Regards,
Sudeep
