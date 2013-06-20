From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 20 Jun 2013 11:32:21 -0700
Subject: [PATCH v2] ARM/KVM: save and restore generic timer registers
In-Reply-To: <51C339BD.2080600@arm.com>
References: <1370963819-26165-1-git-send-email-andre.przywara@linaro.org>
 <51C2D528.90805@arm.com> <20130620170923.GA4563@lvm>
 <51C339BD.2080600@arm.com>
Message-ID: <20130620183221.GE4563@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> >>> +int kvm_arm_timer_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> >>> +{
> >>> +	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
> >>> +	void __user *uaddr = (void __user *)(long)reg->addr;
> >>> +	u64 val;
> >>> +	int ret;
> >>> +
> >>> +	ret = copy_from_user(&val, uaddr, KVM_REG_SIZE(reg->id));
> >>> +	if (ret != 0)
> >>> +		return ret;
> >>> +
> >>> +	switch (reg->id) {
> >>> +	case KVM_REG_ARM_TIMER_CTL:
> >>> +		timer->cntv_ctl = val;
> >>> +		break;
> >>> +	case KVM_REG_ARM_TIMER_CNT:
> >>> +		vcpu->kvm->arch.timer.cntvoff = kvm_phys_timer_read() - val;
> >>
> >> I just realized what bothers me here: You're computing cntvoff on a per
> >> vcpu basis, while this is a VM property. Which means that as you're
> >> restoring vcpus, you'll be changing cntvoff - sounds like a bad idea to me.
> >>
> >> The counter is really global. Do we have a way to handle VM-wide
> >> registers? I think Christoffer was trying to some a similar thing with
> >> the GIC...
> >>
> > 
> > We do have a way, but it requires user space to create a device and keep
> > track of the device fd just to set/get a single register, which seems
> > like overkill to me.
> > 
> > I suggest you do one of two things:
> >  1. Whenever this value is written, make sure it's written across all
> >     vcpus, so guests always have a consistent view of time (be careful
> >     about synchronization here).
> >  2. Move the cntvoff value to the vm struct instead, so there's only one
> >     offset and a consistent view of time.  This may have an adverse
> >     effect on the world-switch code performance, but I suspect it would
> >     completely disappear in the noise.
> > 
> > I dont' feel strongly about either approach.
> 
> So it turns out I've completely forgotten about that - cntvoff is
> already per-VM (the indirection shows it). Doh.

right.... ahem.

> 
> So there is just one thing we absolutely need to make sure here: no vcpu
> can run before they've all had their timer restored, and hence a stable
> cntvoff. Otherwise two vcpus will have a different view of time.
> 
> Can we guarantee this?
> 

Do we need to?  User space is free to modify time and all sort of other
registers at any point during VM execution - it will just break the
guest that it's running.

I think the key here is that we expect the VM to be stopped for all
save/restore operations (we can enforce it if we want to, which I am
going to for the VGIC state, because we don't want to interfere with
consistent state being written to the hardware).

-Christoffer
