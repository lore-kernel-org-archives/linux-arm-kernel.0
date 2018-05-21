From: leo.yan@linaro.org (Leo Yan)
Date: Mon, 21 May 2018 16:52:28 +0800
Subject: [RFT v2 4/4] coresight: Document for CoreSight trace disassembler
In-Reply-To: <1526892748-326-1-git-send-email-leo.yan@linaro.org>
References: <1526892748-326-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1526892748-326-5-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit documents CoreSight trace disassembler usage and gives
example for it.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 Documentation/trace/coresight.txt | 52 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/trace/coresight.txt b/Documentation/trace/coresight.txt
index 6f0120c..b8f2359 100644
--- a/Documentation/trace/coresight.txt
+++ b/Documentation/trace/coresight.txt
@@ -381,3 +381,55 @@ sort example is from the AutoFDO tutorial (https://gcc.gnu.org/wiki/AutoFDO/Tuto
 	$ taskset -c 2 ./sort_autofdo
 	Bubble sorting array of 30000 elements
 	5806 ms
+
+
+Tracing data disassembler
+-------------------------
+
+'perf script' supports to use script to parse tracing packet and rely on
+'objdump' for disassembled lines, this can convert tracing data to readable
+program execution flow for easily reviewing tracing data.
+
+The CoreSight trace disassembler is located in the folder:
+tools/perf/scripts/python/arm-cs-trace-disasm.py.  This script support below
+options:
+
+	-d, --objdump: Set path to objdump executable, this option is
+		       mandatory.
+	-k, --vmlinux: Set path to vmlinux file.
+	-v, --verbose: Enable debugging log, after enable this option the
+		       script dumps every event data.
+
+Below is one example for using python script to dump CoreSight trace
+disassembler:
+
+	$ perf script -s arm-cs-trace-disasm.py -i perf.data \
+	    -F cpu,event,ip,addr,sym -- -d objdump -k ./vmlinux > cs-disasm.log
+
+Below is one example for the disassembler log:
+
+ARM CoreSight Trace Data Assembler Dump
+	ffff000008a5f2dc <etm4_enable_hw+0x344>:
+	ffff000008a5f2dc:	340000a0 	cbz	w0, ffff000008a5f2f0 <etm4_enable_hw+0x358>
+	ffff000008a5f2f0 <etm4_enable_hw+0x358>:
+	ffff000008a5f2f0:	f9400260 	ldr	x0, [x19]
+	ffff000008a5f2f4:	d5033f9f 	dsb	sy
+	ffff000008a5f2f8:	913ec000 	add	x0, x0, #0xfb0
+	ffff000008a5f2fc:	b900001f 	str	wzr, [x0]
+	ffff000008a5f300:	f9400bf3 	ldr	x19, [sp, #16]
+	ffff000008a5f304:	a8c27bfd 	ldp	x29, x30, [sp], #32
+	ffff000008a5f308:	d65f03c0 	ret
+	ffff000008a5fa18 <etm4_enable+0x1b0>:
+	ffff000008a5fa18:	14000025 	b	ffff000008a5faac <etm4_enable+0x244>
+	ffff000008a5faac <etm4_enable+0x244>:
+	ffff000008a5faac:	b9406261 	ldr	w1, [x19, #96]
+	ffff000008a5fab0:	52800015 	mov	w21, #0x0                   	// #0
+	ffff000008a5fab4:	f901ca61 	str	x1, [x19, #912]
+	ffff000008a5fab8:	2a1503e0 	mov	w0, w21
+	ffff000008a5fabc:	3940e261 	ldrb	w1, [x19, #56]
+	ffff000008a5fac0:	f901ce61 	str	x1, [x19, #920]
+	ffff000008a5fac4:	a94153f3 	ldp	x19, x20, [sp, #16]
+	ffff000008a5fac8:	a9425bf5 	ldp	x21, x22, [sp, #32]
+	ffff000008a5facc:	a94363f7 	ldp	x23, x24, [sp, #48]
+	ffff000008a5fad0:	a8c47bfd 	ldp	x29, x30, [sp], #64
+	ffff000008a5fad4:	d65f03c0 	ret
-- 
2.7.4
