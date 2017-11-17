From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 16 Nov 2017 18:39:57 -0800
Subject: [PATCH] arm64: cpu_errata: Add Kryo to Falkor 1003 errata
In-Reply-To: <20171115003522.GL11955@codeaurora.org>
References: <20171108190029.19835-1-sboyd@codeaurora.org>
 <20171110172656.zvnpfjkky7rqumyf@armageddon.cambridge.arm.com>
 <20171115003522.GL11955@codeaurora.org>
Message-ID: <20171117023957.GT11955@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/14, Stephen Boyd wrote:
> On 11/10, Catalin Marinas wrote:
> > On Wed, Nov 08, 2017 at 11:00:29AM -0800, Stephen Boyd wrote:
> > > The Kryo CPUs are also affected by the Falkor 1003 errata, so
> > > we need to do the same workaround on Kryo CPUs. The MIDR is
> > > slightly more complicated here, where the PART number is not
> > > always the same when looking at all the bits from 15 to 4. Drop
> > > the lower 8 bits and just look at the top 4 to see if it's '2'
> > > and then consider those as Kryo CPUs. This covers all the
> > > combinations without having to list them all out.
> > > 
> > > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > > ---
> > > 
> > > We may need to introduce another Kconfig option to block software PAN
> > > from being enabled when this errata is enabled (and then have software PAN
> > > depend on this new config being false).
> > 
> > It depends on whether you'd want to use SW PAN together with these CPUs.
> > From a defconfig + single Image perspective, SW PAN is disabled but it
> > would be nice to allow single Image with both E1003 and SW PAN configs
> > enabled (though SW PAN wouldn't be used at run-time).
> > 
> > As a quick hack, something like below but we may want to add a separate
> > cap bit as a minor optimisation (not sure it makes a difference).
> > Untested:
> 
> Ok. The Falkor CPUs support HW PAN so your patch looks like it
> should work. If we're running on a Kryo CPU we may not see the HW
> PAN capability and then we would still return false here because
> the errata is present. I'll fold it in and test it out.

Almost works. The problem is that uaccess_ttbr0_{disable,enable}
assembly macros need to be patched for NOPs if we have cap bits
for ARM64_HAS_PAN or ARM64_WORKAROUND_QCOM_FALKOR_E1003. From
what I can tell, we have only ever had one bit there so doing
something like:

----8<----
diff --git a/arch/arm64/include/asm/asm-uaccess.h b/arch/arm64/include/asm/asm-uaccess.h
index b3da6c886835..70644cde9e7c 100644
--- a/arch/arm64/include/asm/asm-uaccess.h
+++ b/arch/arm64/include/asm/asm-uaccess.h
@@ -26,13 +26,13 @@
 	.endm
 
 	.macro	uaccess_ttbr0_disable, tmp1
-alternative_if_not ARM64_HAS_PAN
+alternative_if_not (ARM64_HAS_PAN | ARM64_WORKAROUND_QCOM_FALKOR_E1003)
 	__uaccess_ttbr0_disable \tmp1
 alternative_else_nop_endif
 	.endm
 
 	.macro	uaccess_ttbr0_enable, tmp1, tmp2
-alternative_if_not ARM64_HAS_PAN
+alternative_if_not (ARM64_HAS_PAN | ARM64_WORKAROUND_QCOM_FALKOR_E1003)
 	save_and_disable_irq \tmp2		// avoid preemption
 	__uaccess_ttbr0_enable \tmp1
 	restore_irq \tmp2

won't work just like that because it's not a bitmask, just a raw
cap number. So I need to introduce another capability number that
combines the presence of HW_PAN and this errata? Looks like it
would be similar to ARM64_ALT_PAN_NOT_UAO.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
