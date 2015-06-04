From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 4 Jun 2015 11:34:36 +0200
Subject: [PATCH] KVM: arm64: fix misleading comments in save/restore
In-Reply-To: <1432806186-27993-1-git-send-email-alex.bennee@linaro.org>
References: <1432806186-27993-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <20150604093436.GC7657@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 28, 2015 at 10:43:06AM +0100, Alex Benn?e wrote:
> The elr_el2 and spsr_el2 registers in fact contain the processor state
> before entry into the hypervisor code.

be careful with your use of the hypervisor, in the KVM design the
hypervisor is split across EL1 and EL2.

> In the case of guest state it
> could be in either el0 or el1.

true

> 
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
> ---
>  arch/arm64/kvm/hyp.S | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
> index d755922..1940a4c 100644
> --- a/arch/arm64/kvm/hyp.S
> +++ b/arch/arm64/kvm/hyp.S
> @@ -50,8 +50,8 @@
>  	stp	x29, lr, [x3, #80]
>  
>  	mrs	x19, sp_el0
> -	mrs	x20, elr_el2		// EL1 PC
> -	mrs	x21, spsr_el2		// EL1 pstate
> +	mrs	x20, elr_el2		// PC before hyp entry
> +	mrs	x21, spsr_el2		// pstate before hyp entry
>  
>  	stp	x19, x20, [x3, #96]
>  	str	x21, [x3, #112]
> @@ -82,8 +82,8 @@
>  	ldr	x21, [x3, #16]
>  
>  	msr	sp_el0, x19
> -	msr	elr_el2, x20 				// EL1 PC
> -	msr	spsr_el2, x21 				// EL1 pstate
> +	msr	elr_el2, x20 		// PC to restore
> +	msr	spsr_el2, x21 		// pstate to restore

I don't feel like 'to restore' is much more meaningful here.

I would actually vote for removin the comments all together, since one
should really understand the code as opposed to the comments when
reading this kind of stuff.

Meh, I'm not sure.  Your patch is definitely better than doing nothing.

Marc?

-Christoffer
