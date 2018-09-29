From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Sat, 29 Sep 2018 14:50:35 +0200
Subject: [PATCH v25 2/2] soc: mediatek: Add Mediatek CMDQ helper
In-Reply-To: <1538212903-14331-3-git-send-email-houlong.wei@mediatek.com>
References: <1538212903-14331-1-git-send-email-houlong.wei@mediatek.com>
 <1538212903-14331-3-git-send-email-houlong.wei@mediatek.com>
Message-ID: <7040427b-f580-ec33-8afa-35dcf5735abb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 29/09/2018 11:21, Houlong Wei wrote:
[...]

> +static int cmdq_pkt_append_command(struct cmdq_pkt *pkt, enum cmdq_code code,
> +				   u32 arg_a, u32 arg_b)
> +{
> +	u64 *cmd_ptr;
> +
> +	if (unlikely(pkt->cmd_buf_size + CMDQ_INST_SIZE > pkt->buf_size)) {
> +		pkt->cmd_buf_size += CMDQ_INST_SIZE;

Can you plesae provide some example code of a driver that will use this API, I
still don't understand why you need to update the cmd_buf_size here.

> +		WARN_ON(1);

can we add some debug information:
WARN_ON(1, "%s: buffer size too small for the amount of commands", __func__);

Would it make sense to use WARN_ONCE()?

> +		return -ENOMEM;
> +	}
> +	cmd_ptr = pkt->va_base + pkt->cmd_buf_size;
> +	(*cmd_ptr) = (u64)((code << CMDQ_OP_CODE_SHIFT) | arg_a) << 32 | arg_b;
> +	pkt->cmd_buf_size += CMDQ_INST_SIZE;
> +
> +	return 0;
> +}

Thanks,
Matthias
