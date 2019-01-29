Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B499AC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:52:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76D1320844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uBsA6ikV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76D1320844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WnzzIh2knJC8f3i4w+BDufJqPw41eEDMlLt/qILxmTM=; b=uBsA6ikVGLBD4d
	NkMMCEvc2RUfIcc0RgEMy0T9j8UXdHu5PPanudbRpo/48Q82CfAgOhr8NYsiSEF89UAO4hGSP0McN
	ElsXYnmi1sxckVBXojva/yL9d4pOR7vSrOrsEgbckFboOyW0xPpVv/SemBrkYnhSLZctxLvmXmTa5
	SyiM99KyIsARY6bR9RhfiB7Cc+Xu2dVb8vn200pOdN+Gfdggltt10vSZpcS76nnXUf01SH1uzopQ4
	N2pJIPAu1GVsKTM5Ylu6Op0Ba/OURJZbmB4nNv6MwY8EwGyj14v69R/5k+TgBbMhFXXnEQMOq36ld
	cBasdfTOIharqkqq6f6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goYUm-0000Za-OG; Tue, 29 Jan 2019 18:52:28 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goYSN-0005ig-CX
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 18:50:00 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E30E1596;
 Tue, 29 Jan 2019 10:49:59 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 711903F557;
 Tue, 29 Jan 2019 10:49:56 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-acpi@vger.kernel.org
Subject: [PATCH v8 07/26] ACPI / APEI: Remove spurious GHES_TO_CLEAR check
Date: Tue, 29 Jan 2019 18:48:43 +0000
Message-Id: <20190129184902.102850-8-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129184902.102850-1-james.morse@arm.com>
References: <20190129184902.102850-1-james.morse@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_104959_426266_5F460A2B 
X-CRM114-Status: UNSURE (   9.18  )
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
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Tony Luck <tony.luck@intel.com>,
 Xie XiuQi <xiexiuqi@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>, linux-mm@kvack.org,
 Borislav Petkov <bp@alien8.de>, james.morse@arm.com,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

ghes_notify_nmi() checks ghes->flags for GHES_TO_CLEAR before going
on to __process_error(). This is pointless as ghes_read_estatus()
will always set this flag if it returns success, which was checked
earlier in the loop. Remove it.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 drivers/acpi/apei/ghes.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index a34f79153b1a..c20e1d0947b1 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -940,9 +940,6 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 			__ghes_panic(ghes, buf_paddr);
 		}
 
-		if (!(ghes->flags & GHES_TO_CLEAR))
-			continue;
-
 		__process_error(ghes);
 		ghes_clear_estatus(ghes, buf_paddr);
 	}
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
