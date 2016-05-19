From: hongbo.zhang@nxp.com (Hongbo Zhang)
Date: Thu, 19 May 2016 10:27:41 +0000
Subject: [PSCI DISCUSS] How to implement standby and suspend-to-ram by PSCI
In-Reply-To: <1463486036.19237.9.camel@suse.com>
References: <DB3PR04MB0812DAA98F71C30E8A8832E3847D0@DB3PR04MB0812.eurprd04.prod.outlook.com>
 <572C9BF2.9010004@arm.com>
 <DB3PR04MB08125A628F5034749F8109D884730@DB3PR04MB0812.eurprd04.prod.outlook.com>
 <1463486036.19237.9.camel@suse.com>
Message-ID: <AM3PR04MB0805D7F5375413C154DFB981844A0@AM3PR04MB0805.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Oliver Neukum [mailto:oneukum at suse.com]
> Sent: Tuesday, May 17, 2016 7:54 PM
> To: Hongbo Zhang <hongbo.zhang@nxp.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>; linux-pm at vger.kernel.org;
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Marc Zyngier
> <marc.zyngier@arm.com>; Jan Kiszka <jan.kiszka@siemens.com>; Mark
> Rutland <mark.rutland@arm.com>; Daniel Lezcano
> <daniel.lezcano@linaro.org>; Chen-Yu Tsai <wens@csie.org>; Hans de Goede
> <hdegoede@redhat.com>; Frank Li <Frank.Li@freescale.com>; Peng Fan
> <Peng.Fan@freescale.com>; Tom Warren <twarren@nvidia.com>; Vincent
> Guittot <vincent.guittot@linaro.org>; jszhang at marvell.com; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PSCI DISCUSS] How to implement standby and suspend-to-ram by
> PSCI
> 
> On Thu, 2016-05-12 at 09:42 +0000, Hongbo Zhang wrote:
> > On our platform we have some shallow states which maps to cpuidle
> > well,
> > and we have two more deeper states:
> >
> > Sleep state:
> > All cores are in WFI state,
> > Core cluster is in standby state, e.g. L2 cache is flushed then stops
> > snooping,
> > Only those modules which are required to wake up the device still have
> > a
> > running clock, other device modules in chip are clock gated.
> >
> > Deep sleep state:
> > ARM cores and DDR controller are switched off,
> > DDR is in self-refresh mode,
> > VDD power to off domain IPs are removed, Only the blocks needed to
> > detect wake up and sequence the chip out of deep sleep are on.
> 
> For the pm module of the core kernel a low power state is a sleep
> state if even one of three conditions is met:
> 
> a) a device that can be used for input is not a source of wake ups
> b) tasks need to be frozen to enter it
> c) the display goes off, while it should be on
> 
> Generally runtime PM is better if you can get the same results.
> Going to a system sleep state is a necessary evil.
> 
> 	Regards
> 		Oliver
> 
As I just explained in previous reply, many devices in our Soc cannot be physically clock or power gated, all the non-wakeup devices can only be gated off at same time by a PM module, so runtime PM doesn't fit for us well.

Thanks for your advice. 
