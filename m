From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Thu, 31 Mar 2016 02:43:42 +0000
Subject: [PATCH v5 3/5] ARM: at91: pm: configure PMC fast startup signals
In-Reply-To: <20160324112452.GJ2570@piout.net>
References: <1458111489-23774-1-git-send-email-wenyou.yang@atmel.com>
 <1458111489-23774-4-git-send-email-wenyou.yang@atmel.com>
 <20160317171433.GD2831@piout.net>
 <B256D81BAE5131468A838E5D7A243641D643C03F@penmbx01>
 <20160324112452.GJ2570@piout.net>
Message-ID: <B256D81BAE5131468A838E5D7A243641D6441667@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

> -----Original Message-----
> From: Alexandre Belloni [mailto:alexandre.belloni at free-electrons.com]
> Sent: 2016?3?24? 19:25
> To: Yang, Wenyou <Wenyou.Yang@atmel.com>
> Cc: Ferre, Nicolas <Nicolas.FERRE@atmel.com>; Jean-Christophe Plagniol-
> Villard <plagnioj@jcrosoft.com>; Russell King <linux@arm.linux.org.uk>; linux-
> kernel at vger.kernel.org; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-clk at vger.kernel.org; Rob Herring
> <robh+dt@kernel.org>; Pawel Moll <pawel.moll@arm.com>; Mark Brown
> <broonie@kernel.org>; Ian Campbell <ijc+devicetree@hellion.org.uk>; Kumar
> Gala <galak@codeaurora.org>
> Subject: Re: [PATCH v5 3/5] ARM: at91: pm: configure PMC fast startup signals
> 
> On 21/03/2016 at 02:24:32 +0000, Yang, Wenyou wrote :
> > Hi Alexandre,
> >
> > > -----Original Message-----
> > > From: Alexandre Belloni
> > > [mailto:alexandre.belloni at free-electrons.com]
> > > Sent: 2016?3?18? 1:15
> > > To: Yang, Wenyou <Wenyou.Yang@atmel.com>
> > > Cc: Ferre, Nicolas <Nicolas.FERRE@atmel.com>; Jean-Christophe
> > > Plagniol- Villard <plagnioj@jcrosoft.com>; Russell King
> > > <linux@arm.linux.org.uk>; linux- kernel at vger.kernel.org;
> > > devicetree at vger.kernel.org; linux-arm- kernel at lists.infradead.org;
> > > linux-clk at vger.kernel.org; Rob Herring <robh+dt@kernel.org>; Pawel
> > > Moll <pawel.moll@arm.com>; Mark Brown <broonie@kernel.org>; Ian
> > > Campbell <ijc+devicetree@hellion.org.uk>; Kumar Gala
> > > <galak@codeaurora.org>
> > > Subject: Re: [PATCH v5 3/5] ARM: at91: pm: configure PMC fast
> > > startup signals
> > >
> > > On 16/03/2016 at 14:58:07 +0800, Wenyou Yang wrote :
> > > > The fast startup signal is used as wake up sources for ULP1 mode.
> > > > As soon as a fast startup signal is asserted, the embedded 12 MHz
> > > > RC oscillator restarts automatically.
> > > >
> > > > This patch is to configure the fast startup signals, which signal
> > > > is enabled to trigger the PMC to wake up the system from ULP1 mode
> > > > should be configured via the DT.
> > > >
> > > > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > >
> > > I would actually avoid doing that from the PMC driver and do that
> > > configuration from the aic5 driver. It has all the information you
> > > need, it knows what kind of level or edge is needed to wake up and
> > > what are the wakeup interrupts to enable. This will allow you to
> > > stop introducing a new binding. Also, this will avoid discrepancies
> > > between what is configured in the DT and what the user really wants
> > > (for exemple differences between the edge direction configured for the PIOBu
> in userspace versus what is in the device tree or wakeonlan
> activation/deactivation).
> >
> > Thank you for your feedback.
> >
> > But some wake-ups such as WKUP pin, ACC_CE, RXLP_MCE, don't have the
> > corresponding
> 
> The WKUP pin can be configured from the shdwc driver, ACC_CE from the ACC
> driver, RXLP_MCE, from the RXLP driver because you will need drivers for those
> at some point anyway.
> 
> > interrupt number. Moreover, I think, the ULP1 is very different form
> > the ULP0, it is not woken up by the interrupt. It is fallen sleep and woken up by
> the some mechanism in the PMC.
> >
> 
> Well, we don't really care about the mechanism. We only care about how the user
> is able to configure the wakeup sources.

Understand your concerns.

> 
> With your patch set, what happens when no ULP1 sources are defined but there
> are ULP0 sources? What happens when there are both ULP1 and ULP0 sources?

I think there is only one mode, either ULP1 or ULP0, in a runtime system.
The ULP1 sources are used to wake up the ULP1, and the ULP0 sources wake up the ULP0,
they don't mutually effect each other.

If system is in the ULP1 mode, and there are no ULP1 sources defined, the system will fail to
be waken up, even though there are ULP0 sources defined. The ULP0 source can't wake up the ULP1.

> 
> What would be good is to use ULP1 when only ULP1 sources are set up and
> ULP0 in the other cases. This will greatly help the user. Also, what I'm suggesting
> actually allows to change the ULP1 sources at runtime from devices that are
> actually used which is quite better than setting them up statically from DT.
> 

In the ULP1 mode, all clocks are disabled. It can get lower consumption and
quicker wake up (the processor restarts in less than 10us) than ULP0 mode.

The number of wake up sources is limited as well. It is very different from ULP0's


Hi Nicolas, what is your opinions?


Best Regards,
Wenyou Yang
