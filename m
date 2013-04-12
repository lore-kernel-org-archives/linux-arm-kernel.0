From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 12 Apr 2013 17:04:28 +0100
Subject: [PATCH v3 12/32] arm64: KVM: virtual CPU reset
In-Reply-To: <20130410170707.GM26992@mudshark.cambridge.arm.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-13-git-send-email-marc.zyngier@arm.com>
 <20130410170707.GM26992@mudshark.cambridge.arm.com>
Message-ID: <5168308C.5040107@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/13 18:07, Will Deacon wrote:
> On Mon, Apr 08, 2013 at 05:17:14PM +0100, Marc Zyngier wrote:
>> Provide the reset code for a virtual CPU booted in 64bit mode.
>>
>> Reviewed-by: Christopher Covington <cov@codeaurora.org>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm64/kvm/reset.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 76 insertions(+)
>>  create mode 100644 arch/arm64/kvm/reset.c
>>
>> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
>> new file mode 100644
>> index 0000000..bc33e76
>> --- /dev/null
>> +++ b/arch/arm64/kvm/reset.c
>> @@ -0,0 +1,76 @@
>> +/*
>> + * Copyright (C) 2012,2013 - ARM Ltd
>> + * Author: Marc Zyngier <marc.zyngier@arm.com>
>> + *
>> + * Derived from arch/arm/kvm/reset.c
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
>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include <linux/errno.h>
>> +#include <linux/kvm_host.h>
>> +#include <linux/kvm.h>
>> +
>> +#include <asm/cputype.h>
>> +#include <asm/ptrace.h>
>> +#include <asm/kvm_arm.h>
>> +#include <asm/kvm_coproc.h>
>> +
>> +/*
>> + * ARMv8 Reset Values
>> + */
>> +static struct kvm_regs default_regs_reset = {
>> +	.regs.pstate = PSR_MODE_EL1h | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT,
> 
> PSR_D_BIT again.

OK.

	M.
-- 
Jazz is not dead. It just smells funny...
