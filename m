From: will.deacon@arm.com (Will Deacon)
Date: Thu, 3 Mar 2016 19:19:20 +0000
Subject: [PATCH v2 2/5] arm64: add ARMv8.2 id_aa64mmfr2 boiler plate
In-Reply-To: <56D88A6C.8070304@codeaurora.org>
References: <1454684330-892-1-git-send-email-james.morse@arm.com>
 <1454684330-892-3-git-send-email-james.morse@arm.com>
 <56D87B74.1010306@codeaurora.org> <56D88219.6040806@arm.com>
 <56D88A6C.8070304@codeaurora.org>
Message-ID: <20160303191920.GA650@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 03, 2016 at 02:03:08PM -0500, Christopher Covington wrote:
> On 03/03/2016 01:27 PM, Robin Murphy wrote:
> > On 03/03/16 17:59, Christopher Covington wrote:
> 
> >>> --- a/arch/arm64/kernel/cpuinfo.c
> >>> +++ b/arch/arm64/kernel/cpuinfo.c
> >>> @@ -210,6 +210,7 @@ static void __cpuinfo_store_cpu(struct
> >>> cpuinfo_arm64 *info)
> >>>       info->reg_id_aa64isar1 = read_cpuid(SYS_ID_AA64ISAR1_EL1);
> >>>       info->reg_id_aa64mmfr0 = read_cpuid(SYS_ID_AA64MMFR0_EL1);
> >>>       info->reg_id_aa64mmfr1 = read_cpuid(SYS_ID_AA64MMFR1_EL1);
> >>> +    info->reg_id_aa64mmfr2 = read_cpuid(SYS_ID_AA64MMFR2_EL1);
> >>>       info->reg_id_aa64pfr0 = read_cpuid(SYS_ID_AA64PFR0_EL1);
> >>>       info->reg_id_aa64pfr1 = read_cpuid(SYS_ID_AA64PFR1_EL1);
> >>
> >> swapper[0]: undefined instruction: pc=ffffff800808d730
> >> Code: d5380702 d5380721 f9017c02 f9018001 (d5380742)
> >> Internal error: Oops - undefined instruction: 0 [#1] PREEMPT SMP
> >> Modules linked in:
> >> CPU: 0 PID: 0 Comm: swapper Not tainted 4.5.0-rc6-next-20160303 #1
> >> Hardware name: (null) (DT)
> >> task: ffffff8008b2d980 ti: ffffff8008b20000 task.ti: ffffff8008b20000
> >> PC is at __cpuinfo_store_cpu+0x68/0x198
> >> LR is at cpuinfo_store_boot_cpu+0x28/0x50
> >>
> >> ffffff800808d730:       d5380742        mrs     x2, s3_0_c0_c7_2
> > 
> > Hmm, per table C5-6 in the ARMv8 ARM (issue i), that's specifically a
> > reserved encoding, rather than an unallocated one, so it should read as
> > zero, not undef. What are you running on?
> 
> QDF2432. I'll investigate.

FWIW, I think the same issue was reported on qemu, so we may want to
handle this in the kernel anyway. We could either use alternatives on
the register read or handle the undef.

Will
