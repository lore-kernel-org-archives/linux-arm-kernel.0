Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7A3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:41:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87E78206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JJSBe/QS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E78206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x9q8qNvNlOYJphM+ooUAhxdi/lgyaWg4mmNaZXl2xLc=; b=JJSBe/QSzmXk+y
	c84BL1K100StGDIQHCYi4chmJpGj65VM7U+REwmLyPCHtro3zVCskFn8MWNxOoWh7YIBfG9TNK8dp
	tZndLeDHRqLodnxY0Izx0nsysajRPZUONQKNfEaVM9aZqlCFzLTmhtiQu6GSMmTlAT/QDhtTppz9D
	s9VtWtm1RAamk8N3+zuS6DNshKg+uPcWpcRst0G1E6HgPnpSGTpaYSpnBDNLKbSK/pFiv5MTgpcCD
	g6ohyM2gm97LR37BuwXXuR2kjtL2fiNZKPpGB8CJlhtM9KX/KbaKgqWRSN8wyxYJWN/fGX54EssLU
	9hCrsibKFCJgzsL6A9uQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghdOv-0006HP-E7; Thu, 10 Jan 2019 16:41:49 +0000
Received: from mout.kundenserver.de ([212.227.17.24])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghd9q-0004HW-IS
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 16:26:16 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MXGzQ-1gmTTU2Mc2-00YlJB; Thu, 10 Jan 2019 17:25:10 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 04/15] alpha: wire up io_pgetevents system call
Date: Thu, 10 Jan 2019 17:24:24 +0100
Message-Id: <20190110162435.309262-5-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190110162435.309262-1-arnd@arndb.de>
References: <20190110162435.309262-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:IuTdScJNFP/vlVpLiekPy1ow4ZHjUHd9bBQuCDC76YNBRibrohQ
 xe4PTU5B3/2nsf++H4PdApUdmfw+lrf+m4akyCZLHyYTCLErcx0kRCUeA5fx2pSYrXhfboI
 TGcpRPLubhe7ITv+g8HM3hG2m2F8x+f0mihrQflNCCgZKTCoOQI1SPWgWNjeYt2eQffohnL
 2+S4SOm3O/NYGRyHFCqnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xg+0ntML16s=:vQUEgMtLWbgXhUDfOD4tFX
 XVNGSeubXuS5k5TazDG/RTdD+JSIqKb/pqlh4L0fs8LKwLKGo9Mr7o0bUxYV4FvRtEPZM+GKv
 UfYdpiNhsKK7dBkmvzm5tkoM7X+/xOL79IaUdjoW/sM48o9/nL0wpTNmfPxRgKXqXbNQIiALo
 n+08m1jAdAD3r6B+DybJibdim3imldLCouU/K09vqwerADzQiMJc13fKPRn0V60r/kWpeotYH
 OtY4V38lQzwSmWjU9owIspp0el3VCTwvDZbYu7ojyyAcDHZAYvPrK8caRi3SOaHdwFqesPlpx
 GUzFCEvd4/c2t6OOcaCMSDOy3AMIWnnOK+CMb6653SXWw3bhDJjZFw3EJL/dSwwWluWv8ILx0
 0gajNPyzAPBbJyOhecVf2SSzqeyfzeow/YNVRERPCe+L3c43vvO5D3bIGZExSdI0iLqiyJpXL
 DSMRbux5mjH5JbIiMck0dOMMoRlUXHbvb9V4XPibE4zBWammySsIbDptCPBfr8Ne895uaLKJ5
 p+DL/Lg1ijinapAoxBaw8V2s1MIyXB/ov86x7SR2xFfoSb5fyn9VshvOo8iFhkyv+xIPzpyyY
 vQbuFM1W5zrSVFQlRiSF5Q4hwf/SFkFNVGvJC+s/JC5XiBAffWJcxH0VqilVba1u5pblYuaYz
 5eqR6z5hxwaLgpk95sWnUAn0rfYw3vIQCCkKfnvOdk2lPgt/6pLaX3KfQs02ySpY3vvpD5UNK
 Xq5j6U5WXDRMdBdxYGE53f4ixXF9gjVFB99CiA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_082614_904460_A88D3470 
X-CRM114-Status: UNSURE (   9.87  )
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
