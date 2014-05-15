From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 15 May 2014 09:13:02 +0100
Subject: [PATCH v3 18/19] KVM: ARM: vgic: add the GICv3 backend
In-Reply-To: <20140509140731.GS3362@lvm> (Christoffer Dall's message of "Fri,
 9 May 2014 15:07:31 +0100")
References: <1397655591-2761-1-git-send-email-marc.zyngier@arm.com>
 <1397655591-2761-19-git-send-email-marc.zyngier@arm.com>
 <20140509140731.GS3362@lvm>
Message-ID: <878uq3h33l.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09 2014 at  3:07:31 pm BST, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> On Wed, Apr 16, 2014 at 02:39:50PM +0100, Marc Zyngier wrote:
>> Introduce the support code for emulating a GICv2 on top of GICv3
>> hardware.
>>
>> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  include/kvm/arm_vgic.h |  26 ++++++
>>  virt/kvm/arm/vgic-v3.c | 220 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  virt/kvm/arm/vgic.c    |   2 +
>>  3 files changed, 248 insertions(+)
>>  create mode 100644 virt/kvm/arm/vgic-v3.c
>>

[...]

>> diff --git a/virt/kvm/arm/vgic-v3.c b/virt/kvm/arm/vgic-v3.c
>> new file mode 100644
>> index 0000000..a804a73
>> --- /dev/null
>> +++ b/virt/kvm/arm/vgic-v3.c
>> @@ -0,0 +1,220 @@
>> +/*
>> + * Copyright (C) 2013 ARM Limited, All Rights Reserved.
>> + * Author: Marc Zyngier <marc.zyngier@arm.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include <linux/cpu.h>
>> +#include <linux/kvm.h>
>> +#include <linux/kvm_host.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_irq.h>
>> +
>> +#include <linux/irqchip/arm-gic-v3.h>
>> +
>> +#include <asm/kvm_emulate.h>
>> +#include <asm/kvm_arm.h>
>> +#include <asm/kvm_mmu.h>
>> +
>> +/* These are for GICv2 emulation only */
>
> Is this really true, seems like you're using them to form the lr values
> for the hardware below.
>
>> +#define GICH_LR_VIRTUALID            (0x3ffUL << 0)
>> +#define GICH_LR_PHYSID_CPUID_SHIFT   (10)
>> +#define GICH_LR_PHYSID_CPUID         (7UL << GICH_LR_PHYSID_CPUID_SHIFT)
>
> can't we include them from the existing header file then?

I've given this some more thought, and I think they actually belong
here. The arm-gic-v3.h file is really relevant to GICv3 used in v3
mode. Here, we're using the GICv3 HW to inject GICv2-style interrupts
(ID limited to 1023, CPUID present in the LR...).

So I'd rather keep them here than expose it to the outside world, as I
fear this would be rather confusing.

Thanks,

        M.
-- 
Jazz is not dead. It just smells funny.
