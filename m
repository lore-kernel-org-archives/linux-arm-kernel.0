From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Mon, 21 Mar 2016 02:24:32 +0000
Subject: [PATCH v5 3/5] ARM: at91: pm: configure PMC fast startup signals
In-Reply-To: <20160317171433.GD2831@piout.net>
References: <1458111489-23774-1-git-send-email-wenyou.yang@atmel.com>
 <1458111489-23774-4-git-send-email-wenyou.yang@atmel.com>
 <20160317171433.GD2831@piout.net>
Message-ID: <B256D81BAE5131468A838E5D7A243641D643C03F@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

> -----Original Message-----
> From: Alexandre Belloni [mailto:alexandre.belloni at free-electrons.com]
> Sent: 2016?3?18? 1:15
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
> On 16/03/2016 at 14:58:07 +0800, Wenyou Yang wrote :
> > The fast startup signal is used as wake up sources for ULP1 mode.
> > As soon as a fast startup signal is asserted, the embedded 12 MHz RC
> > oscillator restarts automatically.
> >
> > This patch is to configure the fast startup signals, which signal is
> > enabled to trigger the PMC to wake up the system from ULP1 mode should
> > be configured via the DT.
> >
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> 
> I would actually avoid doing that from the PMC driver and do that configuration
> from the aic5 driver. It has all the information you need, it knows what kind of level
> or edge is needed to wake up and what are the wakeup interrupts to enable. This
> will allow you to stop introducing a new binding. Also, this will avoid discrepancies
> between what is configured in the DT and what the user really wants (for exemple
> differences between the edge direction configured for the PIOBu in userspace
> versus what is in the device tree or wakeonlan activation/deactivation).

Thank you for your feedback.

But some wake-ups such as WKUP pin, ACC_CE, RXLP_MCE, don't have the corresponding
interrupt number. Moreover, I think, the ULP1 is very different form the ULP0, it is not woken
up by the interrupt. It is fallen sleep and woken up by the some mechanism in the PMC. 

Maybe I was wrong. I still think the aic5 driver should be devoted on the AIC5's behaviors. 

> 
> You can get the PMC syscon from irq-atmel-aic5.c and then use a table to map
> the hwirq to the offset in PMC_FSMR. Use it in aic5_set_type to set the polarity
> and then in aic5_suspend to enable the wakeup.
> 
> Maybe we could even go further and avoid ulp1 if no ulp1 compatbile wakeup
> sources are defined but there are ulp0 wakeup sources.
> 
> 
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering http://free-electrons.com


Best Regards,
Wenyou Yang
