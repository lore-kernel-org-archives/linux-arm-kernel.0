From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 9 Jan 2017 12:04:35 +0000
Subject: [PATCH v3 4/9] arm64: cpufeature: Document the rules of safe
 value for features
In-Reply-To: <2338875a-6a5b-ba9e-59fe-d681091c2923@arm.com>
References: <1483552147-9605-1-git-send-email-suzuki.poulose@arm.com>
 <1483552147-9605-5-git-send-email-suzuki.poulose@arm.com>
 <20170106123011.GB12863@e104818-lin.cambridge.arm.com>
 <2338875a-6a5b-ba9e-59fe-d681091c2923@arm.com>
Message-ID: <20170109120434.GA7593@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2017 at 10:43:07AM +0000, Suzuki K. Poulose wrote:
> On 06/01/17 12:30, Catalin Marinas wrote:
> >On Wed, Jan 04, 2017 at 05:49:02PM +0000, Suzuki K. Poulose wrote:
> >>--- a/arch/arm64/include/asm/cpufeature.h
> >>+++ b/arch/arm64/include/asm/cpufeature.h
> >>@@ -29,7 +29,21 @@
> >> #include <linux/jump_label.h>
> >> #include <linux/kernel.h>
> >>
> >>-/* CPU feature register tracking */
> >>+/*
> >>+ * CPU feature register tracking
> >>+ *
> >>+ * The safe value of a CPUID feature field is dependent on the implications
> >>+ * of the values assigned to it by the architecture. Based on the relationship
> >>+ * between the values, the features are classified into 3 types.
> >>+ *
> >>+ * a) LOWER_SAFE - The value 'n+1' indicates, value 'n' and some
> >>+ *    additional features. (where n >= 0). The smaller value (n) is
> >>+ *    considered safer in this case.
> >>+ * b) HIGHER_SAFE - The value 'n+1' is safer than 'n' (for n>= 0).
> >>+ * c) EXACT - If the values of the feature don't have any relationship,
> >>+ *    a predefined safe value is used.
> >>+ */
> >
> >I don't think this text fully describes what is actually compared. You
> >could say something that the lowest value of all the CPUs is chosen for
> >LOWER_SAFE, highest for HIGHER_SAFE and it is expected that all CPUs
> >have the same value for a field when EXACT is specified.
> 
> Ok. I have changed it as below :
> 
> /*
>  * CPU feature register tracking
>  *
>  * The safe value of a CPUID feature field is dependent on the implications
>  * of the values assigned to it by the architecture. Based on the relationship
>  * between the values, the features are classified into 3 types - LOWER_SAFE,
>  * HIGHER_SAFE and EXACT.
>  *
>  * The lowest value of all the CPUs is chosen for LOWER_SAFE and highest
>  * for HIGHER_SAFE. It is expected that all CPUs have the same value for
>  * a field when EXACT is specified, failing which, the safe value specified
>  * in the table is chosen.
>  */

It looks better to me. Thanks.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
