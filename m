From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 15 Oct 2015 16:11:14 +0100
Subject: [PATCHv3 08/11] arm64: Check for selected granule support
In-Reply-To: <561FBC99.9090501@arm.com>
References: <1444821634-1689-1-git-send-email-suzuki.poulose@arm.com>
 <1444821634-1689-9-git-send-email-suzuki.poulose@arm.com>
 <561EC58B.9080408@arm.com> <20151015104515.GE8825@leverpostej>
 <20151015112532.GA16125@e106634-lin.cambridge.arm.com>
 <561FBC99.9090501@arm.com>
Message-ID: <20151015151113.GK8825@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 09:47:53AM -0500, Jeremy Linton wrote:
> On 10/15/2015 06:25 AM, Suzuki K. Poulose wrote:
> >+	/*
> >+	 * Check to see if the CPU supports the requested pagesize
> >+	 */
> >+	asm volatile("mrs %0, ID_AA64MMFR0_EL1" : "=r" (aa64mmfr0_el1));
> >+	aa64mmfr0_el1 >>= ID_AA64MMFR0_TGRAN_SHIFT;
> >+	if ((aa64mmfr0_el1 & 0xf) != ID_AA64MMFR0_TGRAN_SUPPORTED) {
> >+		pr_efi_err(sys_table_arg, PAGE_SIZE_STR" granule not supported by the CPU\n");
> >+		return EFI_UNSUPPORTED;
> >+	}
> 
> 
> This is definitely an improvement over my original hack job.
> 
> I would like to add, that I actually think this should be in a new
> function "check_kernel_compatibility" (or whatever) that is called
> before handle_kernel_image.

To bikeshed, perhaps efi_arch_check_system?

> That is because I don't really think it belongs in
> handle_kernel_image which is focused on relocation. Plus, if you add
> another function, you can avoid the "Failed to relocate kernel"
> error that comes out following the granule not supported message.
> Further, checks like this in the future will have a place to live.

I agree.

There are some other diagnostic utilities I'd like to add to the stub
(e.g. dumping the memory map and ID registers) that would help with
diagnosing boot issues. I started on those at Connect, but realised I
needed to first implement half of printf for those to be useful.

> Of course you will then need a matching stubbed out function for the
> normal arm kernel as well.

I'm sure there are similar things we'll want to check for 32-bit (e.g.
LPAE support), but a stub should be fine for now.

Thanks,
Mark.
