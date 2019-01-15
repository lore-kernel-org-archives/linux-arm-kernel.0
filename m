Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E535C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:04:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 310E720657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nZtTB3m4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 310E720657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ODeqZJ1u1HRUqzoJtJOlz/mDunBYUKct8Xql9Q95sRA=; b=nZtTB3m4xuLGn1rde1o/y1MaT8
	vQVZAq8XoYQfMbbVIlVe8SGT9TVuti4MG0NJYJC7Aqo39CpmAaIp8egh0wlUNoKC963eTMsB4I+6T
	htF9ykuHL9GdHCVg/A4xq5Sjtb6/9nYQZ6dpMqmfND3vmyXVaWavazswjQT9PJ0GNrws7iuej9Qus
	es+NQYo+P42eP3W+GBuclpl/2R/L7j4NJtVTXAdiK8EvfccZpxKFQrROWk6y2pr8w2MSnVtqxbFHE
	uzj1Kaf7857c4lK+fC2qcy96HxGzqkIdGaVXOhvRZZAaKsPDNY7VeVnMzXPFrUpockQNM5RDMS9QR
	QOf++6aA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjPJr-00048B-8w; Tue, 15 Jan 2019 14:03:55 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjPEl-0005m2-Ko
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 13:59:18 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79C7FEBD;
 Tue, 15 Jan 2019 05:58:39 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ADFFB3F70D;
 Tue, 15 Jan 2019 05:58:37 -0800 (PST)
From: Julien Thierry <julien.thierry@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/4] arm64: uaccess: Cleanup get/put_user()
Date: Tue, 15 Jan 2019 13:58:26 +0000
Message-Id: <1547560709-56207-2-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
References: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_055839_735689_7BBC878D 
X-CRM114-Status: GOOD (  11.94  )
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
Cc: Julien Thierry <julien.thierry@arm.com>, peterz@infradead.org,
 catalin.marinas@arm.com, will.deacon@arm.com, mingo@redhat.com,
 james.morse@arm.com, hpa@zytor.com, valentin.schneider@arm.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

__get/put_user_check() macro is made to return a value but this is never
used. Get rid of them and just use directly __get/put_user_error() as
a statement, reducing macro indirection.

Also, take this opportunity to rename __get/put_user_err() as it gets
a bit confusing having them along __get/put_user_error().

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>

---
 arch/arm64/include/asm/uaccess.h | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 547d7a0..8e40808 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -268,7 +268,7 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
 	: "+r" (err), "=&r" (x)						\
 	: "r" (addr), "i" (-EFAULT))

-#define __get_user_err(x, ptr, err)					\
+#define __raw_get_user(x, ptr, err)					\
 do {									\
 	unsigned long __gu_val;						\
 	__chk_user_ptr(ptr);						\
@@ -297,28 +297,22 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
 	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
 } while (0)

-#define __get_user_check(x, ptr, err)					\
-({									\
+#define __get_user_error(x, ptr, err)					\
+do {									\
 	__typeof__(*(ptr)) __user *__p = (ptr);				\
 	might_fault();							\
 	if (access_ok(__p, sizeof(*__p))) {				\
 		__p = uaccess_mask_ptr(__p);				\
-		__get_user_err((x), __p, (err));			\
+		__raw_get_user((x), __p, (err));			\
 	} else {							\
 		(x) = 0; (err) = -EFAULT;				\
 	}								\
-})
-
-#define __get_user_error(x, ptr, err)					\
-({									\
-	__get_user_check((x), (ptr), (err));				\
-	(void)0;							\
-})
+} while (0)

 #define __get_user(x, ptr)						\
 ({									\
 	int __gu_err = 0;						\
-	__get_user_check((x), (ptr), __gu_err);				\
+	__get_user_error((x), (ptr), __gu_err);				\
 	__gu_err;							\
 })

@@ -338,7 +332,7 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
 	: "+r" (err)							\
 	: "r" (x), "r" (addr), "i" (-EFAULT))

-#define __put_user_err(x, ptr, err)					\
+#define __raw_put_user(x, ptr, err)					\
 do {									\
 	__typeof__(*(ptr)) __pu_val = (x);				\
 	__chk_user_ptr(ptr);						\
@@ -366,28 +360,22 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
 	uaccess_disable_not_uao();					\
 } while (0)

-#define __put_user_check(x, ptr, err)					\
-({									\
+#define __put_user_error(x, ptr, err)					\
+do {									\
 	__typeof__(*(ptr)) __user *__p = (ptr);				\
 	might_fault();							\
 	if (access_ok(__p, sizeof(*__p))) {				\
 		__p = uaccess_mask_ptr(__p);				\
-		__put_user_err((x), __p, (err));			\
+		__raw_put_user((x), __p, (err));			\
 	} else	{							\
 		(err) = -EFAULT;					\
 	}								\
-})
-
-#define __put_user_error(x, ptr, err)					\
-({									\
-	__put_user_check((x), (ptr), (err));				\
-	(void)0;							\
-})
+} while (0)

 #define __put_user(x, ptr)						\
 ({									\
 	int __pu_err = 0;						\
-	__put_user_check((x), (ptr), __pu_err);				\
+	__put_user_error((x), (ptr), __pu_err);				\
 	__pu_err;							\
 })

--
1.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
