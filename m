Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520F6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:05:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 228D82184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sG0G9pu8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="P8DM7NY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 228D82184A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g3rwtXwQfAzdtvEcjER6ciVV/SoTubuw8zeh4Woqauk=; b=sG0G9pu8qJBrTU
	O4BxK3r0RBpislA5jrd9drEKSZnUfnLH0sfp2oDYKtW9WYrhtv5OA8u4r30OryO4gJqvxcyc1mk5s
	TXTgCFTC1Pr4fsJG3k4wkqwXDxLqoyz9rcSK0Dt3KVjTCBrHbV2F7jLnBczYMgrpE+Rt+VqEyk3yk
	Xg5p53IvUmI3u7DaLhUX7DU38wAaqI5bmBZnFMLL4H8WWsYNfP83kep3AJ3xqByDnxi/2SK+YR7o0
	LCt3VQNn1Yt3wDUsozUd9RT46OQY48lZDnDYldiS59fFFjhryB8saJ4Mt1euYgMpCsOS1Usq0/mQs
	G4zlo3Zqdpb7RjmzeS9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZCFg-0002UA-0q; Tue, 18 Dec 2018 10:05:24 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZCFd-0002TG-47
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 10:05:22 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c18c64e0000>; Tue, 18 Dec 2018 02:05:02 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Tue, 18 Dec 2018 02:05:10 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Tue, 18 Dec 2018 02:05:10 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Dec
 2018 10:05:08 +0000
Subject: Re: [PATCH V3 08/20] clk: tegra: dfll: round down voltages based on
 alignment
To: Joseph Lo <josephl@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, 
 Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181218091232.23532-1-josephl@nvidia.com>
 <20181218091232.23532-9-josephl@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <1914601f-8b27-8f90-da21-5a4ae1f0de03@nvidia.com>
Date: Tue, 18 Dec 2018 10:05:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181218091232.23532-9-josephl@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1545127502; bh=xkXugpE3eyAHGxUcnrBwD5GJ9wnXWHdbgkrVe1z2ZC0=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=P8DM7NY8v/8XUEwJvuQ1AJG9qyiKzk8s4qyf8CoRz6UNCrxcH+DxDEdeY7LHuKcgZ
 xQPE36vyPPP4hVaA/97IeEKqEfZQIoUuzBRveJh67Fc0X+zciHwgRjZbCsKd4zNu3N
 N+0isHre4IhTQU6E4cUqEr+kbCRmERWoDHR3LV8s+AuCaNHCKKxrptriDDLl1z3/LM
 VRfGiwvziCBrVZJpjJFfknG0npgD/2m31xnmGCTCXH4XRPpC48XZxqRkWd9LSRy/e0
 eicRU0HlfsPoN0ng4R34nsQ+gwTgOWw9mT4I9ZW/xne7d8wKHZ5Zp4+9q3X66uQQxC
 shoRRRIXug8Ug==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_020521_182567_2B6F9C57 
X-CRM114-Status: GOOD (  17.73  )
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
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 18/12/2018 09:12, Joseph Lo wrote:
> When generating the OPP table, the voltages are round down with the
> alignment from the regulator. The alignment should be applied for
> voltages look up as well.
> 
> Based on the work of Penny Chiu <pchiu@nvidia.com>.
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
> *v3:
>  - fix error handling code when regulator_list_voltage returns error
> *V2:
>  - s/align_volt/align_step/
>  - s/reg_volt/reg_volt_id/
> ---
>  drivers/clk/tegra/clk-dfll.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
> index 96be522398ed..ca9a4ae0d29e 100644
> --- a/drivers/clk/tegra/clk-dfll.c
> +++ b/drivers/clk/tegra/clk-dfll.c
> @@ -804,18 +804,17 @@ static void dfll_init_out_if(struct tegra_dfll *td)
>  static int find_lut_index_for_rate(struct tegra_dfll *td, unsigned long rate)
>  {
>  	struct dev_pm_opp *opp;
> -	unsigned long uv;
> -	int i;
> +	int i, align_step;
>  
>  	opp = dev_pm_opp_find_freq_ceil(td->soc->dev, &rate);
>  	if (IS_ERR(opp))
>  		return PTR_ERR(opp);
>  
> -	uv = dev_pm_opp_get_voltage(opp);
> +	align_step = dev_pm_opp_get_voltage(opp) / td->soc->alignment.step_uv;
>  	dev_pm_opp_put(opp);
>  
>  	for (i = td->lut_bottom; i < td->lut_size; i++) {
> -		if (td->lut_uv[i] >= uv)
> +		if ((td->lut_uv[i] / td->soc->alignment.step_uv) >= align_step)
>  			return i;
>  	}
>  
> @@ -1533,18 +1532,21 @@ static int dfll_init(struct tegra_dfll *td)
>   */
>  static int find_vdd_map_entry_exact(struct tegra_dfll *td, int uV)
>  {
> -	int i, n_voltages, reg_uV;
> +	int i, n_voltages, reg_uV,reg_volt_id, align_step;
>  
>  	if (WARN_ON(td->pmu_if == TEGRA_DFLL_PMU_PWM))
>  		return -EINVAL;
>  
> +	align_step = uV / td->soc->alignment.step_uv;
>  	n_voltages = regulator_count_voltages(td->vdd_reg);
>  	for (i = 0; i < n_voltages; i++) {
>  		reg_uV = regulator_list_voltage(td->vdd_reg, i);
>  		if (reg_uV < 0)
>  			break;
>  
> -		if (uV == reg_uV)
> +		reg_volt_id = reg_uV / td->soc->alignment.step_uv;
> +
> +		if (align_step == reg_volt_id)
>  			return i;
>  	}
>  
> @@ -1558,18 +1560,21 @@ static int find_vdd_map_entry_exact(struct tegra_dfll *td, int uV)
>   * */
>  static int find_vdd_map_entry_min(struct tegra_dfll *td, int uV)
>  {
> -	int i, n_voltages, reg_uV;
> +	int i, n_voltages, reg_uV, reg_volt_id, align_step;
>  
>  	if (WARN_ON(td->pmu_if == TEGRA_DFLL_PMU_PWM))
>  		return -EINVAL;
>  
> +	align_step = uV / td->soc->alignment.step_uv;
>  	n_voltages = regulator_count_voltages(td->vdd_reg);
>  	for (i = 0; i < n_voltages; i++) {
>  		reg_uV = regulator_list_voltage(td->vdd_reg, i);
>  		if (reg_uV < 0)
>  			break;
>  
> -		if (uV <= reg_uV)
> +		reg_volt_id = reg_uV / td->soc->alignment.step_uv;
> +
> +		if (align_step <= reg_volt_id)
>  			return i;
>  	}
>  
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
