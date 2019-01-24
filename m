Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B0BC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:32:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72D4121872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ei6NBdUU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eZIPSiqL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D4121872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=WHrdRHTk9TEpd5TvvhVVF5WQlQ6drYS8IWBiuZJJ6dM=; b=Ei6
	NBdUUhluCFX34ytmxeqZUxraNJEAc2imTRTe4ddAOwZJ6UsfZQgBHuRecQhjvVSOZxE57M976BcUn
	pgi21+sHhQsc17lWhdVnhng/McOSwoggyPncr1itwWHbk0UvvsklmGNh+qT4BOQAqYPWM8PrTb1mI
	P4fA3PZV/g4Vqu6ukr0m2htSLknD58iTgVoRKkM63oyEHFSrOJgCsvAhc2HCTtBfvdLL9WWiFYrW1
	rzFqDnUXKfxziAlbqORse5LTeOM392uenrvbXGmRXrh3pLsAjpye6achATG/JwPpBMypz+cKmaubF
	InAkfKiITvurfxDbWuoXMLJzm/JM0qw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmirm-0006ED-PY; Thu, 24 Jan 2019 17:32:38 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmirj-0006Ds-Jz
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 17:32:37 +0000
Received: by mail-lj1-x242.google.com with SMTP id v1-v6so6012018ljd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 09:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=KWJ7bHoK/sF4rrqF5MiZ+1DYYfCAJZqlGq6hSezEKP8=;
 b=eZIPSiqL34TBnH/ER0RA6ai9bEeY4M1ZpoObjCS9/M6AfopBGmh7yIayEA9iLDS9IJ
 gz0lnDpwKMSMa7WyBcOp0p3LoK/vPqOtk0dJ8gnq+ganaUw1Xzaljvb8cAScLLDi0Yy/
 850NdW40fcIYwxElFfZdR9FozwKjYocgDNFWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=KWJ7bHoK/sF4rrqF5MiZ+1DYYfCAJZqlGq6hSezEKP8=;
 b=NPqKpuA1uusV04as3zBGr2vpeVRLJE3+1LayzqOmLNN6NQHMfT/wkTw1B8rjQXNO2X
 XcJw+AHgWIE0XxLurnw0pIfElcy7gg1DHJ8qIpqYboTROYhLRK3g/veT8xI8v8RbpGqQ
 m56ls3GJFnxRxJbpkuehI4k8xXQZIUD667EKf+zGtFR6MmNknfc+DZ+hhBsnKPTUzq9R
 6tbRQgkMMk7dQbDUJB6043mzCrMx2wdYk22xlhnPOJl0Qn90BDXO94UpSQQbbpPkINiD
 FzBJq9D3VECcx3SQHLXhmN7vsIUpeIlO2s2axdXnRyB+LzjqYzECLk6Mw8HzzYS09pCo
 Pw+g==
X-Gm-Message-State: AJcUukcUS7tQuzCG0Q6vWJvjRnC4QhGH1cw7It+WeZTuivoqavsYggwd
 1FhEOwji3oTtBM/+4QICMz4sOg==
X-Google-Smtp-Source: ALg8bN78g8GAJjJPsLdp+v2YHWnYh/cST8kguvz/X6aUB/7KFq3QiTSmsFFYUYHrs8rIgWHd3+WDCw==
X-Received: by 2002:a2e:1bc5:: with SMTP id
 c66-v6mr6600436ljf.96.1548351153486; 
 Thu, 24 Jan 2019 09:32:33 -0800 (PST)
Received: from localhost ([195.238.92.223])
 by smtp.gmail.com with ESMTPSA id y81-v6sm1113700lje.30.2019.01.24.09.32.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 09:32:32 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@linaro.org>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 tee-dev@lists.linaro.org
Subject: [PATCH v2 1/1] tee: add cancellation support to client interface
Date: Thu, 24 Jan 2019 19:32:31 +0200
Message-Id: <1548351151-3722-1-git-send-email-igor.opaniuk@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_093235_673384_0A23B724 
X-CRM114-Status: GOOD (  12.33  )
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
Cc: sumit.garg@linaro.org, prime.zeng@hisilicon.com, jens.wiklander@linaro.org,
 jerome.forissier@linaro.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add support of cancellation request to the TEE kernel internal
client interface. Can be used by software TPM drivers, that leverage
TEE under the hood (for instance TPM2.0 mobile profile), for requesting
cancellation of time-consuming operations (RSA key-pair generation etc.).

Signed-off-by: Igor Opaniuk <igor.opaniuk@linaro.org>
---

v2:
- use tee_ioctl_cancel_arg to provide session and cancel_id
- fix tee_client_cancel_req function description header

 drivers/tee/tee_core.c  | 10 ++++++++++
 include/linux/tee_drv.h | 12 ++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 7b2bb4c..1148175 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -1027,6 +1027,16 @@ int tee_client_invoke_func(struct tee_context *ctx,
 }
 EXPORT_SYMBOL_GPL(tee_client_invoke_func);
 
+int tee_client_cancel_req(struct tee_context *ctx,
+			  struct tee_ioctl_cancel_arg *arg)
+{
+	if (!ctx->teedev->desc->ops->cancel_req)
+		return -EINVAL;
+	return ctx->teedev->desc->ops->cancel_req(ctx, arg->cancel_id,
+						  arg->session);
+}
+EXPORT_SYMBOL_GPL(tee_client_cancel_req);
+
 static int __init tee_init(void)
 {
 	int rc;
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 6cfe058..177016e 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -526,6 +526,18 @@ int tee_client_invoke_func(struct tee_context *ctx,
 			   struct tee_ioctl_invoke_arg *arg,
 			   struct tee_param *param);
 
+/**
+ * tee_client_cancel_req() - Request cancellation of the previous open-session
+ * or invoke-command operations in a Trusted Application
+ * @ctx:       TEE Context
+ * @arg:       Cancellation arguments, see description of
+ *             struct tee_ioctl_cancel_arg
+ *
+ * Returns < 0 on error else 0 if the cancellation was successfully requested.
+ */
+int tee_client_cancel_req(struct tee_context *ctx,
+			  struct tee_ioctl_cancel_arg *arg);
+
 static inline bool tee_param_is_memref(struct tee_param *param)
 {
 	switch (param->attr & TEE_IOCTL_PARAM_ATTR_TYPE_MASK) {
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
