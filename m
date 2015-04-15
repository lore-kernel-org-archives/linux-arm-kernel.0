From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 15 Apr 2015 18:35:13 +0100
Subject: [RFC PATCH 0/5] Add smp booting support for Qualcomm ARMv8 SoCs
In-Reply-To: <20150415161759.GB1111@linaro.org>
References: <1428601031-5366-1-git-send-email-galak@codeaurora.org>
 <20150410100529.GA6854@e104818-lin.cambridge.arm.com>
 <493B15F8-0EBE-4633-9604-671EF403F36E@codeaurora.org>
 <20150410161052.GF6854@e104818-lin.cambridge.arm.com>
 <FDC755A7-ACCF-4222-8730-782EEC632159@codeaurora.org>
 <20150413094117.GA2745@e104818-lin.cambridge.arm.com>
 <245B9FDD-E1B5-41E4-9F24-4D5BB86C450E@codeaurora.org>
 <20150414223242.GA18888@e107981-lin.cambridge.arm.com>
 <20150415161759.GB1111@linaro.org>
Message-ID: <20150415173513.GE23758@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 15, 2015 at 05:17:59PM +0100, Lina Iyer wrote:
> On Tue, Apr 14 2015 at 16:32 -0600, Lorenzo Pieralisi wrote:
> >On Tue, Apr 14, 2015 at 03:21:17PM +0100, Kumar Gala wrote:
> >
> >[...]
> >
> >> > Looking beyond this set of patches, I can foresee that you won't care
> >> > about the generic arm64 cpuidle driver either, or more precisely the
> >> > separation between cpuidle subsystem+driver and the SoC-specific
> >> > back-end (cpu_operations).
> >>
> >> That's probably true for what I guess are a number of reasons.  I'm guessing the arm64 cpuidle driver expects PSCI.
> >
> >Wrap lines sensibly please.
> >
> >The arm64 cpuidle driver, that is now arm generic cpuidle driver does
> >not expect anything apart from an enable-method (and you pulled
> >part of its back-end implementation for arm32 Qualcomm platforms, FYI).
> >
> The backend for this SoC would leverage the same platform code as ARM32.
> The cpu_operations callbacks for init and suspend will call into the the
> same platform functions used by arm32 QCOM SoCs.

It is understood, but this does not mean we should merge this patchset,
actually it is the other way around. It was extremely complicated
to factor out some common CPUidle bits because of the prolification
of power down interfaces in arm/mach code, each with its quirks
du jour.

If we had a standard interface (that encompasses what all ARM mach code
power interfaces do, basically PSCI) when arm32 power management code
was being pushed upstream we would not have that power management arm/mach
code today.

PSCI is there to solve that problem, and it predates v8, there is no
reason to merge code that provides no added value (I am obviously
talking about the pseudo-boot protocol this patchset is enabling, not
the platforms themselves which we definitely want to support upstream,
with some preconditions that are equal for everyone) and to leverage
a legacy that does not exist for arm64.

Thanks,
Lorenzo

> 
> Thanks,
> Lina
> 
> >It took years to consolidate it and the main reason was the lack of
> >standard interfaces for power down/up sequences that this patchset of
> >yours wants to promote in arm64 world.
> >
> >The lack of standard power interfaces may not have been an issue for you,
> >who cares about Qualcomm code, it has been a sore issue for people
> >trying to generalize things across ARM platforms in the kernel, which is
> >the only sensible way forward.
> >
> >PSCI is a standard interface (and Qualcomm are already contributing to
> >it, for the records) that can certainly be extended, and you are welcome
> >to contribute to it, but certainly not ignored.
> >
> >Thanks,
> >Lorenzo
> >--
> >To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> >the body of a message to majordomo at vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
