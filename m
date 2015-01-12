From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 12 Jan 2015 11:40:14 +0000
Subject: [PATCH 5/7] arm64: kvm: move to ESR_ELx macros
In-Reply-To: <20150111182716.GL21444@cbox>
References: <1420632260-8798-1-git-send-email-mark.rutland@arm.com>
 <1420632260-8798-6-git-send-email-mark.rutland@arm.com>
 <20150111182716.GL21444@cbox>
Message-ID: <20150112114013.GD16706@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 11, 2015 at 06:27:16PM +0000, Christoffer Dall wrote:
> On Wed, Jan 07, 2015 at 12:04:18PM +0000, Mark Rutland wrote:
> > Now that we have common ESR_ELx macros, make use of them in the arm64
> > KVM code. The addition of <asm/esr.h> to the include path highlighted
> > badly ordered (i.e. not alphabetical) include lists; these are changed
> > to alphabetical order.
> >
> > There should be no functional change as a result of this patch.
> >
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Christoffer Dall <christoffer.dall@linaro.org>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Cc: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm64/include/asm/kvm_emulate.h | 28 +++++++++++++++-------------
> >  arch/arm64/kvm/emulate.c             |  5 +++--
> >  arch/arm64/kvm/handle_exit.c         | 32 +++++++++++++++++---------------
> >  arch/arm64/kvm/hyp.S                 | 17 +++++++++--------
> >  arch/arm64/kvm/inject_fault.c        | 14 +++++++-------
> >  arch/arm64/kvm/sys_regs.c            | 23 +++++++++++++----------
> >  6 files changed, 64 insertions(+), 55 deletions(-)

[...]

> >  static inline int kvm_vcpu_dabt_get_as(const struct kvm_vcpu *vcpu)
> >  {
> > -     return 1 << ((kvm_vcpu_get_hsr(vcpu) & ESR_EL2_SAS) >> ESR_EL2_SAS_SHIFT);
> > +     return 1 << !!(kvm_vcpu_get_hsr(vcpu) & ESR_ELx_SAS);
> 
> huh?

Sorry, this is nonsense I derived from thinking the SAS field was a
single bit and believing I could remove the need for the shift
definition.

I'll introduce ESR_ELx_SAS_SHIFT in patch 1 and use it here.

Thanks,
Mark.
