Return-Path: <SRS0=YQjL=OY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C0EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 03:02:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A495B20645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 03:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HBb/WBam";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hI246O9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A495B20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=rIrtucREKfSaVdxRf3mfSAE0nz8+i6HjgvFzyK22NqI=; b=HBb
	/WBamHgHDbHmDp3DkGNyllKdqFZ26Cfg21P9RSTMso0aZ3BRxKh2Z6nX5DZt5iksHjPA8jGcFBCEh
	NPeaQrbVFD5OCQKQxiDRhiUOhyupi9XxcAdWOJq0aCB2G5NbPshsDA2n5Sx+HwVl10lnvjvlTmdHm
	9vY24ALseSlO5PR/auI1o7L63Zxi0qf0i3L0Rc0YtaB3KfYs3Kqdn/q01hY+JqFpLJCcLH/r0hHJT
	9o91ZzYMyMhHBW36k3EPmSrmH/ml7WEaOc2G7pf8Uzs3dCd8tayEzNiCUQmqAjwlNo0UwZRN5m2+2
	p+RT04x/cZ9c97bi3V8FbpoEUhOWvow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gY0Dn-0001zA-Rm; Sat, 15 Dec 2018 03:02:31 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gY0Dk-0001xU-Mh
 for linux-arm-kernel@lists.infradead.org; Sat, 15 Dec 2018 03:02:30 +0000
Received: by mail-pg1-x544.google.com with SMTP id z11so3535604pgu.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 19:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=ircXPkLKlb7ZlNEJJFaa+uDJP6y5IrcHuMjbfpKiMOA=;
 b=hI246O9+rjglH+Fpwi7teN9sIiZjU7bBHZjPD0MJfbc/wztB8yiiViidzL7qK9Ruc/
 rM4u6wZmwVZ1iTckFuYIau29gF1l9SIC8U0HOMU+JGFaiktpq8/OGlxfaOBBWlUblU0W
 ulKzQqAvAQpfZ2rdpE0BrJq6iU4kZDj8d1R8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=ircXPkLKlb7ZlNEJJFaa+uDJP6y5IrcHuMjbfpKiMOA=;
 b=IlMs1rFnvLqQO6KWC5jFEjriL00yaV+TvygeVpG8MHqwTQGkr3Jky0iQmEit4CiZmH
 9N1JXEPDZWFfpg8lHdbB9ifZk2JIYq6Y7EhcQ3sIyHLRHF/6knlcWi2A4CtdouIFwBg/
 9gT24ZyV0emF+pGJJgR0ZKghc6gDMjGCOj9tyghScah8Go/szhoo2WrQD8KbVCH4K+Ut
 sbBZPLUCzIne9d076BPEkbuEVuyr5Wg/ojy49y1DERGTdWeOavDjO+xoPEx+q4APU4AK
 imTGPEmHnuPAMKJOdXMSihM6Mshp1XjOtPFmyhf/UxxWkMDMkBIKTD5SdOz5mAC8HCN0
 IF2Q==
X-Gm-Message-State: AA+aEWbjt/ZwiF3+3Vvb/8gyG1PdEPzrHJtlGgCmBk0fxLcvKD6367Uf
 yL5akh9WrTE+ZNV8Pzp+DvVpbv2mGg==
X-Google-Smtp-Source: AFSGD/WTLEHHv8GWZsDQuLb/c22diVLXIs4DHvBqscDpWO5WejTmyN6nTgQvMOE9gEPuCDKSfGaZyg==
X-Received: by 2002:a62:64d7:: with SMTP id y206mr5204641pfb.84.1544842937540; 
 Fri, 14 Dec 2018 19:02:17 -0800 (PST)
Received: from localhost.localdomain
 ([2409:4072:6301:5419:f1e8:77a0:59f7:2cb5])
 by smtp.gmail.com with ESMTPSA id h15sm7309534pgl.43.2018.12.14.19.02.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Dec 2018 19:02:16 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: dinguyen@kernel.org,
	robh+dt@kernel.org
Subject: [PATCH 0/2] Add board support for Chameleon96 Board
Date: Sat, 15 Dec 2018 08:31:50 +0530
Message-Id: <20181215030152.4386-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_190228_743403_5E326D21 
X-CRM114-Status: GOOD (  12.09  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, nazik@novtech.com, yossi@novtech.com,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

This patchset adds board support for Chameleon96 board from Novetech
based on Intel Cyclone V SoC FPGA. This board is one of the Consumer
Edition boards of the 96Boards family and has the following key features:
    
* SoC - Intel Cyclone V SoC FPGA
* GPU - Graphics based on Intel Video Suite for FPGA
* RAM - 512MB DDR3L
* USB - 2x USB2.0 Host, 1x USB2.0 OTG
* Wireless - Wifi, BT
    
More information about this board can be found in 96Boards product
page: https://www.96boards.org/product/chameleon96/

This patchset has been tested on Chameleon96 board and the board boots
into a distro on SD card with USB ports working.

Thanks,
Mani

Manivannan Sadhasivam (2):
  dt-bindings: vendor-prefixes: Add Novtech Vendor Prefix
  ARM: dts: Add support for 96Boards Chameleon96 board

 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/socfpga_cyclone5_chameleon96.dts | 130 ++++++++++++++++++
 3 files changed, 132 insertions(+)
 create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_chameleon96.dts

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
