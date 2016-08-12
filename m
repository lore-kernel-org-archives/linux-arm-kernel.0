From: james.morse@arm.com (James Morse)
Date: Fri, 12 Aug 2016 19:07:27 +0100
Subject: [PATCHv2 2/2] arm64: hibernate: handle allocation failures
In-Reply-To: <1470921066-27421-3-git-send-email-mark.rutland@arm.com>
References: <1470921066-27421-1-git-send-email-mark.rutland@arm.com>
 <1470921066-27421-3-git-send-email-mark.rutland@arm.com>
Message-ID: <57AE105F.2050800@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/16 14:11, Mark Rutland wrote:
> In create_safe_exec_page(), we create a copy of the hibernate exit text,
> along with some page tables to map this via TTBR0. We then install the
> new tables in TTBR0.
> 
> In swsusp_arch_resume() we call create_safe_exec_page() before trying a
> number of operations which may fail (e.g. copying the linear map page
> tables). If these fail, we bail out of swsusp_arch_resume() and return
> an error code, but leave TTBR0 as-is. Subsequently, the core hibernate
> code will call free_basic_memory_bitmaps(), which will free all of the
> memory allocations we made, including the page tables installed in
> TTBR0.
> 
> Thus, we may have TTBR0 pointing at dangling freed memory for some
> period of time. If the hibernate attempt was triggered by a user
> requesting a hibernate test via the reboot syscall, we may return to
> userspace with the clobbered TTBR0 value.
> 
> Avoid these issues by reorganising swsusp_arch_resume() such that we
> have no failure paths after create_safe_exec_page(). We also add a check
> that the zero page allocation succeeded, matching what we have for other
> allocations.

Looks good to me.

Acked-by: James Morse <james.morse@arm.com>


Thanks,

James
