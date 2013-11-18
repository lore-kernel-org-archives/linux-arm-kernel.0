From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 18 Nov 2013 10:30:35 -0700
Subject: [PATCH 23/31] spi: tegra: convert to standard DMA DT bindings
In-Reply-To: <20131116101422.GK15393@sirena.org.uk>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-24-git-send-email-swarren@wwwdotorg.org>
 <20131116101422.GK15393@sirena.org.uk>
Message-ID: <528A4EBB.2090800@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2013 03:14 AM, Mark Brown wrote:
> On Fri, Nov 15, 2013 at 01:54:18PM -0700, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> By using dma_request_slave_channel_or_err(), the DMA slave ID can be
> 
> Acked-by: Mark Brown <broonie@linaro.org>
> 
> Is this function introduced earlier in the series?

Yes, patch 11/31 introduced this.

> One of the things
> I'm looking at is trying to factor out some DMA code in the SPI
> framework so perhaps using this straight off would be good.  But perhaps
> the channel request stuff will all be in the drivers and it'll just pass
> a handle to the framework code so there'll be no issue.

I think I can make a "core changes" branch that contains:

[PATCH 11/31] dma: add channel request API that supports deferred probe

[PATCH 14/31] ASoC: dmaengine: support deferred probe for DMA channels

[PATCH 15/31] ASoC: dmaengine: add custom DMA config to
snd_dmaengine_pcm_config

That could be merged into relevant subsystems alone, if they only depend
on the core changes and not any of the Tegra driver changes.

However, I suspect that the Tegra driver changes may need to be merged
into any subsystem that's doing much other work on the Tegra drivers,
especially any significant refactoring, so the subsystem would probably
have to pick up the whole series anyway. Still, I'll make sure I
re-order the branch to put the core changes first so we have as much
flexibility as possible.
