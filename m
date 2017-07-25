From: Jiong.Wang@arm.com (Jiong Wang)
Date: Tue, 25 Jul 2017 14:00:56 +0000
Subject: [PATCH 00/11] ARMv8.3 pointer authentication userspace support
In-Reply-To: <20170725120630.GA8116@leverpostej>
References: <1500480092-28480-1-git-send-email-mark.rutland@arm.com>
 <20170721170509.GC1538@e103592.cambridge.arm.com>,
 <20170725120630.GA8116@leverpostej>
Message-ID: <DB6PR0802MB2405BBA6E6D545F35F0154A39FB80@DB6PR0802MB2405.eurprd08.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > * Should the kernel remove PACs when unwinding user stacks?
> >
> >   This is simple to do, but it's arguably placing a policy in the kernel as to
> >   what we expect user stacks to look like. Regardless, userspace will have to
> >   perform this when unwinding with DWARF.
>>
>> Not sure.  This is arguably not more gross than related things the
>> kernel already does, and may be inefficient for userspace to do e.g.,
>> when capturing perf backtraces.  Still gross though.
>>
>> Side question: do you know whether there will be DWARF / ELF annotations
>> for this?  Since ptr auth is a compile-time option, it is plausible that
>> an attribute could be added to indicate that an image uses it.

> Jiong, Yao, can you answer this?
>
> I think that there's DWARF metadata for unwinding, but I'm not sure
> there's an ELF annotation on an image.
>
> Note that you may link with libraries which may or may not use pointer
> auth, so a single process can have a mixture of code using pointer auth,
> and code which does not.

Yes, there is new DWARF frame information for pointer authentication to describe
the signing status at instruction level.  There is no ELF annotation on an image.

As the use cases of pointer authentication extension in GCC are about return
address signing.  The DWARF extension is mostly around describing signed LR so
the unwinder could have a way to figure out the original value of it to continue
unwinding.

In general, whenever return address, i.e. LR register, is mangled or restored by
hardware instruction, compiler (or assembly writer) is expected to generate a
DW_CFA_AARCH64_negate_ra_state CFA instruction.

For DWARF unwinder, during unwinding, whenever a DW_CFA_AARCH64_negate_ra_state
is hit, the unwinder toggle the LR signing status and kept it in bit zero (lsb)
of a new DWARF register AARCH64_DWARF_PAUTH_RA_STATE whose value must be honored
later when unwinding the value of LR. If the lsb of AARCH64_DWARF_PAUTH_RA_STATE
is set, it means the return address is mangled, then the unwinder needs to
restore LR by either masking off the signature (userspace unwinders need ptrace
interface to get this) or executing signature strip instruction (can only be
done by native unwinder) or executing authentication instruction (can only be
done by native unwinder).

Please see the following links for more details:
  https://gcc.gnu.org/ml/gcc-patches/2017-01/msg00376.html
  https://gcc.gnu.org/ml/gcc-patches/2016-11/msg03010.html


Regards,
Jiong

IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
