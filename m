Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D75EC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:50:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE2AA21872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RuO53YnK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gQAHsQPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2AA21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=NtEov7DvJEwKFdqCnSc3fO1y0G9kKZjGNSnsIX5xm1s=; b=RuO53YnKihXAm0utVSkW8I7BQs
	OrTCAPzttV6jn6zNSFpbaB2fJXMS4D7T+RdsQdo4qCVxkE9Ze7bY8loe3TnmxuWMwfXjd0C4/v2C8
	PgIwCZa/uBNOBOLefxNFYOCMi1p/SSa2mkLs9KJ7eCHrEQe8Yc307uvo5153VlknbVWC+4W8otSys
	qQw5SiS7yzcaTo7sIoTvwjZxPspi6TeHsnrUD9CFqnPxSjE+SOFp3xlgxW2RiGPvVpUqpIh81HQ6/
	Tc4ZV8MgN85omlReSSWb1S9+vYMuH3Q7kq6dhpqzHbfwbf25JFMKkhcE2zcZEzWMRFIH7Pm+O/OlU
	F6dTmSDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmxBW-00021X-Nn; Fri, 25 Jan 2019 08:49:58 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmxAy-0001ZI-Bw
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 08:49:26 +0000
Received: by mail-wm1-x344.google.com with SMTP id m22so5825750wml.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 00:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=JD/Pi2kZaELwRAgMBI67I7DkYZJn4nUbk7rRyg7KRPY=;
 b=gQAHsQPA3EQJ2spnhqB9b8/zrowsf9lfNBgtq/u8ZeciSgbkRRQTHvelGFhlCRv6kx
 xrxhyZYpPFLg6smeWj5jZA6YbRD0JKKCgcvGUYKDJYJrYBGrMzz8xRdjBxjpF/nDsIvz
 dXEmvug4EVKT1LRK4rQu1yB0hhtpkjKNpcr70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=JD/Pi2kZaELwRAgMBI67I7DkYZJn4nUbk7rRyg7KRPY=;
 b=A898PVMQqBm/I4prY1uBWw+nqBNt/oicoqRVGNDszSLR+2ygivAHqAJ17ItuNa8GjI
 lTr9gD0P+PZ1/Q1q5M3liLmVS29XswcZ5ITpdteC9hRT7FOEWNbq7c1J7JfGk01LU6IO
 NMa1GVSOoHrg+GIn9MngY9EKmtyATk7Lk84xNvp+nSMTWRlS0iuRCc3Q1S9Eg7ZC1IV7
 wvfKI9fZqVBj+cYHG976m9gIrsIzwkZc19D6aWcBtJjwf6HsTqcOYfFIgV5lwjYDBENZ
 R4hlWLd9MP2Q1Tw6IfGnrnh/kPd4mDJGMfwncx1qpHaA/LBbtsF1oQ41qG+DcAmL2gNr
 FFcQ==
X-Gm-Message-State: AJcUukcjgfYSe7FuEHeWnwolvczHsGBS2Jm3zwvypdONMlSFLXch2sTe
 fsB3TSrrjDKVSymAcvt6HCvSUQ==
X-Google-Smtp-Source: ALg8bN6iAjm1C9zmxKZ86cj+QOgziSPaRndh33v5n+5iMuIGdgsU3aZpSl21ynW47+ql7XRiPnd9Cg==
X-Received: by 2002:a7b:cd85:: with SMTP id y5mr5710268wmj.129.1548406162511; 
 Fri, 25 Jan 2019 00:49:22 -0800 (PST)
Received: from dogfood.home ([2a01:cb1d:112:6f00:bcd4:806e:230a:673e])
 by smtp.gmail.com with ESMTPSA id 125sm112594574wmm.26.2019.01.25.00.49.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Jan 2019 00:49:21 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-crypto@vger.kernel.org
Subject: [PATCH v2 2/4] crypto: arm64/crct10dif - revert to C code for short
 inputs
Date: Fri, 25 Jan 2019 09:49:13 +0100
Message-Id: <20190125084915.25411-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190125084915.25411-1-ard.biesheuvel@linaro.org>
References: <20190125084915.25411-1-ard.biesheuvel@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_004924_409373_76870D2D 
X-CRM114-Status: GOOD (  17.01  )
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
Cc: ebiggers@kernel.org, stable@vger.kernel.org, herbert@gondor.apana.org.au,
 linux-arm-kernel@lists.infradead.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The SIMD routine ported from x86 used to have a special code path
for inputs < 16 bytes, which got lost somewhere along the way.
Instead, the current glue code aligns the input pointer to 16 bytes,
which is not really necessary on this architecture (although it
could be beneficial to performance to expose aligned data to the
the NEON routine), but this could result in inputs of less than
16 bytes to be passed in. This not only fails the new extended
tests that Eric has implemented, it also results in the code
reading past the end of the input, which could potentially result
in crashes when dealing with less than 16 bytes of input at the
end of a page which is followed by an unmapped page.

So update the glue code to only invoke the NEON routine if the
input is more than 16 bytes.

Reported-by: Eric Biggers <ebiggers@kernel.org>
Fixes: 6ef5737f3931 ("crypto: arm64/crct10dif - port x86 SSE implementation to arm64")
Cc: <stable@vger.kernel.org> # v4.10+
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/crypto/crct10dif-ce-glue.c | 25 +++++---------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/crypto/crct10dif-ce-glue.c b/arch/arm64/crypto/crct10dif-ce-glue.c
index b461d62023f2..567c24f3d224 100644
--- a/arch/arm64/crypto/crct10dif-ce-glue.c
+++ b/arch/arm64/crypto/crct10dif-ce-glue.c
@@ -39,26 +39,13 @@ static int crct10dif_update(struct shash_desc *desc, const u8 *data,
 			    unsigned int length)
 {
 	u16 *crc = shash_desc_ctx(desc);
-	unsigned int l;
 
-	if (unlikely((u64)data % CRC_T10DIF_PMULL_CHUNK_SIZE)) {
-		l = min_t(u32, length, CRC_T10DIF_PMULL_CHUNK_SIZE -
-			  ((u64)data % CRC_T10DIF_PMULL_CHUNK_SIZE));
-
-		*crc = crc_t10dif_generic(*crc, data, l);
-
-		length -= l;
-		data += l;
-	}
-
-	if (length > 0) {
-		if (may_use_simd()) {
-			kernel_neon_begin();
-			*crc = crc_t10dif_pmull(*crc, data, length);
-			kernel_neon_end();
-		} else {
-			*crc = crc_t10dif_generic(*crc, data, length);
-		}
+	if (length >= CRC_T10DIF_PMULL_CHUNK_SIZE && may_use_simd()) {
+		kernel_neon_begin();
+		*crc = crc_t10dif_pmull(*crc, data, length);
+		kernel_neon_end();
+	} else {
+		*crc = crc_t10dif_generic(*crc, data, length);
 	}
 
 	return 0;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
