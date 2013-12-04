From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 4 Dec 2013 02:34:09 +0100
Subject: [PATCH V3] dma: tegra: register as an OF DMA controller
In-Reply-To: <1386102787-21839-1-git-send-email-swarren@wwwdotorg.org>
References: <1386102787-21839-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201312040234.09708.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 December 2013, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Call of_dma_controller_register() so that DMA clients can look up the
> Tegra DMA controller using standard APIs. This requires the of_xlate()
> function to save off the DMA slave ID, and for tegra_dma_slave_config()
> not to over-write this information; once DMA client drivers are converted
> to dma_request_slave_channel() and DT-based lookups, they won't set this
> field of struct dma_slave_config anymore.
> 
> Cc: treding at nvidia.com
> Cc: pdeschrijver at nvidia.com
> Cc: linux-tegra at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: dmaengine at vger.kernel.org
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Looks great to me.

Acked-by: Arnd Bergmann <arnd@arndb.de>

but see my comments about the dma_get_any_slave_channel. If we want to merge
that function with the existing dma_get_slave_channel function (and change
the three existing users of that one), one line here will of course have
to change.

Also, one (long-running, not just for this driver) comment I have is
about this snippet:

> @@ -340,6 +342,8 @@ static int tegra_dma_slave_config(struct dma_chan *dc,
>         }
>  
>         memcpy(&tdc->dma_sconfig, sconfig, sizeof(*sconfig));
> +       if (!tdc->slave_id)
> +               tdc->slave_id = sconfig->slave_id;
>         tdc->config_init = true;
>         return 0;
>  }

We really need to be better at having a common set of rules regarding what
it actually means to set the slave_id through dma_slave_config(). IMHO
we should just treat it as a bug for any dmaengine driver that is configured
through DT, or we should get rid of this entirely. Looking through the
code now, I only see two dmaengine drivers that actually do this: one is 
the tegra driver (which you are about to change), the other one is shdma,
and that one is already a bit special. Any ideas?

	Arnd
