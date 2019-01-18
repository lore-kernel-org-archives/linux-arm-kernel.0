Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D01C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:21:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B1C3208E4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GB3PazOf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B1C3208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qyLAzzDbirY1B3Y8E5XXXITIzqP+a/ZSAEoiMdTndkA=; b=GB3PazOfFIOmFl
	IhoRV0u461R1kmeR3f5p4YOaPRfpKGtcHG1kArekdzVLFzjXCUlv1NuwUOF0OPNd8diGQkf6imCvN
	ep7ewi0FGEuy75ybzbY9nJhRj0gzwc68efdjvE8sv8UdfuN4sUK1sMyfCKTKSQ7aswdJ18hMN+Szc
	QOCJYlddtL8nkdtmn88RbP9fkDKsQKIqMeUuSCQuo/MH2xnxoa3AxrMp7dMMgXtlx+wA0NpLQHql9
	aI93pebmDiDtwwX/CwDZt9WZ4RB74AUPHXqnsR5bE9dAYpyNbyIOcMrSxuzeZ04jH5VMOj1ZwWQHF
	AMmS0FKB/qzFGCbF04Ig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkWtG-0001z8-BD; Fri, 18 Jan 2019 16:21:06 +0000
Received: from mout.kundenserver.de ([217.72.192.75])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWsc-0001N2-7d
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:20:28 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MxmBc-1hA8vX10n8-00zDnp; Fri, 18 Jan 2019 17:19:29 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 10/29] sh: add statx system call
Date: Fri, 18 Jan 2019 17:18:16 +0100
Message-Id: <20190118161835.2259170-11-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:t6R82Z8zvFPH8uWQ6By1AD6aeG6e8KS2PY2/czpxmB8Es3E26cv
 3dhBYAef9afhAuL29iHi03NhT3UhsVoPZnZgPwDSWRTBENn7w6vYQa04n0JEgelAV4AcQV4
 niYmWNSNREOQA7PmgEZSP8TTUvUovupTfoOkrCAgtXj1/eWPuXUVXUAbdG11E5Dzakhmw3B
 pcwXh5016l/gnps966ABw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K/830N4fOkA=:yN6pOj/X6AddYs3f+eMAIX
 KZAXszxGKZpxuZdFdqWqDpVCdiq7BDlsKw5Zlv3n5jTwNsq1pS7SY/hlDdh1ADT1cb5xsCgET
 Gb4r4HL1nl/9ZSl1wjr94ugJZp+q6Em6x9V1hItbA3T9OZ3/zX78SQoF69CITLB4KKWknfok0
 TJOMxaojmcDtEdRmxh0tBzQXNxtPyV45u4zhDAK4/qJk4Fo9usCEZjT1W0mkVwVHYTfKwLSIf
 HbIj8UKQPvMwOGeLhsnrXZA4dgFFmrDJ4/9M8+UG+tzMakmVh+YLibDaUM19QCE81rxIlw9T7
 p/zg75cru2OhVCX8iZ6bq3O+jwVsqqyIA/U5RJjjIJzr1EuN4IQLAd77WCJG6v/uc64+wnBWM
 7FLDGmYFLengqH3ZTPAKfuApbWgGoFtgkZZ6Pg4UtmLFbpOI2JTTPlSe9plOwagBizOzFsSEX
 ZAhC3O9XT2DutmKSKdV5rQTGRQKzBk/FlzWUP5/P5IKoHgKjXjXcLOjjPmQxEawiUNDcZg0kZ
 bZQMQZdNRpio44pggQSPFl6vkB/UQDTJ7EyCzjn+qHq09wFoF+HjbB1SSUO8j9Cuv9Gi2pI53
 10zJ/kIT6LsnKordXwiWo06lPR7ZnvRSnvaWbI14kQwXtODJiJyjPiinoFMZxqSJJXq5Qp/YP
 M7X0SSEku5AAmTelT8L5LGrCy9KOXPvV0ux6a9PVGXvk/IA7FOUywhhMyLCYnJwc3Dw/KEybT
 VbS5ECidR7DDExAyvQNUJmwmbhphorFSJQSrhQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_082026_571012_6FE6794F 
X-CRM114-Status: UNSURE (   9.22  )
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
Cc: dalias@libc.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 catalin.marinas@arm.com, will.deacon@arm.com, jcmvbkbc@gmail.com,
 deepa.kernel@gmail.com, hpa@zytor.com, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, mpe@ellerman.id.au, deller@gmx.de, x86@kernel.org,
 linux@armlinux.org.uk, mingo@redhat.com, geert@linux-m68k.org,
 benh@kernel.crashing.org, firoz.khan@linaro.org, mattst88@gmail.com,
 fenghua.yu@intel.com, Arnd Bergmann <arnd@arndb.de>, heiko.carstens@de.ibm.com,
 linux-fsdevel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 luto@kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 monstr@monstr.eu, tony.luck@intel.com, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, linux-mips@vger.kernel.org, paul.burton@mips.com,
 ebiederm@xmission.com, linux-alpha@vger.kernel.org, schwidefsky@de.ibm.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

statx is available on almost all other architectures but
got missed on sh, so add it now.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sh/kernel/syscalls/syscall.tbl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 21ec75288562..a70db013dbc7 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -390,3 +390,4 @@
 380	common	copy_file_range			sys_copy_file_range
 381	common	preadv2				sys_preadv2
 382	common	pwritev2			sys_pwritev2
+383	common	statx				sys_statx
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
