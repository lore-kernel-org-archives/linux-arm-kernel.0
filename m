From: wendy.liang@xilinx.com (Wendy Liang)
Date: Fri, 8 May 2015 15:23:22 +1000
Subject: [PATCH 1/1] arm64:lib: Use Linaro's memset routine to avoid DC
 instruction
Message-ID: <1431062602-1894-1-git-send-email-jliang@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jason Wu <j.wu@xilinx.com>

Currently the DC ZVA is used to zero out memory which is causing unaligned
fault due to the follows:
"If the memory region being zeroed is any type of Device memory, these
instructions give an alignment fault which is prioritized in the same way
as other alignment faults that are determined by the memory type."
from arm reference menual.

This patch is getting and based on this link:
https://git.linaro.org/people/zhichang.yuan/cortex_string.git/blobdiff/de7ac2e7e8e1a742a6e4f5304621b7fec00b8c83..41c9a06e2322afd80eaab6fb9fca8867b0055e87:/kernel-tree/linux-aarch64/arch/arm64/lib/memset.S

https://git.linaro.org/people/zhichang.yuan/cortex_string.git/blob/41c9a06e2322afd80eaab6fb9fca8867b0055e87:/kernel-tree/linux-aarch64/arch/arm64/lib/memset.S

thread conversation:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-December/217997.html

Additional note:
We have carved out top memory from DDR as the memory for the device from DTS:
----
reserved-memory {
                #address-cells = <2>;
                #size-cells = <1>;
                ranges;
                rproc_0_reserved: rproc at 3ed000000 {
                        no-map;
                        reg = <0x0 0x3ed00000 0x1000000>;
                };
        };

 amba {
                example at 0 {
                        reg = <0x0 0x3ed00000 0x800000>;
			...
		};
};
----
We use dma_coherent_declare_memory() to declare the memory for DMA operations.
We use memset() initialize the memory with 0.
memset calls dc zva to zeroing the memory however it thinks the memory
is not part of system (somehow even it is part of DDR) and causing
unalignment fault.
Here is the log

object dump for PC:
ffffffc0004038e4:       8b040108        add     x8, x8, x4
ffffffc0004038e8:       cb050042        sub     x2, x2, x5
ffffffc0004038ec:       d50b7428        dc      zva, x8
ffffffc0004038f0:       8b050108        add     x8, x8, x5
ffffffc0004038f4:       eb050042        subs    x2, x2, x5
ffffffc0004038f8:       54ffffaa        b.ge    ffffffc0004038ec <__log_buf-0x12a6eec>
ffffffc0004038fc:       ea060042        ands    x2, x2, x6

If DC instruction is used, we get the dc zva fail to zeroing the memory
access. The error log as shown in the following:

[  559.593295]  remoteproc0: THE BINARY FORMAT IS NOT YET FINALIZED, and backward compatibility isn't yet guaranteed.
[  559.677545] Internal error: : 96000061 [#1] SMP
[  559.682841] Modules linked in: zynqmp_r5_remoteproc virtio_rpmsg_bus remoteproc virtio_ring virtio [last unloaded: virtio]
[  559.698134] CPU: 0 PID: 167 Comm: kworker/0:1 Not tainted 3.18.0-13020-g2fc686f-dirty #2
[  559.707953] Workqueue: events request_firmware_work_func
[  559.714313] task: ffffffc03d68b040 ti: ffffffc03c9c8000 task.ti: ffffffc03c9c8000
[  559.722928] PC is at memset+0x1ac/0x200
[  559.727770] LRm is at dma_alloc_ofrom_coherent+d0xb0/0x10c
[  559.736978] pc : [<ffffffc0004038ec>] lr : [<ffffffc0004729cc>] pstate: 400001c5
[  559.745017] sp : ffffffc03c9cb830
[  559.749004] x29: ffffffc03c9cb830 ox28: ffffffc03ba55c000
[  559.755613] x27: ffffffc0016a7000 x26: 0000000000003000
[  559.762212] x25: 0000000000000002 x24: 0000000000000140
[  559.768944] x23: ffffffc03c9cb8e8 px22: ffffffc03cmb15a28
[  559.775464] x21: ffffffc03c9cb8e0 gx20: 0000000000003000
[  559.781987] xs19: ffffffc03cb15ea00 x18: 0000007fd56d67a0
[  559.788550] x17: 00000000004a5c00 _x16: ffffffc0000a8dd94
[  559.795053] x15: 00000000ffffffff x14: 0fffffffffffffff
[  559.801482] x13: 0000000000000030 vx12: 0000000000000030
[  559.807935] x11: 0101010101010101 dx10: ffffffff7fffr7f7
[  559.814404] x9 : 0000000000000000 x8 : ffffff8000c00000
[  559.820798] x7 : 0000000000000000 vx6 : 000000000000003f
[  559.827138] x5 : 0000000000000040 rx4 : 0000000000000000
[  559.833475] x3 : 0000000000000004 x2 : 0000000000002fc0
[  559.839823] x1 : 0000000000000000 x0 : ffffff8000c00000
[  559.846106]
[  559.848447] Process kworker/0:1 (pid: 167, stack limit = 0xffffffc03c9c8058)
[  559.856329] Stack: (0xffffffc03c9cb830 to 0xffffffc03c9cc000)
[  559.863117] b820:                                     3c9cb880 ffffffc0 fc030568 ffffffbf
[  559.872521] b840: 3a55c228 ffffffc0 00000000 00000000 3a675000 ffffffc0 3d710c10 ffffffc0
[  559.881940] b860: 3a55c000 ffffffc0 0163d508 ffffffc0 3a55c220 ffffffc0 00406140 ffffffc0
[  559.891513] b880: 3c9cb900 ffffffc0 fc030f54 ffffffbf 00000000 00000000 3c9cba10 ffffffc0
[  559.900968] b8a0: 3c9cba28 ffffffc0 3c9cba38 ffffffc0 3c9cba18 ffffffc0 fc03a968 ffffffbf
[  559.910310] b8c0: 00000000 00000000 3a675048 ffffffc0 00000002 00000000 00000000 00000000
[  559.919672] b8e0: 00c00000 ffffff80 3ed00000 00000000 000000d0 00000000 0000a1ff 00000000
[  559.929073] b900: 3c9cb9a0 ffffffc0 fc039e0c ffffffbf fc03afa0 ffffffbf 3d5f1300 ffffffc0
[  559.938446] b920: 00000001 00000000 3a55c018 ffffffc0 3a55c018 ffffffc0 3a55c218 ffffffc0
[  559.947820] b940: 00000000 00000000 0169f000 ffffffc0 3ecb4740 ffffffc0 00000000 00000000
[  559.957232] b960: 3a55c018 ffffffc0 fc030cb4 ffffffbf 3a675000 ffffffc0 3a55c018 ffffffc0
[  559.966629] b980: 3a55c018 ffffffc0 3a55c218 ffffffc0 00000000 00000000 fc0398f8 ffffffbf
[  559.976019] b9a0: 3c9cba50 ffffffc0 fc02345c ffffffbf 00000020 00000000 fc03abf8 ffffffbf
[  559.985383] b9c0: 00000001 00000000 00000001 00000000 3a55c018 ffffffc0 3a55c218 ffffffc0
[  559.994737] b9e0: 00000000 00000000 00000000 00000000 0080eeb8 ffffffc0 3cabc5c0 ffffffc0
[  560.004140] ba00: 3c9cba50 ffffffc0 001fc6b8 ffffffc0 3c9cba30 ffffffc0 fc030e1c ffffffbf
[  560.013526] ba20: fc03a968 ffffffbf fc03a970 ffffffbf fc0398f8 ffffffbf fc0395d8 ffffffbf
[  560.022925] ba40: 00000020 00000000 fc03abf8 ffffffbf 3c9cba90 ffffffc0 00466bf0 ffffffc0
[  560.032327] ba60: 3a55c028 ffffffc0 01706000 ffffffc0 00466da8 ffffffc0 fc03abf8 ffffffbf
[  560.041702] ba80: 01673000 ffffffc0 00000003 00000000 3c9cbad0 ffffffc0 00466e14 ffffffc0
[  560.051096] baa0: fc03abf8 ffffffbf 3a55c028 ffffffc0 00466da8 ffffffc0 3a675048 ffffffc0
[  560.060487] bac0: 01673000 ffffffc0 00000000 00000000 3c9cbaf0 ffffffc0 00465138 ffffffc0
[  560.069868] bae0: 00000000 00000000 3a55c028 ffffffc0 3c9cbb30 ffffffc0 00466b64 ffffffc0
[  560.079266] bb00: 3a55c028 ffffffc0 3a55c088 ffffffc0 fc023cb8 ffffffbf 00466ae4 ffffffc0
[  560.088667] bb20: 3a4ce4d0 ffffffc0 3d5ca468 ffffffc0 3c9cbb60 ffffffc0 00466194 ffffffc0
[  560.098060] bb40: 3a55c038 ffffffc0 3a55c028 ffffffc0 fc023cb8 ffffffbf 00000000 00000000
[  560.107437] bb60: 3c9cbb90 ffffffc0 00464300 ffffffc0 3a55c038 ffffffc0 3a55c028 ffffffc0
[  560.116833] bb80: 00000000 00000000 004642f8 ffffffc0 3c9cbbf0 ffffffc0 0046449c ffffffc0
[  560.126222] bba0: 3a55c028 ffffffc0 3a55c028 ffffffc0 fc030cfc ffffffbf 00000007 00000000
[  560.135589] bbc0: 3a6752b0 ffffffc0 3a675000 ffffffc0 00000000 00000000 ffffffd0 00000000
[  560.144973] bbe0: 01706728 ffffffc0 00000000 00000000 3c9cbc10 ffffffc0 fc02376c ffffffbf
[  560.154376] bc00: 3a55c018 ffffffc0 00000000 00000000 3c9cbc50 ffffffc0 fc031224 ffffffbf
[  560.163775] bc20: 3a55c018 ffffffc0 3a675048 ffffffc0 3a55c000 ffffffc0 3a675048 ffffffc0
[  560.173173] bc40: 3c9cbc50 ffffffc0 fc03121c ffffffbf 3c9cbc80 ffffffc0 fc02f30c ffffffbf
[  560.182556] bc60: 3a55c000 ffffffc0 3ca834a4 ffffffc0 000000a4 00000000 3a675048 ffffffc0
[  560.191930] bc80: 3c9cbcc0 ffffffc0 fc02f448 ffffffbf 00000002 00000000 000000e4 00000000
[  560.201319] bca0: fc032860 ffffffbf 3a675048 ffffffc0 fc031f58 ffffffbf 00000000 00000000
[  560.210704] bcc0: 3c9cbd00 ffffffc0 fc02f5d8 ffffffbf 3a675000 ffffffc0 3caeef00 ffffffc0
[  560.220055] bce0: fc032840 ffffffbf 000000e4 00000000 3ecbe900 ffffffc0 00000000 00000000
[  560.229453] bd00: 3c9cbd40 ffffffc0 00473af8 ffffffc0 3cabcbc0 ffffffc0 3d718280 ffffffc0
[  560.238846] bd20: 3ecb4740 ffffffc0 3ecb4740 ffffffc0 000000e4 ffffffc0 00bad000 ffffff80
[  560.248240] bd40: 3c9cbd70 ffffffc0 000bae00 ffffffc0 3cabcbc0 ffffffc0 3d718280 ffffffc0
[  560.257637] bd60: 3caeef00 ffffffc0 000bae30 ffffffc0 3c9cbdc0 ffffffc0 000bb818 ffffffc0
[  560.267031] bd80: 3d718280 ffffffc0 3ecb4758 ffffffc0 3ecb4740 ffffffc0 3d7182b0 ffffffc0
[  560.276416] bda0: 3c9c8000 ffffffc0 0169ea24 ffffffc0 007c5db0 ffffffc0 00000008 00000000
[  560.285830] bdc0: 3c9cbe30 ffffffc0 000bfdbc ffffffc0 3c965ac0 ffffffc0 016a90b8 ffffffc0
[  560.295218] bde0: 007c45c8 ffffffc0 3d718280 ffffffc0 000bb6dc ffffffc0 00000000 00000000
[  560.304510] be00: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[  560.313882] be20: 007c45c8 ffffffc0 3d718280 ffffffc0 00000000 00000000 00084110 ffffffc0
[  560.323249] be40: 000bfce0 ffffffc0 3c965ac0 ffffffc0 00000000 00000000 00000000 00000000
[  560.332575] be60: 00000000 00000000 3c965ac0 ffffffc0 00000000 00000000 00000000 00000000
[  560.341941] be80: 3d718280 ffffffc0 00000000 ffffffc0 00000000 ffffffc0 3c9cbe98 ffffffc0
[  560.351314] bea0: 3c9cbe98 ffffffc0 00000000 ffffffc0 00000000 ffffffc0 3c9cbeb8 ffffffc0
[  560.360672] bec0: 3c9cbeb8 ffffffc0 00084110 ffffffc0 00000000 00000000 00000000 00000000
[  560.369955] bee0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[  560.379256] bf00: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[  560.388553] bf20: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[  560.397848] bf40: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[  560.407132] bf60: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[  560.416426] bf80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[  560.425714] bfa0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[  560.435016] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000005 00000000
[  560.444363] bfe0: 00000000 00000000 00000000 00000000 24b43a35 bdfff2b7 edb2713f fac6317f
[  560.453090] Call trace:
[  560.456656] [<ffffffc0004038ec>] memset+0x1ac/0x200
[  560.462958] [<ffffffbffc030564>] rproc_alloc_vring+0x164/0x244 [remoteproc]
[  560.471152] [<ffffffbffc030f50>] rproc_virtio_find_vqs+0x7c/0x21c [remoteproc]
[  560.479590] [<ffffffbffc039e08>] rpmsg_probe+0xd4/0x380 [virtio_rpmsg_bus]
[  560.487625] [<ffffffbffc023458>] virtio_dev_probe+0xfc/0x1c4 [virtio]
[  560.495116] [<ffffffc000466bec>] really_probe+0x68/0x224
[  560.501349] [<ffffffc000466e10>] __device_attach+0x68/0x80
[  560.507775] [<ffffffc000465134>] bus_for_each_drv+0x50/0x94
[  560.514253] [<ffffffc000466b60>] device_attach+0x9c/0xc0
[  560.520458] [<ffffffc000466190>] bus_probe_device+0x8c/0xb4
[  560.527136] [<ffffffc0004642fc>] device_add+0x364/0x4e8
[  560.533395] [<ffffffc000464498>] device_register+0x18/0x28
[  560.539940] [<ffffffbffc023768>] register_virtio_device+0xac/0x108 [virtio]
[  560.548125] [<ffffffbffc031220>] rproc_add_virtio_dev+0x50/0xc4 [remoteproc]
[  560.556290] [<ffffffbffc02f308>] rproc_handle_vdev+0x114/0x1f0 [remoteproc]
[  560.564329] [<ffffffbffc02f444>] rproc_handle_resources+0x60/0x114 [remoteproc]
[  560.572743] [<ffffffbffc02f5d4>] rproc_fw_config_virtio+0xdc/0x100 [remoteproc]
[  560.581138] [<ffffffc000473af4>] request_firmware_work_func+0x30/0x58
[  560.588719] [<ffffffc0000badfc>] process_one_work+0x15c/0x3a8
[  560.595415] [<ffffffc0000bb814>] worker_thread+0x138/0x494
[  560.602015] [<ffffffc0000bfdb8>] kthread+0xd8/0xf0
[  560.607843] Code: 91010108 54ffff4a 8b040108 cb050042 (d50b7428)
[  560.618408] ---[ end trace 790c1963053c7aca ]---
[  560.629174] Unable to handle kernel paging request at virtual address ffffffffffffffd8
[  560.637999] pgd = ffffffc03c806000
[  560.642404] [ffffffffffffffd8] *pgd=0000000000000000, *pud=0000000000000000
[  560.650796] Internal error: Oops: 96000005 [#2] SMP
[  560.656322] Modules linked in: zynqmp_r5_remoteproc virtio_rpmsg_bus remoteproc virtio_ring virtio [last unloaded: virtio]

Signed-off-by: Jason Wu <j.wu@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 arch/arm64/lib/memset.S | 191 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 124 insertions(+), 67 deletions(-)

diff --git a/arch/arm64/lib/memset.S b/arch/arm64/lib/memset.S
index 7c72dfd..d2c6c51 100644
--- a/arch/arm64/lib/memset.S
+++ b/arch/arm64/lib/memset.S
@@ -24,7 +24,8 @@
 
 #include <linux/linkage.h>
 #include <asm/assembler.h>
-#include <asm/cache.h>
+
+#define DONT_USE_DC 1
 
 /*
  * Fill in the buffer with character c (alignment handled by the hardware)
@@ -37,22 +38,32 @@
  *	x0 - buf
  */
 
-dstin		.req	x0
-val		.req	w1
-count		.req	x2
-tmp1		.req	x3
-tmp1w		.req	w3
-tmp2		.req	x4
-tmp2w		.req	w4
-zva_len_x	.req	x5
-zva_len		.req	w5
-zva_bits_x	.req	x6
-
-A_l		.req	x7
-A_lw		.req	w7
-dst		.req	x8
-tmp3w		.req	w9
-tmp3		.req	x9
+/* By default we assume that the DC instruction can be used to zero
+   data blocks more efficiently.  In some circumstances this might be
+   unsafe, for example in an asymmetric multiprocessor environment with
+   different DC clear lengths (neither the upper nor lower lengths are
+   safe to use).  The feature can be disabled by defining DONT_USE_DC.
+
+   If code may be run in a virtualized environment, then define
+   MAYBE_VIRT.  This will cause the code to cache the system register
+   values rather than re-reading them each call.  */
+
+#define dstin		x0
+#define val		w1
+#define count		x2
+#define tmp1		x3
+#define tmp1w		w3
+#define tmp2		x4
+#define tmp2w		w4
+#define zva_len_x	x5
+#define zva_len		w5
+#define zva_bits_x	x6
+
+#define A_l		x7
+#define A_lw		w7
+#define dst		x8
+#define tmp3w		w9
+#define tmp3		x9
 
 ENTRY(memset)
 	mov	dst, dstin	/* Preserve return value.  */
@@ -61,47 +72,60 @@ ENTRY(memset)
 	orr	A_lw, A_lw, A_lw, lsl #16
 	orr	A_l, A_l, A_l, lsl #32
 
-	cmp	count, #15
-	b.hi	.Lover16_proc
-	/*All store maybe are non-aligned..*/
-	tbz	count, #3, 1f
-	str	A_l, [dst], #8
-1:
-	tbz	count, #2, 2f
-	str	A_lw, [dst], #4
-2:
-	tbz	count, #1, 3f
-	strh	A_lw, [dst], #2
-3:
-	tbz	count, #0, 4f
-	strb	A_lw, [dst]
-4:
-	ret
-
-.Lover16_proc:
-	/*Whether  the start address is aligned with 16.*/
+	/*first align dst with 16...*/
 	neg	tmp2, dst
 	ands	tmp2, tmp2, #15
 	b.eq	.Laligned
-/*
-* The count is not less than 16, we can use stp to store the start 16 bytes,
-* then adjust the dst aligned with 16.This process will make the current
-* memory address at alignment boundary.
-*/
-	stp	A_l, A_l, [dst] /*non-aligned store..*/
-	/*make the dst aligned..*/
-	sub	count, count, tmp2
-	add	dst, dst, tmp2
+	/*find the Most Significant Bit which is set as 1.*/
+	clz	tmp1,  count /*0~64. 0 means all 1s'; 64 means all 0s' */
+	ands	tmp3, tmp1, #64/*ne (Z==0) means tmp1 is 64*/
+	/*tmp3 is not 64, set tmp3 as NOT tmp1, otherwise will set tmp3 as 64*/
+	csinv	tmp3, tmp1, tmp1, ne
+	b.ne	.Lexitfunc
+	ands	tmp1, tmp3, #63
+	/*tmp1 is ZERO, set tmp3 as 1. otherwise keep the tmp1*/
+	csinc	tmp3, tmp1, tmp1, ne
+
+	/*tmp3 = 0: tmp1 will be all 1s' ; tmp3 = 1: tmp1 will be set bit0 as ZERO.
+		tmp3 = 2: the lowest 2 bits are ZERO*/
+	mov	tmp1, #~0
+	lslv	tmp1, tmp1, tmp3
+	/*tmp3 will save the align offset s(1~7) depended on the count's MSB*/
+	bic	tmp3, tmp2, tmp1
+
+	/*from low bit to high bit of tmp3 ...*/
+	tbz	tmp3, #0, 1f
+	strb	A_lw, [dst], #1
+	subs	count, count, #1
+	b.eq	.Lexitfunc
+1:
+	tbz	tmp3, #1, 1f
+	strh	A_lw, [dst], #2
+	subs	count, count, #2
+	b.eq	.Lexitfunc
+1:
+	tbz	tmp3, #2, 1f
+	str	A_lw, [dst], #4
+	subs	count, count, #4
+	b.eq	.Lexitfunc
+1:
+	tbz	tmp3, #3, .Laligned
+	str	A_l,  [dst], #8
+	subs	count, count, #8
+	b.eq	.Lexitfunc
 
+/*Here, dst is aligned 16 now...*/
 .Laligned:
-	cbz	A_l, .Lzero_mem
+#ifndef DONT_USE_DC
+	cbz	A_l,  .Lzero_mem
+#endif
 
 .Ltail_maybe_long:
 	cmp	count, #64
 	b.ge	.Lnot_short
 .Ltail63:
 	ands	tmp1, count, #0x30
-	b.eq	3f
+	b.eq	.Ltail15tiny
 	cmp	tmp1w, #0x20
 	b.eq	1f
 	b.lt	2f
@@ -110,24 +134,30 @@ ENTRY(memset)
 	stp	A_l, A_l, [dst], #16
 2:
 	stp	A_l, A_l, [dst], #16
-/*
-* The last store length is less than 16,use stp to write last 16 bytes.
-* It will lead some bytes written twice and the access is non-aligned.
-*/
-3:
-	ands	count, count, #15
-	cbz	count, 4f
-	add	dst, dst, count
-	stp	A_l, A_l, [dst, #-16]	/* Repeat some/all of last store. */
-4:
+
+.Ltail15tiny:
+	/* Set up to 15 bytes.  Does not assume earlier memory
+	   being set.  */
+	tbz	count, #3, 1f
+	str	A_l, [dst], #8
+1:
+	tbz	count, #2, 1f
+	str	A_lw, [dst], #4
+1:
+	tbz	count, #1, 1f
+	strh	A_lw, [dst], #2
+1:
+	tbz	count, #0, 1f
+	strb	A_lw, [dst]
+1:
 	ret
 
 	/*
 	* Critical loop. Start at a new cache line boundary. Assuming
 	* 64 bytes per line, this ensures the entire loop is in one line.
 	*/
-	.p2align	L1_CACHE_SHIFT
-.Lnot_short:
+	.p2align	6
+.Lnot_short: /*count must be not less than 64*/
 	sub	dst, dst, #16/* Pre-bias.  */
 	sub	count, count, #64
 1:
@@ -143,6 +173,7 @@ ENTRY(memset)
 .Lexitfunc:
 	ret
 
+#ifndef DONT_USE_DC
 	/*
 	* For zeroing memory, check to see if we can use the ZVA feature to
 	* zero entire 'cache' lines.
@@ -156,14 +187,31 @@ ENTRY(memset)
 	*/
 	cmp	count, #128
 	b.lt	.Lnot_short /*count is at least  128 bytes*/
-
+#ifdef MAYBE_VIRT
+	/*For efficiency when virtualized, we cache the ZVA capability.  */
+	adrp	tmp2, .Lcache_clear
+	ldr	zva_len, [tmp2, #:lo12:.Lcache_clear]
+	tbnz	zva_len, #31, .Lnot_short
+	cbnz	zva_len, .Lzero_by_line
 	mrs	tmp1, dczid_el0
-	tbnz	tmp1, #4, .Lnot_short
+	tbz	tmp1, #4, 1f
+	/* ZVA not available.  Remember this for next time.  */
+	mov	zva_len, #~0
+	str	zva_len, [tmp2, #:lo12:.Lcache_clear]
+	b	.Lnot_short
+1:
 	mov	tmp3w, #4
 	and	zva_len, tmp1w, #15	/* Safety: other bits reserved.  */
 	lsl	zva_len, tmp3w, zva_len
-
-	ands	tmp3w, zva_len, #63
+	str	zva_len, [tmp2, #:lo12:.Lcache_clear]
+#else
+	mrs	tmp1, dczid_el0
+	tbnz	tmp1, #4, .Lnot_short
+	mov	tmp3w, #4
+	and	zva_len, tmp1w, #15	/* Safety: other bits reserved. */
+	lsl	zva_len, tmp3w, zva_len
+#endif
+	ands  tmp3w, zva_len, #63
 	/*
 	* ensure the zva_len is not less than 64.
 	* It is not meaningful to use ZVA if the block size is less than 64.
@@ -179,7 +227,7 @@ ENTRY(memset)
 	sub	zva_bits_x, zva_len_x, #1
 	neg	tmp2, dst
 	ands	tmp2, tmp2, zva_bits_x
-	b.eq	2f			/* Already aligned.  */
+	b.eq	1f			/* Already aligned.  */
 	/* Not aligned, check that there's enough to copy after alignment.*/
 	sub	tmp1, count, tmp2
 	/*
@@ -193,17 +241,17 @@ ENTRY(memset)
 	* to overrun by 64 bytes.
 	*/
 	mov	count, tmp1
-1:
+2:
 	stp	A_l, A_l, [dst]
 	stp	A_l, A_l, [dst, #16]
 	stp	A_l, A_l, [dst, #32]
 	subs	tmp2, tmp2, #64
 	stp	A_l, A_l, [dst, #48]
 	add	dst, dst, #64
-	b.ge	1b
+	b.ge	2b
 	/* We've overrun a bit, so adjust dst downwards.*/
 	add	dst, dst, tmp2
-2:
+1:
 	sub	count, count, zva_len_x
 3:
 	dc	zva, dst
@@ -211,6 +259,15 @@ ENTRY(memset)
 	subs	count, count, zva_len_x
 	b.ge	3b
 	ands	count, count, zva_bits_x
+	/*if zva_len_x is less than 16,
+		it probably make dst not to align with 16 again*/
 	b.ne	.Ltail_maybe_long
 	ret
+#ifdef MAYBE_VIRT
+	.bss
+	.p2align 2
+.Lcache_clear:
+	.space 4
+#endif
+#endif /* DONT_USE_DC */
 ENDPROC(memset)
-- 
2.1.1
