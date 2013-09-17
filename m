From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 17 Sep 2013 22:10:09 +0100
Subject: [PATCH v2 0/4] Target CPU=Host implementation for KVM ARM/ARM64
In-Reply-To: <CAAhSdy1rejL7Ck6VVNUgEy5We_vi6REO9Y3cW8dNGcPToXJtNA@mail.gmail.com>
References: <1379156917-17497-1-git-send-email-anup.patel@linaro.org>
 <CAAhSdy1rejL7Ck6VVNUgEy5We_vi6REO9Y3cW8dNGcPToXJtNA@mail.gmail.com>
Message-ID: <20130917211009.GH7623@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 14, 2013 at 05:07:17PM +0530, Anup Patel wrote:
> On Sat, Sep 14, 2013 at 4:38 PM, Anup Patel <anup.patel@linaro.org> wrote:
> > It will be very useful for user space if it has a method of querying
> > VCPU target type matching to underlying Host. We can use such querying
> > mechanism and implement machine models in user space where VCPU target
> > type is always same-as/similar-to underlying Host (i.e. Target CPU=Host).
> >
> > This patch series implements KVM_ARM_PREFERRED_TARGET ioclt for querying
> > VCPU target type matching underlying host. Using this new ioctl we can
> > implement VCPU target CPU=Host in user space (i.e. QEMU/KVMTOOL).
> >
> > Also, it is not mandatory to call KVM_ARM_PREFERRED_TARGET ioctl and the
> > old method of trying all possible target types using KVM_ARM_VCPU_INIT
> > ioctl to initialize VCPU works fine.
> >
> > Anup Patel (4):
> >   ARM: KVM: Implement kvm_vcpu_preferred_target() function
> >   ARM64: KVM: Implement kvm_vcpu_preferred_target() function
> >   ARM/ARM64: KVM: Implement KVM_ARM_PREFERRED_TARGET ioctl
> >   KVM: Add documentation for KVM_ARM_PREFERRED_TARGET ioctl
> >
> >  Documentation/virtual/kvm/api.txt |   26 ++++++++++++++++++++++----
> >  arch/arm/include/asm/kvm_host.h   |    1 +
> >  arch/arm/kvm/arm.c                |   12 ++++++++++++
> >  arch/arm/kvm/guest.c              |   19 +++++++++++++++++++
> >  arch/arm64/include/asm/kvm_host.h |    1 +
> >  arch/arm64/kvm/guest.c            |   20 ++++++++++++++++++++
> >  include/uapi/linux/kvm.h          |    1 +
> >  7 files changed, 76 insertions(+), 4 deletions(-)
> >
> > --
> > 1.7.9.5
> >
> > _______________________________________________
> > kvmarm mailing list
> > kvmarm at lists.cs.columbia.edu
> > https://lists.cs.columbia.edu/cucslists/listinfo/kvmarm
> 
> Hi Christoffer,
> 
> I forgot to address two of your comments in this patch-series:
> 1. Make the IOCTL as VM IOCTL
> 2. Return ENODEV instead of EINVAL from IOCTL.
> 
> I will take care of the above in v3.
> 
No worries, sorry for the delay in reviewing.

I'm wondering if we should actually make the ioctl a system ioctl
instead of a kvm ioctl so user space can just query the system about the
preferred target without having to create any KVM data structures.
Unless there's some problem with creating new system ioctls.  Anyone?

Assuming you take care of the above then this looks good!

Thanks,
-Christoffer
