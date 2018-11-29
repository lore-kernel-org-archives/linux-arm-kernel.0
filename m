Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6867C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:28:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A37CC20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QDyDPYV/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mcLaErqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A37CC20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=uNbjiG8Nq/KfJ0wR46MP/kca9CqUdV9dB7PCc0Uw6CM=; b=QDy
	DPYV/f1FxG8P6st0AWGh1FfJaRXmutLsUDgJWwU2Brc3/wJaUOzR2xWoBqKeOJNXNtZEPO1fmQSnk
	bwNJP5pGx/nKS51Co4PyLVZpq00aZ05U+WJ/48NqgXE37CQrbWmeLYTAbQoO6IQbXnmYH45arhSAA
	smBVzhJ9deNF/4FVJXZujzaouhcN2kGsnuHA/DiwTDu6xuUC9JcJaYw4Dx/UidKAq77+eOdgnBC4i
	889fn11O+Za+BqSrz2WGc7F/knVGsDizui1NkIJaLyEzE13nimNw5bRty6MAmuBuxv2MmCPpUd8Jz
	owRGaqabOo0txWr8lpuYXRXudEEcd0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSVje-0004xo-FL; Thu, 29 Nov 2018 23:28:42 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSVja-0004vC-Te; Thu, 29 Nov 2018 23:28:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1543534309; x=1575070309;
 h=from:to:cc:subject:date:message-id;
 bh=L7Qnx+G1U15UoezilU3DKAcIr1VLVm+CQnW9+MoRsKs=;
 b=mcLaErqtxlJWhwu3x5oL2RCvdZ5N9QXWCJIWCZDjC4oFG9w5QLvs12E3
 Z4xN3TMC1//xY8UA0FeDxYTCUp/ax7+a/ltRvTfceFAW4ch20jDtMNfbr
 nT1ZvtcssuprLNtzSpRipmvCSrK+i4VmeROhub8l4k63OAxE1yqR6DCMV
 jXJFUGADYTUzQZgxZNUbh9dmt5nWZoSGfLAs8L2EGm0yXuEIVzUU/e4py
 H+fpYEvGPf3+BOhP8wEjOdwaZ+J7ydbHRpr9wdNi3IES/4HvJjmjp5ab/
 UbfwCxszDkKedGoa1sA+UX8Y2Wcdj9SxsLNRI6TbrTTZpxYm0rTMlYFtT w==;
X-IronPort-AV: E=Sophos;i="5.56,296,1539619200"; d="scan'208";a="193267101"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2018 07:31:30 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP; 29 Nov 2018 15:11:23 -0800
Received: from jedi-01.sdcorp.global.sandisk.com (HELO
 jedi-01.int.fusionio.com) ([10.11.143.218])
 by uls-op-cesaip02.wdc.com with ESMTP; 29 Nov 2018 15:28:26 -0800
From: Atish Patra <atish.patra@wdc.com>
To: linux-kernel@vger.kernel.org
Subject: [RFT PATCH v1 0/4] Unify CPU topology across ARM64 & RISC-V
Date: Thu, 29 Nov 2018 15:28:16 -0800
Message-Id: <1543534100-3654-1-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_152839_051865_4DAB6609 
X-CRM114-Status: GOOD (  14.27  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Palmer Dabbelt <palmer@sifive.com>,
 Will Deacon <will.deacon@arm.com>, Atish Patra <atish.patra@wdc.com>,
 linux-riscv@lists.infradead.org, Morten Rasmussen <morten.rasmussen@arm.com>,
 Juri Lelli <juri.lelli@arm.com>, Dmitriy Cherkasov <dmitriy@oss-tech.org>,
 Anup Patel <anup@brainfault.org>, Ingo Molnar <mingo@kernel.org>,
 devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
 Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 "moderated list:ARM64 PORT AARCH64 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jeremy Linton <jeremy.linton@arm.com>, Sudeep Holla <sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The cpu-map DT entry in ARM64 can describe the CPU topology in
much better way compared to other existing approaches. RISC-V can
easily adopt this binding to represent it's own CPU topology.
Thus, both cpu-map DT binding and topology parsing code can be
moved to a common location so that RISC-V or any other
architecture can leverage that.

The relevant discussion regarding unifying cpu topology can be
found in [1].

arch_topology seems to be a perfect place to move the common
code. I have not introduced any functional changes in the moved
code. The only downside in this approach is that the capacity
code will be executed for RISC-V as well. But, it will exit
immediately after not able to find the appropriate DT node. If
the overhead is considered too much, we can always compile out
capacity related functions under a different config for the
architectures that do not support them.

The patches have been tested for RISC-V and compile tested for
ARM64 & x86.

The socket change[2] is also now part of this series.

[1] https://lkml.org/lkml/2018/11/6/19
[2] https://lkml.org/lkml/2018/11/7/918

QEMU changes for RISC-V topology are available at

https://github.com/atishp04/riscv-qemu/tree/cpu_topo

Apologies for the previous patch series with incorrect title and
was sent only to kernel mailing list due to a bug in my config.
Please ignore that.

Atish Patra (3):
dt-binding: cpu-topology: Move cpu-map to a common binding.
cpu-topology: Move cpu topology code to common code.
RISC-V: Parse cpu topology during boot.

Sudeep Holla (1):
Documentation: DT: arm: add support for sockets defining package
boundaries

.../{arm/topology.txt => cpu/cpu-topology.txt}     | 133 +++++++--
arch/arm64/include/asm/topology.h                  |  22 --
arch/arm64/kernel/topology.c                       | 303 +--------------------
arch/riscv/Kconfig                                 |   1 +
arch/riscv/kernel/smpboot.c                        |   3 +
drivers/base/arch_topology.c                       | 294 ++++++++++++++++++++
include/linux/arch_topology.h                      |  26 ++
include/linux/topology.h                           |   1 +
8 files changed, 435 insertions(+), 348 deletions(-)
rename Documentation/devicetree/bindings/{arm/topology.txt => cpu/cpu-topology.txt} (66%)

--
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
