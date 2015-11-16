From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 16 Nov 2015 14:32:25 +0000
Subject: [PATCH 15/21] arm64: KVM: Add panic handling
In-Reply-To: <5649E7A0.3050109@arm.com>
References: <1447679519-17888-1-git-send-email-marc.zyngier@arm.com>
 <1447679519-17888-16-git-send-email-marc.zyngier@arm.com>
 <20151116141629.GH20696@leverpostej> <5649E7A0.3050109@arm.com>
Message-ID: <20151116143224.GK20696@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> +	/* Call panic for real */
> >> +	while (1) {
> >> +		unsigned long str_va = (unsigned long)__hyp_panic_string;
> >> +
> >> +		str_va -= HYP_PAGE_OFFSET;
> >> +		str_va += PAGE_OFFSET;
> >> +		__hyp_do_panic(str_va,
> >> +			       spsr,  elr,
> >> +			       read_sysreg(esr_el2),   read_sysreg(far_el2),
> >> +			       read_sysreg(hpfar_el2), par,
> >> +			       read_sysreg(tpidr_el2));
> >> +	}
> >> +}
> > 
> > I think the while (1) here is confusing.
> > 
> > Can we not jsut declare str_va at the start of the function and get rid
> > of the loop?
> 
> The while(1) is to prevent GCC from screaming (it otherwise believes
> that the function actually returns, despite the __noreturn attribute).

Aha!

Perhaps a comment to that effect...?

> Or were you thinking of something else?

I just failed to derive the __noreturn problem from first principles.

Perhaps follow the __hyp_do_panic() call with an unreachable(), with the
comment as to GCC failing to reason about the __noreturn? That would be
less confusing than the loop, assuming that it works.

Mark.
