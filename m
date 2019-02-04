Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C21C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:11:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B39B2087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cNOYtz32"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B39B2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C8XZ+3YwKvBPSCEBMBAyC/oBYGPHJpuyBhS0eNos9l0=; b=cNOYtz32cyLvwd
	Dd6cKZVf6d0BX20FmQVL7dQekUXnC0CHgD0e1pSHqCR76jNuIppDiR5PQCsbikI00DDIzUS3fF3Ka
	9em37u2YJpxSM5EPOeIYFEIeKckvrbwnwtVZJvhD+duUZM9w+R2nnbA2SMs8Sbx0r0qfQix1+pdKn
	DrwGrnJktPPXAPi/FolfUJWi7zhk8T3Y9straH4leU4HSsYh+xnizLRSaT/otklo5CNGJ7M0NaXpW
	1FRvwF+K0uiWUd6KK2ZziqqKprjkgk3mC/5piLbMHptTxKSc3tCeoYVZxohkgIuQWoTcw8IkgK1ur
	c3I0L3K3qD4EdPKROsKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqhly-0005zD-QJ; Mon, 04 Feb 2019 17:11:06 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqhkk-0003SW-Oj
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 17:10:01 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B6AE1682;
 Mon,  4 Feb 2019 09:09:47 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
 [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8D7733F589;
 Mon,  4 Feb 2019 09:09:45 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will.deacon@arm.com,
	mark.rutland@arm.com
Subject: [PATCH 4/5] cpu/hotplug: Add locked variant of
 cpuhp_state_add_instance()
Date: Mon,  4 Feb 2019 17:09:07 +0000
Message-Id: <93599efb6ea546370dd470a31f8e8cf97764a31e.1549299188.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.20.1.dirty
In-Reply-To: <cover.1549299188.git.robin.murphy@arm.com>
References: <cover.1549299188.git.robin.murphy@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_090951_720742_C0D14078 
X-CRM114-Status: GOOD (  14.94  )
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
Cc: suzuki.poulose@arm.com, peterz@infradead.org, bigeasy@linutronix.de,
 linux-kernel@vger.kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

A helper already exists for nearly every combination of parameters,
except of course the one that I now need.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 include/linux/cpuhotplug.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index fd586d0301e7..1d6231fe1590 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -290,6 +290,12 @@ static inline int cpuhp_state_add_instance(enum cpuhp_state state,
 	return __cpuhp_state_add_instance(state, node, true);
 }
 
+static inline int cpuhp_state_add_instance_cpuslocked(enum cpuhp_state state,
+						      struct hlist_node *node)
+{
+	return __cpuhp_state_add_instance_cpuslocked(state, node, true);
+}
+
 /**
  * cpuhp_state_add_instance_nocalls - Add an instance for a state without
  *                                    invoking the startup callback.
-- 
2.20.1.dirty


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
