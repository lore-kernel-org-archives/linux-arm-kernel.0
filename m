From: pbonzini@redhat.com (Paolo Bonzini)
Date: Thu, 2 Jul 2015 15:40:47 +0200
Subject: [RFC 12/17] irq: bypass: Extend skeleton for ARM forwarding
 control
In-Reply-To: <1435843047-6327-13-git-send-email-eric.auger@linaro.org>
References: <1435843047-6327-1-git-send-email-eric.auger@linaro.org>
 <1435843047-6327-13-git-send-email-eric.auger@linaro.org>
Message-ID: <55953F5F.9090203@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/07/2015 15:17, Eric Auger wrote:
> - new fields are added on producer side: linux irq, vfio_device handle,
>   active which reflects whether the source is active (at interrupt
>   controller level or at VFIO level - automasked -) and finally an
>   opaque pointer which will be used to point to the vfio_platform_device
>   in this series.

Linux IRQ and active should be okay.  As to the vfio_device handle, you
should link it from the vfio_platform_device instead.  And for the
vfio_platform_device, you can link it from the vfio_platform_irq instead.

Once you've done this, embed the irq_bypass_producer struct in the
vfio_platform_irq struct; in the new kvm_arch_* functions, go back to
the vfio_platform_irq struct via container_of.  From there you can
retrieve pointers to the vfio_platform_device and the vfio_device.

> - new fields on consumer side: the kvm handle, the gsi

You do not need to add these.  Instead, add the kvm handle to irqfd
only.  Like above, embed the irq_bypass_consumer struct in the irqfd
struct; in the new kvm_arch_* functions, go back to the
vfio_platform_irq struct via container_of.

Paolo
