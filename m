From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 26 Jul 2018 13:53:35 +0100
Subject: [RFC PATCH 08/16] KVM: arm64: Support dynamically hideable
 system registers
In-Reply-To: <877eljtj9j.fsf@linaro.org>
References: <1529593060-542-1-git-send-email-Dave.Martin@arm.com>
 <1529593060-542-9-git-send-email-Dave.Martin@arm.com>
 <878t5ztneo.fsf@linaro.org>
 <20180725143613.GM4240@e103592.cambridge.arm.com>
 <877eljtj9j.fsf@linaro.org>
Message-ID: <20180726125335.GU4240@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 25, 2018 at 04:41:44PM +0100, Alex Benn?e wrote:
> 
> Dave Martin <Dave.Martin@arm.com> writes:
> 
> > On Wed, Jul 25, 2018 at 03:12:15PM +0100, Alex Benn?e wrote:
> >>
> >> Dave Martin <Dave.Martin@arm.com> writes:
> >>
> >> > Some system registers may or may not logically exist for a vcpu
> >> > depending on whether certain architectural features are enabled for
> >> > the vcpu.
> >> >
> >> > In order to avoid spuriously emulating access to these registers
> >> > when they should not exist, or allowing the registers to be
> >> > spuriously enumerated or saved/restored through the ioctl
> >> > interface, a means is needed to allow registers to be hidden
> >> > depending on the vcpu configuration.
> >> >
> >> > In order to support this in a flexible way, this patch adds a
> >> > check_present() method to struct sys_reg_desc, and updates the
> >> > generic system register access and enumeration code to be aware of
> >> > it:  if check_present() returns false, the code behaves as if the
> >> > register did not exist.
> >> >
> >> > For convenience, the complete check is wrapped up in a new helper
> >> > sys_reg_present().
> >> >
> >> > An attempt has been made to hook the new check into the generic
> >> > accessors for trapped system registers.  This should reduce the
> >> > potential for future surprises, although the redundant check will
> >> > add a small cost.  No system register depends on this functionality
> >> > yet, and some paths needing the check may also need attention.
> >> >
> >> > Naturally, this facility makes sense only for registers that are
> >> > trapped.
> >> >
> >> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> >> > ---
> >> >  arch/arm64/kvm/sys_regs.c | 20 +++++++++++++++-----
> >> >  arch/arm64/kvm/sys_regs.h | 11 +++++++++++
> >> >  2 files changed, 26 insertions(+), 5 deletions(-)
> >
> > [...]
> >
> >> > diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
> >> > index cd710f8..dfbb342 100644
> >> > --- a/arch/arm64/kvm/sys_regs.h
> >> > +++ b/arch/arm64/kvm/sys_regs.h
> >> > @@ -22,6 +22,9 @@
> >> >  #ifndef __ARM64_KVM_SYS_REGS_LOCAL_H__
> >> >  #define __ARM64_KVM_SYS_REGS_LOCAL_H__
> >> >
> >> > +#include <linux/compiler.h>
> >> > +#include <linux/types.h>
> >>
> >> I can see why you want compiler.h, but why types.h?
> >
> > For bool (though it felt a bit pedantic).
> 
> It must be picked up elsewhere because it didn't fail when I rebuilt
> without it - and the header has been happily using bool up to that
> point.

Sure, lots of headers include linux/types.h, so we get away with it all
over the place.

I was adding it for completeness really: I prefer not to rely on headers
being included by accident.

Cheers
---Dave
