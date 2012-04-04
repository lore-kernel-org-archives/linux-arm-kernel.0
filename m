From: olof@lixom.net (Olof Johansson)
Date: Wed, 4 Apr 2012 11:57:42 -0700
Subject: [PATCH 03/11] gpio: tegra: fix register address calculations for
 Tegra30
In-Reply-To: <4F7C9893.1030704@wwwdotorg.org>
References: <1333148404-17691-1-git-send-email-swarren@wwwdotorg.org>
 <1333148404-17691-4-git-send-email-swarren@wwwdotorg.org>
 <20120404175722.GC29919@quad.lixom.net>
 <4F7C9893.1030704@wwwdotorg.org>
Message-ID: <20120404185742.GA10603@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 04, 2012 at 12:53:07PM -0600, Stephen Warren wrote:
> On 04/04/2012 11:57 AM, Olof Johansson wrote:
> > On Fri, Mar 30, 2012 at 04:59:56PM -0600, Stephen Warren wrote:
> >> From: Stephen Warren <swarren@nvidia.com>
> >>
> >> Tegra20 and Tegra30 share the same register layout within registers, but
> >> the addresses of the registers is a little different. Fix the driver to
> >> cope with this.
> >>
> >> @@ -333,6 +336,26 @@ static struct irq_chip tegra_gpio_irq_chip = {
> >>  #endif
> >>  };
> >>  
> >> +struct tegra_gpio_soc_config {
> >> +	u32 bank_stride;
> >> +	u32 upper_offset;
> >> +};
> >> +
> >> +static struct tegra_gpio_soc_config tegra20_gpio_config = {
> >> +	.bank_stride = 0x80,
> >> +	.upper_offset = 0x800,
> >> +};
> >> +
> >> +static struct tegra_gpio_soc_config tegra30_gpio_config = {
> >> +	.bank_stride = 0x100,
> >> +	.upper_offset = 0x80,
> >> +};
> > 
> > Hmm. I wonder if this would be better to just describe in the device tree
> > bindings for the gpio controller? Perhaps split the reg property in a higher
> > and lower to take care of the offset, and add a nvidia,bank-stride=<x>
> > property?
> 
> Splitting the reg property in two wouldn't really work. Notice that on
> Tegra20, bank_stride is less than upper_offset whereas on Tegra30,
> bank_stride is larger than upper_offset, so the issue is that in one
> case the registers are interleaved and in the other in separate chunks.
> 
> I guess we could put those values into DT, but they only vary per SoC
> not per board, so there didn't seem much need.
> 
> I believe the Tegra30 register layout is applicable to future chips if
> it matters.

Ok, that's sufficient for me right now then.


-Olof
