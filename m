From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 30 Jun 2014 17:42:17 +0300
Subject: [RFC 1/4] ARM: tegra: Move SoC drivers to drivers/soc/tegra
In-Reply-To: <20140630141334.GK28951@arm.com>
References: <1403888329-24755-1-git-send-email-thierry.reding@gmail.com>
 <53ADAA1C.70407@ti.com> <20140627232757.GB26184@ulmo>
 <20140630102512.GE28951@arm.com>
 <20140630114621.GT3679@tbergstrom-lnx.Nvidia.com>
 <20140630141334.GK28951@arm.com>
Message-ID: <20140630144217.GV3679@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > PSCI again?
> > 
> > Not possible for boards where linux runs in NS (roth and tn7).
> 
> That's one of the main use-cases for PSCI - Linux running in NS mode.
> AFAIK, the boards that you mentioned are not ARMv8? We don't intend to

They are v7 indeed...

> enforce PSCI on ARMv7 platforms, mainly because of the legacy firmware
> (though where starting from scratch it would be nice). That means that
> the code won't be shared with arm64 and you can leave it under arch/arm
> (it's a lot of AArch32 assembly anyway).
> 
> > The secure monitor on those is outside our control and does not
> > implement PSCI.
> 
> As I said, I don't think we should change firmware on existing ARMv7
> SoCs but for a new ARMv8 SoC I strongly recommend PSCI. The firmware
> needs to be written anyway (different AArch64 exception model), so you
> can raise such requirement with your firmware provider (ARM also
> provides Trusted Firmware freely as a quick start which implements PSCI,
> though you can only use it as an example).

For v8 this should be fine yes...

> 
> > There might be some value for Tegra114 and Tegra124 if we would like
> > to use HYP mode, but that's not on the radar today. It's a waste of
> > time for Tegra20 and Tegra30.
> 
> I think you should keep the Hyp support in mind anyway and test Linux
> booting in NS mode on your platforms. It may not be on your radar today
> for a SoC but if you later decide that it is, we end up with needing
> different code paths in Linux for the same SoC depending on how it boots
> (and you can't easily detect this at boot time, nor you can pass it via
> DT).

You can just look for a psci DT node? If this node is missing, fallback to
the existing tegra specific mechanism. At least, that's how I envision doing
PSCI for HYP mode on v7 based boards where linux today runs in secure mode.
u-boot loads a minimal secure monitor which only does PSCI (we don't care about
any security as there are no keys available for signing on those boards
anyway), adds the PSCI node to the DT and then boots linux in HYP mode. 
tegra_cpu_reset_handler_enable() checks for a PSCI node and uses it if
available. Else it will fallback to the existing methods. Similar for cpuidle.
No guarantees that this will ever be implemented though :) Maybe.

Cheers,

Peter.
