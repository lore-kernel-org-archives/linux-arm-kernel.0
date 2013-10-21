From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Oct 2013 09:52:00 +0100
Subject: [PATCH] ASoC: kirkwood: cleanup the external clock probe
In-Reply-To: <20131021102834.768c0887@armhf>
References: <20131021094613.2a07bd79@armhf>
 <20131021080657.GU25034@n2100.arm.linux.org.uk>
 <20131021102834.768c0887@armhf>
Message-ID: <20131021085200.GW25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 21, 2013 at 10:28:34AM +0200, Jean-Francois Moine wrote:
> On Mon, 21 Oct 2013 09:06:57 +0100
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > On Mon, Oct 21, 2013 at 09:46:13AM +0200, Jean-Francois Moine wrote:
> > > This patch checks the return value of the clk_prepare_enable of the
> > > external clock and removes the test about a same internal and external
> > > clock which would quite never occur and won't work in most cases
> > > it would occur.
> > 
> > NAK.  It can occur.
> 
> In which case? And, what would be the right treatment?

        priv->clk = devm_clk_get(&pdev->dev, NULL);
        priv->extclk = devm_clk_get(&pdev->dev, "extclk");

Supplying the first clock to this driver without a separate "extclk"
via clkdev will return it as the second clock.

Again, NAK.  Your change is against the principles of the clk API.
