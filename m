From: punit.agrawal@arm.com (Punit Agrawal)
Date: Fri, 07 Nov 2014 18:15:20 +0000
Subject: [PATCHv3 3/5] arm64: Port SWP/SWPB emulation support from arm
In-Reply-To: <20141105114734.GF32700@e104818-lin.cambridge.arm.com> (Catalin
 Marinas's message of "Wed, 5 Nov 2014 11:47:34 +0000")
References: <1414435207-30240-1-git-send-email-punit.agrawal@arm.com>
 <1414435207-30240-5-git-send-email-punit.agrawal@arm.com>
 <20141105114734.GF32700@e104818-lin.cambridge.arm.com>
Message-ID: <9hhfvdu3miv.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Mon, Oct 27, 2014 at 06:40:05PM +0000, Punit Agrawal wrote:
>> --- /dev/null
>> +++ b/Documentation/arm64/legacy_instructions.txt
>> @@ -0,0 +1,40 @@
>> +The arm64 port of the Linux kernel provides infrastructure to support
>> +emulation of instructions which have been deprecated, or obsoleted in
>> +the architecture. The infrastructure code uses undefined instruction
>> +hooks to support emulation. Where available it also allows turning on
>> +the instruction execution in hardware.
>> +
>> +The emulation mode can be controlled by writing to sysctl nodes
>> +(/proc/sys/abi). The following explains the different execution
>> +behaviours and the corresponding values of the sysctl nodes -
>> +
>> +* Undef
>> +  Value: 0
>> +  Generates undefined instruction abort. Default for instructions that
>> +  have been obsoleted in the architecture, e.g., SWP
>> +
>> +* Emulate
>> +  Value: 1
>> +  Uses software emulation. To aid migration of software, in this mode
>> +  usage of emulated instruction is traced as well as rate limited
>> +  warnings are issued. This is the default for deprecated
>> +  instructions, .e.g., CP15 barriers
>> +
>> +* Hardware Execution
>> +  Value: 2
>> +  Although marked as deprecated, some implementations may support the
>> +  enabling/disabling of hardware support for the execution of these
>> +  instructions. Using hardware execution generally provides better
>> +  performance, but at the loss of ability to gather runtime statistics
>> +  about the use of the deprecated instructions.
>> +
>> +The default mode depends on the status of the instruction in the
>> +architecture. Deprecated instructions should default to emulation
>> +while obsolete instructions must be undefined by default.
>> +
>> +Supported legacy instructions
>> +-----------------------------
>> +* SWP{B}
>> +Node: /proc/sys/abi/swp
>> +Status: Obsolete
>> +Default: Undef (0)
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 9532f8d..6ae8079 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -162,6 +162,45 @@ config ARCH_XGENE
>>         help
>>           This enables support for AppliedMicro X-Gene SOC Family
>> 
>> +comment "Processor Features"
>> +
>> +menuconfig ARMV8_DEPRECATED
>> +       bool "Emulate deprecated/obsolete ARMv8 instructions"
>> +       depends on COMPAT
>> +       help
>> +         Legacy software support may require certain instructions
>> +         that have been deprecated or obsoleted in the architecture.
>> +
>> +         Enable this config to enable selective emulation of these
>> +         features.
>> +
>> +         If unsure, say N
>
> I think if unsure we should say Y. It should probably be disabled if you
> know for sure you are not going to have legacy applications using
> deprecated instructions. We could even have a "default y".

I replied in another email to why this wasn't turned off by default. Let
me know if you'd like to change it.

>
>> +
>> +if ARMV8_DEPRECATED
>
> Does menuconfig automatically imply an "if"? Not sure.
>
>> +
>> +config SWP_EMULATION
>> +       bool "Emulate SWP/SWPB instructions"
>> +       help
>> +         ARMv8 obsoletes the use of A32 SWP/SWPB instructions such that
>> +         they are always undefined. Say Y here to enable software
>> +         emulation of these instructions for userspace using LDXR/STXR.
>> +
>> +         In some older versions of glibc [<=2.8] SWP is used during futex
>> +         trylock() operations with the assumption that the code will not
>> +         be preempted. This invalid assumption may be more likely to fail
>> +         with SWP emulation enabled, leading to deadlock of the user
>> +         application.
>> +
>> +         NOTE: when accessing uncached shared regions, LDXR/STXR rely
>> +         on an external transaction monitoring block called a global
>> +         monitor to maintain update atomicity. If your system does not
>> +         implement a global monitor, this option can cause programs that
>> +         perform SWP operations to uncached memory to deadlock.
>> +
>> +         If unsure, say N
>
> Same here, I think we should default to y.

Again, same as above.

>
>> +static void update_insn_emulation_mode(struct insn_emulation *insn,
>> +                                      enum insn_emulation_mode prev)
>> +{
>> +       switch (prev) {
>> +       case INSN_UNDEF: /* Nothing to be done */
>> +               break;
>> +       case INSN_EMULATE:
>> +               remove_emulation_hooks(insn->ops);
>> +               break;
>> +       case INSN_HW:
>> +               if (insn->ops->set_hw_mode) {
>> +                       insn->ops->set_hw_mode(false);
>> +                       pr_notice("Disabled %s support\n", insn->ops->name);
>> +               }
>> +               break;
>> +       }
>> +
>> +       switch (insn->current_mode) {
>> +       case INSN_UNDEF:
>> +               break;
>> +       case INSN_EMULATE:
>> +               register_emulation_hooks(insn->ops);
>> +               break;
>> +       case INSN_HW:
>> +               if (insn->ops->set_hw_mode) {
>> +                       insn->ops->set_hw_mode(true);
>> +                       pr_notice("Enabled %s support\n", insn->ops->name);
>> +               }
>> +               break;
>
> Here we should return -EINVAL all the way to the sysctl hook when
> !set_hw_mode. SWP doesn't have a hw mode on ARMv8, so we should let the
> user know. We even remove the emulation in this case falling back to
> undef.

If set_hw_mode callback is not provided- which swp doesn't, then
the min-max check performed when parsing the value written to sysctl
will fail. So it already works as you suggest for swp - but I take your
point about erroring out all the way to userspace if something doesn't
succeed.

I'll audit the code to make sure all code paths behave accordingly.

Thanks for your feedback. I'll post a new version with the updates.
