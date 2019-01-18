Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A1BC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:21:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7783820850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YaJ8xhB1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7783820850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x9q8qNvNlOYJphM+ooUAhxdi/lgyaWg4mmNaZXl2xLc=; b=YaJ8xhB1DExzd/
	cc4yCXYjNsCfcngNmfM+9DUMOZZPGty4FrmLZeSD/FJJuwNQVlaFl0U9yaYVs9nfV0svlNyG84gJn
	Ec7U1GiXlpSCfYzaR4+8WsWDOhA+y5MIV/WLwKLQ3/OEGQzaB8Cgnxk/JduaQlD/lXWA+KrBBaXrU
	xycOgmEKhe6ZiDGSTMcVnq5jeQWa1GCvEk1Cr8GRW3ntNEJrB01r6J1DcwV7VoEBnLvTHavCXeh0Z
	h4U7/N+ZjRlto19TL+5Z3n+BYThrPck0To9r3Gv80w02KJICHrgECo9Bs2WYuXj51cnZ7EE/hXFTs
	IOm3B9RTWMjctO9w1Q8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkWtU-0002Ce-Ap; Fri, 18 Jan 2019 16:21:20 +0000
Received: from mout.kundenserver.de ([217.72.192.74])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWsc-0001N3-BV
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:20:28 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N5VPg-1hHoRO3rPm-016smX; Fri, 18 Jan 2019 17:19:21 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 04/29] alpha: wire up io_pgetevents system call
Date: Fri, 18 Jan 2019 17:18:10 +0100
Message-Id: <20190118161835.2259170-5-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:kflSL09LUig5PrGqhrkajxoK0SeWp2U4JIIMcfjCGVSWg5iIrgA
 J5hv9soxVYSFR49SvlQMaZXIAO1p6EUEeltN0pngVIpqcfTLf3sWXn2IBnJQaQLzGZJ3q+Q
 ACD8kJOssOub6MuDS3QPNehTEgd/CCZtDjgODFWU+Gy7sWZ+HJNEkrOPxOfu05RgPwNPDqD
 aoZ6iSR7CX2gKXzv0VMBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CeyxGSCiaRY=:qpuIHbxy3A65/sCKEAE7D3
 ddepm1c6+m4oaC3wmX+/hUYOk+vtmAFnZ6Kd4BzrkF9gMlYL4J6KSefBBWheOLiMOzxEfHcGr
 Rus23XiyxSkQFRafe/srQUUgUIDlP2ZeFaHMw40pc/zl4LWUSZrX2WoDQcgTfj6VtksN/V4Yj
 SJJpsRVSLQp8ey6pe8MYBxW1o3Ega++JZLlMnSDaQHDqYNK+im42pC2RWqjA/sdEhFR8js0a8
 Vd58EZ6ZXTX+niqnqnR0rRlayZMDJUP5TooxbiFskhhE97TltTJcOw4T8sSlsDWdU3pFOEFN2
 TVqzgi0d1Gq4y6eVCU1KwNyzY4q1xFzBNST+Lqc9CfbVdyr3JIMdTGDT2XhxcuVmpGFnBHyNp
 J24nQxFlSbrn3htY51QpZcB2Sg1XdIvAydyRtpeUZQUT+B+/smpxh3V/MNhPfmM+psB3wPlnc
 Rx1IoK/nFb3JbVFKWwxmu5Aal8w06mXFYc5ajI0zj4RLvkX1HLiOifKHsEaAD9iyZ1B/0bHrm
 7A0FbmbqpqfeHa8xppNwFJDhdgMDuaeo44n4OO6mSjxmpMQiJoCgqb9jOSaoIf47Jj8mtlWyL
 lqn2pZFDHLWvq7L10oDp3J1e6pKAQMpvs/913pfWja4VPOxHweNPo6KrPUJLgT3algq6owiZx
 zd+TvvExdx1OitYhrhMXYY+ayhXjg6hRKsMKsa1pHOMeIRxDBz3Bucx6iiIZwIBncfLKSdpzN
 WcHZC4slp6nRdjtDeg1mVNWkkyuERWfVPiWJag==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_082026_688838_E7128E86 
X-CRM114-Status: UNSURE (   9.16  )
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
 netdev@vger.kernel.org, linux-mips@vger.kernel.org, stable@vger.kernel.org,
 paul.burton@mips.com, ebiederm@xmission.com, linux-alpha@vger.kernel.org,
 schwidefsky@de.ibm.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The io_pgetevents system call was added in linux-4.18 but has
no entry for alpha:

warning: #warning syscall io_pgetevents not implemented [-Wcpp]

Assign a the next system call number here.

Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/kernel/syscalls/syscall.tbl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 7b56a53be5e3..e09558edae73 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -451,3 +451,4 @@
 520	common	preadv2				sys_preadv2
 521	common	pwritev2			sys_pwritev2
 522	common	statx				sys_statx
+523	common	io_pgetevents			sys_io_pgetevents
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
