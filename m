From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu, 21 Aug 2014 14:42:13 -0700
Subject: [PATCHv3 4/7] arm64: Move some head.text functions to executable
 section
In-Reply-To: <20140821103455.GJ21734@leverpostej>
References: <1408584039-12735-1-git-send-email-lauraa@codeaurora.org>
 <1408584039-12735-5-git-send-email-lauraa@codeaurora.org>
 <20140821103455.GJ21734@leverpostej>
Message-ID: <53F667B5.6010609@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/21/2014 3:34 AM, Mark Rutland wrote:
> Hi Laura,
> 
> On Thu, Aug 21, 2014 at 02:20:36AM +0100, Laura Abbott wrote:
>> The code in the head.text section of the kernel exists in the
>> same section as the swapper_pg_dir which means it needs the
>> same page table permissions. The swapper_pg_dir needs to be
>> writeable but shouldn't be executable.
> 
> I think we can drop the above. As far as I can tell as of commit
> bd00cd5f8c8c (arm64: place initial page tables above the kernel) it's no
> longer relevant.
>

Yes, this should be changed. Instead of citing swapper_pg_dir, I need
to cite the fact that there may still be memory outside of stext which
will get freed to the buddy allocator and therefore should be RW/NX.
 
>> The head.text section
>> is intended to be run at early bootup before any of the regular
>> kernel mappings have been setup so there is no issue at bootup.
>> The suspend/resume/hotplug code path requires some of these
>> head.S functions to run however which means they need to be
>> executable. We can't easily move all of the head.text to
>> an executable section, so split it into two parts: that which
>> is used only at early head.S bootup and that which is used
>> after bootup. There is a small bit of code duplication because
>> of some relocation issues related to accessing code more than
>> 1MB away.
> 
> From a cursory glance it looks like the only things we need write access
> to in .head.text are __cpu_boot_mode and __switch_data. Can't we instead
> place those in .data and make .head.text executable?
> 
> We currently find them with adr, which should be easy to replace with
> adrp + add to get around relocation issues.
> 

__boot_cpu_mode should be placed in data with a push section and
__switch_data is only modified before the permissions are set up.
I took a closer look at the code and the only thing that actually
needs to be executable from head.S is __secondary_switched so
the following patch should be sufficient to cover it:

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index caa9557..5c17599 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -414,12 +414,14 @@ ENTRY(secondary_startup)
        b       __enable_mmu
 ENDPROC(secondary_startup)
 
+       .pushsection    .text, "ax"
 ENTRY(__secondary_switched)
        ldr     x0, [x21]                       // get secondary_data.stack
        mov     sp, x0
        mov     x29, #0
        b       secondary_start_kernel
 ENDPROC(__secondary_switched)
+       .popsection
 #endif /* CONFIG_SMP */
 
 /*

I think I was a bit over zealous in determining that everything needed
to be placed in .text vs. not.

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
