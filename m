Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BD2C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:07:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B80BC218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mBVlFT8k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B80BC218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=6BZ/Xs4pGvE7WHc3/sFsY4eFsNFawuR0wacrydSPnIA=; b=mBV
	lFT8kDVIKkHd/uIyw0TziAtlUB2DmWJlnS7BEEZWyDQoDPwwMWrXiAgeoXtWeKPn/bPQGs13/cdCW
	dpxn4CDwy4nZr4QE3YuyaHXdJgBMo5/mmOTEEphf/AmZINS1gqw3NlXzDGb+FzbSwvZy9PerSRgbB
	W6s/dcpxm3pN+BhVb14kHQ9tSAXvDGEtRFli/LEKsYA0EHbSH17y21hjj9KjTqKuyLAnatTFrbSUe
	qxxM9xqJoVsr4ULIypR7bS+7hf9z5iFppmaBUrreYwKYyInets7K4OX18TORO2SX0tP9RxHkX7Z5t
	7u0AyvsXYrn/rkjnTcBkmzOBvyYs0Lg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn35H-0003u9-Gy; Fri, 25 Jan 2019 15:07:55 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn35D-0003tA-OM
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 15:07:53 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 738C9A78;
 Fri, 25 Jan 2019 07:07:50 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.44])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9D113F5C1;
 Fri, 25 Jan 2019 07:07:48 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>
Subject: [PATCH v2 0/2] KVM: arm/arm64: Add VCPU workarounds firmware register
Date: Fri, 25 Jan 2019 15:07:39 +0000
Message-Id: <20190125150741.184128-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_070751_792898_059E0155 
X-CRM114-Status: GOOD (  16.11  )
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
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Steven Price <steven.price@arm.com>, kvmarm@lists.cs.columbia.edu,
 Dave Martin <dave.martin@arm.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

this is a try to address Dave's comments concerning the readability of
the compatiblitiy check of the protection levels.
If picks up the idea of creating a linear scale, where smaller values
mean less protection. Originally the suggestion was to use a signed
encoding, with "unknown" being 0. While this sounds neat, it turns out
to be not very readable and hard to communicate in the ABI
documentation. I don't think it's feasible to establish a forward
looking standard for each and every upcoming firmware workaround
register, so I just moved everything up to avoid negative values.

Please let me know if this makes more sense or what else could be done.

Regarding the states in "workaround 1": At the moment the host kernel side
only reports the availability of the SMC call. "Not available" could
mean both "not needed" or "not implemented (aka. vulnerable)".
If the kernel would separate the last two states, we could propagate
this in the firmware register.
So would we need this in the host side to allow migration from
"workaround available" to "always mitigated, no w/a needed"?

Cheers,
Andre

-----------------------------
Workarounds for Spectre variant 2 or 4 vulnerabilities require some help
from the firmware, so KVM implements an interface to provide that for
guests. When such a guest is migrated, we want to make sure we don't
loose the protection the guest relies on.

This introduces two new firmware registers in KVM's GET/SET_ONE_REG
interface, so userland can save the level of protection implemented by
the hypervisor and used by the guest. Upon restoring these registers,
we make sure we don't downgrade and reject any values that would mean
weaker protection.
The protection level is encoding in the lower 4 bits, with smaller
values indicating weaker protection.

Patch 1 implements the two firmware registers, patch 2 adds the
documentation.

ARM(32) is a bit of a pain (again), as the firmware register interface
is shared, but 32-bit does not implement all the workarounds.
For now I stuffed two wrappers into kvm_emulate.h, which doesn't sound
like the best solution. Happy to hear about better solutions.

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

 Documentation/virtual/kvm/arm/psci.txt |  21 +++++
 arch/arm/include/asm/kvm_emulate.h     |  10 +++
 arch/arm/include/uapi/asm/kvm.h        |   9 ++
 arch/arm64/include/asm/kvm_emulate.h   |  14 +++
 arch/arm64/include/uapi/asm/kvm.h      |   9 ++
 virt/kvm/arm/psci.c                    | 118 +++++++++++++++++++++----
 6 files changed, 165 insertions(+), 16 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
