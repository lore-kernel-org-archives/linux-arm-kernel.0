From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 Jan 2013 22:25:33 +0000
Subject: [PATCH v5 3/4] ARM: KVM: arch_timers: Add timer world switch
In-Reply-To: <CANM98qLsq7=PRNu4-5-N2GaAuLFOUfpy-yEWb6LpZri3WQ8JwA@mail.gmail.com>
References: <20130108184259.46758.17939.stgit@ubuntu>
 <20130108184327.46758.70599.stgit@ubuntu>
 <20130114152101.GD18935@mudshark.cambridge.arm.com>
 <50F445BC.6050507@arm.com>
 <CANM98qLsq7=PRNu4-5-N2GaAuLFOUfpy-yEWb6LpZri3WQ8JwA@mail.gmail.com>
Message-ID: <20130114222533.GA3937@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 10:08:39PM +0000, Christoffer Dall wrote:
> can't we also get rid of the isb on the return path then?
> 
> do you agree with this patch:
> 
> diff --git a/arch/arm/kvm/interrupts_head.S b/arch/arm/kvm/interrupts_head.S
> index 57cfa84..7e6eedf 100644
> --- a/arch/arm/kvm/interrupts_head.S
> +++ b/arch/arm/kvm/interrupts_head.S
> @@ -492,7 +492,6 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>  	str	r2, [vcpu, #VCPU_TIMER_CNTV_CTL]
>  	bic	r2, #1			@ Clear ENABLE
>  	mcr	p15, 0, r2, c14, c3, 1	@ CNTV_CTL
> -	isb

I'd keep this one as it stops speculation of CVAL until the timer is
disabled.

>  	mrrc	p15, 3, r2, r3, c14	@ CNTV_CVAL
>  	ldr	r4, =VCPU_TIMER_CNTV_CVAL
> @@ -532,18 +531,17 @@ vcpu	.req	r0		@ vcpu pointer always in r0
>  	ldr	r2, [r4, #KVM_TIMER_CNTVOFF]
>  	ldr	r3, [r4, #(KVM_TIMER_CNTVOFF + 4)]
>  	mcrr	p15, 4, r2, r3, c14	@ CNTVOFF
> -	isb
> 
>  	ldr	r4, =VCPU_TIMER_CNTV_CVAL
>  	add	vcpu, vcpu, r4
>  	ldrd	r2, r3, [vcpu]
>  	sub	vcpu, vcpu, r4
>  	mcrr	p15, 3, r2, r3, c14	@ CNTV_CVAL
> +	isb
> 
>  	ldr	r2, [vcpu, #VCPU_TIMER_CNTV_CTL]
>  	and	r2, r2, #3
>  	mcr	p15, 0, r2, c14, c3, 1	@ CNTV_CTL
> -	isb

Looks ok to me, but I'll let Marc decide as it's his code.

Will
