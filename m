From: christoffer.dall@arm.com (Christoffer Dall)
Date: Mon, 3 Sep 2018 13:13:41 +0200
Subject: [PATCH v4 06/20] arm64: Add a helper for PARange to physical
 shift conversion
In-Reply-To: <30b9aa82-7600-8094-dca3-44a5e79caf5a@arm.com>
References: <1531905547-25478-1-git-send-email-suzuki.poulose@arm.com>
 <1531905547-25478-7-git-send-email-suzuki.poulose@arm.com>
 <20180830094227.GB4029@e113682-lin.lund.arm.com>
 <30b9aa82-7600-8094-dca3-44a5e79caf5a@arm.com>
Message-ID: <20180903111341.GI4029@e113682-lin.lund.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 03, 2018 at 11:06:44AM +0100, Suzuki K Poulose wrote:
> On 30/08/18 10:42, Christoffer Dall wrote:
> >On Wed, Jul 18, 2018 at 10:18:49AM +0100, Suzuki K Poulose wrote:
> >>On arm64, ID_AA64MMFR0_EL1.PARange encodes the maximum Physical
> >>Address range supported by the CPU. Add a helper to decode this
> >>to actual physical shift. If we hit an unallocated value, return
> >>the maximum range supported by the kernel.
> >>This will be used by KVM to set the VTCR_EL2.T0SZ, as it
> >>is about to move its place. Having this helper keeps the code
> >>movement cleaner.
> >>
> >>Cc: Catalin Marinas <catalin.marinas@arm.com>
> >>Cc: Marc Zyngier <marc.zyngier@arm.com>
> >>Cc: James Morse <james.morse@arm.com>
> >>Cc: Christoffer Dall <cdall@kernel.org>
> >>Reviewed-by: Eric Auger <eric.auger@redhat.com>
> >>Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >>---
> >>Changes since V2:
> >>  - Split the patch
> >>  - Limit the physical shift only for values unrecognized.
> >>---
> >>  arch/arm64/include/asm/cpufeature.h | 13 +++++++++++++
> >>  1 file changed, 13 insertions(+)
> >>
> >>diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> >>index 1717ba1..855cf0e 100644
> >>--- a/arch/arm64/include/asm/cpufeature.h
> >>+++ b/arch/arm64/include/asm/cpufeature.h
> >>@@ -530,6 +530,19 @@ void arm64_set_ssbd_mitigation(bool state);
> >>  static inline void arm64_set_ssbd_mitigation(bool state) {}
> >>  #endif
> >>+static inline u32 id_aa64mmfr0_parange_to_phys_shift(int parange)
> >>+{
> >>+	switch (parange) {
> >>+	case 0: return 32;
> >>+	case 1: return 36;
> >>+	case 2: return 40;
> >>+	case 3: return 42;
> >>+	case 4: return 44;
> >>+	case 5: return 48;
> >>+	case 6: return 52;
> >>+	default: return CONFIG_ARM64_PA_BITS;
> >
> >I don't understand this case?  Shouldn't this include at least a WARN()
> >?
> 
> If a new value gets assigned in the future, an older kernel might not
> be aware of it. As per the Arm ARM ID feature value rules, we are
> guaranteed that the next higher value must indicate higher value.
> So, WARN() may not be the right choice. Hence, we restrict it to
> the value supported by the kernel.
> 

ok, fair enough.

Thanks,

    Christoffer
