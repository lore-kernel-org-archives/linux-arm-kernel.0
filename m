From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 May 2018 20:45:04 +0100
Subject: [PATCH 09/14] ARM: spectre-v2: add PSCI based hardening
In-Reply-To: <35edb3df-fed4-b6e6-be0c-ee758618c92e@arm.com>
References: <20180521114238.GN17671@n2100.armlinux.org.uk>
 <E1fKjFT-00064F-Bs@rmk-PC.armlinux.org.uk>
 <35edb3df-fed4-b6e6-be0c-ee758618c92e@arm.com>
Message-ID: <20180523194503.GX17671@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2018 at 06:24:13PM +0100, Marc Zyngier wrote:
> On 21/05/18 12:45, Russell King wrote:
> > +#ifdef CONFIG_ARM_PSCI
> > +	if (psci_ops.smccc_version != SMCCC_VERSION_1_0) {
> > +		struct arm_smccc_res res;
> > +
> > +		switch (psci_ops.conduit) {
> > +		case PSCI_CONDUIT_HVC:
> > +			arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
> > +					  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
> > +			if ((int)res.a0 < 0)
> > +				break;
> 
> I just realised that there is a small, but significant difference
> between this and the arm64 version: On arm64, we have a table of
> vulnerable implementations, and we try the mitigation on a per-cpu
> basis. Here, you entirely rely on the firmware to discover whether the
> CPU needs mitigation or not. You then need to check for a return value
> of 1, which indicates that although the mitigation is implemented, it is
> not required on this particular CPU.

Okay, so digging further into the documentation seems to suggest that we
only need to check the firmware for A72 and A57 CPUs, and given this
statement:

"Arm recommends that the caller only call this on PEs for which a
 firmware based mitigation of CVE-2017-5715 is required, or where
 a local workaround is infeasible."

it seems that the right answer is to ignore the PSCI based methods when
we have anything but these CPUs.  Do you agree?

> But that's probably moot if you don't support BL systems.

Any bL systems with A72 or A57?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
