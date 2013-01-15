From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 15 Jan 2013 11:10:43 +0000
Subject: [PATCH v5 3/4] ARM: KVM: arch_timers: Add timer world switch
In-Reply-To: <CANM98qLsq7=PRNu4-5-N2GaAuLFOUfpy-yEWb6LpZri3WQ8JwA@mail.gmail.com>
References: <20130108184259.46758.17939.stgit@ubuntu>
 <20130108184327.46758.70599.stgit@ubuntu>
 <20130114152101.GD18935@mudshark.cambridge.arm.com>
 <50F445BC.6050507@arm.com>
 <CANM98qLsq7=PRNu4-5-N2GaAuLFOUfpy-yEWb6LpZri3WQ8JwA@mail.gmail.com>
Message-ID: <50F53933.7050309@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/01/13 22:08, Christoffer Dall wrote:
> On Mon, Jan 14, 2013 at 12:51 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On 14/01/13 15:21, Will Deacon wrote:
>>> On Tue, Jan 08, 2013 at 06:43:27PM +0000, Christoffer Dall wrote:
>>>> From: Marc Zyngier <marc.zyngier@arm.com>
>>>>
>>>> Do the necessary save/restore dance for the timers in the world
>>>> switch code. In the process, allow the guest to read the physical
>>>> counter, which is useful for its own clock_event_device.
>>>
>>> [...]
>>>
>>>> @@ -476,6 +513,7 @@ vcpu     .req    r0              @ vcpu pointer always in r0
>>>>   * for the host.
>>>>   *
>>>>   * Assumes vcpu pointer in vcpu reg
>>>> + * Clobbers r2-r4
>>>>   */
>>>>  .macro restore_timer_state
>>>>      @ Disallow physical timer access for the guest
>>>> @@ -484,6 +522,30 @@ vcpu    .req    r0              @ vcpu pointer always in r0
>>>>      orr     r2, r2, #CNTHCTL_PL1PCTEN
>>>>      bic     r2, r2, #CNTHCTL_PL1PCEN
>>>>      mcr     p15, 4, r2, c14, c1, 0  @ CNTHCTL
>>>> +
>>>> +#ifdef CONFIG_KVM_ARM_TIMER
>>>> +    ldr     r4, [vcpu, #VCPU_KVM]
>>>> +    ldr     r2, [r4, #KVM_TIMER_ENABLED]
>>>> +    cmp     r2, #0
>>>> +    beq     1f
>>>> +
>>>> +    ldr     r2, [r4, #KVM_TIMER_CNTVOFF]
>>>> +    ldr     r3, [r4, #(KVM_TIMER_CNTVOFF + 4)]
>>>> +    mcrr    p15, 4, r2, r3, c14     @ CNTVOFF
>>>> +    isb
>>>> +
>>>> +    ldr     r4, =VCPU_TIMER_CNTV_CVAL
>>>> +    add     vcpu, vcpu, r4
>>>> +    ldrd    r2, r3, [vcpu]
>>>> +    sub     vcpu, vcpu, r4
>>>> +    mcrr    p15, 3, r2, r3, c14     @ CNTV_CVAL
>>>> +
>>>> +    ldr     r2, [vcpu, #VCPU_TIMER_CNTV_CTL]
>>>> +    and     r2, r2, #3
>>>> +    mcr     p15, 0, r2, c14, c3, 1  @ CNTV_CTL
>>>> +    isb
>>>
>>> How many of these isbs are actually needed, given that we're going to make
>>> an exception return to the guest? The last one certainly looks redundant and
>>> I can't see the need for ordering CNTVOFF vs CNTV_CVAL. I can see an
>>> argument to putting one *before* CNTV_CTL, but you don't have one there!
>>
>> CNTVOFF directly influences whether or not CNTV_CVAL will trigger or
>> not. Maybe I'm just being paranoid and moving the isb after CNTV_CVAL is
>> enough.
>>
>> The last one is definitively superfluous.
>>
> 
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

This isb is required. Otherwise you have no guarantee about how recent
the next CNTV_CVAL read is (could be speculated).

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
>  1:
>  #endif
>  .endm

This part is OK.

	M.
-- 
Jazz is not dead. It just smells funny...
