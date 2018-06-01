From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 1 Jun 2018 10:42:24 +0100
Subject: [PATCH] KVM: arm64: VHE: Migrate _elx sysreg accessors to
 msr_s/mrs_s
In-Reply-To: <1527603647-24787-1-git-send-email-Dave.Martin@arm.com>
References: <1527603647-24787-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <20180601094224.ctyvafybcnzys6f4@salmiak>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, May 29, 2018 at 03:20:47PM +0100, Dave Martin wrote:
> Currently, the {read,write}_sysreg_el*() accessors for accessing
> particular ELs' sysregs in the presence of VHE rely on some local
> hacks and define their system register encodings in a way that is
> inconsistent with the core definitions in <asm/sysreg.h>.
> 
> As a result, it is necessary to add duplicate definitions for any
> system register that already needs a definition in sysreg.h for
> other reasons.
> 
> This is a bit of a maintenance headache, and the reasons for the
> _el*() accessors working the way they do is a bit historical.
> 
> This patch gets rid of the shadow sysreg definitions in
> <asm/kvm_hyp.h>, converts the _el*() accessors to use the core
> msr_s/mrs_s interface, and converts all call sites to use the
> standard sysreg #define names (i.e., upper case, with SYS_ prefix).

Nice!

[...]

>  static inline unsigned long vcpu_read_elr_el1(const struct kvm_vcpu *vcpu)
>  {
>  	if (vcpu->arch.sysregs_loaded_on_cpu)
> -		return read_sysreg_el1(elr);
> +		return read_sysreg_el1(SYS_ELR);

Could we have the macro implicitly handle the SYS_ prefix?

A further bit of cleanup that I'd like to do is make {read,write}_sysreg() use
{mrs,msr}_s, implicitly handling the SYS_ prefix, so that we can kill off
{read,write}_sysreg_s(), and always use a {read,write}_sysreg().

A minor pain point is that we'd have to convert callers to pass the sysreg name
in upper-case, but that conversion can be scripted fairly easily.

e.g. for the above, read_sysreg() would take ELR_EL1, and read_sysreg_el1()
would take ELR.

Thanks,
Mark.
