From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 13 Apr 2017 16:36:36 +0100
Subject: [PATCHv3 13/14] arm64: pmuv3: handle !PMUv3 when probing
In-Reply-To: <CA+7sy7AA+SX_YUNAgCL5tyBXGW+rUidaApN7D2g3O0maRNcKSw@mail.gmail.com>
References: <1491899997-32210-1-git-send-email-mark.rutland@arm.com>
 <1491899997-32210-14-git-send-email-mark.rutland@arm.com>
 <CA+7sy7AA+SX_YUNAgCL5tyBXGW+rUidaApN7D2g3O0maRNcKSw@mail.gmail.com>
Message-ID: <20170413153636.GG24027@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Apr 13, 2017 at 07:36:45PM +0530, Jayachandran C. wrote:
> On Tue, Apr 11, 2017 at 2:09 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > When probing via ACPI, we won't know up-front whether a CPU has a PMUv3
> > compatible PMU. Thus we need to consult ID registers during probe time.
> >
> > This patch updates our PMUv3 probing code to test for the presence of
> > PMUv3 functionality before touching an PMUv3-specific registers, and
> > before updating the struct arm_pmu with PMUv3 data.

[..]

> > +       dfr0 = read_sysreg(id_aa64dfr0_el1);
> > +       pmuver = cpuid_feature_extract_unsigned_field(dfr0,
> > +                       ID_AA64DFR0_PMUVER_SHIFT);
> > +       if (pmuver != 1)
> > +               return;
> 
> There is a problem here, the 8.1 spec allows PMUver value 4 for PMUv3
> "Performance Monitors extension System registers implemented, PMUv3,
> with a 16-bit evtCount field, and if EL2 is implemented, the addition
> of the MDCR_EL2.HPMD bit"
>
> On Broadcom Vulcan/Cavium ThunderX2 the value of PMUver is 4 and this
> breaks (even the working DT case if I am not mistaken).

Good point; sorry about this.

Annoyingly, ID_AA64DFR0.PMUVer is a bit weird, and doesn't seem to
strictly follow the rules laid out in ARM DDI 0487B.a, D7.1.4,
"Principles of the ID scheme for fields in ID registers".

Since both 0b0000 and 0b1111 mean that PMUv3 isn't implemented, I don't
know if it should be treated as unsigned with 0xf being special-cased,
or if it should be treated as signed with 0b001 being the minimal
version we expect.

i.e. it's not clear to me if we should do:

	dfr0 = read_sysreg(id_aa64dfr0_el1);
	pmuver = cpuid_feature_extract_unsigned_field(dfr0,
			id_aa64dfr0_pmuver_shift);
	if (pmuver < 1 || pmuver == 0xf)
		return;

... or:

	dfr0 = read_sysreg(id_aa64dfr0_el1);
	pmuver = cpuid_feature_extract_signed_field(dfr0,
			id_aa64dfr0_pmuver_shift);
	if (pmuver < 1)
		return;

I'll try to get that clarified ASAP.

Thanks,
Mark.
