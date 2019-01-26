Return-Path: <SRS0=wPy5=QC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3E0C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 14:30:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B744D218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 14:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qcSIakf8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B744D218B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yGxzvV44bumZtTCwTVtQ0YAhNHzKPZYntoKCypOXRKo=; b=qcSIakf8N5rW2N
	nX7lBcpYs8NBnlj0BoE8nOKlXx5FoJO6dX/drNZqIIet4AIVnAwR1T+V6du2V6ZKnOo6/3L3Um1Ae
	Lx6eexhhuuKjuahfqIr24lvijfaiNItOPKsn3FyuIXIcVNavRCEYg+Yh6NXNEAASQjRrbFBgPARTa
	3ZadpaI5A12K44fhlwvMSh3kO1T65a+uP4b289KalCvuRl0iWJI4CBJHlb4x3mog/YeLi67qXhCuF
	KZNq9GVZPTA6VygwhSOyIxYwqSn1kEkw5uFPkbL6Uvvkb2le2tHEoclSe+eBIfCg99p2HCjbjLmrk
	5DAthwPNro1kcoaDtSVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnOyP-0002hO-5S; Sat, 26 Jan 2019 14:30:17 +0000
Received: from mleia.com ([178.79.152.223] helo=mail.mleia.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnOxc-0001Ne-H6
 for linux-arm-kernel@lists.infradead.org; Sat, 26 Jan 2019 14:29:31 +0000
Received: from mail.mleia.com (localhost [127.0.0.1])
 by mail.mleia.com (Postfix) with ESMTP id BB68843B6A5;
 Sat, 26 Jan 2019 14:29:26 +0000 (GMT)
From: Vladimir Zapolskiy <vz@mleia.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 1/3] Input: lpc32xx-key - add clocks property and fix DT
 binding example
Date: Sat, 26 Jan 2019 16:29:19 +0200
Message-Id: <20190126142921.16041-2-vz@mleia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190126142921.16041-1-vz@mleia.com>
References: <20190126142921.16041-1-vz@mleia.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20190126_142926_785940_332631EC 
X-CRM114-Status: GOOD (  13.59  )
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190126_142926_785940_332631EC 
X-CRM114-Status: UNSURE (   9.20  )
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
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Sylvain Lemieux <slemieux.tyco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The keypad controller on NXP LPC32xx requires its clock gate to be open,
therefore add description of the requires 'clocks' property.

In addition adjust the example by adding description of required 'clocks'
property and by fixing 'interrupts' property.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 Documentation/devicetree/bindings/input/lpc32xx-key.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/lpc32xx-key.txt b/Documentation/devicetree/bindings/input/lpc32xx-key.txt
index bcf62f856358..2b075a080d30 100644
--- a/Documentation/devicetree/bindings/input/lpc32xx-key.txt
+++ b/Documentation/devicetree/bindings/input/lpc32xx-key.txt
@@ -8,6 +8,7 @@ Required Properties:
 - reg: Physical base address of the controller and length of memory mapped
   region.
 - interrupts: The interrupt number to the cpu.
+- clocks: phandle to clock controller plus clock-specifier pair
 - nxp,debounce-delay-ms: Debounce delay in ms
 - nxp,scan-delay-ms: Repeated scan period in ms
 - linux,keymap: the key-code to be reported when the key is pressed
@@ -22,7 +23,9 @@ Example:
 	key@40050000 {
 		compatible = "nxp,lpc3220-key";
 		reg = <0x40050000 0x1000>;
-		interrupts = <54 0>;
+		clocks = <&clk LPC32XX_CLK_KEY>;
+		interrupt-parent = <&sic1>;
+		interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;
 		keypad,num-rows = <1>;
 		keypad,num-columns = <1>;
 		nxp,debounce-delay-ms = <3>;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
