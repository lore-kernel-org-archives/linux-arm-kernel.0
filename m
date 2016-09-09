From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri, 9 Sep 2016 14:45:15 +0100
Subject: [PATCH v3 1/8] arm64: KVM: Use static keys for selecting the GIC
 backend
In-Reply-To: <57D281F1.5000902@arm.com>
References: <1473350810-10857-1-git-send-email-vladimir.murzin@arm.com>
 <1473350810-10857-2-git-send-email-vladimir.murzin@arm.com>
 <57D27EA7.2040500@arm.com> <57D281F1.5000902@arm.com>
Message-ID: <57D2BCEB.3030306@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/09/16 10:33, Vladimir Murzin wrote:
> Hi Marc,
> 
> On 09/09/16 10:19, Marc Zyngier wrote:
>> > Hi Vladimir,
>> > 
> ...
>>> >>  
>>> >> +extern struct static_key_false kvm_gicv3_cpuif;
>> > 
>> > I think we should follow the model set by kvm_vgic_global_state, which
>> > is declared in arm_vgic.h. Even better, we should *embed* the static key
>> > in this structure. This will reduce the clutter and we wouldn't have to
>> > deal with all the section stuff (the hyp_data thing is a good cleanup,
>> > but I'd like to see it as a separate patch if possible).
> Yes, it is what I was thinking about too, but was not sure about which
> way to go, so hyp_data seemed me something we might reuse latter.
> However, I agree that we can defer hyp_data thing...
> 

I've just tried it out and it seems that static keys are not happy to
accept a key after kern_hyp_va is applied at &kvm_vgic_global_state:

> In file included from ./include/linux/jump_label.h:105:0,
>                  from arch/arm64/kvm/hyp/switch.c:19:
> ./arch/arm64/include/asm/jump_label.h: In function ?__guest_run?:
> ./arch/arm64/include/asm/jump_label.h:31:2: warning: asm operand 0 probably doesn?t match constraints
>   asm goto("1: nop\n\t"
>   ^
> ./arch/arm64/include/asm/jump_label.h:31:2: warning: asm operand 0 probably doesn?t match constraints
>   asm goto("1: nop\n\t"
>   ^
> ./arch/arm64/include/asm/jump_label.h:31:2: error: impossible constraint in ?asm?
>   asm goto("1: nop\n\t"
>   ^
> ./arch/arm64/include/asm/jump_label.h:31:2: error: impossible constraint in ?asm?
>   asm goto("1: nop\n\t"
>   ^
> make[1]: *** [arch/arm64/kvm/hyp/switch.o] Error 1
> make: *** [arch/arm64/kvm/hyp/switch.o] Error 2

it looks like we cannot avoid hyp_data thing... if you don't mind I can
do hyp_data clean-up in separate patch. Alternatively, we can do
conversion to static keys for both architectures later as an
optimisation step.

Cheers
Vladimir
