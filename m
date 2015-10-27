From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Tue, 27 Oct 2015 14:54:40 +0000
Subject: Trustzone: DSB before/after SMC
In-Reply-To: <20151027143706.GF3091@leverpostej> (Mark Rutland's message of
 "Tue, 27 Oct 2015 14:37:06 +0000")
References: <562F7CBA.7060806@free.fr> <20151027134318.GD3091@leverpostej>
 <562F84BA.5060203@free.fr> <20151027143706.GF3091@leverpostej>
Message-ID: <yw1x4mhce4zz.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Rutland <mark.rutland@arm.com> writes:

> On Tue, Oct 27, 2015 at 03:05:46PM +0100, Mason wrote:
>> On 27/10/2015 14:43, Mark Rutland wrote:
>> 
>> > On Tue, Oct 27, 2015 at 02:31:38PM +0100, Mason wrote:
>> > 
>> >> I have a few questions about SMC. (I'm using Cortex-A9)
>> >>
>> >> Platforms that use SMC often/always execute DSB beforehand.
>> > 
>> > Please give an example. We don't do this for PSCI, for instance.
>> 
>> arch/arm/mach-exynos/exynos-smc.S
>> arch/arm/mach-highbank/smc.S
>> arch/arm/mach-omap2/omap-smc.S
>
> From a quick look, it's not obvious to me why those DSBs are present. It
> would be best to ask the original authors; it may simply be that this
> was never necessary and has simply been copied.

It could be required due to secure firmware bugs or CPU errata.

>> In my case, I just want to write the L2_CONTROL register.
>
> Is that a register in the L2, or in the CPU? Which L2/CPU?

Cortex-A9, he said.  I believe it's the usual PL310 L2 controller.

> There may be a constraint that the memory system needs to be quiescent
> or something to that effect. Without more information I cannot say what
> specifically you need to do.
>
>> > A DSB is certainly not always required before nor after an SMC.
>> 
>> That makes sense. But a colleague mentioned that the secure OS may
>> be using different MMU mappings. In that case, it might be required
>> to wait for all in-flight accesses to resolve?

It's normally a design error for a more secure domain to require things
of a less secure one.  If the secure monitor code requires a DMB for
proper operation, it had better do it itself, or else hostile non-secure
code might be able to exploit it.

-- 
M?ns Rullg?rd
mans at mansr.com
