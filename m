From: will.deacon@arm.com (Will Deacon)
Date: Tue, 20 Mar 2018 09:47:44 +0000
Subject: [PATCH v2] arm64: KVM: Use SMCCC_ARCH_WORKAROUND_1 for Falkor BP
 hardening
In-Reply-To: <fed53181-db58-9f48-0c5b-7eebe9eb9b10@arm.com>
References: <1520269603-2900-1-git-send-email-shankerd@codeaurora.org>
 <861sgx5wb6.wl-marc.zyngier@arm.com>
 <fed53181-db58-9f48-0c5b-7eebe9eb9b10@arm.com>
Message-ID: <20180320094744.GA24986@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 19, 2018 at 06:30:16PM +0000, Marc Zyngier wrote:
> On 06/03/18 10:32, Marc Zyngier wrote:
> > On Mon, 05 Mar 2018 17:06:43 +0000,
> > Shanker Donthineni wrote:
> >>
> >> The function SMCCC_ARCH_WORKAROUND_1 was introduced as part of SMC
> >> V1.1 Calling Convention to mitigate CVE-2017-5715. This patch uses
> >> the standard call SMCCC_ARCH_WORKAROUND_1 for Falkor chips instead
> >> of Silicon provider service ID 0xC2001700.
> >>
> >> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
> >> ---
> >> Chnages since v1:
> >>   - Trivial change in cpucaps.h (refresh after removing ARM64_HARDEN_BP_POST_GUEST_EXIT)
> >>
> >>  arch/arm64/include/asm/cpucaps.h |  5 ++--
> >>  arch/arm64/include/asm/kvm_asm.h |  2 --
> >>  arch/arm64/kernel/bpi.S          |  8 ------
> >>  arch/arm64/kernel/cpu_errata.c   | 55 ++++++++++++++--------------------------
> >>  arch/arm64/kvm/hyp/entry.S       | 12 ---------
> >>  arch/arm64/kvm/hyp/switch.c      | 10 --------
> >>  6 files changed, 21 insertions(+), 71 deletions(-)
> > 
> > Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> > 
> > Will/Catalin, if you want to take it via the arm64 tree, that's fine
> > by me.
> 
> Please allow me to change my mind. This is going to conflict horribly
> with the VHE rework and the HYP randomization patches.
> 
> I'll take it via the KVM tree, which will make everyone's life a lot easier.

Sure; if you need it:

Acked-by: Will Deacon <will.deacon@arm.com>

You'll probably want to comment out the ARM64_HARDEN_BP_POST_GUEST_EXIT
capability for now to avoid silly conflicts in -next. I can remove and
renumber at -rc1.

Will
