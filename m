From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 1 Mar 2014 14:50:03 +0100
Subject: [PATCH v3 01/20] clk: shmobile: r8a7779: Add clocks support
In-Reply-To: <1393400016-23433-2-git-send-email-horms+renesas@verge.net.au>
References: <1393400016-23433-1-git-send-email-horms+renesas@verge.net.au>
 <1393400016-23433-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20140301135002.GA4307@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> +	cpg = kzalloc(sizeof(*cpg), GFP_KERNEL);
> +	clks = kzalloc(CPG_NUM_CLOCKS * sizeof(*clks), GFP_KERNEL);
> +	if (cpg == NULL || clks == NULL) {
> +		/* We're leaking memory on purpose, there's no point in cleaning
> +		 * up as the system won't boot anyway.
> +		 */
> +		pr_err("%s: failed to allocate cpg\n", __func__);
> +		return;
> +	}

I have problems with this sloppiness. Writing the comment took probably
the same time as writing the proper exit path :) On the drawback side,
static code checkers will keep reporting this.

> +	cpg->reg = of_iomap(np, 0);
> +	if (WARN_ON(cpg->reg == NULL))
> +		return;

if (WARN(!cpg->reg, "can't ioremap CPG\n"))

?

> diff --git a/include/linux/clk/shmobile.h b/include/linux/clk/shmobile.h
> index f9bf080..7667f49 100644
> --- a/include/linux/clk/shmobile.h
> +++ b/include/linux/clk/shmobile.h
> @@ -1,7 +1,9 @@
>  /*
>   * Copyright 2013 Ideas On Board SPRL
> + * Copyright 2013 Horms Solutions Ltd.
>   *
>   * Contact: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> + * Contact: Simon Horman <horms@verge.net.au>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
> @@ -14,6 +16,7 @@
>  
>  #include <linux/types.h>
>  
> +void r8a7779_clocks_init(u32 mode);
>  void rcar_gen2_clocks_init(u32 mode);

Shouldn't the init functions be protected by #ifdef CONFIG_ARCH...?

Regards,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140301/44525a28/attachment.sig>
