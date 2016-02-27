From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 26 Feb 2016 17:50:49 -0800
Subject: [PATCH v3 6/8] arm64: dts: qcom: fix usb digital voltage levels
In-Reply-To: <CAPBZ5QeJGV5iqx5wwGP3mwr292-rkqmORnTe8qtHSX2DzVc97Q@mail.gmail.com>
References: <1456246153-18087-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1456246236-18341-1-git-send-email-srinivas.kandagatla@linaro.org>
 <56CE3780.5060408@codeaurora.org> <56CEE3D4.3030407@linaro.org>
 <CAPBZ5QfD4q4hDg2Vfj8E_2Hjoa80feFN4cM+LkhdGgHLDkKx_g@mail.gmail.com>
 <CAPBZ5QeJGV5iqx5wwGP3mwr292-rkqmORnTe8qtHSX2DzVc97Q@mail.gmail.com>
Message-ID: <20160227015049.GE28849@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/25, Andy Gross wrote:
> > On 25 February 2016 at 05:21, Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:
> >>
> >> Andy/Bjorn, any comments on plans on corner regulators?
> >>
> >> Please note, that this is a patch to fix what is already in the mainline.
> >> Without this patch the regulator would be configured with 1uV or 5uV or 7uV
> >> which would obviously fail.
> >>
> >> THB, it does not make sense to drop feature which is functional, and I
> >> also agree that we should cleanup some of this mess at some point in time
> >> once we all the bits and pieces ready.
> >>
> >> I was surprised to see these usb bindings(qcom,vdd-levels) existed even
> >> before we had concept of corner regulators in mainline kernel. Which also
> >> suggests that this driver needs a proper relook once again.
>
> I think the vdd-levels were an oversight.  The voltages definitely
> need to be correct.  As for the corner regulators, I believe the CPR
> driver was supposed to address this.  The USB requests a specific
> voltage and frequency and based on this the CPR would set the corner
> for the regulator.
> 
> Stephen, correct me if i am wrong.

There's CPR for the CPU voltage and there's CPR for the digital
voltage. The RPM controls the latter, and so all we have on the
Linux side is an API to request corners, not voltages, for
digital logic. Almost everything in the SoC is using the digital
voltage, so having USB be the only consumer of this voltage and
then be the only driver telling the RPM what corner or voltage we
want here is potentially very dangerous.

Consider the case where USB goes to runtime suspend and USB
driver says it only needs "low" voltage. This might cause RPM to
go and lower the voltage because no other master in the system is
asking for anything else besides "low". But we may have other
hardware blocks using the digital logic supply in the system,
e.g. GPU is running at max speed, and those blocks need "high"
voltage. We just browned out the GPU.

So maybe we should just remove this code from the USB driver for
now? By default the voltage is nominal, and when the bus clocks
are maxed out the voltage goes to the highest level. So as long
as RPM bus clocks are maxed this code is not doing anything.

My plan for handling corners is to hide it behind the OPP
framework and/or generic power domains. The digital logic supply
is really a regulator that supplies a large power domain called
CX. All the digital logic in the SoC lives within this power
domain. As an aside, it's quite typical that a hardware block
sits in a few domains: digital, analog, memories, etc. so this
may require us to expand the ability for devices to be in
multiple PM domains at one time. But regardless, the frequency
that a device in the digital logic domain is running at is used
to pick a voltage that is "maxed" across all devices and factors
into the voltage requirement of the domain. Another way to put it
is that each device casts a "vote" for the CX voltage based on
their frequency and the largest uV wins and is set.

This is further complicated by CPR, which takes away the uV units
from this calculation and transforms that into a "corner". Each
hardware block now knows what voltage "corner" it needs for CX
when their clock is at a particular frequency. We'll probably
need to add some sort of "corner" property to the OPP binding to
express this. Hopefully it can be a generic power domain level
thing (keep reading!).

So I'm thinking each device gets an OPP table of frequency to
voltage/corner pairs. Devices would change their OPP through OPP
framework and this would adjust the clk and voltage/corner
appropriately. To make things generic between voltages and
corners, we could hide that part behind the genpd framework by
having OPP pick a "power level" that the power domain should be
at. On SoCs where the power domain is supplied by a regulator the
level would be translated into a uV (probably need some sort of
level to uV table in DT or just put that in the code). On SoCs
where the power domain is supplied by a regulator with corners,
the level would be used as is and sent to the RPM. OPP framework
wouldn't care, as long as the genpd driver handles the voltage
vs. corner stuff.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
