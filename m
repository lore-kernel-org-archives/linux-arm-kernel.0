From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 08 Mar 2013 04:46:15 +0100
Subject: [kvmarm] [PATCH 08/29] arm64: KVM: user space interface
In-Reply-To: <20130307080903.GA3819@redhat.com>
References: <1362455265-24165-1-git-send-email-marc.zyngier@arm.com>
 <1362455265-24165-9-git-send-email-marc.zyngier@arm.com>
 <20130307080903.GA3819@redhat.com>
Message-ID: <2d088fa3db5159ac94cb6813a5e6c03b@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Mar 2013 10:09:03 +0200, "Michael S. Tsirkin" <mst@redhat.com>
wrote:
> On Tue, Mar 05, 2013 at 03:47:24AM +0000, Marc Zyngier wrote:
>> Provide the kvm.h file that defines the user space visible
>> interface.
>> 
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm64/include/uapi/asm/kvm.h | 112
>>  ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 112 insertions(+)
>>  create mode 100644 arch/arm64/include/uapi/asm/kvm.h
>> 
>> diff --git a/arch/arm64/include/uapi/asm/kvm.h
>> b/arch/arm64/include/uapi/asm/kvm.h
>> new file mode 100644
>> index 0000000..f5525f1
>> --- /dev/null
>> +++ b/arch/arm64/include/uapi/asm/kvm.h
>> @@ -0,0 +1,112 @@
>> +/*
>> + * Copyright (C) 2012 - ARM Ltd
>> + * Author: Marc Zyngier <marc.zyngier@arm.com>
>> + *
>> + * Derived from arch/arm/include/uapi/asm/kvm.h:
>> + * Copyright (C) 2012 - Virtual Open Systems and Columbia University
>> + * Author: Christoffer Dall <c.dall@virtualopensystems.com>
>> + *
>> + * This program is free software; you can redistribute it and/or
modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see
<http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef __ARM_KVM_H__
>> +#define __ARM_KVM_H__
>> +
>> +#define KVM_SPSR_EL1	0
>> +#define KVM_NR_SPSR	1
>> +
>> +#ifndef __ASSEMBLY__
>> +#include <asm/types.h>
>> +#include <asm/ptrace.h>
>> +
>> +#define __KVM_HAVE_GUEST_DEBUG
>> +#define __KVM_HAVE_IRQ_LINE
>> +
>> +#define KVM_REG_SIZE(id)						\
>> +	(1U << (((id) & KVM_REG_SIZE_MASK) >> KVM_REG_SIZE_SHIFT))
>> +
>> +struct kvm_regs {
>> +	struct user_pt_regs regs;	/* sp = sp_el0 */
>> +
>> +	unsigned long	sp_el1;
>> +	unsigned long	elr_el1;
>> +
>> +	unsigned long	spsr[KVM_NR_SPSR];
>> +};
>> +
> 
> Using long in uapi is generally a mistake: with gcc it has
> different size depending on whether you build in 64 and 32 bit mode.
> I think it is better to make it __u64.

Ah, well spotted. Definitely a mistake.

>> +/* Supported Processor Types */
>> +#define KVM_ARM_TARGET_CORTEX_A57	0
>> +#define KVM_ARM_NUM_TARGETS		1
>> +
>> +/* KVM_ARM_SET_DEVICE_ADDR ioctl id encoding */
>> +#define KVM_ARM_DEVICE_TYPE_SHIFT	0
>> +#define KVM_ARM_DEVICE_TYPE_MASK	(0xffff << KVM_ARM_DEVICE_TYPE_SHIFT)
>> +#define KVM_ARM_DEVICE_ID_SHIFT		16
>> +#define KVM_ARM_DEVICE_ID_MASK		(0xffff << KVM_ARM_DEVICE_ID_SHIFT)
>> +
>> +/* Supported device IDs */
>> +#define KVM_ARM_DEVICE_VGIC_V2		0
>> +
>> +/* Supported VGIC address types  */
>> +#define KVM_VGIC_V2_ADDR_TYPE_DIST	0
>> +#define KVM_VGIC_V2_ADDR_TYPE_CPU	1
>> +
>> +#define KVM_VGIC_V2_DIST_SIZE		0x1000
>> +#define KVM_VGIC_V2_CPU_SIZE		0x2000
>> +
>> +struct kvm_vcpu_init {
>> +	__u32 target;
>> +	__u32 features[7];
>> +};
>> +
>> +struct kvm_sregs {
>> +};
>> +
>> +struct kvm_fpu {
>> +};
>> +
>> +struct kvm_guest_debug_arch {
>> +};
>> +
>> +struct kvm_debug_exit_arch {
>> +};
>> +
> 
> This is a problem too: structure alignment is different
> in -m32 versus -m64 modes, which will affect the offset of
> the following fields. I think it's best to add a "padding"
> field in there, and size it to multiple of 8 bytes.

Sorry, which field are you referring to?

> I think the same is a good idea for other empty stuctures,
> since otherwise the padding is implicit and
> not initialized by gcc, and it is hard not too leak
> info to userspace when you copy these structures out.
> 
> And, it'll be handy if you want to extend the structures
> down the line.

Sure, what would make some sense.

Thanks,

         M.
-- 
Fast, cheap, reliable. Pick two.
