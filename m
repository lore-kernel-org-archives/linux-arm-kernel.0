From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Feb 2017 10:54:34 +0100 (CET)
Subject: [RFC PATCH 03/33] irqchip/gic-v3-its: Refactor command
 encoding
In-Reply-To: <1484648454-21216-4-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.20.1702131039340.3619@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Jan 2017, Marc Zyngier wrote:
> +static void its_mask_encode(u64 *raw_cmd, u64 val, int h, int l)

I'd rather name h/l in a way which makes it clear that they are describing
a bit range. msb/lsb perhaps.

> +{
> +	u64 mask = GENMASK_ULL(h, l);

New line missing here.

> +	*raw_cmd &= ~mask;
> +	*raw_cmd |= (val << l) & mask;
> +}
> +
>  static void its_encode_cmd(struct its_cmd_block *cmd, u8 cmd_nr)
>  {
> -	cmd->raw_cmd[0] &= ~0xffULL;
> -	cmd->raw_cmd[0] |= cmd_nr;
> +	its_mask_encode(&cmd->raw_cmd[0], cmd_nr, 7, 0);

I assume that the manual provides a name for these bit ranges. Wouldn't it
be helpful to use them in these functions?

Looks good otherwise.

Thanks,

	tglx
