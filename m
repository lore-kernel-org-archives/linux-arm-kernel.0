From: tony@atomide.com (Tony Lindgren)
Date: Tue, 6 Mar 2012 16:13:11 -0800
Subject: [PATCH V2] OMAP3+: PM: VP: fix integer truncation error
In-Reply-To: <87hay1b7i0.fsf@ti.com>
References: <1331059872-29011-1-git-send-email-nm@ti.com>
 <87hay1b7i0.fsf@ti.com>
Message-ID: <20120307001311.GB12083@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [120306 15:33]:
> Nishanth Menon <nm@ti.com> writes:
> 
> > From: Yuan Jiangli <jlyuan@motorola.com>
> >
> > commit 2f34ce81b8c05c900e45bd88595cc154f7bb5957
> > (OMAP3: PM: Adding voltage driver support.)
> > introduced runtime computation of waittime to handle all potential
> > sys clocks available.
> >
> > In the voltage processor, the SPMSUpdateWait is calculated based on
> > the slew rate and the voltage step (SMPSUpdateWait = slew rate *
> > Voltage Step). After the voltage processor receives the SMPS_Ack
> > signal, the Voltage Controller will wait for SMPSUpdateWait clock
> > cycles for the voltage to settle to the new value. For all
> > practical purposes, the waittime parameter is the OMAP hardware
> > translation of what the slew rate on the PMIC is.
> >
> > As an example, with TPS62361 on OMAP4460,
> > step_size = 10000
> > slew_rate = 32000
> > sys_clk_rate = 38400
> >
> > Our current computation results in the following:
> >  = ((step_size / slew_rate) * sys_clk_rate) / 1000
> >  = ((10000 / 32000) * 38400 / 1000
> >  = 0
> >
> > Fix the same using DIV_ROUND_UP as an extra wait clock cycle
> > is better than lesser clock cycle. For the above example, this
> > translates to:
> >  = (10000 * 38400) / (1000 * 32000)
> >  = 12
> >
> > Acked-by: Jon Hunter <jon-hunter@ti.com>
> > [nm at ti.com: slightly better implementation]
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > Signed-off-by: Yuan Jiangli <jlyuan@motorola.com>
> 
> Acked-by: Kevin Hilman <khilman@ti.com>
> 
> Tony, I don't have any more PM fixes for this cycle, so feel free to add
> this to fixes-non-critical-part2.
> 
> This is an important fix, but since we're not doing active voltage
> scaling in mainline today, I don't think it's 3.3 material.

OK, adding.

Thanks,

Tony
