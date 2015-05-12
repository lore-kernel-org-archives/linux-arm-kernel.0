From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 May 2015 17:49:08 +0200
Subject: [PATCH 2/8] dmaengine: mv_xor: add support for a38x command in
 descriptor mode
In-Reply-To: <1431445063-20226-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1431445063-20226-1-git-send-email-maxime.ripard@free-electrons.com>
 <1431445063-20226-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <4862159.g8Sk9nOiS2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 May 2015 17:37:37 Maxime Ripard wrote:
> From: Lior Amsalem <alior@marvell.com>
> 
> The Marvell Armada 38x SoC introduce new features to the XOR engine,
> especially the fact that the engine mode (MEMCPY/XOR/PQ/etc) can be part of
> the descriptor and not set through the controller registers.
> 
> This new feature allows mixing of different commands (even PQ) on the same
> channel/chain without the need to stop the engine to reconfigure the engine
> mode.
> 
> Refactor the driver to be able to use that new feature on the Armada 38x,
> while keeping the old behaviour on the older SoCs.
> 
> Signed-off-by: Lior Amsalem <alior@marvell.com>
> Reviewed-by: Ofer Heifetz <oferh@marvell.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Two minimal style comments:

> +static void mv_chan_set_mode_to_desc(struct mv_xor_chan *chan)
> +{
> +	u32 op_mode;
> +	u32 config = readl_relaxed(XOR_CONFIG(chan));
> +
> +	op_mode = XOR_OPERATION_MODE_IN_DESC;
> +
> +	config &= ~0x7;
> +	config |= op_mode;
> +
> +#if defined(__BIG_ENDIAN)
> +	config |= XOR_DESCRIPTOR_SWAP;
> +#else
> +	config &= ~XOR_DESCRIPTOR_SWAP;
> +#endif
> +
> +	writel_relaxed(config, XOR_CONFIG(chan));
> +}

Using 

	if (IS_ENABLED(__BIG_ENDIAN))

here would make it more readable by avoiding the #if. Alternatively,
you could leave the XOR_DESCRIPTOR_SWAP flag disabled and just swap
the descriptors manually like a lot of other drivers do. You have
to swap the mmio accesses anywya.

>  }
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id mv_xor_dt_ids[] = {
> +	{ .compatible = "marvell,orion-xor", .data = (void *)XOR_MODE_IN_REG },
> +	{ .compatible = "marvell,a38x-xor", .data = (void *)XOR_MODE_IN_DESC },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mv_xor_dt_ids);
> +#endif
> +

Just leave out the #ifdef here. Almost all the mvebu machines use DT now,
so it's not worth the size benefit of leaving it out on the few machines
that don't.

You'll have to remove the of_match_ptr() invocation as well if you do that,
to avoid a warning about an unused symbol.

	Arnd
