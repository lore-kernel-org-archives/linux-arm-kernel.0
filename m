From: houlong.wei@mediatek.com (houlong wei)
Date: Mon, 8 Oct 2018 10:29:06 +0800
Subject: [PATCH v25 2/2] soc: mediatek: Add Mediatek CMDQ helper
In-Reply-To: <7040427b-f580-ec33-8afa-35dcf5735abb@gmail.com>
References: <1538212903-14331-1-git-send-email-houlong.wei@mediatek.com>
 <1538212903-14331-3-git-send-email-houlong.wei@mediatek.com>
 <7040427b-f580-ec33-8afa-35dcf5735abb@gmail.com>
Message-ID: <1538965746.4271.20.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2018-09-29 at 20:50 +0800, Matthias Brugger wrote:
> 
> On 29/09/2018 11:21, Houlong Wei wrote:
> [...]
> 
> > +static int cmdq_pkt_append_command(struct cmdq_pkt *pkt, enum cmdq_code code,
> > +				   u32 arg_a, u32 arg_b)
> > +{
> > +	u64 *cmd_ptr;
> > +
> > +	if (unlikely(pkt->cmd_buf_size + CMDQ_INST_SIZE > pkt->buf_size)) {
> > +		pkt->cmd_buf_size += CMDQ_INST_SIZE;
> 
> Can you plesae provide some example code of a driver that will use this API, I
> still don't understand why you need to update the cmd_buf_size here.

In our previous design, when appending a new command to buffer and the
buffer gets overflow, we will re-allocate a larger buffer to use.
CK.Hu had concern about the performance of buffer re-allocation. Please
refer:
http://lists.infradead.org/pipermail/linux-mediatek/2018-June/013797.html
One of his suggestions is that the consumer dynamically allocates buffer
with a initial size. Because the consumer doesn't know how to calculate
the buffer size. So we increase cmdq_buf_size here, that will help the
consumer get the buffer size in developing phase. In release driver
code, consumer passes a constant value to function call
cmdq_pkt_create(client, cmdq_buffer_size), cmdq_buffer_size is the
specified command queue buffer size.

> 
> > +		WARN_ON(1);
> 
> can we add some debug information:
> WARN_ON(1, "%s: buffer size too small for the amount of commands", __func__);
> 
> Would it make sense to use WARN_ONCE()?
> 
Yes, I will add debug information and use WARN_ONCE().

> > +		return -ENOMEM;
> > +	}
> > +	cmd_ptr = pkt->va_base + pkt->cmd_buf_size;
> > +	(*cmd_ptr) = (u64)((code << CMDQ_OP_CODE_SHIFT) | arg_a) << 32 | arg_b;
> > +	pkt->cmd_buf_size += CMDQ_INST_SIZE;
> > +
> > +	return 0;
> > +}
> 
> Thanks,
> Matthias
