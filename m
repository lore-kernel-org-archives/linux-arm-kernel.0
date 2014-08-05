From: apatel@apm.com (Anup Patel)
Date: Tue, 5 Aug 2014 15:02:29 +0530
Subject: [RFC PATCH 0/6] ARM64: KVM: PMU infrastructure support
In-Reply-To: <1407230655-28864-1-git-send-email-anup.patel@linaro.org>
References: <1407230655-28864-1-git-send-email-anup.patel@linaro.org>
Message-ID: <CAMwBHsYTB_gAry_0Or8XvTqw_=KZo_3vh1r3y9kNmecN5zTKmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 5, 2014 at 2:54 PM, Anup Patel <anup.patel@linaro.org> wrote:
> This patchset enables PMU virtualization in KVM ARM64. The
> Guest can now directly use PMU available on the host HW.
>
> The virtual PMU IRQ injection for Guest VCPUs is managed by
> small piece of code shared between KVM ARM and KVM ARM64. The
> virtual PMU IRQ number will be based on Guest machine model and
> user space will provide it using set device address vm ioctl.
>
> The second last patch of this series implements full context
> switch of PMU registers which will context switch all PMU
> registers on every KVM world-switch.
>
> The last patch implements a lazy context switch of PMU registers
> which is very similar to lazy debug context switch.
> (Refer, http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/271040.html)
>
> Also, we reserve last PMU event counter for EL2 mode which
> will not be accessible from Host and Guest EL1 mode. This
> reserved EL2 mode PMU event counter can be used for profiling
> KVM world-switch and other EL2 mode functions.
>
> All testing have been done using KVMTOOL on X-Gene Mustang and
> Foundation v8 Model for both Aarch32 and Aarch64 guest.
>
> Anup Patel (6):
>   ARM64: Move PMU register related defines to asm/pmu.h
>   ARM64: perf: Re-enable overflow interrupt from interrupt handler
>   ARM: perf: Re-enable overflow interrupt from interrupt handler
>   ARM/ARM64: KVM: Add common code PMU IRQ routing
>   ARM64: KVM: Implement full context switch of PMU registers
>   ARM64: KVM: Upgrade to lazy context switch of PMU registers
>
>  arch/arm/include/asm/kvm_host.h   |    9 +
>  arch/arm/include/uapi/asm/kvm.h   |    1 +
>  arch/arm/kernel/perf_event_v7.c   |    8 +
>  arch/arm/kvm/arm.c                |    6 +
>  arch/arm/kvm/reset.c              |    4 +
>  arch/arm64/include/asm/kvm_asm.h  |   39 +++-
>  arch/arm64/include/asm/kvm_host.h |   12 ++
>  arch/arm64/include/asm/pmu.h      |   44 +++++
>  arch/arm64/include/uapi/asm/kvm.h |    1 +
>  arch/arm64/kernel/asm-offsets.c   |    2 +
>  arch/arm64/kernel/perf_event.c    |   40 +---
>  arch/arm64/kvm/Kconfig            |    7 +
>  arch/arm64/kvm/Makefile           |    1 +
>  arch/arm64/kvm/hyp-init.S         |   15 ++
>  arch/arm64/kvm/hyp.S              |  209 +++++++++++++++++++-
>  arch/arm64/kvm/reset.c            |    4 +
>  arch/arm64/kvm/sys_regs.c         |  385 +++++++++++++++++++++++++++++++++----
>  include/kvm/arm_pmu.h             |   52 +++++
>  virt/kvm/arm/pmu.c                |  105 ++++++++++
>  19 files changed, 870 insertions(+), 74 deletions(-)
>  create mode 100644 include/kvm/arm_pmu.h
>  create mode 100644 virt/kvm/arm/pmu.c
>
> --
> 1.7.9.5
>
> CONFIDENTIALITY NOTICE: This e-mail message, including any attachments,
> is for the sole use of the intended recipient(s) and contains information
> that is confidential and proprietary to Applied Micro Circuits Corporation or its subsidiaries.
> It is to be used solely for the purpose of furthering the parties' business relationship.
> All unauthorized review, use, disclosure or distribution is prohibited.
> If you are not the intended recipient, please contact the sender by reply e-mail
> and destroy all copies of the original message.
>

Hi All,

Please apply attached patch to KVMTOOL on-top-of my
recent KVMTOOL patchset for trying this patchset using
KVMTOOL.

Regards,
Anup
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-kvmtool-ARM-ARM64-Add-PMU-node-to-generated-guest-DT.patch
Type: text/x-patch
Size: 3994 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140805/399a674d/attachment.bin>
