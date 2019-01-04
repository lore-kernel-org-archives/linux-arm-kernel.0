Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FADC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 03:10:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A6E520449
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 03:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fUzZZ2A6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bwGZLpAL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A6E520449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HA+Z8ONhnRedJIOXr7kDwq98v34J1r3D7pdWygSq+kM=; b=fUzZZ2A6v/TDnv
	3kW6NkWeHhjdcwIIwLmIGQyvnkzwkVVe8hYS4ckA3y3Jl1qusbbBepeyws7A4SF3sziJag4298BFJ
	P4srOhwpn3TwiHGVKNBUGvTtrBjVGrcdG9Gp7OJLi3z+Ir5Zd7A0Ies6ofLLnE+wxaM8Gnyj8s+uh
	pkj2qYmG8AM0ndt7/3a4gIminxdnC0xSAGUE54VEoFglN3T5bniIK0Hh9Vd19bwMo+nUr+VmXdaYi
	JCCpK/PkZRI7pSAWiljgQOkHhUTJuT9+O+0LG5mUB/pZo0KlUgCHMPQr5dzBvx9jkFr7JZPudErUp
	nJOCBfD9ylSKqA3jwugg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfFsa-0001Ck-PG; Fri, 04 Jan 2019 03:10:36 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfFpY-0005qq-MU
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 03:07:34 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c2ecde50000>; Thu, 03 Jan 2019 19:07:17 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 03 Jan 2019 19:07:28 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 03 Jan 2019 19:07:28 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 4 Jan
 2019 03:07:28 +0000
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 4 Jan
 2019 03:07:27 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Fri, 4 Jan 2019 03:07:27 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c2ecdee0000>; Thu, 03 Jan 2019 19:07:27 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver
 <pdeschrijver@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH V4 08/20] clk: tegra: dfll: round down voltages based on
 alignment
Date: Fri, 4 Jan 2019 11:06:50 +0800
Message-ID: <20190104030702.8684-9-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104030702.8684-1-josephl@nvidia.com>
References: <20190104030702.8684-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1546571237; bh=cUL37m/rzFCv9nFOio1KsIIUXrkHUsCbWPXDPN0i4xg=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=bwGZLpALI7OB9ebdx7ADFI9rh/zrdat1vrkwErZB2BT4gFOG+JO1kz51mQj1hEF4T
 V5DNUGCGnGvt4G7Vi8DrAfGApaVVgfnZO/18vCPRf7DdBMowYoi9uNCer1vBXW6zjj
 anfhPy5PYD6p+s6vtvPO5KM0nKwY9l2Eqc81RXY5RdOfcKcm0wEtyeH1M58f8NPdW3
 l2Ov78euIT6EpCdSoPJ92R2oCSUOsscBBQB1vNNEnB7sy2p4VehACHVJ4htUTPh2Iw
 Wn8fN/Hha4hEAAEJUN1Gls9opkRzTFhltTyYEclC7CJwygs8i5hW4/vddyhD95UB1f
 qgguczQEnGbnQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_190729_148651_E48C654D 
X-CRM114-Status: GOOD (  11.22  )
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
Cc: linux-tegra@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Joseph Lo <josephl@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When generating the OPP table, the voltages are round down with the
alignment from the regulator. The alignment should be applied for
voltages look up as well.

Based on the work of Penny Chiu <pchiu@nvidia.com>.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
*V4:
 - add ack tags
*V3:
 - fix error handling code when regulator_list_voltage returns error
*V2:
 - s/align_volt/align_step/
 - s/reg_volt/reg_volt_id/
---
 drivers/clk/tegra/clk-dfll.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
index 69bbf62a9eab..0400e5b1d627 100644
--- a/drivers/clk/tegra/clk-dfll.c
+++ b/drivers/clk/tegra/clk-dfll.c
@@ -804,18 +804,17 @@ static void dfll_init_out_if(struct tegra_dfll *td)
 static int find_lut_index_for_rate(struct tegra_dfll *td, unsigned long rate)
 {
 	struct dev_pm_opp *opp;
-	unsigned long uv;
-	int i;
+	int i, align_step;
 
 	opp = dev_pm_opp_find_freq_ceil(td->soc->dev, &rate);
 	if (IS_ERR(opp))
 		return PTR_ERR(opp);
 
-	uv = dev_pm_opp_get_voltage(opp);
+	align_step = dev_pm_opp_get_voltage(opp) / td->soc->alignment.step_uv;
 	dev_pm_opp_put(opp);
 
 	for (i = td->lut_bottom; i < td->lut_size; i++) {
-		if (td->lut_uv[i] >= uv)
+		if ((td->lut_uv[i] / td->soc->alignment.step_uv) >= align_step)
 			return i;
 	}
 
@@ -1533,18 +1532,21 @@ static int dfll_init(struct tegra_dfll *td)
  */
 static int find_vdd_map_entry_exact(struct tegra_dfll *td, int uV)
 {
-	int i, n_voltages, reg_uV;
+	int i, n_voltages, reg_uV,reg_volt_id, align_step;
 
 	if (WARN_ON(td->pmu_if == TEGRA_DFLL_PMU_PWM))
 		return -EINVAL;
 
+	align_step = uV / td->soc->alignment.step_uv;
 	n_voltages = regulator_count_voltages(td->vdd_reg);
 	for (i = 0; i < n_voltages; i++) {
 		reg_uV = regulator_list_voltage(td->vdd_reg, i);
 		if (reg_uV < 0)
 			break;
 
-		if (uV == reg_uV)
+		reg_volt_id = reg_uV / td->soc->alignment.step_uv;
+
+		if (align_step == reg_volt_id)
 			return i;
 	}
 
@@ -1558,18 +1560,21 @@ static int find_vdd_map_entry_exact(struct tegra_dfll *td, int uV)
  * */
 static int find_vdd_map_entry_min(struct tegra_dfll *td, int uV)
 {
-	int i, n_voltages, reg_uV;
+	int i, n_voltages, reg_uV, reg_volt_id, align_step;
 
 	if (WARN_ON(td->pmu_if == TEGRA_DFLL_PMU_PWM))
 		return -EINVAL;
 
+	align_step = uV / td->soc->alignment.step_uv;
 	n_voltages = regulator_count_voltages(td->vdd_reg);
 	for (i = 0; i < n_voltages; i++) {
 		reg_uV = regulator_list_voltage(td->vdd_reg, i);
 		if (reg_uV < 0)
 			break;
 
-		if (uV <= reg_uV)
+		reg_volt_id = reg_uV / td->soc->alignment.step_uv;
+
+		if (align_step <= reg_volt_id)
 			return i;
 	}
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
