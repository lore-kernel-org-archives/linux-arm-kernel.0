From: robherring2@gmail.com (Rob Herring)
Date: Wed, 20 Jun 2012 10:14:01 -0500
Subject: Bindings for SMC/HVC firmware interfaces on ARM (Re: [RFC PATCH]
 ARM: Make a compile trustzone conditionally)
In-Reply-To: <20120620105116.GA2179@linaro.org>
References: <20120611051502.GA24030@july>
 <CAOesGMgGQMwQTUy2g-XSYFrQ-p+x9g2q8kAd-ZYq=TBgVFu0Zw@mail.gmail.com>
 <CAH9JG2X=15G6wDX5SGJkDEVohkQQkzfBoL3Qv7HVuBUMqYnwRg@mail.gmail.com>
 <201206181410.39267.arnd@arndb.de> <4FE125C6.3030401@codeaurora.org>
 <20120620094334.GA32666@mudshark.cambridge.arm.com>
 <20120620105116.GA2179@linaro.org>
Message-ID: <4FE1E8B9.2020200@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/20/2012 05:51 AM, Dave Martin wrote:
> On Wed, Jun 20, 2012 at 10:43:34AM +0100, Will Deacon wrote:
>> Hi Stephen,
>>
>> On Wed, Jun 20, 2012 at 02:22:14AM +0100, Stephen Boyd wrote:
>>> On 06/18/12 07:10, Arnd Bergmann wrote:
>>>> Instead of checking for trustzone_enabled() in each place where
>>>> we call into smc, we can have a generic implementation that
>>>> we call for the disabled case, and provide a vendor specific
>>>> version of that struct with functions that call into smp 
>>>> where necessary.
>>>>
>>>
>>> What if we tried to read the SCR.NS bit to determine if we're running in
>>> secure state or not? It looks like reading SCR is UNDEFINED (i.e. causes
>>> an undefined instruction exception) if we're running in the non-secure
>>> state so I propose we set up an undef hook that traps the SCR access and
>>> lies about the value of the NS bit to indicate we're non-secure.
>>> Basically this:
>>
>> Well, I can't resist reviewing the code, but I don't think we should be
>> trying to detect this (see below).
>>
>>> static int scr_trap(struct pt_regs *regs, unsigned int instr)
>>> {
>>>         int reg = (instr >> 12) & 15;
>>>         if (reg == 15)
>>>                 return 1;
>>
>> Eek -- surely GCC won't allocate PC for the destination register?!
>>
>>>         regs->uregs[reg] = BIT(0); /* Trapped = non-secure */
>>>         regs->ARM_pc += 4;
>>>         return 0;
>>> }
>>>
>>> static struct undef_hook scr_hook = {
>>>         .instr_mask     = 0x0fff0fff,
>>>         .instr_val      = 0x0e110f11,
>>>         .fn             = scr_trap,
>>> };
> 
> (you'd also need to handle the Thumb case; I digress...)
> 
>>>
>>> int in_secure_state(void)
>>> {
>>>         unsigned int scr;
>>>
>>> 	register_undef_hook(&scr_hook);
>>>
>>>         asm volatile(
>>>         "       mrc p15, 0, %0, c1, c1, 0\n"
>>>         : "=r" (scr)
>>>         :
>>>         : "cc");
>>
>> I don't think you need this clobber either.
>>> It seems to mostly work, although I haven't figured out what you do
>>> about the hypervisor case when the hypervisor has disabled the smc
>>> instruction entirely (SCR.SCD=1). At that point I throw up my hands.
>>> Maybe Will has some idea.

Perhaps there are other registers with fewer/different bits in
non-secure mode. IIRC, the A9 GIC has different secure and non-secure
enable bits in a mirrored register. This wouldn't be the best choice
given it is A9 specific and in the GIC.

>>
>> I think this is part of a bigger problem, which is about how we know where
>> we live in the privilege hierarchy and what we have sitting above us. We
>> have exactly the same issue with hypervisors and the hvc instruction.
>>
>> Rather than try to probe the instruction (which by itself isn't enough,
>> since we can't guarantee that the exception will be handled by the upper
>> layers) I would personally prefer to see this described in the device tree.
>> We could have a simple property in the CPU node that says what the interface
>> looks like:
>>
>> 	smc-interface = "samsung, exynos";

You already know you're on samsung,exynos, so you minimally only need to
know non-secure or secure. Presence of the property can indicate
non-secure mode and then the value can be something meaningful to that
platform like version.

>>
>> or whatever you need to identify the interface uniquely. You could have a
>> corresponding entry for hvc-interface (and something like KVM could pass
>> its version to the guest for paravirualisation). If the property is missing,
>> then we take that to mean that the instruction shouldn't be executed on that
>> core -- it may be undefined or there may not be anything to pick up the
>> exception.
> 
> I concur.
> 
> The firmware is the only thing that really knows what's there,
> and in reality there's no safe way to probe.  Even if we know we're in the
> Normal World, we have no idea what's on the other side of SMC.  One
> firmware's "probe" call may be another firmware's "halt and catch fire"
> call.

That reminds me. I need to go write the halt and catch fire call.

> 
> So DT bindings permitting the firmware to tell us what's there make a lot
> of sense.
> 
> 
> Fleshing this out a bit...
> 
> Since the SMC and HVC instructions are features of the architecture, it may
> make sense for the names to be:
> 
> 	arm,smc = "vendor,interface-name";
> 	arm,hvc = "vendor,interface-name";
> 
> Some platforms may not fully service SMC on all CPUs, so there might be a
> need to set this per CPU node.  This can be topologically determined, so
> you might have:

You would know this by knowing the type of firmware.

> 
> 	cluster at 0 {
> 		arm,smc = "vendor,platform-basic-firmware";
> 		
> 		cpu at 0 {
> 			arm,smc = "vendor,platform-fancy-firmware";
> 		};
> 
> 		cpu at 1 {
> 			// no arm,smc property
> 		};
> 
> 		cpu at 2 {
> 			// no arm,smc property
> 		};
> 
> 		// ...
> 	}
> 
> The set of supported SMC calls on a CPU would then be determined by the
> list of all strings on arm,smc properties on that CPU node and its
> ancestors.
> 
> If the arm,smc or arm,hvc property is absent at all levels of the
> topology, this does not mean that there is nothing there, but it does
> mean that nothing is known about what's there.  Platform code would fall
> back to the legacy case in that situation.
> 
> 
> If additional properties are needed, like version or capability info,
> we could have nodes instead:
> 
> 	cluster at 0 {
> 		arm,smc {
> 			basic-firmware {
> 				compatible = "vendor,platform-basic-firmware";
> 			};
> 		}
> 
> 		cpu at 0 {
> 			arm,smc {
> 				fancy-firmware {
> 					compatible = "vendor,platform-fancy-firmware";
> 					version = <1 12>;
> 					capabilities = "whizz", "bang", "kapow";
> 				};
> 
> 				common-firmware {
> 					compatible = "standards-body,common-firmware";
> 					version = <1 0>;
> 				}
> 			};
> 		};
> 
> 		// ...
> 	};
> 
> ...or something equally esoteric.
> 

This seems overly complex. While all of these conditions could happen,
what is reality?

I hope this smc mess is getting standardized for v8...

Rob

> (If node names like "arm,smc" are acceptable ... we could have something
> else if not.)
> 
> It would be up to the platform's code handling "vendor,platform-fancy-
> firmware" etc. to know about and deal with the precise calling
> conventions for that firmware, though if there are generic firmware
> interfaces someday, then those nodes' support code could be shared.
> 
> Cheers
> ---Dave
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
