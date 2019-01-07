Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B4BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:06:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A32520665
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k9dnlTEg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A32520665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=bPlgNFDu0XtBKyDuKDozhuGqiQnun6nGQz9V8voXV5I=; b=k9d
	nlTEgX0QbrfSm1pgztLmRtF+mAxoP5dwcBU8VQtRVQ0j3Vvnma5Q+8uWLJRtTGPg/zl6nr4xwmFjk
	HDUCtzfGaMNYISrjd9oT7qQIYZ0YaCJfYNnyl83Y0xwC1UsxMjl2jdqeFyS3UduJTOQtWs5ETEIWV
	lyjZOfJNpZ9FbD/EkY7lZzykU3I6yu7QPO5zA8w0Rhrm8L2vvm8djuqtmPlal7FBIfiw7srwvBEAC
	JUhpyaJKoOQSAQjaAJH6/BgkT0oZLvfpMHzflI3uuVh6kNfmmlLT5YJ1XWXRd3yqDNCVdQHu7foji
	OH294t+baIJ0Vl4Pc/EyYZ+hmUouPHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggTfT-0000py-Sc; Mon, 07 Jan 2019 12:06:07 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggTfL-0000do-TU
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 12:06:02 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2474C1596;
 Mon,  7 Jan 2019 04:05:56 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.44])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFD463F5A0;
 Mon,  7 Jan 2019 04:05:54 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>
Subject: [PATCH 0/2] KVM: arm/arm64: Add VCPU workarounds firmware register
Date: Mon,  7 Jan 2019 12:05:35 +0000
Message-Id: <20190107120537.184252-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_040600_085392_A8086BBE 
X-CRM114-Status: GOOD (  12.01  )
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
Cc: linux-arm-kernel@lists.infradead.org,
 Peter Maydell <peter.maydell@linaro.org>, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Workarounds for Spectre variant 2 or 4 vulnerabilities require some help
from the firmware, so KVM implements an interface to provide that for
guests. When such a guest is migrated, we want to make sure we don't
loose the protection the guest relies on.

This introduces two new firmware registers in KVM's GET/SET_ONE_REG
interface, so userland can save the level of protection implemented by
the hypervisor and used by the guest. Upon restoring these registers,
we make sure we don't downgrade and reject any values that would mean
weaker protection.
There is some table in the code to describe the valid combinations.

Patch 1 implements the two firmware registers, patch 2 adds the
documentation.

This solution is using two hardcoded firmware registers for that. Not
sure if we should introduce something based on SMCCC instead, which
would allow us to report implementation of any SMCCC based service in a
generic way, or if this would be too generic.

ARM(32) is a bit of a pain (again), as the firmware register interface
is shared, but 32-bit does not implement all the workarounds.
For now I stuffed two wrappers into kvm_emulate.h, which doesn't sound
like the best solution. Happy to hear about better ideas.

This has been tested with a hack to allow faking the protection level
via a debugfs knob, then saving/restoring via some userland tool calling
the GET_ONE_REG/SET_ONE_REG ioctls.

Please have a look and comment!

Cheers,
Andre

Andre Przywara (2):
  KVM: arm/arm64: Add save/restore support for firmware workaround state
  KVM: doc: add API documentation on the KVM_REG_ARM_WORKAROUNDS
    register

 Documentation/virtual/kvm/arm/psci.txt |  20 ++++
 arch/arm/include/asm/kvm_emulate.h     |  10 ++
 arch/arm/include/uapi/asm/kvm.h        |   9 ++
 arch/arm64/include/asm/kvm_emulate.h   |  14 +++
 arch/arm64/include/uapi/asm/kvm.h      |   9 ++
 virt/kvm/arm/psci.c                    | 138 ++++++++++++++++++++++++-
 6 files changed, 198 insertions(+), 2 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
