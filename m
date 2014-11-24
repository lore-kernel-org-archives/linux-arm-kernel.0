From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 24 Nov 2014 11:10:46 +0100
Subject: [PATCH v4 0/3] irqfd support for arm/arm64
In-Reply-To: <20141124094731.GH3401@cbox>
References: <1416765420-12057-1-git-send-email-eric.auger@linaro.org>
 <20141124094731.GH3401@cbox>
Message-ID: <54730426.9030703@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/24/2014 10:47 AM, Christoffer Dall wrote:
> On Sun, Nov 23, 2014 at 06:56:57PM +0100, Eric Auger wrote:
>> This patch series enables irqfd on arm and arm64.
>>
>> Irqfd framework enables to inject a virtual IRQ into a guest upon an
>> eventfd trigger. User-side uses KVM_IRQFD VM ioctl to provide KVM with
>> a kvm_irqfd struct that associates a VM, an eventfd, a virtual IRQ number
>> (aka. the gsi). When an actor signals the eventfd (typically a VFIO
>> platform driver), the kvm irqfd subsystem injects the gsi into the VM.
>>
>> Resamplefd also is supported for level sensitive interrupts, ie. the
>> user can provide another eventfd that is triggered when the completion
>> of the virtual IRQ (gsi) is detected by the GIC.
>>
>> The gsi must correspond to a shared peripheral interrupt (SPI), ie the
>> GIC interrupt ID is gsi + 32.
>>
>> The rationale behind not supporting PPI irqfd injection is that
>> any device using a PPI would be a private-to-the-CPU device (timer for
>> instance), so its state would have to be context-switched along with the
>> VCPU and would require in-kernel wiring anyhow. It is not a relevant use
>> case for irqfds.
>>
>> this patch enables CONFIG_HAVE_KVM_EVENTFD and CONFIG_HAVE_KVM_IRQFD.
>>
>> No IRQ routing table is used, enabling to remove CONFIG_HAVE_KVM_IRQCHIP
>>
>> can be found at git://git.linaro.org/people/eric.auger/linux.git
>> on branch irqfd_integ_v8
>>
>> This work was tested with Calxeda Midway xgmac main interrupt with
>> qemu-system-arm and QEMU VFIO platform device. Also irqfd was proven
>> functional on several vhost-net prototypes.
>>
>> v3 -> v4:
>> - rebase on 3.18rc5
>> - vgic dynamic instantiation brought new challenges:
>>   handling of irqfd injection when vgic is not ready
>> - unset of CONFIG_HAVE_KVM_IRQCHIP in a separate patch
>> - add arm64 enable
>> - vgic.c style modifications according to Christoffer comments
>>
> 
> There also seems to be a different split of the patches here?
Hi Christoffer,
yes I added arm64b support and moved CONFIG_HAVE_KVM_IRQCHIP removal in
a separate patch.
> 
> We've probably also reached the point where you need to start rebasing
> on Andre's GICv3 patches, which I expect will go in first.
the patch applies without conflict on Andre's series.

BR

Eric
> 
> Thanks,
> -Christoffer
> 
