From: skannan@codeaurora.org (Saravana Kannan)
Date: Fri, 03 Dec 2010 12:06:53 -0800
Subject: [PATCH] arm: dma-mapping: move consistent_init to	early_initcall
In-Reply-To: <20101202221909.GK29347@n2100.arm.linux.org.uk>
References: <1291327879-28073-1-git-send-email-johlstei@codeaurora.org>
	<20101202221909.GK29347@n2100.arm.linux.org.uk>
Message-ID: <4CF94DDD.8000409@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Thu, Dec 02, 2010 at 02:11:18PM -0800, Jeff Ohlstein wrote:
>> Some machines require the use of coherent memory to bring up auxillary
>> cpus, and thus want to use dma_alloc_coherent prior to smp_init
>> completing.
> 
> I'd like to see the rest of the code to indicate why you need DMA
> coherent memory for SMP boot.  It seems to me quite unnecessary.
> DMA coherent memory is meant for talking to devices, not to other
> CPUs which will be part of the symmetric part of the system.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

The code that needs this change will be submitted soon (hopefully in a 
day or two).

The MSM8660 SoC uses the TrustZone technology and the Linux kernel 
executes in normal/non-secure domain. When the second core is brought 
out of reset, it starts executing a secure image which then jumps to 
"secondary_startup". So, before bringing the second core out of reset, 
we need to inform the secure domain code where secondary_startup is 
located in memory.

We do the communication with the secure code by using buffers in memory. 
  The cache treats the NS (non secure) bit as an additional address bit 
when tagging memory. Hence, cache accesses are not coherent between the 
secure and non-secure domains. So, the secure side flushes it's cache 
after writing to the buffer. To properly read the response from the 
secure side, the kernel has to pick a buffer that isn't cacheable in the 
first place. We have similar issues in the reverse direction.

Thanks,
Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
