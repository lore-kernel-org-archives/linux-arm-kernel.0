From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Mon, 22 Aug 2011 16:19:17 +0200
Subject: plat-orion problems with mv643xx_eth.c for mv78xx0
In-Reply-To: <4E4C30ED.9030902@drewtech.com>
References: <4E4C30ED.9030902@drewtech.com>
Message-ID: <20110822141917.GJ840@wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 17, 2011 at 05:21:49PM -0400, Joey Oravec wrote:

> Orion maintainers,

Hello!


> config MV643XX_ETH can be selected for Discovery series chips
> (mv78xx0), but it has some problems.
> 
> 1. Register PSC1 (0x44C) bit 4 is named port_reset. It defaults to 1
> "port is reset". The documentation does not explain this bit, but
> the example code clears the bit to "port is not in reset". I needed
> to do the same thing and clear this bit on each port to get ethernet
> working:
> 
> ===================================================================
> --- mv643xx_eth.c
> +++ mv643xx_eth.c
> @@ -2597,6 +2597,9 @@
>         if (msp->base == NULL)
>                 goto out_free;
> 
> +       // Take the part out of reset?
> +       writel(readl(msp->base + 0x44C) & (~(1 << 4)), msp->base + 0x44C);
> +
>         /*
>          * Set up and register SMI bus.
>          */

The stock u-boot probably does this for us, explaining why I've never
run into this.

The 0x44c needs to be a define, a la the other per-port registers at
the top of mv643xx_eth.c.  Also, I need to check if this register bit
is available across all versions of the gigabit ethernet unit that
mv643xx_eth supports.  But no objections against this per se.


> 2. This is confusing, but not an error. There's a variable
> port_number in mv643xx_eth_platform_data that MUST be zero for each
> port on a Discovery (MV78xx0) series processor. The printk will say
> "port 0" for all 4 ports, but it must be zero so the driver
> calculates a valid offset. This probably deserves a comment or a
> change in the printk.

The original mv643xx chips (which this driver still supports) had one
gigabit ethernet unit with two or three ports, while in subsequent
chips, the gigabit ethernet unit has only one port, but there can be
several copies of that whole unit in the chip, which causes all ports
to be reported as port #0 (being port #0 in their respective unit) in
those chips.  I'll admit that this can be confusing.

Since the printk reports the device name anyway, perhaps we can just
remove the "port %d" part entirely?


> 3. This is confusing, but not an error. File mach/mv78xx0.h defines
> each ethernet port's base address like GE00_PHYS_BASE at the wrong
> address. Then orion_ge00_init() in plat-orion/common.c adds a magic
> 0x2000 constant which results in the correct address. This probably
> deserves a comment because the header defines incorrect addresses.

Each mbus target has 64KiB of target register address space.  That
the documented registers start at offset 0x2000 in that range doesn't
change that (and there are some registers in the 0x0000 .. 0x1fff
range, just not any documented ones).  Given this, I wouldn't call the
definition of GE00_PHYS_BASE incorrect.

As to the 0x2000 offset, the mv643xx_eth driver unfortunately expects
that offset to have been included in the platform device mem resource
address range (it did it this way before I took it over), and since
this is encoded in various device trees, we can't easily change this --
or I would have advocated for passing in the 64 KiB aligned address.


> 4. Each processor varies in support for MII, GMII, and RGMII
> interfaces. Function phy_init() calls phy_attach() which is
> hardcoded for PHY_INTERFACE_MODE_GMII. This depends on the board and
> can be different for each port, so it should probably be specified
> in the platform data instead of hardcoded.

This is indeed an issue -- and on some boards, this requires disabling
certain PHY drivers (so that it will fall back to the generic PHY driver)
to have working networking.  If this affects your board, (tested :)
patches would be appreciated.


thanks,
Lennert
