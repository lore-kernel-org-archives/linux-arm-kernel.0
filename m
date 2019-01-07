Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50891C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:27:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 211D02089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bf2Do/NC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 211D02089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=ezi/3FmWAUWA89FGjlRjruhubFUJosow/cdZgY377qQ=; b=bf2
	Do/NCnmWtzEbfUJ6wYUehyiydFkE8UiFGU6Vab8JWM303WdZu8hJZRx4171CoTwA3qmUifv0WChaL
	bSQfvH9yuG7Ig/hpyREqqcBArDNX/kk75yz8ZO+qtZN19hKzeI9tXCcYcS51CicIT3VemngCTiChb
	X3+GAkDBG/gBg0L0t9zpAKD+1SdZKf07eae4YJbJEktTRDaCqOSjPFqq/0cPHCMoILHKEUwhLIDtN
	4HqipwpBfX5lMfn8hoeIdRlaGTlYjbxEy4TLIfiifkHrWYZNxhs3PY9bi4KqZ8kV/TlcqSFID+eG3
	i/heVWogdCXBOHksSrNh0na83bTufzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggXkf-00035B-KU; Mon, 07 Jan 2019 16:27:45 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggXkc-00034m-23
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 16:27:43 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C2011596;
 Mon,  7 Jan 2019 08:27:41 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A74723F5A0;
 Mon,  7 Jan 2019 08:27:36 -0800 (PST)
From: Andrew Murray <andrew.murray@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, Will Deacon <will.deacon@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Russell King <linux@armlinux.org.uk>,
 suzuki.poulose@arm.com, robin.murphy@arm.com,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v4 00/13] perf/core: Generalise event exclusion checking
Date: Mon,  7 Jan 2019 16:27:17 +0000
Message-Id: <1546878450-20341-1-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_082742_114248_0A70CB25 
X-CRM114-Status: GOOD (  16.23  )
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
Cc: x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Many PMU drivers do not have the capability to exclude counting events
that occur in specific contexts such as idle, kernel, guest, etc. These
drivers indicate this by returning an error in their event_init upon
testing the events attribute flags.

However this approach requires that each time a new event modifier is
added to perf, all the perf drivers need to be modified to indicate that
they don't support the attribute. This results in additional boiler-plate
code common to many drivers that needs to be maintained. Furthermore the
drivers are not consistent with regards to the error value they return
when reporting unsupported attributes.

This patchset allow PMU drivers to advertise their inability to exclude
based on context via a new capability: PERF_PMU_CAP_NO_EXCLUDE. This
allows the perf core to reject requests for exclusion events where there
is no support in the PMU.

This is a functional change, in particular:

 - Some drivers will now additionally (but correctly) report unsupported
   exclusion flags. It's typical for existing userspace tools such as
   perf to handle such errors by retrying the system call without the
   unsupported flags.

 - Drivers that do not support any exclusion that previously reported
   -EPERM or -EOPNOTSUPP will now report -EINVAL - this is consistent
   with the majority and results in userspace perf retrying without
   exclusion.

All drivers touched by this patchset have been compile tested.

Changes from v3:

 - Added PERF_PMU_CAP_NO_EXCLUDE to Cavium TX2 PMU driver

Changes from v2:

 - Invert logic from CAP_EXCLUDE to CAP_NO_EXCLUDE

Changes from v1:

 - Changed approach from explicitly rejecting events in unsupporting PMU
   drivers to explicitly advertising a capability in PMU drivers that
   do support exclusion events

 - Added additional information to tools/perf/design.txt

 - Rename event_has_exclude_flags to event_has_any_exclude_flag and
   update commit log to reflect it's a function

Andrew Murray (13):
  perf/doc: update design.txt for exclude_{host|guest} flags
  perf/core: add function to test for event exclusion flags
  perf/core: add PERF_PMU_CAP_NO_EXCLUDE for exclusion incapable PMUs
  alpha: perf/core: use PERF_PMU_CAP_NO_EXCLUDE
  arm: perf: conditionally use PERF_PMU_CAP_NO_EXCLUDE
  arm: perf/core: use PERF_PMU_CAP_NO_EXCLUDE for exclude incapable PMUs
  drivers/perf: perf/core: use PERF_PMU_CAP_NO_EXCLUDE for exclude
    incapable PMUs
  drivers/perf: perf/core: use PERF_PMU_CAP_NO_EXCLUDE for exclude
    incapable PMUs
  powerpc: perf/core: use PERF_PMU_CAP_NO_EXCLUDE for exclude incapable
    PMUs
  x86: perf/core: use PERF_PMU_CAP_NO_EXCLUDE for exclude incapable PMUs
  x86: perf/core: use PERF_PMU_CAP_NO_EXCLUDE for exclude incapable PMUs
  perf/core: remove unused perf_flags
  drivers/perf: use PERF_PMU_CAP_NO_EXCLUDE for Cavium TX2 PMU

 arch/alpha/kernel/perf_event.c                |  7 +------
 arch/arm/mach-imx/mmdc.c                      |  9 ++-------
 arch/arm/mm/cache-l2x0-pmu.c                  |  9 +--------
 arch/powerpc/perf/hv-24x7.c                   | 10 +---------
 arch/powerpc/perf/hv-gpci.c                   | 10 +---------
 arch/powerpc/perf/imc-pmu.c                   | 19 +------------------
 arch/x86/events/amd/ibs.c                     | 13 +------------
 arch/x86/events/amd/iommu.c                   |  6 +-----
 arch/x86/events/amd/power.c                   | 10 ++--------
 arch/x86/events/amd/uncore.c                  |  7 ++-----
 arch/x86/events/intel/cstate.c                | 12 +++---------
 arch/x86/events/intel/rapl.c                  |  9 ++-------
 arch/x86/events/intel/uncore.c                |  9 +--------
 arch/x86/events/intel/uncore_snb.c            |  9 ++-------
 arch/x86/events/msr.c                         | 10 ++--------
 drivers/perf/arm-cci.c                        | 10 +---------
 drivers/perf/arm-ccn.c                        |  6 ++----
 drivers/perf/arm_dsu_pmu.c                    |  9 ++-------
 drivers/perf/arm_pmu.c                        | 15 +++++----------
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c |  1 +
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  |  1 +
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c  |  1 +
 drivers/perf/hisilicon/hisi_uncore_pmu.c      |  9 ---------
 drivers/perf/qcom_l2_pmu.c                    |  9 +--------
 drivers/perf/qcom_l3_pmu.c                    |  8 +-------
 drivers/perf/thunderx2_pmu.c                  | 10 +---------
 drivers/perf/xgene_pmu.c                      |  6 +-----
 include/linux/perf_event.h                    | 10 ++++++++++
 include/uapi/linux/perf_event.h               |  2 --
 kernel/events/core.c                          |  9 +++++++++
 tools/include/uapi/linux/perf_event.h         |  2 --
 tools/perf/design.txt                         |  4 ++++
 32 files changed, 63 insertions(+), 198 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
