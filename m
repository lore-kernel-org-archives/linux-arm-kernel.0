From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 19 Apr 2016 16:22:04 +0100
Subject: [PATCH v7 06/16] arm64: hyp/kvm: Extend hyp-stub API to allow
 function calls at EL2
In-Reply-To: <1459529620-22150-7-git-send-email-james.morse@arm.com>
References: <1459529620-22150-1-git-send-email-james.morse@arm.com>
 <1459529620-22150-7-git-send-email-james.morse@arm.com>
Message-ID: <57164D1C.7000000@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/16 17:53, James Morse wrote:
> From: Geoff Levand <geoff@infradead.org>
> 
> The existing arm64 hcall implementations are limited in that they only
> allow for two distinct hcalls; with the x0 register either zero or not
> zero.  Also, the API of the hyp-stub exception vector routines and the
> KVM exception vector routines differ; hyp-stub uses a non-zero value in
> x0 to implement __hyp_set_vectors, whereas KVM uses it to implement
> kvm_call_hyp.
> 
> To allow for additional hcalls to be defined and to make the arm64 hcall
> API more consistent across exception vector routines, change the hcall
> implementations to reserve all x0 values below PAGE_SIZE for hcalls such
> as {s,g}et_vectors().

<pedantic>
Given that we already have 3 possible page sizes, defining an API in
terms of PAGE_SIZE is a bit risky. I don't anticipate someone coming up
with a 4097th host hypercall anytime soon, but just to be on the safe
size, let's cap it to 0xfff.
</pedantic>

> 
> Define two new preprocessor macros HVC_GET_VECTORS, and HVC_SET_VECTORS
> to be used as hcall type specifiers and convert the existing
> __hyp_get_vectors() and __hyp_set_vectors() routines to use these new
> macros when executing an HVC call.  Also, change the corresponding
> hyp-stub and KVM el1_sync exception vector routines to use these new
> macros.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> [Merged two hcall patches, moved immediate value from esr to x0, use lr
>  as a scratch register]
> Signed-off-by: James Morse <james.morse@arm.com>

Otherwise:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
