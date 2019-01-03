Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4109C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:32:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71B3021479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b9jBQfG7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B3021479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=/JiyJkPz3SsrQbhAsP4Zl1AyZG7526R0K0sn4adLTZQ=; b=b9jBQfG74b6JaN
	bvPlpp/6+/IHYAaZxQheRjoZnBqPVXiaqRLDIiP2wAw8YKDsSldkA1n4C4Q0j5l3kFkLmBfOVdTT7
	NZhx1TJjqoFjhimTKNBRmO9c+dqe3FeS+P25j+uQz/w1sZpOfh4gA0ha04vN2S0dohCVGABmLSmFP
	9OZiNjYGmgO5MEDvAG87o68iFMQuLWbW6sNtWs3XxTMCOFOG9ho7ZYauZbnh25f7p/4Lv4ftQWqfp
	dFgAC2G86Wm9Zog2DQe57Xld0Vl+aInN7LUHzlItgDPHwZ63/jcRdwVS7WHRMlfKAp7T9YXYIftgb
	QHCVvNXNvMB4cZ6TRGOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf2Al-0004Wy-To; Thu, 03 Jan 2019 12:32:27 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf2Ai-0004WU-1Q
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 12:32:25 +0000
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 2D71477FEB4AC
 for <linux-arm-kernel@lists.infradead.org>;
 Thu,  3 Jan 2019 20:32:14 +0800 (CST)
Received: from ubuntu.huawei.com (10.93.195.238) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Thu, 3 Jan 2019 20:32:06 +0800
From: Lingyan Huang <huanglingyan2@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2] arm64: lib: accelerate do_csum with NEON instruction
Date: Thu, 3 Jan 2019 20:32:49 +0800
Message-ID: <1546518769-114424-1-git-send-email-huanglingyan2@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.93.195.238]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_043224_260998_F5AE4170 
X-CRM114-Status: GOOD (  17.41  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lingyan Huang <huanglingyan2@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Function do_csum() in lib/checksum.c is used to compute checksum,
which is turned out to be slowly and costs a lot of resources.
Let's use neon instructions to accelerate the checksum computation
for arm64.

------
V1 ==> V2:
    Change NEON assembly code to NEON intrinsic code which is built
    on top of arm_neon.h to avoid dropping into assembly.
------

Here is the comparison results of function ip_compute_csum() between
general do_csum() and neon instruction do_csum().

        len(1000cycle)      general(ns)        do_csum_neon(ns)
          64B:                58060                 59460
         128B:                82930                 83930
         256B:               132480                 73570
         512B:               230100                 86230
        1024B:               426600                 98200


---
 arch/arm64/lib/Makefile        |   4 ++
 arch/arm64/lib/checksum.c      | 140 +++++++++++++++++++++++++++++++++++++++++
 include/asm-generic/checksum.h |   1 +
 lib/checksum.c                 |   8 ++-
 4 files changed, 152 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/lib/checksum.c

diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 5540a16..ec2fcd3 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -9,6 +9,10 @@ ifeq ($(CONFIG_KERNEL_MODE_NEON), y)
 obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
 CFLAGS_REMOVE_xor-neon.o	+= -mgeneral-regs-only
 CFLAGS_xor-neon.o		+= -ffreestanding
+
+obj-y    += checksum.o
+CFLAGS_REMOVE_checksum.o	+= -mgeneral-regs-only
+CFLAGS_checksum.o		+= -ffreestanding
 endif
 
 # Tell the compiler to treat all general purpose registers (with the
diff --git a/arch/arm64/lib/checksum.c b/arch/arm64/lib/checksum.c
new file mode 100644
index 0000000..48f4ead
--- /dev/null
+++ b/arch/arm64/lib/checksum.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * arch/arm64/lib/checksum.c
+ *
+ * Authors: Lingyan Huang <huanglingyan2@huawei.com>
+ * Copyright (C) 2018 Hisilicon, Inc. All Rights Reserved.
+ *
+ * Generic C or neon implementation of do_csum operations.
+ * Choose faster neon instructions when NEON is supported.
+ *
+ */
+
+#include <asm/neon.h>
+#include <asm/simd.h>
+#include <asm/checksum.h>
+#include <asm/byteorder.h>
+#include <asm/neon-intrinsics.h>
+
+#define CSUM_NEON_THRESHOLD 128
+#ifdef CONFIG_KERNEL_MODE_NEON
+static inline u32 from64to16(u64 x)
+{
+	/* add up 32-bit and 32-bit for 32+c bit */
+	x = (x & 0xffffffff) + (x >> 32);
+	/* add up carry.. */
+	x = (x & 0xffffffff) + (x >> 32);
+	/* add up 16-bit and 16-bit for 16+c bit */
+	x = ((u32)x & 0xffff) + ((u32)x >> 16);
+	/* add up carry.. */
+	x = ((u32)x & 0xffff) + ((u32)x >> 16);
+	return x;
+}
+
+unsigned int do_csum_neon(const unsigned char *buff, unsigned int len)
+{
+	unsigned int odd, count;
+	uint64_t result = 0;
+	unsigned int count64;
+	uint32x4_t vzero = (uint32x4_t){0, 0, 0, 0};
+
+	register uint32x4_t v0, v1, v2, v3;
+
+	if (unlikely(len <= 0))
+		return result;
+
+	odd = 1 & (unsigned long) buff;
+	if (unlikely(odd)) {
+		result = *buff;
+		len--;
+		buff++;
+	}
+
+	count = len >> 1;
+	if (count) {
+		if (2 & (unsigned long) buff) {
+			result += *(unsigned short *)buff;
+			count--;
+			len -= 2;
+			buff += 2;
+		}
+		count >>= 1;            /* nr of 32-bit words.. */
+		if (count) {
+			if (4 & (unsigned long) buff) {
+				result += *(unsigned int *) buff;
+				count--;
+				len -= 4;
+				buff += 4;
+			}
+			count >>= 1;    /* nr of 64-bit words.. */
+
+			v0 = vzero;
+			v1 = vzero;
+			v2 = vzero;
+			v3 = vzero;
+
+			count64 = count >> 3;  /* compute 64 Byte circle */
+			while (count64) {
+				v0 = vpadalq_u16(v0,
+					vld1q_u16((uint16_t *)buff + 0));
+				v1 = vpadalq_u16(v1,
+					vld1q_u16((uint16_t *)buff + 8));
+				v2 = vpadalq_u16(v2,
+					vld1q_u16((uint16_t *)buff + 16));
+				v3 = vpadalq_u16(v3,
+					vld1q_u16((uint16_t *)buff + 24));
+				buff += 64;
+				count64--;
+			}
+			v0 = vaddq_u32(v0, v1);
+			v2 = vaddq_u32(v2, v3);
+			v0 = vaddq_u32(v0, v2);
+
+			count %= 8;
+			while (count >= 2) { /* compute 16 byte circle */
+				v0 = vpadalq_u16(v0,
+					vld1q_u16((uint16_t *)buff + 0));
+				buff += 16;
+				count -= 2;
+			}
+
+			result += vgetq_lane_u32(v0, 0);
+			result += vgetq_lane_u32(v0, 1);
+			result += vgetq_lane_u32(v0, 2);
+			result += vgetq_lane_u32(v0, 3);
+			if (count & 1) {
+				result += *(unsigned long long *) buff;
+				buff += 8;
+			}
+			if (len & 4) {
+				result += *(unsigned int *) buff;
+				buff += 4;
+			}
+		}
+		if (len & 2) {
+			result += *(unsigned short *) buff;
+			buff += 2;
+		}
+	}
+	if (len & 1)
+		result += *buff;
+	result = from64to16(result);
+	if (odd)
+		result = ((result >> 8) & 0xff) | ((result & 0xff) << 8);
+	return result;
+}
+#endif
+
+
+unsigned int do_csum(const unsigned char *buff, unsigned int len)
+{
+	if ((len >= CSUM_NEON_THRESHOLD) && may_use_simd()) {
+		unsigned int res;
+
+		kernel_neon_begin();
+		res = do_csum_neon(buff, len);
+		kernel_neon_end();
+		return res;
+	} else
+		return do_csum_generic(buff, len);
+}
diff --git a/include/asm-generic/checksum.h b/include/asm-generic/checksum.h
index 34785c0..041063c 100644
--- a/include/asm-generic/checksum.h
+++ b/include/asm-generic/checksum.h
@@ -33,6 +33,7 @@ extern __wsum csum_partial_copy(const void *src, void *dst, int len, __wsum sum)
  */
 extern __wsum csum_partial_copy_from_user(const void __user *src, void *dst,
 					int len, __wsum sum, int *csum_err);
+extern unsigned int do_csum_generic(const unsigned char *buff, int len);
 
 #ifndef csum_partial_copy_nocheck
 #define csum_partial_copy_nocheck(src, dst, len, sum)	\
diff --git a/lib/checksum.c b/lib/checksum.c
index d3ec93f..83392db 100644
--- a/lib/checksum.c
+++ b/lib/checksum.c
@@ -47,7 +47,7 @@ static inline unsigned short from32to16(unsigned int x)
 	return x;
 }
 
-static unsigned int do_csum(const unsigned char *buff, int len)
+unsigned int do_csum_generic(const unsigned char *buff, int len)
 {
 	int odd;
 	unsigned int result = 0;
@@ -100,6 +100,12 @@ static unsigned int do_csum(const unsigned char *buff, int len)
 out:
 	return result;
 }
+
+static unsigned int do_csum(const unsigned char *buff, int len)
+{
+	return do_csum_generic(buff, len);
+}
+
 #endif
 
 #ifndef ip_fast_csum
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
