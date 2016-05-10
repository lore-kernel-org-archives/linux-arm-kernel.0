From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Tue, 10 May 2016 14:41:54 +0100
Subject: [PATCH] arm64: kgdb: Match pstate size with gdbserver protocol
In-Reply-To: <20160510104511.GH687@leverpostej>
References: <1462815566-15086-1-git-send-email-daniel.thompson@linaro.org>
 <20160510104511.GH687@leverpostej>
Message-ID: <df946c87-162f-fdda-879b-76b4ad1a1c7a@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/05/16 11:45, Mark Rutland wrote:
>> When commit 44679a4f142b ("arm64: KGDB: Add step debugging support") was
>> introduced it was paired with a gdb patch that made an incompatible
>> change to the gdbserver protocol. This patch was eventually merged into
>> the gdb sources:
>> https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=commit;h=a4d9ba85ec5597a6a556afe26b712e878374b9dd
>>
>> The change to the protocol was mostly made to simplify big-endian support
>> inside the kernel gdb stub.
>
> While that was how we discovered the inconsistency, a major concern is
> that SPSR_EL* (i.e. PSTATE), as accessed by MRS/MSR is a 64-bit
> quantity, even if the upper 32 bits are RES0 today.
>
> It is conceivable that the upper 32 bits could be used in future (as
> happened with CLIDR_EL1), and for this reason we expose those upper 32
> bits from the kernel, and treat system registers as 64-bit quantities
> generally.

These cases are not exactly the same.

CLIDR_ELx is (or was) architecturally defined as a 64-bit register and 
explicitly marks the upper 32-bits as RES0.

That is not the case for SPSR_ELx; this register is architecturally 
defined to be 32-bit.

I know that doesn't *prevent* SPSR_ELx from being expanded in the future 
it is not unreasonable for gdb to design its wire protocol based on the 
description found in the architecture manual.


> So this was also about ensuring the interface was consistent and to some
> extent future-proof.

gdb remote protocol is already future proof and has never at any point 
contradicted the architecture.

However the changes to the protocol in 7.7.x and 7.8.0 were analogous to 
an unexpected ABI change rather than a carefully controlled introduction 
of a new feature. Like the kernel, once detected, they were reversed ;-) .


Daniel.
