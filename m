From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Fri, 30 Nov 2012 15:22:28 -0500
Subject: [PATCH v4 09/14] KVM: ARM: Emulation framework and CP15 emulation
In-Reply-To: <20121119150105.GB3205@mudshark.cambridge.arm.com>
References: <20121110154203.2836.46686.stgit@chazy-air>
 <20121110154313.2836.2851.stgit@chazy-air>
 <20121119150105.GB3205@mudshark.cambridge.arm.com>
Message-ID: <CANM98qKSnt8dmjs9f5ufLPBYAvaSunzKsDTMfi2hm6nLjgjLqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 10:01 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Sat, Nov 10, 2012 at 03:43:13PM +0000, Christoffer Dall wrote:
>> Adds a new important function in the main KVM/ARM code called
>> handle_exit() which is called from kvm_arch_vcpu_ioctl_run() on returns
>> from guest execution. This function examines the Hyp-Syndrome-Register
>> (HSR), which contains information telling KVM what caused the exit from
>> the guest.
>>
>> Some of the reasons for an exit are CP15 accesses, which are
>> not allowed from the guest and this commit handles these exits by
>> emulating the intended operation in software and skipping the guest
>> instruction.
>>
>> Minor notes about the coproc register reset:
>> 1) We reserve a value of 0 as an invalid cp15 offset, to catch bugs in our
>>    table, at cost of 4 bytes per vcpu.
>>
>> 2) Added comments on the table indicating how we handle each register, for
>>    simplicity of understanding.
>>
>> Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
>> Signed-off-by: Rusty Russell <rusty.russell@linaro.org>
>> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
>
> [...]
>
>> diff --git a/arch/arm/kvm/coproc_a15.c b/arch/arm/kvm/coproc_a15.c
>> new file mode 100644
>> index 0000000..55cb4a3
>> --- /dev/null
>> +++ b/arch/arm/kvm/coproc_a15.c
>> @@ -0,0 +1,164 @@
>> +/*
>> + * Copyright (C) 2012 - Virtual Open Systems and Columbia University
>> + * Authors: Rusty Russell <rusty@rustcorp.au>
>> + *          Christoffer Dall <c.dall@virtualopensystems.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License, version 2, as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
>> + */
>> +#include <linux/kvm_host.h>
>> +#include <asm/cputype.h>
>> +#include <asm/kvm_arm.h>
>> +#include <asm/kvm_host.h>
>> +#include <asm/kvm_emulate.h>
>> +#include <asm/kvm_coproc.h>
>> +#include <linux/init.h>
>> +
>> +#define MPIDR_CPUID    0x3
>
> This should probably be 0xff and also use the macros that Lorenzo is
> introducing:
>
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2012-November/132977.html
>

in the A15 TRM bits [7:2] are reserved, so we really only do care
about bits [1:0], and this file is A15 specific, but if you prefer, I
can merge this:

diff --git a/arch/arm/kvm/coproc_a15.c b/arch/arm/kvm/coproc_a15.c
index 55cb4a3..685063a 100644
--- a/arch/arm/kvm/coproc_a15.c
+++ b/arch/arm/kvm/coproc_a15.c
@@ -24,8 +24,6 @@
 #include <asm/kvm_coproc.h>
 #include <linux/init.h>

-#define MPIDR_CPUID    0x3
-
 static void reset_mpidr(struct kvm_vcpu *vcpu, const struct coproc_reg *r)
 {
 	/*
@@ -35,8 +33,8 @@ static void reset_mpidr(struct kvm_vcpu *vcpu, const
struct coproc_reg *r)
 	 * revealing the underlying hardware properties is likely to
 	 * be the best choice).
 	 */
-	vcpu->arch.cp15[c0_MPIDR] = (read_cpuid_mpidr() & ~MPIDR_CPUID)
-		| (vcpu->vcpu_id & MPIDR_CPUID);
+	vcpu->arch.cp15[c0_MPIDR] = (read_cpuid_mpidr() & ~MPIDR_LEVEL_MASK)
+		| (vcpu->vcpu_id & MPIDR_LEVEL_MASK);
 }

 #include "coproc.h"
--

-Christoffer
