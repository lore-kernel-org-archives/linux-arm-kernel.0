From: peter.maydell@linaro.org (Peter Maydell)
Date: Tue, 9 Aug 2016 12:52:54 +0100
Subject: [RFC PATCH v2 0/4] arm/arm64: vgic-new: Implement API for vGICv3
 live migration
In-Reply-To: <1470740326-27751-1-git-send-email-vijay.kilari@gmail.com>
References: <1470740326-27751-1-git-send-email-vijay.kilari@gmail.com>
Message-ID: <CAFEAcA-z+iM+=p0riWreJCewPPxw9wtHgg+_4MDtxV=ccwe-tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 August 2016 at 11:58,  <vijay.kilari@gmail.com> wrote:
> From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
>
> This patchset adds API for saving and restoring
> of VGICv3 registers to support live migration with new vgic feature.
> This API definition is as per version of VGICv3 specification
> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-July/445611.html
>
> To test live migration with QEMU, use below patch series
> https://lists.gnu.org/archive/html/qemu-devel/2016-08/msg01444.html
>
> The patch 3 & 4 are picked from the Pavel's previous implementation.
> http://www.spinics.net/lists/kvm/msg122040.html
>
> v1 => v2:
>  - The init sequence change patch is no more required.
>    Fixed in patch 2 by using static vgic_io_dev regions structure instead
>    of using dynamic allocation pointer.
>  - Updated commit message of patch 4.
>  - Dropped usage of union to manage 32-bit and 64-bit access in patch 1.
>    Used local variable for 32-bit access.
>  - Updated macro __ARM64_SYS_REG and ARM64_SYS_REG in
>    arch/arm64/include/uapi/asm/kvm.h as per qemu requirements.

I only scanned briefly through this patchset, but I didn't
see any code implementing:
 * KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO
 * the different behaviour for accesses to GICD_STATUSR, GICR_STATUSR,
   GICD_ISPENDR, GICR_ISPENDR0, GICD_ICPENDR, and GICR_ICPENDR0, which
   don't act the same via this API as for a guest access to the register

Did I miss something?

thanks
-- PMM
