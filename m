From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 14 Feb 2012 22:23:54 +0000
Subject: [PATCH] Optimize multi-CPU tlb flushing a little more
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF178FACB6A1@HQMAIL01.nvidia.com>
References: <20110823110602.GG19622@n2100.arm.linux.org.uk>
 <CAH+eYFC_mkdObV0NfN5Jtv0L6fM9e0YGOBghTEVSqf=TAFxdXw@mail.gmail.com>
 <20120213162359.GC25655@n2100.arm.linux.org.uk>
 <20120213165926.GA24426@debian>
 <74CDBE0F657A3D45AFBB94109FB122FF178FACB6A1@HQMAIL01.nvidia.com>
Message-ID: <20120214222354.GB29765@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 14, 2012 at 01:59:34PM -0800, Stephen Warren wrote:
> Aha, I should have searched harder for my stack trace... This thread
> describes the exact problem I just posted about a couple of hours ago,
> and Russell's suggested fix solves my problem.

Here's a better fix:

 arch/arm/include/asm/tlbflush.h |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index bb6408a..01f7484 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -359,14 +359,15 @@ static inline void local_flush_tlb_mm(struct mm_struct *mm)
 	if (tlb_flag(TLB_WB))
 		dsb();
 
-	if (possible_tlb_flags & (TLB_V3_FULL|TLB_V4_U_FULL|TLB_V4_D_FULL|TLB_V4_I_FULL) &&
-	    cpumask_test_cpu(get_cpu(), mm_cpumask(mm))) {
-		tlb_op(TLB_V3_FULL, "c6, c0, 0", zero);
-		tlb_op(TLB_V4_U_FULL, "c8, c7, 0", zero);
-		tlb_op(TLB_V4_D_FULL, "c8, c6, 0", zero);
-		tlb_op(TLB_V4_I_FULL, "c8, c5, 0", zero);
+	if (possible_tlb_flags & (TLB_V3_FULL|TLB_V4_U_FULL|TLB_V4_D_FULL|TLB_V4_I_FULL)) {
+		if (cpumask_test_cpu(get_cpu(), mm_cpumask(mm))) {
+			tlb_op(TLB_V3_FULL, "c6, c0, 0", zero);
+			tlb_op(TLB_V4_U_FULL, "c8, c7, 0", zero);
+			tlb_op(TLB_V4_D_FULL, "c8, c6, 0", zero);
+			tlb_op(TLB_V4_I_FULL, "c8, c5, 0", zero);
+		}
+		put_cpu();
 	}
-	put_cpu();
 
 	tlb_op(TLB_V6_U_ASID, "c8, c7, 2", asid);
 	tlb_op(TLB_V6_D_ASID, "c8, c6, 2", asid);
