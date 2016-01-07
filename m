From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 7 Jan 2016 14:36:18 +0000
Subject: [PATCH v8 20/20] KVM: ARM64: Add a new kvm ARM PMU device
In-Reply-To: <1450771695-11948-21-git-send-email-zhaoshenglong@huawei.com>
References: <1450771695-11948-1-git-send-email-zhaoshenglong@huawei.com>
 <1450771695-11948-21-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <CAFEAcA_MDiOphseZ7RGNE3G=4ZDF5SFV5krOjanPbVuhgg9gnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 December 2015 at 08:08, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
>
> Add a new kvm device type KVM_DEV_TYPE_ARM_PMU_V3 for ARM PMU. Implement
> the kvm_device_ops for it.
>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  Documentation/virtual/kvm/devices/arm-pmu.txt |  24 +++++
>  arch/arm64/include/uapi/asm/kvm.h             |   4 +
>  include/linux/kvm_host.h                      |   1 +
>  include/uapi/linux/kvm.h                      |   2 +
>  virt/kvm/arm/pmu.c                            | 128 ++++++++++++++++++++++++++
>  virt/kvm/kvm_main.c                           |   4 +
>  6 files changed, 163 insertions(+)
>  create mode 100644 Documentation/virtual/kvm/devices/arm-pmu.txt
>
> diff --git a/Documentation/virtual/kvm/devices/arm-pmu.txt b/Documentation/virtual/kvm/devices/arm-pmu.txt
> new file mode 100644
> index 0000000..dda864e
> --- /dev/null
> +++ b/Documentation/virtual/kvm/devices/arm-pmu.txt
> @@ -0,0 +1,24 @@
> +ARM Virtual Performance Monitor Unit (vPMU)
> +===========================================
> +
> +Device types supported:
> +  KVM_DEV_TYPE_ARM_PMU_V3         ARM Performance Monitor Unit v3
> +
> +Instantiate one PMU instance for per VCPU through this API.

Do you mean that userspace has to call this API once per vCPU to
create each PMU, or that calling the device create ioctl once makes
the kernel instantiate a PMU for each vCPU?

(It's a little bit confusing that we say "this API" to mean
"not the API documented in this file at all but actually
the KVM_CREATE_DEVICE ioctl", but I see we do that in the GIC
API docs too.)

> +
> +Groups:
> +  KVM_DEV_ARM_PMU_GRP_IRQ
> +  Attributes:
> +    The attr field of kvm_device_attr encodes one value:
> +    bits:     | 63 .... 32 | 31 ....  0 |
> +    values:   |  reserved  | vcpu_index |
> +    A value describing the PMU overflow interrupt number for the specified
> +    vcpu_index vcpu. This interrupt could be a PPI or SPI, but for one VM the
> +    interrupt type must be same for each vcpu. As a PPI, the interrupt number is
> +    same for all vcpus, while as a SPI it must be different for each vcpu.

I see we're using vcpu_index rather than MPIDR affinity value
for specifying which CPU we're configuring. Is this in line with
our planned API for GICv3 configuration?

> +  Errors:
> +    -ENXIO: Unsupported attribute group
> +    -EBUSY: The PMU overflow interrupt is already set
> +    -ENODEV: Getting the PMU overflow interrupt number while it's not set
> +    -EINVAL: Invalid vcpu_index or PMU overflow interrupt number supplied

What happens if you create a PMU but then never set the IRQ number?
Is there a default or does the VM refuse to run or something?

Do we want an attribute like KVM_DEV_ARM_VGIC_CTRL_INIT so userspace
can say "I have definitely completed configuration of this device now" ?

We wound up with a fair amount of legacy mess to deal with in the
GIC code because we didn't put one of those in from the start.
(Perhaps we should aim to standardize on all kvm devices having one?)

thanks
-- PMM
