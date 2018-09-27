From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 27 Sep 2018 09:55:00 +0200
Subject: [PATCH v23 4/4] soc: mediatek: Add Mediatek CMDQ helper
In-Reply-To: <1534297570.21668.3.camel@mhfsdcap03>
References: <1532482002-11164-1-git-send-email-houlong.wei@mediatek.com>
 <1532482002-11164-5-git-send-email-houlong.wei@mediatek.com>
 <1534297570.21668.3.camel@mhfsdcap03>
Message-ID: <23d76d03-c0e9-cd83-f9a8-f5efa0c72938@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 15/08/2018 03:46, houlong wei wrote:
[...]
>> +
>> +static int cmdq_pkt_append_command(struct cmdq_pkt *pkt, enum cmdq_code code,
>> +				   u32 arg_a, u32 arg_b)
>> +{
>> +	u64 *cmd_ptr;
>> +
>> +	if (unlikely(pkt->cmd_buf_size + CMDQ_INST_SIZE > pkt->buf_size)) {
>> +		pkt->cmd_buf_size += CMDQ_INST_SIZE;
>> +		return -ENOMEM;
>> +	}
>> +	cmd_ptr = pkt->va_base + pkt->cmd_buf_size;
>> +	(*cmd_ptr) = (u64)((code << CMDQ_OP_CODE_SHIFT) | arg_a) << 32 | arg_b;
>> +	pkt->cmd_buf_size += CMDQ_INST_SIZE;
>> +
>> +	return 0;
>> +}
>> +
>> +int cmdq_pkt_write(struct cmdq_pkt *pkt, u32 value, u32 subsys, u32 offset)
>> +{
>> +	u32 arg_a = (offset & CMDQ_ARG_A_WRITE_MASK) |
>> +		    (subsys << CMDQ_SUBSYS_SHIFT);
>> +
>> +	return cmdq_pkt_append_command(pkt, CMDQ_CODE_WRITE, arg_a, value);
>> +}
>> +EXPORT_SYMBOL(cmdq_pkt_write);
>> +
>> +int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 value,
>> +			u32 subsys, u32 offset, u32 mask)
>> +{
>> +	u32 offset_mask = offset;
>> +	int err;
>> +
>> +	if (mask != 0xffffffff) {
>> +		err = cmdq_pkt_append_command(pkt, CMDQ_CODE_MASK, 0, ~mask);
>> +		WARN_ON(err < 0);

If we want to write out a warning to the kernel log, then we should but that in
the if (unlikely(pkt->cmd_buf_size + CMDQ_INST_SIZE > pkt->buf_size)) from
cmdq_pkt_append_command to make it consistent between cmdq_pkt_write,
cmdq_pkt_write_mask and cmdq_pkt_finalize

Sorry, just saw this right now.

>> +		offset_mask |= CMDQ_WRITE_ENABLE_MASK;
>> +	}
>> +
>> +	return cmdq_pkt_write(pkt, value, subsys, offset_mask);
>> +}
>> +EXPORT_SYMBOL(cmdq_pkt_write_mask);
>> +
>> +int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u32 event)
>> +{
>> +	u32 arg_b;
>> +
>> +	if (event >= CMDQ_MAX_EVENT)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * WFE arg_b
>> +	 * bit 0-11: wait value
>> +	 * bit 15: 1 - wait, 0 - no wait
>> +	 * bit 16-27: update value
>> +	 * bit 31: 1 - update, 0 - no update
>> +	 */
>> +	arg_b = CMDQ_WFE_UPDATE | CMDQ_WFE_WAIT | CMDQ_WFE_WAIT_VALUE;
>> +
>> +	return cmdq_pkt_append_command(pkt, CMDQ_CODE_WFE, event, arg_b);
>> +}
>> +EXPORT_SYMBOL(cmdq_pkt_wfe);
>> +
>> +int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u32 event)
>> +{
>> +	if (event >= CMDQ_MAX_EVENT)
>> +		return -EINVAL;
>> +
>> +	return cmdq_pkt_append_command(pkt, CMDQ_CODE_WFE, event,
>> +				       CMDQ_WFE_UPDATE);
>> +}
>> +EXPORT_SYMBOL(cmdq_pkt_clear_event);
>> +
>> +static int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
>> +{
>> +	int err;
>> +
>> +	/* insert EOC and generate IRQ for each command iteration */
>> +	err = cmdq_pkt_append_command(pkt, CMDQ_CODE_EOC, 0, CMDQ_EOC_IRQ_EN);
>> +	WARN_ON(err < 0);

Should move into cmdq_pkt_append_command

>> +
>> +	/* JUMP to end */
>> +	err = cmdq_pkt_append_command(pkt, CMDQ_CODE_JUMP, 0, CMDQ_JUMP_PASS);
>> +	WARN_ON(err < 0);

same here.

>> +
>> +	return err;
>> +}
>> +
[...]

Regards,
Matthias
