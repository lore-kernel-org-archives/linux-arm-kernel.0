Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9078FC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:26:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F83D206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QFEvSc/I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F83D206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H0P026UrbaeYdcGjPqIli172IIYeZ3t74/o6HFjdNLQ=; b=QFEvSc/IMbSr5r
	WdhjimojHOHNjthYbHbF8YqGcK2gaZdSmcNpZWjJbxufQt8r+GeqWTWal6KSRZhMXJanwgtyxmNeq
	JR4nuec4D6Eu2Dk/ftuWZIr9I1sJM7SxEDBHJueN9ThxMXnjzToh/YuAD76ZOHfVRUdYZ4wehmkxG
	YKDFppyM1ve1JW+1PSnL14MiAbScazugDEn+EDiu9FiCkrObWW4fa0SSjXdEL0tC7hmRGuSL/b9sQ
	iRtE9oydOviwBWSQwhm3CQE3bdL9yh+Ru/33u5FWteaxTiDOC7njxQtnwi4XMW057PVK13kWX5Qx0
	kaaLlgRcmFBp74lFTH4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghdAQ-0004qO-0E; Thu, 10 Jan 2019 16:26:50 +0000
Received: from mout.kundenserver.de ([217.72.192.73])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghd9p-0004HR-IH
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 16:26:16 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N6KQZ-1hNB0I3voH-016iww; Thu, 10 Jan 2019 17:25:20 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 11/15] mips: fix n32 compat_ipc_parse_version
Date: Thu, 10 Jan 2019 17:24:31 +0100
Message-Id: <20190110162435.309262-12-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190110162435.309262-1-arnd@arndb.de>
References: <20190110162435.309262-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:NTeLC7MR2Bco8KMPQbeHemq+c8XkDiSkrQwrov4uU0Z2HIvLK3h
 B70xuWmOCA+GgP9GbJW06L0FSoky+iyRXiPQtor05zQnX3nSWgbCFexomF8JWeeFg3drH3y
 rXvQCh8Qq2yvqHXdwWp+IqlKijE958CWOwGDX5zrvh45L7DSmguLRjdatci2FIWThGOBeMO
 7Grv+aoRjg5U7DHRIfGJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G9+dY9LvBJI=:bKGBCt806147bZ4SdhcCjz
 CjfhFmq62oMPvk12bhL/NPBuD+5FlocKRN+VDrlu+h+1YO7B5XMKs1rQ3bMyWXFjXtyrfVUmf
 ROFcBae7Gm7dn55/DbQjGxJB0kf9LN8M3r7dfpsX/llHt7fhXBWYwXxcBTsUfD0welfTav328
 EDIRylUi4qTuCL5Iz1Nfi2GSWB4mXFvcQ3V2YCErrq9qaRl3dP0Xj/QHcw2UC5UHXD2RrZNun
 ajqDXU4WSW9wdw5rWh9WyppYeb+r8+uvy8qnSE4JZkaLcvMsJ4wyypUhZvpUSQX4QefATbLZd
 z51aUK8wUHE+2Egci+WDHRnqzes2wM5K6O/LXALHZJITLXvaigwteu6ieZqq10+GZdb3+ct8z
 czBjsXuimew+gJhrQLYucnaH0q1xO8HZpwXJus5JJIY7c7UipaP7g+Y4XOcfDevXN1QRC/PqW
 UDf3gCSIyz5BygoBlLNZlYIfD243aj1b2j7/b3cne1RchQTejvJtnWreir8CZpzVDssrP5t7p
 2lbK8eWngwNVdCPotXiIUPbEC2XxM3avQAZj82p/+02ovqTGk11Z3iwL6txAojsEk31Q21+Ll
 4yTnEhil5jv8i1KAoINI+qkfWyZbpyy5Xl8BgJBk/x1Zu7W4l6OI8S2bLKyO/j7NTkKOylmda
 UcIZbdDo1TJkxvo4XDfB2o6PCbxZ2+UvgAyNn37onfsy4lX/gDc7LwuqgrnG7rp7o4p0dybPS
 aALSWonHNDRdQhORpQPMx1dXI5BMScV7uDxMFw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_082613_963035_9D2E71FE 
X-CRM114-Status: GOOD (  12.02  )
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
 catalin.marinas@arm.com, will.deacon@arm.com, linux@dominikbrodowski.net,
 jcmvbkbc@gmail.com, deepa.kernel@gmail.com, hpa@zytor.com,
 sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, dave@stgolabs.net,
 mpe@ellerman.id.au, deller@gmx.de, x86@kernel.org, linux@armlinux.org.uk,
 mingo@redhat.com, geert@linux-m68k.org, firoz.khan@linaro.org,
 mattst88@gmail.com, fenghua.yu@intel.com, Arnd Bergmann <arnd@arndb.de>,
 heiko.carstens@de.ibm.com, linux-m68k@lists.linux-m68k.org,
 ink@jurassic.park.msu.ru, luto@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, monstr@monstr.eu, tony.luck@intel.com,
 linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org,
 stable@vger.kernel.org, paul.burton@mips.com, ebiederm@xmission.com,
 linux-alpha@vger.kernel.org, schwidefsky@de.ibm.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

While reading through the sysvipc implementation, I noticed that the n32
semctl/shmctl/msgctl system calls behave differently based on whether
o32 support is enabled or not: Without o32, the IPC_64 flag passed by
user space is rejected but calls without that flag get IPC_64 behavior.

As far as I can tell, this was inadvertently changed by a cleanup patch
but never noticed by anyone, possibly nobody has tried using sysvipc
on n32 after linux-3.19.

Change it back to the old behavior now.

Fixes: 78aaf956ba3a ("MIPS: Compat: Fix build error if CONFIG_MIPS32_COMPAT but no compat ABI.")
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
As stated above, this was only found by inspection, the patch is not
tested. Please review accordingly.
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 787290781b8c..0d14f51d0002 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -3155,6 +3155,7 @@ config MIPS32_O32
 config MIPS32_N32
 	bool "Kernel support for n32 binaries"
 	depends on 64BIT
+	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
 	select COMPAT
 	select MIPS32_COMPAT
 	select SYSVIPC_COMPAT if SYSVIPC
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
