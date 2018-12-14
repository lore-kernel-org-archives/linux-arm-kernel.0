Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719A3C6786C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:19:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F04D2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cAr/jfFx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FvN4oA/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F04D2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7PcbMrII2OJGGUo7nL9XyrfiKTzGmmUlhGbXxGV8Hnw=; b=cAr/jfFxFc+qRSxHfBtLiFNVd
	jl1r6U7lNyGP33wOR+fv6pHGe20GvZ5Qaw7PKkW8eMDZCbM49BhL9GyuFZ8baCDn2edfsNvyIuGRU
	Gsjxc6gFlXpEytWcqLNbxiebU8vQy3Z8kHivsD3AsTrvSBJEy/yrBs4LCDN5lIJYxLwm/TzouGqDa
	nbz9iVS72aVfeY9fiSlVCINjIbOgftYkxVSEXgK9an1wabGL6Zic6UttXeSre7Nz6uqLy+GxpU8ef
	X+PqCdK2DkveN7CQvalGkhR+s1Gr9KiP/2V4BECL8vrqORjzuekNIiuXI+L6aV4EO5Mlc6vhm4I0R
	izMVJFCLA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXhkj-0007I7-GR; Fri, 14 Dec 2018 07:19:17 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXhkf-0007HQ-T3
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 07:19:15 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c1359630000>; Thu, 13 Dec 2018 23:19:00 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Thu, 13 Dec 2018 23:19:03 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Thu, 13 Dec 2018 23:19:03 -0800
Received: from [10.19.108.132] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 14 Dec
 2018 07:19:01 +0000
Subject: Re: [PATCH V2 08/21] clk: tegra: dfll: round down voltages based on
 alignment
To: Jon Hunter <jonathanh@nvidia.com>, Thierry Reding
 <thierry.reding@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181213093438.29621-1-josephl@nvidia.com>
 <20181213093438.29621-9-josephl@nvidia.com>
 <c1ce50e0-fccf-aa37-361c-4dd9367b092d@nvidia.com>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <b9f473fc-d1e8-6d80-be20-d9884960dc16@nvidia.com>
Date: Fri, 14 Dec 2018 15:18:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <c1ce50e0-fccf-aa37-361c-4dd9367b092d@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544771940; bh=9bq3ULHjCypEe9On9Z0bgXi1soGhhN7q505XybaliWQ=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=FvN4oA/T4O2pLj5rt2IWsW5ObCpk8MWgrH3ZBhafOHr9hFBNXC1w+PRvGhI3fwZVf
 yBf7v6ItaGxnKmD9bbido8vMOKwwF9xwyuxbzzfuS1nzfKDZlu9Gdp+7XrUO/qC0ZQ
 7zAIHzZ3LNyFV9erqk0HlERN7ZB2qSqCZ+4+t4OrZ1Jj7xo2j6MXAsPQVdYH9OPMem
 gTx4MiaF7XV1F6yswd1Wf9Ip2NOCUOhr8ZteShtS+ODtGOGBh8RefO9L/r80x/x8XL
 EQQQ6ZeZ1Thy/HSkWQthhoL7XHdf6vq+vEdISGVYGj3lEeXrHZMvdMug+4QScquJmy
 t82S4OguEeRKw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_231913_953850_82ADE7B9 
X-CRM114-Status: GOOD (  18.99  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/13/18 7:46 PM, Jon Hunter wrote:
> 
> On 13/12/2018 09:34, Joseph Lo wrote:
>> When generating the OPP table, the voltages are round down with the
>> alignment from the regulator. The alignment should be applied for
>> voltages look up as well.
>>
>> Based on the work of Penny Chiu <pchiu@nvidia.com>.
>>
>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>> ---
>> *V2:
>>   - s/align_volt/align_step/
>>   - s/reg_volt/reg_volt_id/
>> ---
>>   drivers/clk/tegra/clk-dfll.c | 26 +++++++++++++++-----------
>>   1 file changed, 15 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
>> index 72e02898006c..b3668073d9b4 100644
>> --- a/drivers/clk/tegra/clk-dfll.c
>> +++ b/drivers/clk/tegra/clk-dfll.c
>> @@ -804,17 +804,17 @@ static void dfll_init_out_if(struct tegra_dfll *td)
>>   static int find_lut_index_for_rate(struct tegra_dfll *td, unsigned long rate)
>>   {
>>   	struct dev_pm_opp *opp;
>> -	int i, uv;
>> +	int i, align_step;
>>   
>>   	opp = dev_pm_opp_find_freq_ceil(td->soc->dev, &rate);
>>   	if (IS_ERR(opp))
>>   		return PTR_ERR(opp);
>>   
>> -	uv = dev_pm_opp_get_voltage(opp);
>> +	align_step = dev_pm_opp_get_voltage(opp) / td->soc->alignment.step_uv;
>>   	dev_pm_opp_put(opp);
>>   
>>   	for (i = td->lut_bottom; i < td->lut_size; i++) {
>> -		if (td->lut_uv[i] >= uv)
>> +		if ((td->lut_uv[i] / td->soc->alignment.step_uv) >= align_step)
>>   			return i;
>>   	}
>>   
>> @@ -1532,15 +1532,17 @@ static int dfll_init(struct tegra_dfll *td)
>>    */
>>   static int find_vdd_map_entry_exact(struct tegra_dfll *td, int uV)
>>   {
>> -	int i, n_voltages, reg_uV;
>> +	int i, n_voltages, reg_volt_id, align_step;
>>   
>> +	align_step = uV / td->soc->alignment.step_uv;
>>   	n_voltages = regulator_count_voltages(td->vdd_reg);
>>   	for (i = 0; i < n_voltages; i++) {
>> -		reg_uV = regulator_list_voltage(td->vdd_reg, i);
>> -		if (reg_uV < 0)
>> +		reg_volt_id = regulator_list_voltage(td->vdd_reg, i) /
>> +			      td->soc->alignment.step_uv;
>> +		if (reg_volt_id < 0)
> 
> I don't think that this will work. If the step is say 10000 and we
> return an error code greater than -10000, we will end up with 0.

Ah,I think you mean when the error code smaller than step_uv. Yes, it 
will be 0 in that case. I think I will just remove the 'if' clause, then 
it will not match anything and leave the for loop. And return error if 
it couldn't find anything. Same as below.

Thanks.

> 
>>   			break;
>>   
>> -		if (uV == reg_uV)
>> +		if (align_step == reg_volt_id)
>>   			return i;
>>   	}
>>   
>> @@ -1554,15 +1556,17 @@ static int find_vdd_map_entry_exact(struct tegra_dfll *td, int uV)
>>    * */
>>   static int find_vdd_map_entry_min(struct tegra_dfll *td, int uV)
>>   {
>> -	int i, n_voltages, reg_uV;
>> +	int i, n_voltages, reg_volt_id, align_step;
>>   
>> +	align_step = uV / td->soc->alignment.step_uv;
>>   	n_voltages = regulator_count_voltages(td->vdd_reg);
>>   	for (i = 0; i < n_voltages; i++) {
>> -		reg_uV = regulator_list_voltage(td->vdd_reg, i);
>> -		if (reg_uV < 0)
>> +		reg_volt_id = regulator_list_voltage(td->vdd_reg, i) /
>> +			      td->soc->alignment.step_uv;
>> +		if (reg_volt_id < 0)
> 
> Same here.
> 
>>   			break;
>>   
>> -		if (uV <= reg_uV)
>> +		if (align_step <= reg_volt_id)
>>   			return i;
>>   	}
>>   
>>
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
