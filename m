Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFCEC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:08:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F8F020896
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WCSCk1/4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HeVMkhKs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="On6RXlUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F8F020896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=5k+Y+7tSSmq8giBlG+YPcZFHv7qLCqACWMkDYCsH/jw=; b=WCSCk1/4m7Pp+pmEmOdi9I1Fx0
	lLtmCjMaiwSSzNA1tbfL9Tr80bOY1n8T56cMNJ1tw9n/J++QT/7RWdyIdzMQcE3mSl6nE6yzx3A1V
	jSaTuqRp92BI3rQ9SYs/WXOLJ3U/iVSyyzjFXEu4VCXYALWrlW9gKA3cIcHpkfDr4ca8Lg/Fov4jH
	Ufue4/Ub07bahh2Ff77trdVwdagA91DMdTaMXR5r83Tuc3oWH9G8ApRXmc+33DLgRJqGICCGo8Gy3
	ceWUb6GWZAezNSAfEKN3Zge0NQA9s0aqnuBWTyjsiV++XmLMBIwGXJL/D41ZLk4AlYteSc6vLR/NL
	c5J8OTUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjXoY-0005E1-1v; Tue, 15 Jan 2019 23:08:10 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjXoS-00058R-0L
 for linux-arm-kernel@bombadil.infradead.org; Tue, 15 Jan 2019 23:08:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bBbcO/FLwThPnzi9ctGancax6oPRinsiTg0II3oScgw=; b=HeVMkhKsVK+F6wy+89mLaMF68
 ssi1VatoUTA9WAZ7FBXQUIe4UNRx+IW2qfZFrC5EgmczP8bM7Z7fHHa2gdhx9Yvmvsmdz8J12PCip
 yclP+9jE51WrQvRia2aXaoR8lifBlYSG9pZuJ2SPMvbEN0lJLFJPAFgG73jn7X+uqY/YKpEOQTvYu
 SMKZTnHS0zoiS8rzT4nP70JmwVJBKE4Omtkb3Z66pK4BOXWQPej1ZQ0UcoBF+j73LqGSCkhG7nwXF
 1W5XJUPQ9lcUYMAZ8NWjgQmoiowmA1VIs+O6Rj+fNnT2ROL4rcxgqIVG074/WqUuCqyMkqGhNWAqF
 sQlBlRLAw==;
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjXoN-0006JW-IR
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 23:08:01 +0000
Received: by mail-pl1-x643.google.com with SMTP id t13so1984085ply.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 15:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=bBbcO/FLwThPnzi9ctGancax6oPRinsiTg0II3oScgw=;
 b=On6RXlUUcE77eKNO+PGQZ6PETa/RedcAgn21UjeW5c60TBBoJQX7Io8Ezm7UFYxu39
 hsyo67UlNJInScryS+W+t/3wr6aRdEK6LtYCajq7Ys2wG1l0Ee6w8LfltwUDtQAvSmUN
 DZAa46lZP3mjb0uw0IWOZU6BuFaab+JcpIGTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=bBbcO/FLwThPnzi9ctGancax6oPRinsiTg0II3oScgw=;
 b=nZvZyXHv0ZDZ0AcwWdTy5nj6a4wwWVkGu6YIuFt9vJf6rT9qHL0WJn3QFCgUgtXxt+
 BK4F7wur3MHPhNNnEATlhXsT32uygcH4LG1fFZSAv5phGqTM/wOMMdLEwwbFWaEFxPlQ
 kqIEw74p4g2wFd92pVF0Lw0t5bz21deNjqWd4X29QRzoHSv1CzU4nUdIenH5DGwfVVZg
 DilxNTwlIfRO3oPC2y1g8xiQ9OleVLLwerhaJSl3e5LwT0uPM3PJ06UsHErEpW3jCTr1
 742mFkWRqCSZLPhsrFqaTkCqOVT359XtlcWAbOCrKYQVrJwooY24KD11EjbpB97jpDMI
 WfrQ==
X-Gm-Message-State: AJcUukfIPPkMyVoSsT8TPlHrVv7KjeKZidw8ZvQavr88MEnBA9eEhXKr
 nahwHVVKT0bGvvldABcD0fQajw==
X-Google-Smtp-Source: ALg8bN7+l3YPkRP9qcLyj4ZI/wD3XEov976kmI5a3XEqdMZ2PkcjH+3du2whuhuUJX/kFN6olhSwpw==
X-Received: by 2002:a17:902:5066:: with SMTP id
 f35mr6651355plh.78.1547593673313; 
 Tue, 15 Jan 2019 15:07:53 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id h19sm4985928pfn.114.2019.01.15.15.07.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 15 Jan 2019 15:07:52 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org,
	peterz@infradead.org,
	gregkh@linuxfoundation.org
Subject: [PATCH 4/7] perf pmu: Moving EVENT_SOURCE_DEVICE_PATH to PMU header
 file
Date: Tue, 15 Jan 2019 16:07:39 -0700
Message-Id: <20190115230742.13730-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190115230742.13730-1-mathieu.poirier@linaro.org>
References: <20190115230742.13730-1-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_180759_630429_F7479B03 
X-CRM114-Status: GOOD (  13.93  )
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
Cc: mark.rutland@arm.com, linux-s390@vger.kernel.org, suzuki.poulose@arm.com,
 alexander.shishkin@linux.intel.com, will.deacon@arm.com,
 heiko.carstens@de.ibm.com, adrian.hunter@intel.com, ast@kernel.org,
 mingo@redhat.com, linux-arm-kernel@lists.infradead.org, hpa@zytor.com,
 schwidefsky@de.ibm.com, namhyung@kernel.org, tglx@linutronix.de,
 jolsa@redhat.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: linaro <linaro@localhost.localdomain>

Moving definition of EVENT_SOURCE_DEVICE_PATH to pmu.h so that it can be
used by other files than pmu.c

Signed-off-by: linaro <linaro@localhost.localdomain>
---
 tools/perf/util/pmu.c | 2 --
 tools/perf/util/pmu.h | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 11a234740632..51d437f55d18 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -29,8 +29,6 @@ struct perf_pmu_format {
 	struct list_head list;
 };
 
-#define EVENT_SOURCE_DEVICE_PATH "/bus/event_source/devices/"
-
 int perf_pmu_parse(struct list_head *list, char *name);
 extern FILE *perf_pmu_in;
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 76fecec7b3f9..350c54e0bd3d 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -16,6 +16,7 @@ enum {
 };
 
 #define PERF_PMU_FORMAT_BITS 64
+#define EVENT_SOURCE_DEVICE_PATH "/bus/event_source/devices/"
 
 struct perf_event_attr;
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
