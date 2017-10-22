From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 22 Oct 2017 09:44:18 +0200
Subject: [PATCH] KVM: arm/arm64: Allow usercopy to vcpu->arch.ctxt and
 arm64 debug
In-Reply-To: <CAGXu5jKJ2jPz2540ZLCwmcdVZxrgnhVPHs0uumiJm2o0ZgpVag@mail.gmail.com>
References: <20171020232525.7387-1-pbonzini@redhat.com>
 <20171021184545.2497-1-christoffer.dall@linaro.org>
 <CAGXu5jKJ2jPz2540ZLCwmcdVZxrgnhVPHs0uumiJm2o0ZgpVag@mail.gmail.com>
Message-ID: <20171022074418.GA3805@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 21, 2017 at 08:06:10PM -0700, Kees Cook wrote:
> On Sat, Oct 21, 2017 at 11:45 AM, Christoffer Dall
> <christoffer.dall@linaro.org> wrote:
> > We do direct useraccess copying to the kvm_cpu_context structure
> > embedded in the kvm_vcpu_arch structure, and to the vcpu debug register
> > state.  Everything else (timer, PMU, vgic) goes through a temporary
> > indirection.
> 
> Are these copies done with a dynamic size? The normal way these get
> whitelisted is via builtin_const sizes on the copy. Looking at
> KVM_REG_SIZE(), though, it seems that would be a dynamic calculation.
> 

It's super confusing, but it's actually static.

We can only get to thee functions via kvm_arm_sys_reg_get_reg() and
kvm_arm_sys_reg_set_reg(), and they both do

	if (KVM_REG_SIZE(reg->id) != sizeof(__u64))"
		return -ENOENT;

So this is always a u64 copy.  However, I think it's much clearer if I
rewrite these to use get_user() and put_user().  v2 incoming.

> > Fixing all accesses to kvm_cpu_context is massively invasive, and we'd
> > like to avoid that, so we tell kvm_init_usercopy to whitelist accesses
> > to out context structure.
> >
> > The debug system register accesses on arm64 are modified to work through
> > an indirection instead.
> >
> > Cc: kernel-hardening at lists.openwall.com
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Radim Kr?m?? <rkrcmar@redhat.com>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> > ---
> > This fixes KVM/ARM on today's linux next with CONFIG_HARDENED_USERCOPY.
> >
> > The patch is based on linux-next plus Paolo's x86 patch which introduces
> > kvm_init_usercopy.  Not sure how this needs to get merged, but it would
> > potentially make sense for Paolo to put together a set of the patches
> > needed for this.
> 
> I was planning to carry Paolo's patches, and I can take this one too.

Sounds good to me.

> If this poses a problem, then I could just do a two-phase commit of
> the whitelisting code, leaving the very last commit (which enables the
> defense for anything not yet whitelisted), until the KVM trees land.
> 
> What's preferred?

Assuming there's an ack from Marc Zyngier on v2 of this patch, I prefer
you just take them as part of your series.

> 
> Thanks for looking at this!
> 
No problem,
-Christoffer
