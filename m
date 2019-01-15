Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92452C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:34:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C8A2085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pxT5R/ug";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="efeDpCR3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C8A2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=xlkPBE5HrsexPh+/MQFx6yfG/U7pJHtbGPrR5jo+sRI=; b=pxT
	5R/ugmVBPCVzRTPXBvnikLSe0utxAnhiThxS84UPkhQ9tay0jFm/TuuyRMEQoxc/PndOuZCX+Rmxk
	DmPBTpXAxAhXUTGzHBlVLajoZGXSrPX6T3lqwIpP0KXiQc8QbTTLt+4tVfcTBWAQfBVxajqmRi9Cn
	U1AJmnQBGSA/A6p0BWf6dA0N3x43CE7Yn8c7LxTGbfkKKmKA7zYzTsFMOBvS5lnmexHRFfimnOkQQ
	hHlmhUQKSXOgvHrULSLoN7a0VJoUlm2GMvIdmd3Vmblr+VnsI4+nvNGDw9VKQ0m1GNVhTLXSAc7N6
	PhaY4hHkZ1LhZo+z1KBL1yuW6VW4zKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjFUJ-0000SP-7k; Tue, 15 Jan 2019 03:34:03 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjFUE-0000RY-RE
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 03:34:00 +0000
Received: by mail-pg1-x544.google.com with SMTP id y4so583611pgc.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 19:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=4X8kcU6d3NqyUxrmUJdEBWCif0hJtOT6s4rVRjXlFOA=;
 b=efeDpCR3Ngei9k8D7/TQEoASBe4kOWQrKK7luOm0fDonWQE/ylPUXoXe4u2i50bmOj
 WPQWHpk0zz4TSCYPXwN+iaRZ+g8t/9ykoGOkkti4sMJq6lOL3TTmJyh5/WtIhY4juh0K
 T373uvqT8SbRKTgkyja8WsY0Qxr3CtJyJx4OU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=4X8kcU6d3NqyUxrmUJdEBWCif0hJtOT6s4rVRjXlFOA=;
 b=KfcYd3jUNWOiOKavS8UZjfq7v/emJY0lEEi3GVasgXC3k5yC9FcIA2+xeMXG+M3tuJ
 Wy2k0CQieaMmdHbuSK3dePF4v4YhiTaB5chbt0Ra0dYSLFY/5nXWqJBkinm/mzgomIUf
 CtDTFTi1on56QXKTJHOnhfHeOrpWBFAvQOKvu5432LCPlFPQrEuGOCRp96CPzunGoHVI
 4mkEPnx+6ZSG9yHS0xt+q3yx35MkEDEapXpsLbNlxfhWUxbOZs7SQCdIeV+HTabOnojF
 Lqrr6HvedXgpLjV3UwGVvs+QMg54Dfy4/DqFOJnQJD96nHWgsNtvcq3GAW7Fw+TuaBCn
 jMEg==
X-Gm-Message-State: AJcUukdk4QR/WSqN/8hFuh7vabidW4GSJPoo1VB743TMazWbsXOFlu5m
 h6Sh4Y47UNExVpjX8K0L2zQE
X-Google-Smtp-Source: ALg8bN6jazPCc7Jqm3wzmoCByTWc9OgBNXgSdiB8IUD7rmYY0k5rlUV7vjIvzzoP6/VoC3gm/He5Bw==
X-Received: by 2002:a63:557:: with SMTP id 84mr1755834pgf.411.1547523237621;
 Mon, 14 Jan 2019 19:33:57 -0800 (PST)
Received: from localhost.localdomain
 ([2409:4072:6084:4813:7cd6:42d1:f14c:3e90])
 by smtp.gmail.com with ESMTPSA id s9sm2137023pgl.88.2019.01.14.19.33.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Jan 2019 19:33:56 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: sboyd@kernel.org, mturquette@baylibre.com, afaerber@suse.de,
 robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-actions@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 0/6] Add clock support for Actions Semi S500 SoC
Date: Tue, 15 Jan 2019 09:03:34 +0530
Message-Id: <20190115033340.25016-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_193358_905288_E02E350F 
X-CRM114-Status: GOOD (  12.79  )
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
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

This patchset adds common clock support for Actions Semi S500 SoC of
the Owl family SoCs. This series is based on the initial work done
by Edgar Bernardi Righi. https://patchwork.kernel.org/cover/10587527/

Since there isn't any update from him for long time, I took the liberty
to modify his patches, address review comments and send to list for review.

This series has been tested on Allo Sparky SBC.

Thanks,
Mani

Changes in v2:

* Incorporated review comments from Stephen for driver cleanup.

Edgar Bernardi Righi (1):
  dt-bindings: clock: Add DT bindings for Actions Semi S500 CMU

Manivannan Sadhasivam (5):
  clk: actions: Add configurable PLL delay
  ARM: dts: Add CMU support for Actions Semi Owl S500 SoC
  ARM: dts: Remove fake UART clock for S500 based SBCs
  clk: actions: Add clock driver for S500 SoC
  MAINTAINERS: Add linux-actions mailing list for Actions Semi

 .../bindings/clock/actions,owl-cmu.txt        |   7 +-
 MAINTAINERS                                   |   1 +
 arch/arm/boot/dts/owl-s500-cubieboard6.dts    |   7 -
 .../arm/boot/dts/owl-s500-guitar-bb-rev-b.dts |   7 -
 arch/arm/boot/dts/owl-s500-sparky.dts         |   7 -
 arch/arm/boot/dts/owl-s500.dtsi               |  22 +
 drivers/clk/actions/Kconfig                   |   5 +
 drivers/clk/actions/Makefile                  |   1 +
 drivers/clk/actions/owl-pll.c                 |   2 +-
 drivers/clk/actions/owl-pll.h                 |  30 +-
 drivers/clk/actions/owl-s500.c                | 525 ++++++++++++++++++
 include/dt-bindings/clock/actions,s500-cmu.h  |  78 +++
 12 files changed, 661 insertions(+), 31 deletions(-)
 create mode 100644 drivers/clk/actions/owl-s500.c
 create mode 100644 include/dt-bindings/clock/actions,s500-cmu.h

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
