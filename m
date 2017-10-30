From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 30 Oct 2017 21:44:35 +0000
Subject: [PATCH v3 0/12] arm+arm64: vdso unification to lib/vdso/
In-Reply-To: <6c9aa942-bfc0-4c54-888a-85fd1d43e40c@android.com>
References: <20171027222353.56875-1-salyzyn@android.com>
 <20171030141813.nozm5bgumb5qp2ol@lakrids.cambridge.arm.com>
 <6c9aa942-bfc0-4c54-888a-85fd1d43e40c@android.com>
Message-ID: <20171030214434.ta26ekbg7jyws2lf@salmiak>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 30, 2017 at 01:34:13PM -0700, Mark Salyzyn wrote:
> On 10/30/2017 07:18 AM, Mark Rutland wrote:
> > On Fri, Oct 27, 2017 at 03:23:48PM -0700, Mark Salyzyn wrote:
> > > Note I noticed a bug in the old implementation of __kernel_clock_getres;
> > > it was checking only the lower 32bits of the pointer; this would work
> > > for most cases but could fail in a few.
> > Sorry if this is a stupid question, but do you mean from a prior version
> > of this series, or the one in the kernel today?
> 
> apinski at cavium.com noticed this as part of the existing upstream arm64
> assembler when he did the original conversion to C.

Just to check, does the below address the issue, or is there something that
I've missed?

Thanks,
Mark.

---->8----
>From 3557ca259f0a6dbb35a057256552545ec0cef677 Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Mon, 30 Oct 2017 21:23:19 +0000
Subject: [PATCH] arm64: vdso: fix clock_getres for 4GiB-aligned res

The vdso tries to check for a NULL res pointer in __kernel_clock_getres,
but only checks the lower 32 bits as is uses CBZ on the W register the
res pointer is held in.

Thus, if the res pointer happened to be aligned to a 4GiB boundary, we'd
spuriously skip storing the timespec to it, while returning a zero error code
to the caller.

Prevent this by checking the whole pointer, using CBZ on the X register
the res pointer is held in.

Fixes: 9031fefde6f2ac1d ("arm64: VDSO support")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reported-by: Andrew Pinski <apinski@cavium.com>
Reported-by: Mark Salyzyn <salyzyn@android.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/vdso/gettimeofday.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
index 76320e920965..c39872a7b03c 100644
--- a/arch/arm64/kernel/vdso/gettimeofday.S
+++ b/arch/arm64/kernel/vdso/gettimeofday.S
@@ -309,7 +309,7 @@ ENTRY(__kernel_clock_getres)
 	b.ne	4f
 	ldr	x2, 6f
 2:
-	cbz	w1, 3f
+	cbz	x1, 3f
 	stp	xzr, x2, [x1]
 
 3:	/* res == NULL. */
-- 
2.11.0
