From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Jun 2013 19:52:23 +0100
Subject: [RFC PATCH 03/11] dma: amba-pl08x: Add support for different
 offset of CONFIG register
In-Reply-To: <1371416058-22047-4-git-send-email-tomasz.figa@gmail.com>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
 <1371416058-22047-4-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20130617185223.GO2718@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 16, 2013 at 10:54:10PM +0200, Tomasz Figa wrote:
> Some variants of PL08x (namely PL080S, found in Samsung S3C64xx SoCs)
> have CONFIG register at different offset. This patch makes the driver
> use offset from vendor data struct.

I'd suggest doing this a different way.  Instead of having to pass around
two pointers everywhere in order to access this register, add to
struct pl08x_phy_chan a void __iomem *reg_config; member, and initialize
that to base + vd->config_offset.  Then use ch->reg_cfg instead of
ch->base + PL080_CH_CONFIG.

This has the benefit that you won't have to modify a whole load of
functions to pass another argument, which costs not only an additional
register, but also storage to keep it around.
