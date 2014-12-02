From: eric.auger@linaro.org (Eric Auger)
Date: Tue, 02 Dec 2014 18:54:30 +0100
Subject: [PATCH] KVM: arm/arm64: vgic: add init entry to VGIC KVM device
In-Reply-To: <CAFEAcA9YmAVYAOFbmV53Y3zBdcmK9MGSVR4gaLCjKxbyrZ6Xaw@mail.gmail.com>
References: <1417541251-20761-1-git-send-email-eric.auger@linaro.org>
 <CAFEAcA9YmAVYAOFbmV53Y3zBdcmK9MGSVR4gaLCjKxbyrZ6Xaw@mail.gmail.com>
Message-ID: <547DFCD6.3000406@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/2014 06:50 PM, Peter Maydell wrote:
> On 2 December 2014 at 17:27, Eric Auger <eric.auger@linaro.org> wrote:
>> Since the advent of dynamic initialization of VGIC, this latter is
>> initialized very late, on the first vcpu run. This initialization
>> could be initiated much earlier by the user, as soon as it has
>> provided the requested dimensioning parameters:
>> - number of IRQs and number of vCPUs,
>> - DIST and CPU interface base address.
>>
>> One motivation behind being able to initialize the VGIC sooner is
>> related to the setup of IRQ injection in VFIO use case. The VFIO
>> signaling, especially when used along with irqfd must be set *after*
>> vgic initialization to prevent any virtual IRQ injection before
>> VGIC initialization. If virtual IRQ injection occurs before the VGIC
>> init, the IRQ cannot be injected and subsequent injection is blocked
>> due to VFIO completion mechanism (unmask/mask or forward/unforward).
> 
> This implies that you're potentially injecting virtual IRQs
> (and changing the state of the VGIC) before we actually
> start running the VM (ie before userspace calls KVM_RUN).
> Is that right? It seems odd, but maybe vfio works that way?

Hi Peter,

as soon as VFIO signaling is set up (the device IRQ index is linked to
an eventfd, the physical IRQ VFIO handler is installed and the physical
IRQ is enabled at interrupt controller level), virtual IRQs are likely
to be injected. With current QEMU code, we setup this VFIO signaling
*before* the vgic readiness (either on machine init done or reset
notifier) and we face that issue of early injection. QEMU related
patches to follow ...

Best Regards

Eric
> 
> -- PMM
> 
