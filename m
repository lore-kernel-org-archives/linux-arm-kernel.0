From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 17 Mar 2016 18:14:33 +0100
Subject: [PATCH v5 3/5] ARM: at91: pm: configure PMC fast startup signals
In-Reply-To: <1458111489-23774-4-git-send-email-wenyou.yang@atmel.com>
References: <1458111489-23774-1-git-send-email-wenyou.yang@atmel.com>
 <1458111489-23774-4-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20160317171433.GD2831@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/03/2016 at 14:58:07 +0800, Wenyou Yang wrote :
> The fast startup signal is used as wake up sources for ULP1 mode.
> As soon as a fast startup signal is asserted, the embedded 12 MHz
> RC oscillator restarts automatically.
> 
> This patch is to configure the fast startup signals, which signal
> is enabled to trigger the PMC to wake up the system from ULP1 mode
> should be configured via the DT.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>

I would actually avoid doing that from the PMC driver and do that
configuration from the aic5 driver. It has all the information you need,
it knows what kind of level or edge is needed to wake up and what are
the wakeup interrupts to enable. This will allow you to stop introducing
a new binding. Also, this will avoid discrepancies between what is
configured in the DT and what the user really wants (for exemple
differences between the edge direction configured for the PIOBu in
userspace versus what is in the device tree or wakeonlan
activation/deactivation).

You can get the PMC syscon from irq-atmel-aic5.c and then use a table to
map the hwirq to the offset in PMC_FSMR. Use it in aic5_set_type to set
the polarity and then in aic5_suspend to enable the wakeup.

Maybe we could even go further and avoid ulp1 if no ulp1 compatbile
wakeup sources are defined but there are ulp0 wakeup sources.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
