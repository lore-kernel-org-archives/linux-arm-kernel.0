From: zhongjiang@huawei.com (zhongjiang)
Date: Tue, 25 Apr 2017 23:03:08 +0800
Subject: [PATCH v2] arm64: fix the overlap between the kernel image and
 vmalloc address
Message-ID: <1493132588-39904-1-git-send-email-zhongjiang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recently, xiaojun report the following issue.

[ 4544.984139] Unable to handle kernel paging request at virtual address ffff804392800000
[ 4544.991995] pgd = ffff80096745f000
[ 4544.995369] [ffff804392800000] *pgd=0000000000000000
[ 4545.000297] Internal error: Oops: 96000005 [#1] PREEMPT SMP
[ 4545.005815] Modules linked in:
[ 4545.008843] CPU: 1 PID: 8976 Comm: cat Not tainted 4.11.0-rc6 #1
[ 4545.014790] Hardware name: ARM Juno development board (r1) (DT)
[ 4545.020653] task: ffff8009753fdb00 task.stack: ffff80097533c000
[ 4545.026520] PC is at __memcpy+0x100/0x180
[ 4545.030491] LR is at vread+0x144/0x280
[ 4545.034202] pc : [<ffff0000083a1000>] lr : [<ffff0000081c126c>] pstate: 20000145
[ 4545.041530] sp : ffff80097533fcb0
[ 4545.044811] x29: ffff80097533fcb0 x28: ffff800962d24000
[ 4545.050074] x27: 0000000000001000 x26: ffff8009753fdb00
[ 4545.055337] x25: ffff000008200000 x24: ffff800977801380
[ 4545.060600] x23: ffff8009753fdb00 x22: ffff800962d24000
[ 4545.065863] x21: 0000000000001000 x20: ffff000008200000
[ 4545.071125] x19: 0000000000001000 x18: 0000ffffefa323c0
[ 4545.076387] x17: 0000ffffa9c87440 x16: ffff0000081fdfd0
[ 4545.081649] x15: 0000ffffa9d01588 x14: 72a77346b2407be7
[ 4545.086911] x13: 5299400690000000 x12: b0000001f9001a79
[ 4545.092173] x11: 97fc098d91042260 x10: 0000000000000000
[ 4545.097435] x9 : 0000000000000000 x8 : 9110626091260021
[ 4545.102698] x7 : 0000000000001000 x6 : ffff800962d24000
[ 4545.107960] x5 : ffff8009778013b0 x4 : 0000000000000000
[ 4545.113222] x3 : 0400000000000001 x2 : 0000000000000f80
[ 4545.118484] x1 : ffff804392800000 x0 : ffff800962d24000
[ 4545.123745]
[ 4545.125220] Process cat (pid: 8976, stack limit = 0xffff80097533c000)
[ 4545.131598] Stack: (0xffff80097533fcb0 to 0xffff800975340000)
[ 4545.137289] fca0:                                   ffff80097533fd30 ffff000008270f64
[ 4545.145049] fcc0: 000000000000e000 000000003956f000 ffff000008f950d0 ffff80097533feb8
[ 4545.152809] fce0: 0000000000002000 ffff8009753fdb00 ffff800962d24000 ffff000008e8d3d8
[ 4545.160568] fd00: 0000000000001000 ffff000008200000 0000000000001000 ffff800962d24000
[ 4545.168327] fd20: 0000000000001000 ffff000008e884a0 ffff80097533fdb0 ffff00000826340c
[ 4545.176086] fd40: ffff800976bf2800 fffffffffffffffb 000000003956d000 ffff80097533feb8
[ 4545.183846] fd60: 0000000060000000 0000000000000015 0000000000000124 000000000000003f
[ 4545.191605] fd80: ffff000008962000 ffff8009753fdb00 ffff8009753fdb00 ffff8009753fdb00
[ 4545.199364] fda0: 0000000300000124 0000000000002000 ffff80097533fdd0 ffff0000081fb83c
[ 4545.207123] fdc0: 0000000000010000 ffff80097514f900 ffff80097533fe50 ffff0000081fcb28
[ 4545.214883] fde0: 0000000000010000 ffff80097514f900 0000000000000000 0000000000000000
[ 4545.222642] fe00: ffff80097533fe30 ffff0000081fca1c ffff80097514f900 0000000000000000
[ 4545.230401] fe20: 000000003956d000 ffff80097533feb8 ffff80097533fe50 ffff0000081fcb04
[ 4545.238160] fe40: 0000000000010000 ffff80097514f900 ffff80097533fe80 ffff0000081fe014
[ 4545.245919] fe60: ffff80097514f900 ffff80097514f900 000000003956d000 0000000000010000
[ 4545.253678] fe80: 0000000000000000 ffff000008082f30 0000000000000000 0000800977146000
[ 4545.261438] fea0: ffffffffffffffff 0000ffffa9c8745c 0000000000000124 0000000008202000
[ 4545.269197] fec0: 0000000000000003 000000003956d000 0000000000010000 0000000000000000
[ 4545.276956] fee0: 0000000000011011 0000000000000001 0000000000000011 0000000000000002
[ 4545.284715] ff00: 000000000000003f 1f3c201f7372686b 00000000ffffffff 0000000000000030
[ 4545.292474] ff20: 0000000000000038 0000000000000000 0000ffffa9bcca94 0000ffffa9d01588
[ 4545.300233] ff40: 0000000000000000 0000ffffa9c87440 0000ffffefa323c0 0000000000010000
[ 4545.307993] ff60: 000000000041a310 000000003956d000 0000000000000003 000000007fffe000
[ 4545.315751] ff80: 00000000004088d0 0000000000010000 0000000000000000 0000000000000000
[ 4545.323511] ffa0: 0000000000010000 0000ffffefa32690 0000000000404dcc 0000ffffefa32690
[ 4545.331270] ffc0: 0000ffffa9c8745c 0000000060000000 0000000000000003 000000000000003f
[ 4545.339029] ffe0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[ 4545.346786] Call trace:
[ 4545.349207] Exception stack(0xffff80097533fae0 to 0xffff80097533fc10)
[ 4545.355586] fae0: 0000000000001000 0001000000000000 ffff80097533fcb0 ffff0000083a1000
[ 4545.363345] fb00: 000000003957c000 ffff80097533fc00 0000000020000145 0000000000000025
[ 4545.371105] fb20: ffff800962d24000 ffff000008e8d3d8 0000000000001000 ffff8009753fdb00
[ 4545.378864] fb40: 0000000000000000 0000000000000002 ffff80097533fd30 ffff000008082604
[ 4545.386623] fb60: 0000000000001000 0001000000000000 ffff80097533fd30 ffff0000083a0a90
[ 4545.394382] fb80: ffff800962d24000 ffff804392800000 0000000000000f80 0400000000000001
[ 4545.402140] fba0: 0000000000000000 ffff8009778013b0 ffff800962d24000 0000000000001000
[ 4545.409899] fbc0: 9110626091260021 0000000000000000 0000000000000000 97fc098d91042260
[ 4545.417658] fbe0: b0000001f9001a79 5299400690000000 72a77346b2407be7 0000ffffa9d01588
[ 4545.425416] fc00: ffff0000081fdfd0 0000ffffa9c87440
[ 4545.430248] [<ffff0000083a1000>] __memcpy+0x100/0x180
[ 4545.435253] [<ffff000008270f64>] read_kcore+0x21c/0x3b0
[ 4545.440429] [<ffff00000826340c>] proc_reg_read+0x64/0x90
[ 4545.445691] [<ffff0000081fb83c>] __vfs_read+0x1c/0x108
[ 4545.450779] [<ffff0000081fcb28>] vfs_read+0x80/0x130
[ 4545.455696] [<ffff0000081fe014>] SyS_read+0x44/0xa0
[ 4545.460528] [<ffff000008082f30>] el0_svc_naked+0x24/0x28
[ 4545.465790] Code: d503201f d503201f d503201f d503201f (a8c12027)
[ 4545.471852] ---[ end trace 4d1897f94759f461 ]---
[ 4545.476435] note: cat[8976] exited with preempt_count 2

I find the issue is introduced when applying commit f9040773b7bb
("arm64: move kernel image to base of vmalloc area"). This patch
make the kernel image overlap with vmalloc area. It will result in
vmalloc area have the huge page table. but the vmalloc_to_page is
not realize the change. and the function is public to any arch.

I fix it by adding the another kernel image condition in vmalloc_to_page
to make it keep the accordance with previous vmalloc mapping.

Fixes: f9040773b7bb ("arm64: move kernel image to base of vmalloc area")
Reported-by: tan xiaojun <tanxiaojun@huawei.com>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: zhongjiang <zhongjiang@huawei.com>
---
v2
 Reimplement the fix by adding the kernel_image_addr helper function.
 instead by the previos fix by forcing the kernel image page table to
 set up in page granularity. beacuse it will bring in TLB pressure.

 include/linux/mm.h |  8 ++++++++
 mm/vmalloc.c       | 14 ++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6ad0ef6..2b45b46 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -509,6 +509,14 @@ static inline bool is_vmalloc_addr(const void *x)
 	return false;
 #endif
 }
+
+static inline bool is_kernel_image_addr(const void *x)
+{
+	unsigned long addr = (unsigned long)x;
+
+	return addr >= (unsigned long)_stext && add < (unsigned long)_end;
+}
+
 #ifdef CONFIG_MMU
 extern int is_vmalloc_or_module_addr(const void *x);
 #else
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 68eb002..19b9c6e 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -262,6 +262,11 @@ int is_vmalloc_or_module_addr(const void *x)
 	return is_vmalloc_addr(x);
 }
 
+static struct page *kernel_image_to_page(const void *addr)
+{
+	return virt_to_page(lm_alias(addr));
+}
+
 /*
  * Walk a vmap address to the struct page it maps.
  */
@@ -281,6 +286,15 @@ struct page *vmalloc_to_page(const void *vmalloc_addr)
 	 */
 	VIRTUAL_BUG_ON(!is_vmalloc_or_module_addr(vmalloc_addr));
 
+	/*
+	 * kenrel image overlap with the vmalloc area in arm64, it will
+	 * make the huge talbe page existence, if we walk the all page
+	 * talbe, it may be result in the panic. Add the following code,
+	 * it will keep consistent with previous behavior.
+	 */
+	if (is_kernel_image_addr(vmalloc_addr))
+		return kernel_image_to_page(vmalloc_addr);
+
 	if (pgd_none(*pgd))
 		return NULL;
 	p4d = p4d_offset(pgd, addr);
-- 
1.7.12.4
