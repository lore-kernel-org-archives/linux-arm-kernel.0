From: stefan@agner.ch (Stefan Agner)
Date: Tue, 07 Jun 2016 10:06:24 -0700
Subject: shared resources in AMP between Cortex-A9 and Cortex-M4
In-Reply-To: <5756FB64.6060207@arm.com>
References: <20160607162545.GX26768@pengutronix.de> <5756FB64.6060207@arm.com>
Message-ID: <3c51425927c13aed01026d2ab8a50551@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe, Hi Sudeep,

On 2016-06-07 09:50, Sudeep Holla wrote:
> On 07/06/16 17:25, Uwe Kleine-K?nig wrote:
>> Hello Stefan,
>>
>> I'm currently trying to get Linux running on the M4 of an i.MX6 Solo X
>> and found you describing doing this on the Vybrid already[1].
>>
>> I see the problem that clk and pinmux must be used by both cores. Did
>> you solve this for your Vybrid experiments? And if so, how did it work?

No, it is basically unsolved. I just used "clk_ignore_unused" on both
sides to avoid stuff getting disabled. It works surprisingly well :-)


>>
>> Having two drivers on the same IP is racy at best and using some kind of
>> inter cpu communication to let (say) the A9 enable the clks for the M4
>> sounds like overkill.
>>

On a high level there are these two options:

1) One core takes care of the IP, hence needs to know the other cores
needs and provide it
2) Both cores access the IP (with some kind of mutual exclusion to avoid
races and conflicts of shared resources)

Especially for the clock stuff I fell that 1 is probably easier.

> 
> IMO it should be other way around. In-fact few latest platforms(with
> performant Cortex-A cores) have dedicated Cortex-M core to do such
> system control and power management as it are low power and mostly
> always on.

Whether that is the M4 or the A-class CPU is probably application
specific. If it is used for system control/power management, I agree
with Sudeep, however, the NXP's new AMP designs mainly target user
applications, e.g. to fulfill real-time requirements. In those
applications I feel that the A-class CPU being the master is probably
more common. Usually you only want to solve a small subset of your
application on the M4.

I thought about device trees which describe the other cores needs,
basically a massively enhanced version of this:
http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/remoteproc/wkup_m3_rproc.txt

I mean, we could assign lets say a UART to the remote proc, and then let
the master core handle pinmux, clocks etc...

--
Stefan
