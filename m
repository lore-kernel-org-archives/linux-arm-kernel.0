Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16413C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:03:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C478620868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fz/CyImQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aqrkyehf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C478620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=wPhSn45PcYMHFmir26zk/sf8iayUAQdzDTIvbqaN39c=; b=Fz/CyImQpA9PUrn4jAJx+sFTms
	9x3Ppd0Q2ZrjCxVSBHlNPHucz7FOLelyne4L/mShw7DXRsfkMHQ3QjbkDlprzrEnUE3XIZRsEHigA
	5F8manA+TrE+hixXHAFvoEt/sbSlfNMyryFsKrBh2eWMU/vjjTr3DYYpeWVo9GpXd+tMdSAxAsAzN
	uS4fHGIVFR5nPEhYcb/sqEex3wElQrRckG0OSrg8J4OnU4jWXjM13L2DQ+qzXhNG2se+lYAQx/d1I
	fhTIT8K6TVzOWxbRijcgZ1FwVHeF1Qfjx/l0euMu6bB4ztVB5JKmJAGsSMoNXA8KWtcvSOCGKWdFb
	Up8FyizA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gShVa-00054G-Ue; Fri, 30 Nov 2018 12:02:58 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gShVM-0004rb-Qg
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 12:02:46 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20181130120230euoutp025177c590ccea2dbc272ca881cad4323b~r5T2pdqXR1090810908euoutp02c
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 12:02:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20181130120230euoutp025177c590ccea2dbc272ca881cad4323b~r5T2pdqXR1090810908euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1543579350;
 bh=lBf6JAoFHbx6NthwBSg2D1kScF7EVOwlotNynBKwKIw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aqrkyehfkbIjlfNYrRCELmGMCmo4UTsuTjtstKvInQiG3i3gpGZbBFzoTi87vrRHt
 hRDNLLjwyt+afxWegPoTHzZAZSIFmWv9CMQQMdyFMZnEp0XUXmKFs0optXY2EvLumr
 GSSrpmYeMbVQHh6iZoFgtanJyVlYNbohCoxXdddA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20181130120229eucas1p2218be6aff3ee2cd618709a63da427bfd~r5T1xFy1i0231202312eucas1p23;
 Fri, 30 Nov 2018 12:02:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id A5.6B.04294.5D6210C5; Fri, 30
 Nov 2018 12:02:29 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20181130120228eucas1p17dd7e4da8adb8bb8c88f1e372fb0ebd9~r5T0_MW5P2507925079eucas1p1d;
 Fri, 30 Nov 2018 12:02:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20181130120228eusmtrp26e297096bd7a2e63c1764b930b85e90b~r5T0u5LPx2249222492eusmtrp2g;
 Fri, 30 Nov 2018 12:02:28 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-96-5c0126d50732
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id C2.A1.04128.4D6210C5; Fri, 30
 Nov 2018 12:02:28 +0000 (GMT)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20181130120227eusmtip21b340e588508aee92205f932d1bb7546~r5T0IGLcg0121601216eusmtip2F;
 Fri, 30 Nov 2018 12:02:27 +0000 (GMT)
From: Christoph Manszewski <c.manszewski@samsung.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH 1/2] drm/edid: Add colorimetry helper function
Date: Fri, 30 Nov 2018 13:02:11 +0100
Message-Id: <1543579332-16609-2-git-send-email-c.manszewski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543579332-16609-1-git-send-email-c.manszewski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfyyUcRzHfe957rmHOR7H+EzNrWvZZH416lk1/Vhbj//UsiVKF09YHN05
 JRViCqVDi0n6MeZHtnSdH11FbtxlcaYwx8Qmm1/NdPRrIo9n5r/X9/3j+/7u2UNiEp3QnYxX
 pLBKhTxBRtjhzcY/Zp9BTxTp32PB6XvmbgFteluN6IHlBYIuHtfg9PTXfpy+PzmH0X19jSK6
 99a8iNZODgnpL/oKgi7raxPQzxabcHpiph3RYyWdiC4rmSEOOzKVDemMtj6PYFp+TgiZyu4T
 zHiBScC8rspgTPoREVOoq0eMVesRanvG7mAMmxCfyir9gs/bxT0sn8KT2x2uLrb8FWQig30+
 siWBCoSs5QKUj+xICVWLoL94RcgZEmoJQfYIwxtWBI9KM4WbjZyuuyLeqEFQ0Krfakx/DOWY
 oIJgdOwHwbELtRP+FdVvTGBUAw5Zo80bBWcqGJoGs3COcWoXFA2/F3Esphioere55gEWcx7G
 sS0VAp9b5jHuIqCMIqiY7UJ86BhkfagheHaGWZNOxPN2WHvzRMAXshGMLA0J+YMGQceLfJxP
 HQDt8Ox6ilx/nxe81Pvx8hFozJnCORkoBxj+7sTJ2DoWN5divCyGO7kSPu0JczodsTk7bV1G
 fISBztZA/mNVIGi0rmIaJC3f2nqKUD1yY9WqxFhWtUfBXvFVyRNVakWsb3RSohat/0ufVk1L
 rUi/csGAKBLJ7MXTv9YiJEJ5qiot0YCAxGQuYnOuTaREHCNPu8Yqk6KU6gRWZUDbSFzmJk63
 mYiQULHyFPYSyyazyk1XQNq6Z6KjCY9DW52COqKd9vfcODVjvPkNpC5FO+ZP+xibwtNSvJgA
 tUJnE15XebbkYpgfE7B3ON510GC5HRriaHWzerQteLtaddH+3iJNr/GBRRqVkfPcPFdbePnk
 8ZjiCXnH79wpaNtXOaCuCQt0VL9aOufoKq3WBgxc90g6ZFHXDZbIcFWcPGA3plTJ/wMlfsx5
 RwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsVy+t/xe7pX1BhjDP6s5rHoPXeSyeL47qWM
 Fle+vmezmHR/AovFi3sXWSz6H79mtjh/fgO7xdmmN+wWmx5fY7W4vGsOm8WM8/uYLBZ+3Mpi
 8eDlfkaLu5OPMFrMmPySzYHfY96aao9NqzrZPLZ/e8DqMe9koMf97uNMHpuX1Hsc33WL3aNv
 yypGj8+b5AI4o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstS
 i/TtEvQyps16ylKwn6/i4/ZfTA2Mh3i6GDk5JARMJFqO9rB3MXJxCAksZZTYtPAUO0RCRmLe
 2T42CFtY4s+1LjaIok+MEu1bZ7OAJNgETCVu3/0EViQioCzxd+IqRpAiZoEdLBLfPu8BKxIW
 sJPYerURzGYRUJWYeGMv2AZeAQ+JJXsaWCE2yEncPNfJDGJzCnhKXNr+BswWAqo5enQFywRG
 vgWMDKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECI2XbsZ9bdjB2vQs+xCjAwajEw+vw63+0
 EGtiWXFl7iFGCQ5mJRHec20MMUK8KYmVValF+fFFpTmpxYcYTYGOmsgsJZqcD4zivJJ4Q1ND
 cwtLQ3Njc2MzCyVx3vMGlVFCAumJJanZqakFqUUwfUwcnFINjOq/uBS42n02xLzctElV+ZGv
 6+blQedP9PKeeGwXzPf72f3Iptpzi57tXZLKlXjd/7Wjp/pXWbm4jKCl0qv5ZihP6p66cgeD
 t13auoVl1Z5fFRVuhV6/d0/syuT38hsnXd31h6l9gU4hd3QaT+qp4Bm/tyi8mcS4qljg3S11
 hweRcnscxY9MO6PEUpyRaKjFXFScCADNLBd2qgIAAA==
X-CMS-MailID: 20181130120228eucas1p17dd7e4da8adb8bb8c88f1e372fb0ebd9
X-Msg-Generator: CA
X-RootMTR: 20181130120228eucas1p17dd7e4da8adb8bb8c88f1e372fb0ebd9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181130120228eucas1p17dd7e4da8adb8bb8c88f1e372fb0ebd9
References: <1543579332-16609-1-git-send-email-c.manszewski@samsung.com>
 <CGME20181130120228eucas1p17dd7e4da8adb8bb8c88f1e372fb0ebd9@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_040245_002450_A0419332 
X-CRM114-Status: GOOD (  12.80  )
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
Cc: linux-samsung-soc@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>,
 Christoph Manszewski <c.manszewski@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, David Airlie <airlied@linux.ie>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Inki Dae <inki.dae@samsung.com>, Maxime Ripard <maxime.ripard@bootlin.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>,
 Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In analogy to drm_default_rgb_quant_range, create
drm_default_colorimetry helper function to determine the default
colorimetry value based on drm_display_mode. Currently there isn't any
standarized way to determine the default color space format.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---
 drivers/gpu/drm/drm_edid.c | 12 ++++++++++++
 include/drm/drm_edid.h     |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index b506e3622b08..03ac833dcc3c 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -4278,6 +4278,18 @@ drm_default_rgb_quant_range(const struct drm_display_mode *mode)
 }
 EXPORT_SYMBOL(drm_default_rgb_quant_range);
 
+enum hdmi_colorimetry
+drm_default_colorimetry(const struct drm_display_mode *mode)
+{
+	if (mode->vdisplay < 720)
+		return HDMI_COLORIMETRY_ITU_601;
+	else if (mode->vdisplay <= 1080)
+		return HDMI_COLORIMETRY_ITU_709;
+	else
+		return HDMI_COLORIMETRY_EXTENDED;
+}
+EXPORT_SYMBOL(drm_default_colorimetry);
+
 static void drm_parse_ycbcr420_deep_color_info(struct drm_connector *connector,
 					       const u8 *db)
 {
diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index e3c404833115..da43a5d02f7f 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -474,6 +474,8 @@ bool drm_detect_monitor_audio(struct edid *edid);
 bool drm_rgb_quant_range_selectable(struct edid *edid);
 enum hdmi_quantization_range
 drm_default_rgb_quant_range(const struct drm_display_mode *mode);
+enum hdmi_colorimetry
+drm_default_colorimetry(const struct drm_display_mode *mode);
 int drm_add_modes_noedid(struct drm_connector *connector,
 			 int hdisplay, int vdisplay);
 void drm_set_preferred_mode(struct drm_connector *connector,
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
