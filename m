From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 29 Nov 2013 16:37:09 +0100
Subject: [PATCH 1/5] clk: tegra: fix blink clock rate
In-Reply-To: <20131129152241.GM9712@ulmo.nvidia.com>
References: <1384991242-13596-1-git-send-email-swarren@wwwdotorg.org>
 <20131129152241.GM9712@ulmo.nvidia.com>
Message-ID: <20131129153708.GN9712@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 29, 2013 at 04:22:42PM +0100, Thierry Reding wrote:
> On Wed, Nov 20, 2013 at 04:47:18PM -0700, Stephen Warren wrote:
> > From: Stephen Warren <swarren@nvidia.com>
> > 
> > The blink clock rate needs to be configured, or it will run at ~1Hz
> > rather than the desired 32KHz. If it runs at the wrong rate, e.g. the
> > SDIO WiFi on Seaboard and Cardhu will fail to be detected.
> 
> How is this related to WiFi?
> 
> > 
> > Signed-off-by: Stephen Warren <swarren@nvidia.com>
> > ---
> > This probably needs to be squashed into commit 32721a734a3d "clk: tegra:
> > move PMC, fixed clocks to common files".
> > ---
> >  drivers/clk/tegra/clk-tegra-pmc.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/clk/tegra/clk-tegra-pmc.c b/drivers/clk/tegra/clk-tegra-pmc.c
> > index 00e8275a7178..08b21c1ee867 100644
> > --- a/drivers/clk/tegra/clk-tegra-pmc.c
> > +++ b/drivers/clk/tegra/clk-tegra-pmc.c
> > @@ -114,6 +114,7 @@ void __init tegra_pmc_clk_init(void __iomem *pmc_base,
> >  	}
> >  
> >  	/* blink */
> > +	writel_relaxed(0, pmc_base + PMC_BLINK_TIMER);
> >  	clk = clk_register_gate(NULL, "blink_override", "clk_32k", 0,
> >  				pmc_base + PMC_DPD_PADS_ORIDE,
> >  				PMC_DPD_PADS_ORIDE_BLINK_ENB, 0, NULL);
> 
> Perhaps a better location would be a few lines below, where the "blink"
> clock is registered, since this actually controls the "blink" clock
> rather than "blink_override". But either way:

Just realized that Peter already squashed all of these into his -next
branch, so nevermind.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131129/81f676eb/attachment.sig>
