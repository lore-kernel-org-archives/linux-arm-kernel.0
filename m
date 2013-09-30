From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 30 Sep 2013 23:34:37 +0200
Subject: [PATCH 3/4] clk: kirkwood: Add CLK_IGNORE_UNUSED to ethernet ge0
 and ge1 clocks
In-Reply-To: <20130930213131.GB10393@obsidianresearch.com>
References: <1380575010-8573-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1380575010-8573-4-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130930213131.GB10393@obsidianresearch.com>
Message-ID: <20130930213437.GG6735@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason

> Our bootloader gates the power and turns off the clock, having Linux
> turn the clock back on without knowing how to control the power seems
> like a possible problem.

This patch won't do that. This patch will stop it getting turn off. It
will never turn it on. The only thing that will turn it on is the
Ethernet driver. So if the bootloader turned it off, it should stay
off.

> I don't have code, but when this was first brought up it was suggested
> to add local-mac-address to the DT nodes if it isn't present in the
> common code and don't mess with the clocks.
> 
> Psudeo code:
> 
> void marvell_dt_ethernet_fixup(void)
> {
>  for_each_compatible_node(np, "marvell,kirkwood-eth-port")
>  {
>    if (of_get_mac_address(np) != NULL)
>       continue;
>    regs = ioremap(of_regs(np->parent,0));
>    address = (readl(regs + MAC_ADDR_HIGH) << 32) | 
>               readl(regs + MAC_ADDR_LOW))
>    iounmap(regs);
>    of_add_property(np, {"local-mac-address" = address});
>  }
> }

The pseudo code looks nice, but i think in reality, the
of_add_property(np, {"local-mac-address" = address}); is not so
simple. Sebastian took a look at this.

	Andrew
