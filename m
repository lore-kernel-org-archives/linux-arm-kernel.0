From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Tue, 23 Apr 2013 15:59:21 -0700
Subject: [PATCH v3 11/32] arm64: KVM: CPU specific system registers
 handling
In-Reply-To: <5168307E.2080700@arm.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-12-git-send-email-marc.zyngier@arm.com>
 <20130410170624.GL26992@mudshark.cambridge.arm.com>
 <5168307E.2080700@arm.com>
Message-ID: <20130423225921.GD20569@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 12, 2013 at 05:04:14PM +0100, Marc Zyngier wrote:
> On 10/04/13 18:06, Will Deacon wrote:
> > On Mon, Apr 08, 2013 at 05:17:13PM +0100, Marc Zyngier wrote:
> >> Add the support code for CPU specific system registers. Not much
> >> here yet.
> >>
> >> Reviewed-by: Christopher Covington <cov@codeaurora.org>
> >> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> >> ---
> >>  arch/arm64/kvm/sys_regs_generic_v8.c | 85 ++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 85 insertions(+)
> >>  create mode 100644 arch/arm64/kvm/sys_regs_generic_v8.c
> >>
> >> diff --git a/arch/arm64/kvm/sys_regs_generic_v8.c b/arch/arm64/kvm/sys_regs_generic_v8.c
> >> new file mode 100644
> >> index 0000000..d4e8039
> >> --- /dev/null
> >> +++ b/arch/arm64/kvm/sys_regs_generic_v8.c
> >> @@ -0,0 +1,85 @@
> >> +/*
> >> + * Copyright (C) 2012,2013 - ARM Ltd
> >> + * Author: Marc Zyngier <marc.zyngier@arm.com>
> >> + *
> >> + * Based on arch/arm/kvm/coproc_a15.c:
> >> + * Copyright (C) 2012 - Virtual Open Systems and Columbia University
> >> + * Authors: Rusty Russell <rusty@rustcorp.au>
> >> + *          Christoffer Dall <c.dall@virtualopensystems.com>
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License, version 2, as
> >> + * published by the Free Software Foundation.
> >> + *
> >> + * This program is distributed in the hope that it will be useful,
> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> + * GNU General Public License for more details.
> >> + *
> >> + * You should have received a copy of the GNU General Public License
> >> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> >> + */
> >> +#include <linux/kvm_host.h>
> >> +#include <asm/cputype.h>
> >> +#include <asm/kvm_arm.h>
> >> +#include <asm/kvm_asm.h>
> >> +#include <asm/kvm_host.h>
> >> +#include <asm/kvm_emulate.h>
> >> +#include <asm/kvm_coproc.h>
> >> +#include <linux/init.h>
> >> +
> >> +#include "sys_regs.h"
> >> +
> >> +static bool access_actlr(struct kvm_vcpu *vcpu,
> >> +			 const struct sys_reg_params *p,
> >> +			 const struct sys_reg_desc *r)
> >> +{
> >> +	if (p->is_write)
> >> +		return ignore_write(vcpu, p);
> >> +
> >> +	*vcpu_reg(vcpu, p->Rt) = vcpu_sys_reg(vcpu, ACTLR_EL1);
> >> +	return true;
> >> +}
> >> +
> >> +static void reset_actlr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
> >> +{
> >> +	u64 actlr;
> >> +
> >> +	asm volatile("mrs %0, actlr_el1\n" : "=r" (actlr));
> >> +	vcpu_sys_reg(vcpu, ACTLR_EL1) = actlr;
> >> +}
> > 
> > Do we actually need this? If so, there are likely other registers (things
> > like the ectlr) that should be considered too.
> 
> I'm focussing on the architected registers, and only those. ECTLR is
> implementation dependent, and is not specified as an architected sysreg.
> 
> As this is one of the registers that we trap (TACR set in HCR_EL2), we
> have to emulate it. Now, maybe it is not that useful to trap it (nobody
> uses that code path yet).
> 
why is this even in a generic_v8 file then? Should it not be able to be
handled generically in the sys_regs file and only when you have specific
meanings of the register for a specific core should you add something
like this file?

I think it's preferred to have something that traps and shouts than
something that may or may not work (ie. just allowing the guest to read
the register directly), but you guys know better than me what kind of
things can be exposed through this register in the future.
