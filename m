From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 12 May 2016 11:08:46 +0100
Subject: [PSCI DISCUSS] How to implement standby and suspend-to-ram by PSCI
In-Reply-To: <DB3PR04MB08125A628F5034749F8109D884730@DB3PR04MB0812.eurprd04.prod.outlook.com>
References: <DB3PR04MB0812DAA98F71C30E8A8832E3847D0@DB3PR04MB0812.eurprd04.prod.outlook.com>
 <572C9BF2.9010004@arm.com>
 <DB3PR04MB08125A628F5034749F8109D884730@DB3PR04MB0812.eurprd04.prod.outlook.com>
Message-ID: <5734562E.40303@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/05/16 10:42, Hongbo Zhang wrote:
> Hi Sudeep,
> 

[...]

> 
> Sleep state:
> All cores are in WFI state,
> Core cluster is in standby state, e.g. L2 cache is flushed then stops
> snooping,
> Only those modules which are required to wake up the device still have a
> running clock, other device modules in chip are clock gated.
> 
> Deep sleep state:
> ARM cores and DDR controller are switched off,
> DDR is in self-refresh mode,
> VDD power to off domain IPs are removed, Only the blocks needed to
> detect wake up and sequence the chip out of deep sleep are on.
> 
> For the two states, except for the wake-up devices, all the other device
> dirver's suspend callback needs to be called because those devices will
> be clock or power gated off. So, the kernel suspend process (freeze
> tasks, suspend devices etc) are needed for our sleep and deep sleep states.
> In fact we've already implemented these two stated by legacy way, e.g.
> mapping sleep state to STANDBY and deep sleep to MEM, both states are
> implemented in one traditional .enter callback and can be indexed by a
> 'state' parameter.
> 

Yes I understand that.

> While transferring to PSCI, we met the problem I mentioned.
> 
> As to the freeze(suspend-to-idle), it is described as "a generic, pure
> software, light-weight, system sleep state" in the Document, and the
> fact is only acpi is using it, 

No, it independent of ACPI. It can be used on any platform with CPUIdle
support.

> what's more, I don't think it satisfy us
> well, because the freeze_enter() is executed before
> disable_nonboot_cpus() and syscore_suspend(), while the later two are
> necessary for us.
> 

Care to explain ? With suspend-to-idle, wakeup latency is much lesser as
the CPUs are not hotplugged out. I don't think it makes huge different
with power on ARM platforms. So its is much better than standby which
does CPU hotplugging IMO.

> So it seems another 'state' parameter for SYSTEM_SUSPEND can settle this
> problem, but it is lack in the spec.
> 

If you still think you can't make use of suspend-to-idle with added
advantage of reduced wakeup latency, please send email with all the
details to errata at arm.com as suggested in the PSCI specification.

> There are diverse kinds of ARM SOC, and divers kind of peripheral
> devices in each SOC, so even for the SYSTEM_SUSPEND, there may be
> different states too(deeper or shallower states of each device, more or
> less of devices are put to idle), the more the PSCI spec supports, the
> better.
> 

With runtime PM, you can work out on the peripheral device PM directly,
so I can't imagine how the diversity there adds to SYSTEM_SUSPEND
complexity.

-- 
Regards,
Sudeep
