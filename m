From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 22 Aug 2017 15:39:06 +0200
Subject: [PATCH v2 3/4] net: phy: realtek: add disable RX internal delay
 mode
In-Reply-To: <20170822040400.12166-4-icenowy@aosc.io>
References: <20170822040400.12166-1-icenowy@aosc.io>
 <20170822040400.12166-4-icenowy@aosc.io>
Message-ID: <20170822133906.GG24555@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 22, 2017 at 12:03:59PM +0800, Icenowy Zheng wrote:
> From: Icenowy Zheng <icenowy@aosc.xyz>
> 
> Some RTL8211E chips have broken GbE function, which needs a hack to
> fix. It's said that this fix will affect the performance on not-buggy
> PHYs, so it should only be enabled on boards with the broken PHY.

I would not call this a broken PHY. It is a question of board
design. If you have shorter tracks, you need a delay. If you have long
tracks, you don't. Hence the four RGMII modes, so you can select if
the delay is needed or not, depending on your board design.

> Currently only some Pine64+ boards are known to have this issue.

Design feature.

Please remove all reference to bug.
 
> This hack is said to disable RX relay for RTL8211E according to Realtek.
> So implement it as RGMII-TXID mode.

Do we know that the TX lines do have a delay after making this change?
We need to be careful here. We will get into a mess if this is
actually RGMII not RGMII_TXID, and somebody designs a board which
needs RGMII-TXID.

> +#include <linux/of.h>
>  #include <linux/phy.h>
>  #include <linux/module.h>

> +static int rtl8211e_config_init(struct phy_device *phydev)
> +{
> +	struct device *dev = &phydev->mdio.dev;
> +	struct device_node *of_node = dev->of_node;

You don't appear to use of_node, nor dev. Please remove, along with
the header file.

    Andrew
