From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 14 Jan 2013 10:40:28 -0500
Subject: [PATCH v5 03/14] KVM: ARM: Initial skeleton to compile KVM support
In-Reply-To: <20130114150917.GA18935@mudshark.cambridge.arm.com>
References: <20130108183811.46302.58543.stgit@ubuntu>
 <20130108183855.46302.40539.stgit@ubuntu>
 <20130114150917.GA18935@mudshark.cambridge.arm.com>
Message-ID: <CANM98qLyc54+ZbdMMTxerZUZQBEXuchzV=fmjgMpNFPZyamqQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 10:09 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Jan 08, 2013 at 06:38:55PM +0000, Christoffer Dall wrote:
>> Targets KVM support for Cortex A-15 processors.
>>
>> Contains all the framework components, make files, header files, some
>> tracing functionality, and basic user space API.
>>
>> Only supported core is Cortex-A15 for now.
>>
>> Most functionality is in arch/arm/kvm/* or arch/arm/include/asm/kvm_*.h.
>>
>> Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
>> Signed-off-by: Rusty Russell <rusty.russell@linaro.org>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
>> ---
>>  Documentation/virtual/kvm/api.txt  |   57 +++++-
>>  arch/arm/Kconfig                   |    2
>>  arch/arm/Makefile                  |    1
>>  arch/arm/include/asm/kvm_arm.h     |   24 ++
>>  arch/arm/include/asm/kvm_asm.h     |   58 ++++++
>>  arch/arm/include/asm/kvm_coproc.h  |   24 ++
>>  arch/arm/include/asm/kvm_emulate.h |   50 +++++
>>  arch/arm/include/asm/kvm_host.h    |  114 ++++++++++++
>>  arch/arm/include/uapi/asm/kvm.h    |  106 +++++++++++
>
> [...]
>
>> diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
>> new file mode 100644
>> index 0000000..c6298b1
>> --- /dev/null
>> +++ b/arch/arm/include/uapi/asm/kvm.h
>> @@ -0,0 +1,106 @@
>> +/*
>> + * Copyright (C) 2012 - Virtual Open Systems and Columbia University
>> + * Author: Christoffer Dall <c.dall@virtualopensystems.com>
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
>> +
>> +#ifndef __ARM_KVM_H__
>> +#define __ARM_KVM_H__
>> +
>> +#include <asm/types.h>
>> +#include <asm/ptrace.h>
>
> I think you want linux/types.h, as asm/types.h isn't exported from what I
> can tell. make headers_check screams about it too:
>
> /home/will/sources/linux/linux/usr/include/asm/kvm.h:22: include of <linux/types.h> is preferred over <asm/types.h>
> /home/will/sources/linux/linux/usr/include/asm/kvm.h:57: found __[us]{8,16,32,64} type without #include <linux/types.h>
>
right, fixed:

commit 4f880a3224b26a854736f19b21de9d457829940e
Author: Christoffer Dall <c.dall@virtualopensystems.com>
Date:   Mon Jan 14 10:39:03 2013 -0500

    KVM: ARM: Include linux/types.h instead of asm/types.h

    Include the right header file.

    Cc: Will Deacon <will.deacon@arm.com>
    Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>

diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
index 972b90d..236f528 100644
--- a/arch/arm/include/uapi/asm/kvm.h
+++ b/arch/arm/include/uapi/asm/kvm.h
@@ -19,7 +19,7 @@
 #ifndef __ARM_KVM_H__
 #define __ARM_KVM_H__

-#include <asm/types.h>
+#include <linux/types.h>
 #include <asm/ptrace.h>

 #define __KVM_HAVE_GUEST_DEBUG

--

Thanks,
-Christoffer
