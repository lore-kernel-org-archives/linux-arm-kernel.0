From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon, 6 Nov 2017 10:36:02 +0900
Subject: [PATCH 1/2] arm64: Fix static use of function graph
In-Reply-To: <46841fbe-a8d6-53cc-3cfb-e4cd10f630c3@arm.com>
References: <1509546824-46165-1-git-send-email-julien.thierry@arm.com>
 <1509546824-46165-2-git-send-email-julien.thierry@arm.com>
 <20171102044306.GL10563@linaro.org>
 <20171102101831.GU9463@n2100.armlinux.org.uk>
 <46841fbe-a8d6-53cc-3cfb-e4cd10f630c3@arm.com>
Message-ID: <20171106013600.GA7859@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 03, 2017 at 09:25:07AM +0000, Julien Thierry wrote:
> Hi,
> 
> On 02/11/17 10:18, Russell King - ARM Linux wrote:
> >On Thu, Nov 02, 2017 at 01:43:07PM +0900, AKASHI Takahiro wrote:
> >>On Wed, Nov 01, 2017 at 02:33:43PM +0000, Julien Thierry wrote:
> >>>Function graph does not work currently when CONFIG_DYNAMIC_TRACE is not
> >>>set. This is because ftrace_function_trace is not always set to ftrace_stub
> >>>when function_graph is in use.
> >>>
> >>>Do not skip checking of graph tracer functions when ftrace_function_trace
> >>>is set.
> >>>
> >>>Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> >>>Cc: Catalin Marinas <catalin.marinas@arm.com>
> >>>Cc: Will Deacon <will.deacon@arm.com>
> >>>Cc: Mark Rutland <mark.rutland@arm.com>
> >>>Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >>
> >>Reviewed-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >>
> >>I think that arm has the same issue, hoping the following patch
> >>will fix it:
> 
> Thanks for noticing this and for the patch. I'll re-spin a version for this
> series and include your patch.

Thanks. You'd better fix a bug in the subject, which should be
"!DYNAMIC_FTRACE" or use the same title as yours.

-Takahiro AKASHI

> >>===
> >>>From e25bcf50d1acde698285a0c64f72d97f8b17e3fb Mon Sep 17 00:00:00 2001
> >>From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >>Date: Thu, 2 Nov 2017 11:35:04 +0900
> >>Subject: [PATCH] arm: ftrace: function_graph with DYNAMIC_FTRACE
> >>
> >>---
> >>  arch/arm/kernel/entry-ftrace.S | 12 +++++-------
> >>  1 file changed, 5 insertions(+), 7 deletions(-)
> >>
> >>diff --git a/arch/arm/kernel/entry-ftrace.S b/arch/arm/kernel/entry-ftrace.S
> >>index efcd9f25a14b..ef94c73ad996 100644
> >>--- a/arch/arm/kernel/entry-ftrace.S
> >>+++ b/arch/arm/kernel/entry-ftrace.S
> >>@@ -68,8 +68,12 @@
> >>  	ldr	r2, [r0]
> >>  	adr	r0, .Lftrace_stub
> >>  	cmp	r0, r2
> >>-	bne	1f
> >>+	beq	1f
> >>+ 	mcount_get_lr	r1			@ lr of instrumented func
> >>+	mcount_adjust_addr	r0, lr		@ instrumented function
> >>+	blx	r2
> >
> >NAK.  Not all CPUs support "blx".  I don't see why you'd make this
> >gratuitous change when just moving code around.  Please separate
> >your changes in future.
> >
> 
> I'll change the blx back to the badr + mov instructions in the new version.
> 
> Thanks,
> 
> -- 
> Julien Thierry
