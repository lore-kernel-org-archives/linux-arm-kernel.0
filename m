Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FD9C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:36:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 560212080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Uyg8iCxp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MFAeg8gJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 560212080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vABVZXIuGfkESD8z14Zo/llmO2wcwt7OH4MeamzAwVE=; b=Uyg8iCxph5x2cc
	y+5yiPTfp0FtuKr9ZBeRCMiki7qVUObIFvU3KNbHhd/cN8UYjSkg2TuS3+zEUZsD3D1bz5T5JvbRm
	z/WpzbkyavJGMOlJZWWoy65xOMBm31Ou8Z5uKSbDNBwSzyXh+h8pI9Dgm9sUN2LkQVkZR12ddW/gR
	EW1BZPdgJFbQe5hePTuv8s1KcNN80/aWRCLzE9/3coJFDTgDQruGCYr3mf9W5y1c5RCjbo33vNaUn
	ALrdnxBpuvD8eudS+icvV8ac5Z8dvnnihrC82ZP2RiqPda2hiAzvSB2MQ30KYt5ePdYzacSYfeLjj
	4LHyqvf94/HMcqBHdOIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXNQH-0001rk-JZ; Thu, 13 Dec 2018 09:36:49 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXNOk-000802-5w
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 09:35:21 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c1227cd0002>; Thu, 13 Dec 2018 01:35:09 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 13 Dec 2018 01:35:13 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 13 Dec 2018 01:35:13 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 13 Dec
 2018 09:35:12 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 13 Dec
 2018 09:35:12 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 13 Dec 2018 09:35:12 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw01.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c1227cf0002>; Thu, 13 Dec 2018 01:35:12 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver
 <pdeschrijver@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH V2 10/21] clk: tegra: dfll: add CVB tables for Tegra210
Date: Thu, 13 Dec 2018 17:34:27 +0800
Message-ID: <20181213093438.29621-11-josephl@nvidia.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181213093438.29621-1-josephl@nvidia.com>
References: <20181213093438.29621-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544693709; bh=KB3y32OVJ0XKIfcRrIH9t783CV8W76JOi+7QmwSnqb8=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=MFAeg8gJGMQtUW0MfypUf2idJR3FYsvMoBs3mys7oMX4qp/X/2YBjPnYNh+zA1jIn
 ihlJFUDmDjHYR+j5pYOgevVpfeu75Q1678L1EToMG1/Eq5eCSehdDQGVzpvm7eNaYq
 YwlEwazgQl1kQOx3GmfhlvBzrk8y1q/ERRnXFzR0vBkzsCK2mEKHb/g0gNqbx5a/LH
 QzrImjBDlF7bpx6MuRoN36yf+w6Nb8JRQHMj8z2sZY8pmCtEJehocvJ7C6z6dvYocq
 w9m4bPwDvv+eR/9E0FmTVu0ENbvPYkvNWr8+k6v02XmSNN1eQZqJ4ZdZLKAQ/MzTf0
 trt+dDvqz6Liw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_013514_531645_35A7006B 
X-CRM114-Status: UNSURE (   9.12  )
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
Cc: linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Joseph Lo <josephl@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add CVB tables with different chip characterization, so that we can
generate the customize OPP table that suitable for different chips with
different SKUs.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
*V2:
 - no update
---
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c | 426 +++++++++++++++++++++
 drivers/clk/tegra/cvb.h                    |   1 +
 2 files changed, 427 insertions(+)

diff --git a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
index 189b5e20ee4e..db117e9991e3 100644
--- a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
+++ b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
@@ -88,6 +88,421 @@ static const struct cvb_table tegra124_cpu_cvb_tables[] = {
 	},
 };
 
+static const unsigned long tegra210_cpu_max_freq_table[] = {
+	[0] = 1912500000UL,
+	[1] = 1912500000UL,
+	[2] = 2218500000UL,
+	[3] = 1785000000UL,
+	[4] = 1632000000UL,
+	[5] = 1912500000UL,
+	[6] = 2014500000UL,
+	[7] = 1734000000UL,
+	[8] = 1683000000UL,
+	[9] = 1555500000UL,
+	[10] = 1504500000UL,
+};
+
+#define CPU_CVB_TABLE \
+	.speedo_scale = 100,	\
+	.voltage_scale = 1000,	\
+	.entries = {		\
+		{  204000000UL,	{ 1007452, -23865, 370 } }, \
+		{  306000000UL,	{ 1052709, -24875, 370 } }, \
+		{  408000000UL,	{ 1099069, -25895, 370 } }, \
+		{  510000000UL,	{ 1146534, -26905, 370 } }, \
+		{  612000000UL,	{ 1195102, -27915, 370 } }, \
+		{  714000000UL,	{ 1244773, -28925, 370 } }, \
+		{  816000000UL,	{ 1295549, -29935, 370 } }, \
+		{  918000000UL,	{ 1347428, -30955, 370 } }, \
+		{ 1020000000UL,	{ 1400411, -31965, 370 } }, \
+		{ 1122000000UL,	{ 1454497, -32975, 370 } }, \
+		{ 1224000000UL,	{ 1509687, -33985, 370 } }, \
+		{ 1326000000UL,	{ 1565981, -35005, 370 } }, \
+		{ 1428000000UL,	{ 1623379, -36015, 370 } }, \
+		{ 1530000000UL,	{ 1681880, -37025, 370 } }, \
+		{ 1632000000UL,	{ 1741485, -38035, 370 } }, \
+		{ 1734000000UL,	{ 1802194, -39055, 370 } }, \
+		{ 1836000000UL,	{ 1864006, -40065, 370 } }, \
+		{ 1912500000UL,	{ 1910780, -40815, 370 } }, \
+		{ 2014500000UL,	{ 1227000,      0,   0 } }, \
+		{ 2218500000UL,	{ 1227000,      0,   0 } }, \
+		{          0UL,	{       0,      0,   0 } }, \
+	}
+
+#define CPU_CVB_TABLE_XA \
+	.speedo_scale = 100,	\
+	.voltage_scale = 1000,	\
+	.entries = {		\
+		{  204000000UL,	{ 1250024, -39785, 565 } }, \
+		{  306000000UL,	{ 1297556, -41145, 565 } }, \
+		{  408000000UL,	{ 1346718, -42505, 565 } }, \
+		{  510000000UL,	{ 1397511, -43855, 565 } }, \
+		{  612000000UL,	{ 1449933, -45215, 565 } }, \
+		{  714000000UL,	{ 1503986, -46575, 565 } }, \
+		{  816000000UL,	{ 1559669, -47935, 565 } }, \
+		{  918000000UL,	{ 1616982, -49295, 565 } }, \
+		{ 1020000000UL,	{ 1675926, -50645, 565 } }, \
+		{ 1122000000UL,	{ 1736500, -52005, 565 } }, \
+		{ 1224000000UL,	{ 1798704, -53365, 565 } }, \
+		{ 1326000000UL,	{ 1862538, -54725, 565 } }, \
+		{ 1428000000UL,	{ 1928003, -56085, 565 } }, \
+		{ 1530000000UL,	{ 1995097, -57435, 565 } }, \
+		{ 1606500000UL,	{ 2046149, -58445, 565 } }, \
+		{ 1632000000UL,	{ 2063822, -58795, 565 } }, \
+		{          0UL,	{       0,      0,   0 } }, \
+	}
+
+#define CPU_CVB_TABLE_EUCM1 \
+	.speedo_scale = 100,	\
+	.voltage_scale = 1000,	\
+	.entries = {		\
+		{  204000000UL,	{  734429, 0, 0 } }, \
+		{  306000000UL,	{  768191, 0, 0 } }, \
+		{  408000000UL,	{  801953, 0, 0 } }, \
+		{  510000000UL,	{  835715, 0, 0 } }, \
+		{  612000000UL,	{  869477, 0, 0 } }, \
+		{  714000000UL,	{  903239, 0, 0 } }, \
+		{  816000000UL,	{  937001, 0, 0 } }, \
+		{  918000000UL,	{  970763, 0, 0 } }, \
+		{ 1020000000UL,	{ 1004525, 0, 0 } }, \
+		{ 1122000000UL,	{ 1038287, 0, 0 } }, \
+		{ 1224000000UL,	{ 1072049, 0, 0 } }, \
+		{ 1326000000UL,	{ 1105811, 0, 0 } }, \
+		{ 1428000000UL,	{ 1130000, 0, 0 } }, \
+		{ 1555500000UL,	{ 1130000, 0, 0 } }, \
+		{ 1632000000UL,	{ 1170000, 0, 0 } }, \
+		{ 1734000000UL,	{ 1227500, 0, 0 } }, \
+		{          0UL,	{       0, 0, 0 } }, \
+	}
+
+#define CPU_CVB_TABLE_EUCM2 \
+	.speedo_scale = 100,	\
+	.voltage_scale = 1000,	\
+	.entries = {		\
+		{  204000000UL,	{  742283, 0, 0 } }, \
+		{  306000000UL,	{  776249, 0, 0 } }, \
+		{  408000000UL,	{  810215, 0, 0 } }, \
+		{  510000000UL,	{  844181, 0, 0 } }, \
+		{  612000000UL,	{  878147, 0, 0 } }, \
+		{  714000000UL,	{  912113, 0, 0 } }, \
+		{  816000000UL,	{  946079, 0, 0 } }, \
+		{  918000000UL,	{  980045, 0, 0 } }, \
+		{ 1020000000UL,	{ 1014011, 0, 0 } }, \
+		{ 1122000000UL,	{ 1047977, 0, 0 } }, \
+		{ 1224000000UL,	{ 1081943, 0, 0 } }, \
+		{ 1326000000UL,	{ 1090000, 0, 0 } }, \
+		{ 1479000000UL,	{ 1090000, 0, 0 } }, \
+		{ 1555500000UL,	{ 1162000, 0, 0 } }, \
+		{ 1683000000UL,	{ 1195000, 0, 0 } }, \
+		{          0UL,	{       0, 0, 0 } }, \
+	}
+
+#define CPU_CVB_TABLE_EUCM2_JOINT_RAIL \
+	.speedo_scale = 100,	\
+	.voltage_scale = 1000,	\
+	.entries = {		\
+		{  204000000UL,	{  742283, 0, 0 } }, \
+		{  306000000UL,	{  776249, 0, 0 } }, \
+		{  408000000UL,	{  810215, 0, 0 } }, \
+		{  510000000UL,	{  844181, 0, 0 } }, \
+		{  612000000UL,	{  878147, 0, 0 } }, \
+		{  714000000UL,	{  912113, 0, 0 } }, \
+		{  816000000UL,	{  946079, 0, 0 } }, \
+		{  918000000UL,	{  980045, 0, 0 } }, \
+		{ 1020000000UL,	{ 1014011, 0, 0 } }, \
+		{ 1122000000UL,	{ 1047977, 0, 0 } }, \
+		{ 1224000000UL,	{ 1081943, 0, 0 } }, \
+		{ 1326000000UL,	{ 1090000, 0, 0 } }, \
+		{ 1479000000UL,	{ 1090000, 0, 0 } }, \
+		{ 1504500000UL,	{ 1120000, 0, 0 } }, \
+		{          0UL,	{       0, 0, 0 } }, \
+	}
+
+#define CPU_CVB_TABLE_ODN \
+	.speedo_scale = 100,	\
+	.voltage_scale = 1000,	\
+	.entries = {		\
+		{  204000000UL,	{  721094, 0, 0 } }, \
+		{  306000000UL,	{  754040, 0, 0 } }, \
+		{  408000000UL,	{  786986, 0, 0 } }, \
+		{  510000000UL,	{  819932, 0, 0 } }, \
+		{  612000000UL,	{  852878, 0, 0 } }, \
+		{  714000000UL,	{  885824, 0, 0 } }, \
+		{  816000000UL,	{  918770, 0, 0 } }, \
+		{  918000000UL,	{  915716, 0, 0 } }, \
+		{ 1020000000UL,	{  984662, 0, 0 } }, \
+		{ 1122000000UL,	{ 1017608, 0, 0 } }, \
+		{ 1224000000UL,	{ 1050554, 0, 0 } }, \
+		{ 1326000000UL,	{ 1083500, 0, 0 } }, \
+		{ 1428000000UL,	{ 1116446, 0, 0 } }, \
+		{ 1581000000UL,	{ 1130000, 0, 0 } }, \
+		{ 1683000000UL,	{ 1168000, 0, 0 } }, \
+		{ 1785000000UL,	{ 1227500, 0, 0 } }, \
+		{          0UL,	{       0, 0, 0 } }, \
+	}
+
+struct cvb_table tegra210_cpu_cvb_tables[] = {
+	{
+		.speedo_id = 10,
+		.process_id = 0,
+		.min_millivolts = 840,
+		.max_millivolts = 1120,
+		CPU_CVB_TABLE_EUCM2_JOINT_RAIL,
+		.cpu_dfll_data = {
+			.tune0_low = 0xffead0ff,
+			.tune0_high = 0xffead0ff,
+			.tune1 = 0x20091d9,
+			.tune_high_min_millivolts = 864,
+		}
+	},
+	{
+		.speedo_id = 10,
+		.process_id = 1,
+		.min_millivolts = 840,
+		.max_millivolts = 1120,
+		CPU_CVB_TABLE_EUCM2_JOINT_RAIL,
+		.cpu_dfll_data = {
+			.tune0_low = 0xffead0ff,
+			.tune0_high = 0xffead0ff,
+			.tune1 = 0x20091d9,
+			.tune_high_min_millivolts = 864,
+		}
+	},
+	{
+		.speedo_id = 9,
+		.process_id = 0,
+		.min_millivolts = 900,
+		.max_millivolts = 1162,
+		CPU_CVB_TABLE_EUCM2,
+		.cpu_dfll_data = {
+			.tune0_low = 0xffead0ff,
+			.tune0_high = 0xffead0ff,
+			.tune1 = 0x20091d9,
+		}
+	},
+	{
+		.speedo_id = 9,
+		.process_id = 1,
+		.min_millivolts = 900,
+		.max_millivolts = 1162,
+		CPU_CVB_TABLE_EUCM2,
+		.cpu_dfll_data = {
+			.tune0_low = 0xffead0ff,
+			.tune0_high = 0xffead0ff,
+			.tune1 = 0x20091d9,
+		}
+	},
+	{
+		.speedo_id = 8,
+		.process_id = 0,
+		.min_millivolts = 900,
+		.max_millivolts = 1195,
+		CPU_CVB_TABLE_EUCM2,
+		.cpu_dfll_data = {
+			.tune0_low = 0xffead0ff,
+			.tune0_high = 0xffead0ff,
+			.tune1 = 0x20091d9,
+		}
+	},
+	{
+		.speedo_id = 8,
+		.process_id = 1,
+		.min_millivolts = 900,
+		.max_millivolts = 1195,
+		CPU_CVB_TABLE_EUCM2,
+		.cpu_dfll_data = {
+			.tune0_low = 0xffead0ff,
+			.tune0_high = 0xffead0ff,
+			.tune1 = 0x20091d9,
+		}
+	},
+	{
+		.speedo_id = 7,
+		.process_id = 0,
+		.min_millivolts = 841,
+		.max_millivolts = 1227,
+		CPU_CVB_TABLE_EUCM1,
+		.cpu_dfll_data = {
+			.tune0_low = 0xffead0ff,
+			.tune0_high = 0xffead0ff,
+			.tune1 = 0x20091d9,
+			.tune_high_min_millivolts = 864,
+		}
+	},
+	{
+		.speedo_id = 7,
+		.process_id = 1,
+		.min_millivolts = 841,
+		.max_millivolts = 1227,
+		CPU_CVB_TABLE_EUCM1,
+		.cpu_dfll_data = {
+			.tune0_low = 0xffead0ff,
+			.tune0_high = 0xffead0ff,
+			.tune1 = 0x20091d9,
+			.tune_high_min_millivolts = 864,
+		}
+	},
+	{
+		.speedo_id = 6,
+		.process_id = 0,
+		.min_millivolts = 870,
+		.max_millivolts = 1150,
+		CPU_CVB_TABLE,
+		.cpu_dfll_data = {
+			.tune0_low = 0xffead0ff,
+			.tune1 = 0x20091d9,
+		}
+	},
+	{
+		.speedo_id = 6,
+		.process_id = 1,
+		.min_millivolts = 870,
+		.max_millivolts = 1150,
+		CPU_CVB_TABLE,
+		.cpu_dfll_data = {
+			.tune0_low = 0xffead0ff,
+			.tune1 = 0x25501d0,
+		}
+	},
+	{
+		.speedo_id = 5,
+		.process_id = 0,
+		.min_millivolts = 818,
+		.max_millivolts = 1227,
+		CPU_CVB_TABLE,
+		.cpu_dfll_data = {
+			.tune0_low = 0xffead0ff,
+			.tune0_high = 0xffead0ff,
+			.tune1 = 0x20091d9,
+			.tune_high_min_millivolts = 864,
+		}
+	},
+	{
+		.speedo_id = 5,
+		.process_id = 1,
+		.min_millivolts = 818,
+		.max_millivolts = 1227,
+		CPU_CVB_TABLE,
+		.cpu_dfll_data = {
+			.tune0_low = 0xffead0ff,
+			.tune0_high = 0xffead0ff,
+			.tune1 = 0x25501d0,
+			.tune_high_min_millivolts = 864,
+		}
+	},
+	{
+		.speedo_id = 4,
+		.process_id = -1,
+		.min_millivolts = 918,
+		.max_millivolts = 1113,
+		CPU_CVB_TABLE_XA,
+		.cpu_dfll_data = {
+			.tune0_low = 0xffead0ff,
+			.tune1 = 0x17711BD,
+		}
+	},
+	{
+		.speedo_id = 3,
+		.process_id = 0,
+		.min_millivolts = 825,
+		.max_millivolts = 1227,
+		CPU_CVB_TABLE_ODN,
+		.cpu_dfll_data = {
+			.tune0_low = 0xffead0ff,
+			.tune0_high = 0xffead0ff,
+			.tune1 = 0x20091d9,
+			.tune_high_min_millivolts = 864,
+		}
+	},
+	{
+		.speedo_id = 3,
+		.process_id = 1,
+		.min_millivolts = 825,
+		.max_millivolts = 1227,
+		CPU_CVB_TABLE_ODN,
+		.cpu_dfll_data = {
+			.tune0_low = 0xffead0ff,
+			.tune0_high = 0xffead0ff,
+			.tune1 = 0x25501d0,
+			.tune_high_min_millivolts = 864,
+		}
+	},
+	{
+		.speedo_id = 2,
+		.process_id = 0,
+		.min_millivolts = 870,
+		.max_millivolts = 1227,
+		CPU_CVB_TABLE,
+		.cpu_dfll_data = {
+			.tune0_low = 0xffead0ff,
+			.tune1 = 0x20091d9,
+		}
+	},
+	{
+		.speedo_id = 2,
+		.process_id = 1,
+		.min_millivolts = 870,
+		.max_millivolts = 1227,
+		CPU_CVB_TABLE,
+		.cpu_dfll_data = {
+			.tune0_low = 0xffead0ff,
+			.tune1 = 0x25501d0,
+		}
+	},
+	{
+		.speedo_id = 1,
+		.process_id = 0,
+		.min_millivolts = 837,
+		.max_millivolts = 1227,
+		CPU_CVB_TABLE,
+		.cpu_dfll_data = {
+			.tune0_low = 0xffead0ff,
+			.tune0_high = 0xffead0ff,
+			.tune1 = 0x20091d9,
+			.tune_high_min_millivolts = 864,
+		}
+	},
+	{
+		.speedo_id = 1,
+		.process_id = 1,
+		.min_millivolts = 837,
+		.max_millivolts = 1227,
+		CPU_CVB_TABLE,
+		.cpu_dfll_data = {
+			.tune0_low = 0xffead0ff,
+			.tune0_high = 0xffead0ff,
+			.tune1 = 0x25501d0,
+			.tune_high_min_millivolts = 864,
+		}
+	},
+	{
+		.speedo_id = 0,
+		.process_id = 0,
+		.min_millivolts = 850,
+		.max_millivolts = 1170,
+		CPU_CVB_TABLE,
+		.cpu_dfll_data = {
+			.tune0_low = 0xffead0ff,
+			.tune0_high = 0xffead0ff,
+			.tune1 = 0x20091d9,
+			.tune_high_min_millivolts = 864,
+		}
+	},
+	{
+		.speedo_id = 0,
+		.process_id = 1,
+		.min_millivolts = 850,
+		.max_millivolts = 1170,
+		CPU_CVB_TABLE,
+		.cpu_dfll_data = {
+			.tune0_low = 0xffead0ff,
+			.tune0_high = 0xffead0ff,
+			.tune1 = 0x25501d0,
+			.tune_high_min_millivolts = 864,
+		}
+	},
+};
+
 static const struct dfll_fcpu_data tegra124_dfll_fcpu_data = {
 	.cpu_max_freq_table = tegra124_cpu_max_freq_table,
 	.cpu_max_freq_table_size = ARRAY_SIZE(tegra124_cpu_max_freq_table),
@@ -95,11 +510,22 @@ static const struct dfll_fcpu_data tegra124_dfll_fcpu_data = {
 	.cpu_cvb_tables_size = ARRAY_SIZE(tegra124_cpu_cvb_tables)
 };
 
+static const struct dfll_fcpu_data tegra210_dfll_fcpu_data = {
+	.cpu_max_freq_table = tegra210_cpu_max_freq_table,
+	.cpu_max_freq_table_size = ARRAY_SIZE(tegra210_cpu_max_freq_table),
+	.cpu_cvb_tables = tegra210_cpu_cvb_tables,
+	.cpu_cvb_tables_size = ARRAY_SIZE(tegra210_cpu_cvb_tables),
+};
+
 static const struct of_device_id tegra124_dfll_fcpu_of_match[] = {
 	{
 		.compatible = "nvidia,tegra124-dfll",
 		.data = &tegra124_dfll_fcpu_data,
 	},
+	{
+		.compatible = "nvidia,tegra210-dfll",
+		.data = &tegra210_dfll_fcpu_data
+	},
 	{ },
 };
 
diff --git a/drivers/clk/tegra/cvb.h b/drivers/clk/tegra/cvb.h
index bcf15a089b93..91a1941c21ef 100644
--- a/drivers/clk/tegra/cvb.h
+++ b/drivers/clk/tegra/cvb.h
@@ -41,6 +41,7 @@ struct cvb_cpu_dfll_data {
 	u32 tune0_low;
 	u32 tune0_high;
 	u32 tune1;
+	unsigned int tune_high_min_millivolts;
 };
 
 struct cvb_table {
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
