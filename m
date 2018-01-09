From: stefan@agner.ch (Stefan Agner)
Date: Tue, 09 Jan 2018 23:21:45 +0100
Subject: [PATCH 1/7] ARM: imx: add timer stop flag to ARM power off state
In-Reply-To: <1515506669.12538.31.camel@pengutronix.de>
References: <20180102164223.15230-1-stefan@agner.ch>
 <20180109092232.GA26312@b29396-OptiPlex-7040>
 <AM3PR04MB13155287E5AAAF5407AF68A6F5100@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <1515492803.12538.29.camel@pengutronix.de>
 <bacee8fe00b0ab54dfa6692bfc956ffd@agner.ch>
 <1515506669.12538.31.camel@pengutronix.de>
Message-ID: <0f9c60bc8986b5d8cf15449173f77da5@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-01-09 15:04, Lucas Stach wrote:
> Am Dienstag, den 09.01.2018, 14:37 +0100 schrieb Stefan Agner:
>> On 2018-01-09 11:13, Lucas Stach wrote:
>> > Am Dienstag, den 09.01.2018, 09:25 +0000 schrieb Anson Huang:
>> > >
>> > > Best Regards!
>> > > Anson Huang
>> > >
>> > >
>> > > > -----Original Message-----
>> > > > From: Dong Aisheng [mailto:dongas86 at gmail.com]
>> > > > Sent: 2018-01-09 5:23 PM
>> > > > To: Stefan Agner <stefan@agner.ch>
>> > > > Cc: shawnguo at kernel.org; kernel at pengutronix.de; Fabio Estevam
>> > > > <fabio.estevam@nxp.com>; robh+dt at kernel.org; mark.rutland at arm.c
>> > > > om;
>> > > > linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.or
>> > > > g;
>> > > > linux-
>> > > > kernel at vger.kernel.org; Anson Huang <anson.huang@nxp.com>; dl-
>> > > > linux-imx
>> > > > <linux-imx@nxp.com>
>> > > > Subject: Re: [PATCH 1/7] ARM: imx: add timer stop flag to ARM
>> > > > power
>> > > > off state
>> > > >
>> > > > On Tue, Jan 02, 2018 at 05:42:17PM +0100, Stefan Agner wrote:
>> > > > > When the CPU is in ARM power off state the ARM architected
>> > > > > timers
>> > > > > are
>> > > > > stopped. The flag is already present in the higher power WAIT
>> > > > > mode.
>> > > > >
>> > > > > This allows to use the ARM generic timer on i.MX 6UL/6ULL
>> > > > > SoC.
>> > > > > Without the flag the kernel freezes when the timer enters the
>> > > > > first
>> > > > > time ARM power off mode.
>> > > > >
>> > > > > Cc: Anson Huang <anson.huang@nxp.com>
>> > > > > Signed-off-by: Stefan Agner <stefan@agner.ch>
>> > > >
>> > > > It seems ok at my side.
>> > > > Did you meet the real issue? If yes, how to reproduce?
>> > > >
>> > > > Both mx6sx and mx6ul are using GPT which do not need that flag,
>> > > > suppose we
>> > > > should remove it, right?
>> > > > Anson can help confirm it.
>> > >
>> > > For UP system like i.MX6SX, we do NOT enable "cortex-a9-twd-
>> > > timer",
>> > > so local
>> > > timer is NOT used, GPT is used instead, GPT's clock is NOT
>> > > disabled
>> > > when cpuidle,
>> > > so I think we should remove all these Timer stop flag for 6SX
>> > > CPUIDLE.
>> >
>> > It's correct to set the flag even on UP systems, as the flag means
>> > the
>> > CPU _local_ timer is stopped in this sleep mode. Also there are
>> > systems
>> > out there which are using the TWD on UP, as it operates at a higher
>> > frequency leading to better wakeup granularity.
>>
>> Documentation/devicetree/bindings/arm/twd.txt states that TWD
>> provides
>> "per-cpu local timer". But as far as I can see TWD still uses SPI
>> interrupts, routed through GIC, so is this the differentiation?
> 
> Maybe what I wrote wasn't entirely clear. I completely agree with this
> patch.
> 
> The TWD on Cortex-A9 is a CPU local timer, same as the architected
> timer in later cores. It doesn't provide all the benefits of the
> architected timer (the clock frequency varies with CPU core clock and
> it's not virt capable), but some systems still prefer it over the i.MX
> GPT, as it provides much better wakeup granularity.
> 
> So annotating the CPU idle states with the timer stop flag is the right
> thing to do. This flag has nothing to with the usage of GPT or TWD on a
> specific system.

Can I take that as an Acked-by?

--
Stefan
