Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992CFC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:43:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F7702080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SxjD9XMA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rDY8pqF4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F7702080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=59FoYNL1BeO0IywRd/ioBPxe9jVL7pMHomEk95JsVm0=; b=SxjD9XMAEOyZGS
	OA9Glz5JSUq7lFmZzBlgd6A/qGNZFZh46uKGeTJNi/qz8JzeWFJ0e/qowWH2fV065chmjGVZYCSqu
	qSafuAXeO95ToAPfl0qreapDKjJhkJJUT5J5KRFBnAnQ2v4ueo57fkkE2O0yh2YyghJA8NlBDuRZ0
	NePZJfygsjiAIJKsnjhKP4GRJE6gZQKsELpi47XMcWzDVymYABd2JTT0SfWTxmrBH/XUXLbk1iEqV
	cjuW/oXyCHIjL3fwby/RsqLHrTjwkLHDqp/Wkxx0UFWTt26fngpjyg6Dy7u8Y1LVe9TzDnzOU/dLk
	dxjBm83Eoh9Tjqrzhvxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXNX1-0007Ro-OM; Thu, 13 Dec 2018 09:43:47 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXNOr-0007q5-7d
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 09:35:25 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c1227cb0000>; Thu, 13 Dec 2018 01:35:07 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 13 Dec 2018 01:35:10 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 13 Dec 2018 01:35:10 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 13 Dec
 2018 09:35:10 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 13 Dec 2018 09:35:10 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw01.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c1227cd0001>; Thu, 13 Dec 2018 01:35:10 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver
 <pdeschrijver@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH V2 09/21] clk: tegra: dfll: add protection for find_vdd_map
 APIs
Date: Thu, 13 Dec 2018 17:34:26 +0800
Message-ID: <20181213093438.29621-10-josephl@nvidia.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181213093438.29621-1-josephl@nvidia.com>
References: <20181213093438.29621-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544693707; bh=HAfEKjzYprxlPBOEemM+ZU5kIUKVvi6v5gdpSPuX82Q=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=rDY8pqF46YJ0xXMULIH+P0hsiNlS6N0YZeKXA4B23l/DybOWdWguGsCW3eVJjfM4k
 h1C4+76ntDtUKo9hssCHse7unSb0ik8ezhkVy7Vef+drY4l2CovlJ0c9bjoF9/CJkR
 sQ4TcfhVRtitk2FypAlqU/IMbwf2j1OTFrXleK1OsysXBBqWtENUQGEB91zsMQBSU8
 qZWLdLQ+1QoKXFoCLnCPzCrcap3dD2Ukt1Ua75NTnqoZ79PUCFeXCgmZOQ4/8VIVLg
 +4G0r/J1brDWANz9SgmznaU2GWPHz4X+0/HT8zS+5SUI6DLIu37gS2NevgGMmoDRwg
 eWoYOFFz0LgfA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_013521_459360_98DF0099 
X-CRM114-Status: UNSURE (   8.87  )
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

The DFLL hardware supports both I2C and PWM based regulator. SW driver
only touches I2C regulator when generating LUT. And shouldn't touch it
anymore once the DFLL is enabled.

This patch adds the protection for the APIs that only work with I2C mode
to avoid they could be called accidentally.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
*V2:
 - new added patch in V2
---
 drivers/clk/tegra/clk-dfll.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
index b3668073d9b4..93cc86f17f7b 100644
--- a/drivers/clk/tegra/clk-dfll.c
+++ b/drivers/clk/tegra/clk-dfll.c
@@ -1534,6 +1534,9 @@ static int find_vdd_map_entry_exact(struct tegra_dfll *td, int uV)
 {
 	int i, n_voltages, reg_volt_id, align_step;
 
+	if (WARN_ON(td->pmu_if == TEGRA_DFLL_PMU_PWM))
+		return -EINVAL;
+
 	align_step = uV / td->soc->alignment.step_uv;
 	n_voltages = regulator_count_voltages(td->vdd_reg);
 	for (i = 0; i < n_voltages; i++) {
@@ -1558,6 +1561,9 @@ static int find_vdd_map_entry_min(struct tegra_dfll *td, int uV)
 {
 	int i, n_voltages, reg_volt_id, align_step;
 
+	if (WARN_ON(td->pmu_if == TEGRA_DFLL_PMU_PWM))
+		return -EINVAL;
+
 	align_step = uV / td->soc->alignment.step_uv;
 	n_voltages = regulator_count_voltages(td->vdd_reg);
 	for (i = 0; i < n_voltages; i++) {
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
