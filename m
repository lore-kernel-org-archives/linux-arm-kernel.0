From: matt.porter@linaro.org (Matt Porter)
Date: Fri, 18 Oct 2013 09:22:57 -0400
Subject: [RESEND PATCH v2 6/6] mmc: sdhci-bcm-kona: Add basic use of clocks
In-Reply-To: <20131017141309.GG24056@e106331-lin.cambridge.arm.com>
References: <1381960030-1640-1-git-send-email-tim.kryger@linaro.org>
 <1381960030-1640-7-git-send-email-tim.kryger@linaro.org>
 <20131017141309.GG24056@e106331-lin.cambridge.arm.com>
Message-ID: <20131018132257.GG2721@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 17, 2013 at 03:13:09PM +0100, Mark Rutland wrote:
> On Wed, Oct 16, 2013 at 10:47:10PM +0100, Tim Kryger wrote:
> > +	/* Get and enable the external clock */
> > +	kona_dev->external_clk = devm_clk_get(dev, NULL);
> > +	if (IS_ERR(kona_dev->external_clk)) {
> > +		dev_err(dev, "Failed to get external clock\n");
> > +		ret = PTR_ERR(kona_dev->external_clk);
> > +		goto err_pltfm_free;
> 
> This seems like a pretty clear breakage of existing DTBs.
> 
> Why?

Normal kernel incremental development. The notion of breaking DTBs is
pretty much incompatible with the long-standing tradition of developing
kernel support in an incremental fashion.

In this case, the bootloader available on these boards has had clocks
and regulators enabled for all the drivers currently upstream. This
allowed development of the sdhci driver (and others) independent of having
the common clk driver and PMU/regulator drivers ready. That's been especially
important given the flux that the common clk framework is in with regards
to bindings.

Are you suggesting that the required clock needs to be made logically
optional in the code to retain backward compatbility?

-Matt
