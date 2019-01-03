Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9576DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 00:50:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65BF220815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 00:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lKJhDPZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65BF220815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=c4ESytJHGwV72Z7XNAru2EZyByt2Vbzy5xPNVkfDrEU=; b=lKJhDPZQM1FX7ZQl4EaRR+sRkx
	qHj+WO0EamShEQGBpGaZvh1CuQbid/tA5oO/4dE08Rf98oaKSiAGPD+be//ZCNDEvYCAPFWgF/PrI
	roTao1ta8pUda9Ea7jHqQbHPSEhSXMzcvSFhruL/PNWhTRwcERCmLkgRcAnwyXgMgIDlUVJvxGZgl
	TB7kQa0yUuC7Ynch6Elil/4HVq623/mfnxublfnGvdZsy865XpbgDOxG6dGVDdQIti8AP211QrlB/
	kC/9OH/GJRQaHOIs2hF0Csq6vXXT6pDiQyyyUOfzbf1/kw6eDkH9qFJvfTHOBsBnVv1atEnn48byb
	KWejZjSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gerCt-0001AH-W9; Thu, 03 Jan 2019 00:49:56 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gerCV-0000jH-RS
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 00:49:38 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E2C580D;
 Wed,  2 Jan 2019 16:49:31 -0800 (PST)
Received: from beelzebub.austin.arm.com (beelzebub.austin.arm.com
 [10.118.12.119])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 090573F5AF;
 Wed,  2 Jan 2019 16:49:29 -0800 (PST)
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/7] sysfs/cpu: Add "Unknown" vulnerability state
Date: Wed,  2 Jan 2019 18:49:15 -0600
Message-Id: <20190103004921.1928921-2-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190103004921.1928921-1-jeremy.linton@arm.com>
References: <20190103004921.1928921-1-jeremy.linton@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_164932_384437_B478BA07 
X-CRM114-Status: GOOD (  11.70  )
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
Cc: mark.rutland@arm.com, mlangsdo@redhat.com,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, suzuki.poulose@arm.com,
 marc.zyngier@arm.com, catalin.marinas@arm.com,
 Dave Hansen <dave.hansen@intel.com>, julien.thierry@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org,
 Jeremy Linton <jeremy.linton@arm.com>, steven.price@arm.com,
 Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
 David Woodhouse <dwmw@amazon.co.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ykaukab@suse.de,
 Thomas Gleixner <tglx@linutronix.de>, dave.martin@arm.com,
 shankerd@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

There is a lot of variation in the Arm ecosystem. Because of this,
there exist possible cases where the kernel cannot authoritatively
determine if a machine is vulnerable.

Rather than guess the vulnerability status in cases where
the mitigation is disabled or the firmware isn't responding
correctly, we need to display an "Unknown" state.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 9605dbd4b5b5..876103fddfa4 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -495,6 +495,7 @@ Description:	Information about CPU vulnerabilities
 		"Not affected"	  CPU is not affected by the vulnerability
 		"Vulnerable"	  CPU is affected and no mitigation in effect
 		"Mitigation: $M"  CPU is affected and mitigation $M is in effect
+		"Unknown"    	  The kernel is unable to make a determination
 
 		Details about the l1tf file can be found in
 		Documentation/admin-guide/l1tf.rst
-- 
2.17.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
