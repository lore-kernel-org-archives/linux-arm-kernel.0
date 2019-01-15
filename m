Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7ABC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:09:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8CC720866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OrhwNRar";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V8yB2XGa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8CC720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=OGLrgj4Vi5oPFiOwqoQ9gIOxECwfMnaOrHynoe0elEY=; b=Orh
	wNRariLxSK0rcf288+71sBxcBHXml3TDVUSe7R9xPqZGmAbsf66Syn/OEXwT2zDMF33e+kZoz6Sd4
	x1cSFh1Z+4lJvrsWQvmg9XprEOrYDpdRnhrmU4g7Y1EjCSh8BvrqhbPAIv9Kz79ypW0aJY4CaFdGN
	q1SDdY/sIvjwkJbbta+Q0v+SEnJ3IcXfg8c7RgsI7Qb6K1lT1BWbQCfE87/L8A+LHYpNpnho5MhjV
	IH/u+qxcW+n+W08Y7TMz6p+SVR572bOKRw92ZSDaPR65fVnrU0qz6Z2eP9CNAUmCKYnYUIdZOkX4X
	pqyc/uM4fv40ztvwKXde6q3JSrPokAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjXpT-00061S-5q; Tue, 15 Jan 2019 23:09:07 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjXoB-0004sd-CH
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 23:08:11 +0000
Received: by mail-pf1-x442.google.com with SMTP id b85so2036926pfc.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 15:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=KGp8W3Zi1Td46Yk/Amf0n/ihhixIOFYJ4kdCIRrt+Pk=;
 b=V8yB2XGajuaKlqeqY4NqXp2OImEJbkruXqxI3dlvsBkK4tACG1CKqC6/YOtkaMwkg7
 z2+wfOlCxIePRJl5LUumBvlULAgCajajHtPbuqDZsbiUPUKWqoCFZU7pxMhyHzIxJ1E3
 S7Nvq8sQy9iMW5Xjjyt24+QulBf4mmGaPZHp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=KGp8W3Zi1Td46Yk/Amf0n/ihhixIOFYJ4kdCIRrt+Pk=;
 b=gOL7ymIDLU0JdFJVTQm4xgG/6/+gb6YjC8Bcc/e6w4NXjbIAEONDuCR8g451rzq7yx
 n61dJ42NxQX05+eSjBdIsBDwmvO9jb1fIBQ3IUf9Bk76Hj+9+T+K6ndYhK74yAbwdaEA
 50gjV7SpEPpLbyAI8LaXD4lpX04M52pMfTLpp7OQ1eRnHKPjflfym5qnDX7saboBY9lk
 wdHqFrEuHmVbP/AfpzK2zZRbwbyo64HSbY729XwgSB/b3SIEvqFsV48885bHl9ofOpKb
 rdS9jfOD0Mmuxjw//9wSd14Jg1gC3BQKxqcWlAgmdJBM1pZnwjmLqyh/WjdUv9quDCWr
 SMUw==
X-Gm-Message-State: AJcUukfVRqMvgKKiOLIQH6ecNcKR3z6z7ore+l3pkFoIRnB0VBeFP3Of
 orAn+ZSByC3fK3nr1wW5tHcfpg==
X-Google-Smtp-Source: ALg8bN48pOIf9+7lGLTLTPTCCIpyMaEocODeQrdksMnYnOGP+K00uzuNmu8PLm9HEttSbuTciXO3+Q==
X-Received: by 2002:a62:2e46:: with SMTP id u67mr6404064pfu.3.1547593665952;
 Tue, 15 Jan 2019 15:07:45 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id h19sm4985928pfn.114.2019.01.15.15.07.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 15 Jan 2019 15:07:44 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org,
	peterz@infradead.org,
	gregkh@linuxfoundation.org
Subject: [PATCH 0/7] perf: Communicate sink via event::attr:config2 
Date: Tue, 15 Jan 2019 16:07:35 -0700
Message-Id: <20190115230742.13730-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_150748_020470_4E898B99 
X-CRM114-Status: GOOD (  14.74  )
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

From: "Mathieu Poirier]" <mathieu.poirier@linaro.org>

This set is a refurbished version of this one [1].  I dropped the version
count and changed the name because a new approach is taken.

The end result is the same though, that is to allow multiple sources to
select the same sink for a session which is a prerequisite for the CoreSight
support of CPU-wide trace scenarios.

Here the sink ID is communicated to the kernel by way of the event's
configuration attribure (event::attr::config2).  The ID itself is an
hash of the sink's name, something that is readily available and doesn't
require the addition of a new information field in the coresight_device
structure.

With this new strategy the mechanic used to communicate sink selection to the
kernel via sysfs is no longer needed and removed from the code base.

Everthing has been applied and tested on 5.0-rc2.

Regards,
Mathieu

PS: Greg, I'm drawing your attention to patch 02 where I seem to be the first
to use function sysfs_add_file_to_group() in this way.

[1]. https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1818488.html

Mathieu Poirier (6):
  perf/aux: Make perf_event accessible to setup_aux()
  coresight: perf: Add "sinks" group to PMU directory
  coresight: Use event attributes for sink selection
  perf tools: Use event attributes to send sink information to kernel
  perf tools: Removing CoreSight set_drv_config() API
  perf tools: Remove PMU::set_drv_config API

linaro (1):
  perf pmu: Moving EVENT_SOURCE_DEVICE_PATH to PMU header file

 arch/s390/kernel/perf_cpum_sf.c               |  6 +-
 arch/x86/events/intel/bts.c                   |  4 +-
 arch/x86/events/intel/pt.c                    |  5 +-
 .../hwtracing/coresight/coresight-etm-perf.c  | 65 ++++++++++---
 .../hwtracing/coresight/coresight-etm-perf.h  |  1 +
 drivers/hwtracing/coresight/coresight-priv.h  |  1 +
 drivers/hwtracing/coresight/coresight.c       | 56 +++++++++++
 drivers/perf/arm_spe_pmu.c                    |  6 +-
 include/linux/perf_event.h                    |  2 +-
 kernel/events/ring_buffer.c                   |  2 +-
 tools/perf/arch/arm/util/cs-etm.c             | 94 ++++++++-----------
 tools/perf/arch/arm/util/cs-etm.h             |  3 -
 tools/perf/arch/arm/util/pmu.c                |  2 -
 tools/perf/builtin-record.c                   | 10 --
 tools/perf/builtin-stat.c                     |  9 --
 tools/perf/builtin-top.c                      | 13 ---
 tools/perf/util/Build                         |  1 -
 tools/perf/util/drv_configs.c                 | 78 ---------------
 tools/perf/util/drv_configs.h                 | 26 -----
 tools/perf/util/pmu.c                         |  2 -
 tools/perf/util/pmu.h                         |  2 +-
 21 files changed, 163 insertions(+), 225 deletions(-)
 delete mode 100644 tools/perf/util/drv_configs.c
 delete mode 100644 tools/perf/util/drv_configs.h

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
