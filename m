From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 14 Jul 2015 17:11:04 +0100
Subject: [PATCH v2 09/10] arm64/BUG: Use BRK instruction for generic BUG
 traps
In-Reply-To: <1436793967-7138-10-git-send-email-Dave.Martin@arm.com>
References: <1436793967-7138-1-git-send-email-Dave.Martin@arm.com>
 <1436793967-7138-10-git-send-email-Dave.Martin@arm.com>
Message-ID: <20150714161103.GI13555@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 02:25:56PM +0100, Dave P Martin wrote:
> Currently, the minimal default BUG() implementation from asm-
> generic is used for arm64.
> 
> This patch uses the BRK software breakpoint instruction to generate
> a trap instead, similarly to most other arches, with the generic
> BUG code generating the dmesg boilerplate.
> 
> This allows bug metadata to be moved to a separate table and
> reduces the amount of inline code at BUG and WARN sites.  This also
> avoids clobbering any registers before they can be dumped.
> 
> To mitigate the size of the bug table further, this patch makes
> use of the existing infrastructure for encoding addresses within
> the bug table as 32-bit offsets instead of absolute pointers.
> (Note that this limits the kernel size to 2GB.)
> 
> Traps are registered at arch_initcall time for aarch64, but BUG
> has minimal real dependencies and it is desirable to be able to
> generate bug splats as early as possible.  This patch redirects
> all debug exceptions caused by BRK directly to bug_handler() until
> the full debug exception support has been initialised.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

The patch looks fine to me and since I gave you feedback on it before,
you can add:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

For the rest of the series, feel free to add:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
