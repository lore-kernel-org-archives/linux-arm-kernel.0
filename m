From: tony@atomide.com (Tony Lindgren)
Date: Thu, 14 Jun 2012 04:23:22 -0700
Subject: [PATCH 3/3] ARM: OMAP2+: gpmc: handle additional timings
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9997F4@DBDE01.ent.ti.com>
References: <cover.1339419244.git.afzal@ti.com>
 <c4bd7d71e9950c09f9712077160b6231f566d8f3.1339419244.git.afzal@ti.com>
 <20120614092957.GE12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9997F4@DBDE01.ent.ti.com>
Message-ID: <20120614112322.GJ12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mohammed, Afzal <afzal@ti.com> [120614 02:46]:
> Hi Tony,
> 
> On Thu, Jun 14, 2012 at 14:59:57, Tony Lindgren wrote:
> > * Afzal Mohammed <afzal@ti.com> [120611 07:21]:
> 
> > > +	GPMC_SET_ONE(GPMC_CS_CONFIG6, 0, 3, bus_turnaround);
> > > +	GPMC_SET_ONE(GPMC_CS_CONFIG6, 8, 11, cycle2cycle_delay);
> > > +
> > > +	GPMC_SET_ONE(GPMC_CS_CONFIG1, 18, 19, wait_monitoring);
> > > +	GPMC_SET_ONE(GPMC_CS_CONFIG1, 25, 26, clk_activation);
> > > +
> > 
> > Thinking about this, the CONFIG1 bits have been set with
> > gpmc_cs_write_reg because these are part of the static configuration
> > and do not need to be dynamically calculated as they are tick based.
> > For example, tusb6010 sets GPMC_CONFIG1_CLKACTIVATIONTIME(1) during init.
> 
> But aren't we deciding number of ticks based on clock period ?
> If we take case of onenand, based on the knowledge of clock period,
> number of ticks are calculated.
> 
> And similarly to decide cycle2cycledelay, busturnaround, we decide number
> of ticks based on peripheral datasheet timings & gpmc clock, hence
> shouldn't it also be dynamically calculated similar to timings that were
> existing earlier.

Hmm indeed onenand is setting that dynamically. OK, let's try your
approach and make sure we patch in the missing values so we don't
overwrite the values set with gpmc_cs_write_reg.

Regards,

Tony
