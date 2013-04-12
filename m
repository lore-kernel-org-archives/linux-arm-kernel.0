From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 12 Apr 2013 16:48:29 +0100
Subject: [PATCH v3 10/32] arm64: KVM: system register handling
In-Reply-To: <20130410170435.GK26992@mudshark.cambridge.arm.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-11-git-send-email-marc.zyngier@arm.com>
 <20130410170435.GK26992@mudshark.cambridge.arm.com>
Message-ID: <51682CCD.6060704@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/13 18:04, Will Deacon wrote:
> On Mon, Apr 08, 2013 at 05:17:12PM +0100, Marc Zyngier wrote:
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> new file mode 100644
>> index 0000000..9df3b32
>> --- /dev/null
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -0,0 +1,871 @@
>> +/*
>> + * Copyright (C) 2012,2013 - ARM Ltd
>> + * Author: Marc Zyngier <marc.zyngier@arm.com>
>> + *
>> + * Derived from arch/arm/kvm/coproc.c:
>> + * Copyright (C) 2012 - Virtual Open Systems and Columbia University
>> + * Authors: Rusty Russell <rusty@rustcorp.com.au>
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
>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include <linux/mm.h>
>> +#include <linux/kvm_host.h>
>> +#include <linux/uaccess.h>
>> +#include <asm/kvm_arm.h>
>> +#include <asm/kvm_host.h>
>> +#include <asm/kvm_emulate.h>
>> +#include <asm/kvm_coproc.h>
>> +#include <asm/cacheflush.h>
>> +#include <asm/cputype.h>
>> +#include <trace/events/kvm.h>
>> +
>> +#include "sys_regs.h"
>> +
>> +/*
>> + * All of this file is extremly similar to the ARM coproc.c, but the
>> + * types are different. My gut feeling is that it should be pretty
>> + * easy to merge, but that would be an ABI breakage -- again. VFP
>> + * would also need to be abstracted.
>> + */
> 
> Yes, there's a lot of duplication here.

Tell me about it...

>> +/* 3 bits per cache level, as per CLIDR, but non-existent caches always 0 */
>> +static u32 cache_levels;
>> +
>> +/* CSSELR values; used to index KVM_REG_ARM_DEMUX_ID_CCSIDR */
>> +#define CSSELR_MAX 12
>> +
>> +/* Which cache CCSIDR represents depends on CSSELR value. */
>> +static u32 get_ccsidr(u32 csselr)
>> +{
>> +       u32 ccsidr;
>> +
>> +       /* Make sure noone else changes CSSELR during this! */
>> +       local_irq_disable();
>> +       /* Put value into CSSELR */
>> +       asm volatile("msr csselr_el1, %x0" : : "r" (csselr));
>> +       /* Read result out of CCSIDR */
>> +       asm volatile("mrs %0, ccsidr_el1" : "=r" (ccsidr));
>> +       local_irq_enable();
> 
> Case in point: you're missing an isb here, which I remember pointing out
> when Christoffer made the same mistake...

Yup. Will fix.

>> +       return ccsidr;
>> +}
>> +
>> +static void do_dc_cisw(u32 val)
>> +{
>> +       asm volatile("dc cisw, %x0" : : "r" (val));
>> +}
>> +
>> +static void do_dc_csw(u32 val)
>> +{
>> +       asm volatile("dc csw, %x0" : : "r" (val));
>> +}
> 
> You don't have any barriers here. Whilst you could expect the guest to take
> care of barriers, I don't think that works if you are preempted and handle
> this on a different core.

If we've been preempted, we don't execute this code at all, but do a
cache_flush_all instead. But I agree the code is pretty fragile as it
stands, and relies on barriers in the guest (or somewhere else in the
preempting code).

I'll add them, if only for peace of mind...

>> +/* See note at ARM ARM B1.14.4 */
>> +static bool access_dcsw(struct kvm_vcpu *vcpu,
>> +                       const struct sys_reg_params *p,
>> +                       const struct sys_reg_desc *r)
>> +{
>> +       unsigned long val;
>> +       int cpu;
>> +
>> +       cpu = get_cpu();
>> +
>> +       if (!p->is_write)
>> +               return read_from_write_only(vcpu, p);
> 
> Missing put_cpu().

Yeah! Another 32bit bug to be fixed! ;-)

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
