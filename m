From: eric.auger@linaro.org (Eric Auger)
Date: Thu, 04 Dec 2014 13:26:45 +0100
Subject: [PATCH] KVM: arm/arm64: vgic: add init entry to VGIC KVM device
In-Reply-To: <CAFEAcA_moz=PBJX23Ghj53oYTObNN-Hh8DGZ1Oa=mMKWgM7Emw@mail.gmail.com>
References: <1417541251-20761-1-git-send-email-eric.auger@linaro.org>
 <CAFEAcA9YmAVYAOFbmV53Y3zBdcmK9MGSVR4gaLCjKxbyrZ6Xaw@mail.gmail.com>
 <547DFCD6.3000406@linaro.org>
 <CAFEAcA_pSiMXX52xUhNBCwiNdZomspFhr_Y+9+F2yb7P_D26bg@mail.gmail.com>
 <54804D27.1020901@linaro.org>
 <CAFEAcA_moz=PBJX23Ghj53oYTObNN-Hh8DGZ1Oa=mMKWgM7Emw@mail.gmail.com>
Message-ID: <54805305.9070105@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/2014 01:07 PM, Peter Maydell wrote:
> On 4 December 2014 at 12:01, Eric Auger <eric.auger@linaro.org> wrote:
>> Here is the sequence:
>> 1) The VGIC early initialization is initiated in a machine init done
>> notifier. This notifier is registered in kvm_arm_gic_realize
>> (http://lists.gnu.org/archive/html/qemu-devel/2014-12/msg00220.html). It
>> executes after vcpu instantiations + dist/cpu interface base address
>> setting + nb irq setting.
>> 2) the VFIO signaling and irqfd setup is done in a reset notifier
>> http://lists.gnu.org/archive/html/qemu-devel/2014-11/msg04365.html
> 
> OK. And on x86 VFIO how does this work? Obviously x86's GIC just
> initializes as soon as it's created, but do we do the irqfd setup
> in a reset notifier there too?

This is what I understand from PCI intx init sequence: the vfio
signaling and irqfd setup happens in the vfio_initfn function instead.
first vfio signaling with user-side eventfd handlers is setup
(vfio_enable_intx). if KVM is enabled, vfio_enable_intx then tears the
user-side handlers down and replace them by irqfd kernel-side handlers
(IRQFD setup). the virtual IRQ to be injected to the guest is set to
vdev->intx.route.irq. This obviously requires this routing to be set
before the QEMU PCI VFIO device instantiation.

On ARM case, VFIO device are bound to be dynamically instantiated from
command line using dynamic sysbus device instantiation. Binding of IRQ
is done by a platform bus machine init done notifier. Only at that stage
we know the gsi. hence doing the irqfd init in a reset notifier.

Eric


> 
> thanks
> -- PMM
> 
