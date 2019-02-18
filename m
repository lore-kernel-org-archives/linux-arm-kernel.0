Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB097C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:08:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78F722070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IJuLfRPz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78F722070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jUgxlOzPb8bbrKtN0yCXe5lEHvVBQUyiiRv8bnYWDJE=; b=IJuLfRPzaSe1sJ
	oGADj+Isp/r6jSP1n5cNNZoDUg+TMOLTKbOVfKDeo20/PPEcGUdLV4Py42mo+X7gdYGgVhubp/klm
	LhYwNSDCvEYxw6dSRGhvNxpwe8wPVARf1XzzPCToMUiffptQxhE1QphdiNtu70mT8/T4TPb3dTDWU
	8sNEo3xtAYQWClIsAN4r0O7NVWaQkkUaI0IjrcWGkRhNyU7lrF7L6CgVCBKsbFw2gq2CxxPis8XNK
	QRvvARNh09sg1z/L00NX/R9LAeDUsfFbmTFJ+r2oQSgXa1b4ex8GRxxJIKXtYlKrn+qNsz1FTlVTK
	b9IgWus/PbC2QThzLjJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvq9k-0006WX-W5; Mon, 18 Feb 2019 21:08:53 +0000
Received: from mout.kundenserver.de ([212.227.17.13])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvq8o-0005QA-Kf; Mon, 18 Feb 2019 21:07:56 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MlO9r-1hL1UD3zaP-00liHH; Mon, 18 Feb 2019 22:07:29 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org
Subject: [PATCH 6/8] checksyscalls: fix up mq_timedreceive and stat exceptions
Date: Mon, 18 Feb 2019 22:07:10 +0100
Message-Id: <20190218210712.3503891-7-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190218210712.3503891-1-arnd@arndb.de>
References: <20190218210712.3503891-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:UgT5qLzBRe8uGhCU9AyHn5Jt9cfHoQ+D0/iLF4gMTpdoEuzsO5q
 poQ3zyyety+N59s3VxhuXLURLB1ufFgiJP7cPrbxRJTMbWMQ7K0uKTGBFu/NpnSZWaFSdog
 T5gcp2hhQXO/x3YKwmnCZyKSdPjGDBSytrIMMHzUDbw9nXiaOEcLEtNWS47SPtFe0pvedzm
 Ahdkq9w/U6TCxmxQhHcnQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FXDoJv4Bfvw=:6GGmsD/rmCT7ei5OeBL7DH
 t9coJHnvAkWeYWrmUafR5IWBjDhHbw2hVsAkjpwqjvj3M0jVTAtvr7aqtTJp3u2S6u2FYnMqW
 oespDKsgf17cgnskdeI7Sy/It7HDngnnl74fqB+LbOq6/d7fW09m7xuwmbqLX9HGP30okqkVC
 l7Rv7RBccaKtbAvSmZmfBLGqy4RvBP2v1u7W8bw0wCcDCNj/9OGlxnPdKoduPuCDMljPNKkFg
 JTtgWH8cJKfZZ2jO2wbH+O8AtgAx2NPL0R3zDybKPp0Dsvbr4choUvo5Ukzb/LYmpBH/5SqTj
 0eUWMq3UHbkVx8A/WLYPvrRLXGGufyIG3fJukEQka4tWA9POcGL7GbFZdx6cX1YBavQM6+ByU
 zU4K+JW1rJnKBnsQVgKCCms9O+DsmmG7AUmR4yF7tA00HB40Cy1HsgjbxYpo0aWBks6MLe+8E
 S7M6NSY9pyhl8HXrsGEtNZYBhlLUN0Cgw0vl8vgW3V9gq7fPe+GUbtgAxR7VsfN4YHZACoZ/p
 IzfbkPLQA2l7yP0ln+KZkpHc+jEUnWcCy6Leah+mx8/eM2RAQSXAVtrOZGtmgJWqm69jQKts1
 eeB3ScSFFC+r9IGdyNPr8m6apR0guzuUaE1Vw6q+1wIVfXRrJu6sT7SocYw82+e3UcDNhEurI
 7gyiHW/RS/RFQmAfCFQy82U8gb9TOHsW93BtxnO0Uva0vatR8Yfwov25b1QvqBmgsxezJ9Bpq
 o0d2GWfT3VWHoeSTt3tl9IAc2q/hmZNKR3+1xg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_130754_976883_E180C3D2 
X-CRM114-Status: UNSURE (   8.78  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-arch@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp,
 arnd@arndb.de, yury.norov@gmail.com, linux-api@vger.kernel.org,
 Palmer Dabbelt <palmer@sifive.com>, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Vineet Gupta <vgupta@synopsys.com>,
 Guo Ren <guoren@kernel.org>, Greentime Hu <green.hu@gmail.com>,
 linux-hexagon@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Guan Xuetao <gxt@pku.edu.cn>, Stafford Horne <shorne@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

mq_timedreceive was spelled incorrectly, and we need exceptions
for new architectures that leave out newstat or stat64, implementing
only statx() now.

Fixes: 48166e6ea47d ("y2038: add 64-bit time_t syscalls to all 32-bit architectures")
Fixes: bf4b6a7d371e ("y2038: Remove stat64 family from default syscall set")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 scripts/checksyscalls.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
index ffd635efbdca..a18b47695f55 100755
--- a/scripts/checksyscalls.sh
+++ b/scripts/checksyscalls.sh
@@ -30,13 +30,10 @@ cat << EOF
 #define __IGNORE_readlink	/* readlinkat */
 #define __IGNORE_symlink	/* symlinkat */
 #define __IGNORE_utimes		/* futimesat */
-#if BITS_PER_LONG == 64
 #define __IGNORE_stat		/* fstatat */
 #define __IGNORE_lstat		/* fstatat */
-#else
 #define __IGNORE_stat64		/* fstatat64 */
 #define __IGNORE_lstat64	/* fstatat64 */
-#endif
 
 #ifndef __ARCH_WANT_SET_GET_RLIMIT
 #define __IGNORE_getrlimit	/* getrlimit */
@@ -138,7 +135,7 @@ cat << EOF
 #define __IGNORE_io_pgetevents
 #define __IGNORE_recvmmsg
 #define __IGNORE_mq_timedsend
-#define __IGNORE_mq_timedreceiv
+#define __IGNORE_mq_timedreceive
 #define __IGNORE_semtimedop
 #define __IGNORE_rt_sigtimedwait
 #define __IGNORE_futex
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
