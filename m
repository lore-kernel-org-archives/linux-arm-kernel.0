From: robh@kernel.org (Rob Herring)
Date: Mon, 23 Jan 2017 15:00:52 -0600
Subject: [PATCH v2 4/7] rtc: sun6i: Expose the 32kHz oscillator
In-Reply-To: <f244737aa43965e5510e8173b5653deb484a94f0.1485168100.git-series.maxime.ripard@free-electrons.com>
References: <cover.6bd4d4760c24d09845ad09c212fcd487d78da5ad.1485168100.git-series.maxime.ripard@free-electrons.com>
 <f244737aa43965e5510e8173b5653deb484a94f0.1485168100.git-series.maxime.ripard@free-electrons.com>
Message-ID: <20170123210052.rek7fma5gjukq2ld@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2017 at 11:41:49AM +0100, Maxime Ripard wrote:
> The RTC controls the input source of the main 32kHz oscillator in the
> system, feeding it to the clock unit too.
> 
> By default, this is using an internal, very inaccurate (+/- 30%)
> oscillator with a divider to make it roughly around 32kHz. This is however
> quite impractical for the RTC, since our time will not be tracked properly.
> 
> Since this oscillator is an input of the main clock unit, and since that
> clock unit will be probed using CLK_OF_DECLARE, we have to use it as well,
> leading to a two stage probe: one to enable the clock, the other one to
> enable the RTC.
> 
> There is also a slight change in the binding that is required (and should
> have been from the beginning), since we'll need a phandle to the external
> oscillator used on that board. We support the old binding by not allowing
> to switch to the external oscillator and only using the internal one (which
> was the previous behaviour) in the case where we're missing that phandle.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/rtc/sun6i-rtc.txt |  10 +-

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/rtc/rtc-sun6i.c                             | 146 +++++++++++--
>  2 files changed, 143 insertions(+), 13 deletions(-)
