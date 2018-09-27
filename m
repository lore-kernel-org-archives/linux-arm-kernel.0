From: houlong.wei@mediatek.com (houlong wei)
Date: Thu, 27 Sep 2018 18:30:46 +0800
Subject: [PATCH v23 4/4] soc: mediatek: Add Mediatek CMDQ helper
In-Reply-To: <3773f620-e135-578d-5307-08483436f4c2@gmail.com>
References: <1532482002-11164-1-git-send-email-houlong.wei@mediatek.com>
 <1532482002-11164-5-git-send-email-houlong.wei@mediatek.com>
 <ca12e8ab-e3d1-1cf0-8fe9-756d57bd5a3a@gmail.com>
 <1538013431.17514.31.camel@mhfsdcap03>
 <3773f620-e135-578d-5307-08483436f4c2@gmail.com>
Message-ID: <1538044246.17514.51.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-09-27 at 15:50 +0800, Matthias Brugger wrote:
> 
> On 27/09/2018 03:57, houlong wei wrote:
[...]
> >>> +
> >>> +static int cmdq_pkt_append_command(struct cmdq_pkt *pkt, enum cmdq_code code,
> >>> +				   u32 arg_a, u32 arg_b)
> >>> +{
> >>> +	u64 *cmd_ptr;
> >>> +
> >>> +	if (unlikely(pkt->cmd_buf_size + CMDQ_INST_SIZE > pkt->buf_size)) {
> >>> +		pkt->cmd_buf_size += CMDQ_INST_SIZE;
> >>
> >> Why do we update the cmd_buf_size here?
> > 
> > Because in developing phase of consumer driver, the consumer has to know
> > the real command buffer size after adding command failure. Then the
> > consumer will increase the size and run the cmdq flow (cmdq_pkt_create,
> > cmdq_pkt_write/wfe...) again. Finally, the consumer get the real size
> > and fix it.
> > 
> 
> But the consumer should know the size it needs for it's buffer and if not it
> should be able to decide on it's own how much space it needs. If he get's a
> -ENOMEM he implicitly knows that he has to increase the buf_size. Now the size
> depends on how many command he has pending and wasn't able to write to the cmdq_pkt.
> 
> Regards,
> Matthias

The consumer doesn't know how to calculate the command buffer size that
he needs.
When the consumer driver is developing, he could ignore the return value
of cmdq_pkt_write and other command appending functions.
He can print the pkt->cmdq_buf_size after cmdq_pkt_flush() or
cmdq_pkt_flush_async() failure. Now he can get the buffer size he needs.

I copy your another comment here, so I can reply in one mail.
>>If we want to write out a warning to the kernel log, then we should
>>but that in the if (unlikely(pkt->cmd_buf_size + CMDQ_INST_SIZE
>>pkt->buf_size)) from cmdq_pkt_append_command to make it consistent
>>between cmdq_pkt_write, cmdq_pkt_write_mask and cmdq_pkt_finalize.

Thanks, I will move WARN_ON() into cmdq_pkt_append_command() before
returning -ENOMEM.

After your confirmation of the comments above, I will re-send a new
patch.
