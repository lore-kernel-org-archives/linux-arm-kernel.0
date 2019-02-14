Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A941C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:08:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB181222B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zamjb7nr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=integrasources.com header.i=@integrasources.com header.b="cRXs5t1t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB181222B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=integrasources.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-ID:Date:MIME-Version:Subject:To:From:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S2Vuv3iCvcuM9ADwk6YuG0qf8pQFdk+r505mE6AArys=; b=Zamjb7nrAoIJPN
	/Bbd1qiiZtpWXhHhFHJsowjX/ldgh5aIIsjzYNnGNjP19e5sYFs1CP7/CfNJZ/TmFfI/OStW/xXZ9
	aRX/3hKHp03DlNCkdbgjnSF9/L/WeAgMQuIZY4D4eroGUsl+07qi/tq6E2ih1KkIf+GHh9Cv/daus
	tpgjyVzskvrVDE4Y/2K1rJudfUEJZ7W32SVItEfUDc/wY500zNucn1FoRhOTayr0D0cHYSJxkAoqM
	zlR3dF+89rD08AD9Z7dQC/TEk9N2YU69Zkr52GPJgRtYjaaV/yiC57jCT0edCI1JXcEa+guPoJeti
	R9Pu05q9PkALqdPkYbxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guEsF-0008Dc-Fu; Thu, 14 Feb 2019 11:08:11 +0000
Received: from f521.i.mail.ru ([94.100.184.5])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guEsB-0008Cn-Id
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 11:08:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=integrasources.com; s=mailru; 
 h=References:In-Reply-To:Content-Transfer-Encoding:Content-Type:Message-ID:Reply-To:Date:MIME-Version:Subject:Cc:To:From;
 bh=zEt7EE5xeiuzjaP8N/HhMq7vnmMJfEt2GZYfKYBzDTw=; 
 b=cRXs5t1tR3VRWSQmAqmgwt8X7o9096dOU63kj+fOvrWd+BypDQHwGKXO3OqZ/rb5qeq8IARaQQUKNjYFB500lWV24mEh0UQk4yc3Hi1rRS1cjX1geWDcDRhMyo2/+c40gzZF/AzwPrH7alc8T4drbUisDShDW1jCwTXYb7iuTTo=;
Received: by f521.i.mail.ru with local (envelope-from
 <k.sudakov@integrasources.com>)
 id 1guErp-00057L-F9; Thu, 14 Feb 2019 14:07:46 +0300
Received: by e.mail.ru with HTTP;
	Thu, 14 Feb 2019 14:07:45 +0300
From: =?UTF-8?B?S29uc3RhbnRpbiBTdWRha292?= <k.sudakov@integrasources.com>
To: =?UTF-8?B?UGF1bCBLb2NpYWxrb3dza2k=?= <paul.kocialkowski@bootlin.com>,
 =?UTF-8?B?TWF4aW1lIFJpcGFyZA==?= <maxime.ripard@bootlin.com>
Subject: =?UTF-8?B?UmVbMl06IFtQQVRDSCB2MyA4LzhdIGRybS9wYW5lbDogQWRkIFJvbmJvIFJC?=
 =?UTF-8?B?MDcwRDMwIHBhbmVs?=
MIME-Version: 1.0
X-Mailer: Mail.Ru Mailer 1.0
Date: Thu, 14 Feb 2019 14:07:45 +0300
X-Priority: 3 (Normal)
Message-ID: <1550142465.930628529@f521.i.mail.ru>
Authentication-Results: f521.i.mail.ru;
 auth=pass smtp.auth=k.sudakov@integrasources.com
 smtp.mailfrom=k.sudakov@integrasources.com
X-77F55803: 75EFC73397A5A9587F9F52485CB584D72AF743E69CD4874722C24EB7D14BC411CF01FF74127E779F82DA8959A8B4202AC5C7FD16981B76AE
X-7FA49CB5: 70AAF3C13DB70168C09775C1D3CA48CF3F395433950BAD63CEDC9CE4EAAF8441BD4B6F7A4D31EC0B5B47ED7565F4D52D9742502CCDD46D0D2A336C6518635091B2086D80B05047785571747095F342E8C7A0BC55FA0FE5FC90731C072697C03650FDC107160235D0A1984233DD075BF2389733CBF5DBD5E913377AFFFEAFD269A417C69337E82CC2CC7F00164DA146DAFE8445B8C89999725571747095F342E8C26CFBAC0749D213D2E47CDBA5A9658359CC434672EE6371117882F4460429728AD0CFFFB425014E40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE72BDBFF48EC83968139616F89400644F575ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF572FE522B81756EA3300306258E7E6ABB4E4A6367B16DE6309
X-DMARC-Policy: none
X-Mailru-Sender: AAD8E2226B689FDAB33CC05F77CBC91E7DEEC48BFF9043B5B526F127086B2CFEF31CCE872E832FCF5E25B62EB3B830D12C9F54B9DBDCEB51B4873B7769F3E5F805C459423DECFE6322DF1A08BD40178C9DFED97C59FA62B9BC879F90144AC781E4A3161861B40CE50DA7A0AF5A3A8387
X-Mras: OK
X-Spam: undefined
In-Reply-To: <25f4beadd3088b3fbb2751f120e4216969301136.camel@bootlin.com>
References: <cover.f28d9994585553a089a519392616b0d26ed54af1.1549896081.git-series.maxime.ripard@bootlin.com>
 <2663d767bffbc83f84f9086e614b0ec1dd343ced.1549896081.git-series.maxime.ripard@bootlin.com>
 <25f4beadd3088b3fbb2751f120e4216969301136.camel@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_030808_002160_7566864F 
X-CRM114-Status: UNSURE (   2.83  )
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
Reply-To: =?UTF-8?B?S29uc3RhbnRpbiBTdWRha292?= <k.sudakov@integrasources.com>
Cc: bbrezillon@kernel.org, =?UTF-8?B?U2FtIFJhdm5ib3Jn?= <sam@ravnborg.org>,
 =?UTF-8?B?TWFhcnRlbiBMYW5raG9yc3Q=?= <maarten.lankhorst@linux.intel.com>,
 dri-devel@lists.freedesktop.org, =?UTF-8?B?Q2hlbi1ZdSBUc2Fp?= <wens@csie.org>,
 =?UTF-8?B?U2VhbiBQYXVs?= <seanpaul@chromium.org>,
 =?UTF-8?B?VGhvbWFzIFBldGF6em9uaQ==?= <thomas.petazzoni@bootlin.com>,
 =?UTF-8?B?SmFnYW4gVGVraQ==?= <jagan@openedev.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Paul, Maxime. I suggest the patch to fix it.

diff --no-dereference -u -r -N linux-5.0-rc6_origin/Documentation/devicetree/bindings/display/panel/ronbo,rb070d30.txt linux-5.0-rc6/Documentation/devicetree/bindings/display/panel/ronbo,rb070d30.txt
--- linux-5.0-rc6_origin/Documentation/devicetree/bindings/display/panel/ronbo,rb070d30.txt	1970-01-01 07:00:00.000000000 +0700
+++ linux-5.0-rc6/Documentation/devicetree/bindings/display/panel/ronbo,rb070d30.txt	2019-02-14 18:00:06.613795857 +0700
@@ -0,0 +1,23 @@
+Ronbo RB070D30N01A MIPI-DSI panel
+
+Required properties:
+	- compatible: must be "ronbo,rb070d30"
+	- reg: DSI virtual channel used by that screen
+	- vcc-lcd-supply: phandle to the power regulator
+	- backlight: phandle to the backlight used
+	- reset-gpios: a GPIO phandle for the reset pin
+	- power-gpios: a GPIO phandle for the power pin
+	- updn-gpios: a GPIO phandle for the updn pin (vertical flip)
+	- shlr-gpios: a GPIO phandle for the shlr pin (horizontal flip)
+
+Example:
+panel@0 {
+	compatible = "ronbo,rb070d30";
+	reg = <0>;
+	vcc-lcd-supply = <&reg_display>;
+	backlight = <&backlight>;
+	reset-gpios = <&r_pio 0 1 GPIO_ACTIVE_HIGH>; /* PL01 */
+	power-gpios = <&r_pio 0 2 GPIO_ACTIVE_HIGH>; /* PL02 */
+	updn-gpios = <&r_pio 0 3 GPIO_ACTIVE_HIGH>; /* PL03 */
+	shlr-gpios = <&r_pio 0 4 GPIO_ACTIVE_LOW>; /* PL04 */
+};
diff --no-dereference -u -r -N linux-5.0-rc6_origin/Documentation/devicetree/bindings/vendor-prefixes.txt linux-5.0-rc6/Documentation/devicetree/bindings/vendor-prefixes.txt
--- linux-5.0-rc6_origin/Documentation/devicetree/bindings/vendor-prefixes.txt	2019-02-11 05:42:20.000000000 +0700
+++ linux-5.0-rc6/Documentation/devicetree/bindings/vendor-prefixes.txt	2019-02-14 17:39:46.667994322 +0700
@@ -334,6 +334,7 @@
 riscv	RISC-V Foundation
 rockchip	Fuzhou Rockchip Electronics Co., Ltd
 rohm	ROHM Semiconductor Co., Ltd
+ronbo	Ronbo Electronics Ltd.
 roofull	Shenzhen Roofull Technology Co, Ltd
 samsung	Samsung Semiconductor
 samtec	Samtec/Softing company
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
