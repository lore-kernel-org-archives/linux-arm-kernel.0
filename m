Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1758DC10F02
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:09:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD27C21A80
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rVBnVu7X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD27C21A80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=brZYk9eUO3neMxW2riEPltR8JF5C0TGMN+1KMkgb8Ks=; b=rVBnVu7XfBoxK9ndhJaJn/DQr
	gIRkzq9CK7kA78tYEgrYN6M2oLjTxJzC6r1xEQEuHhCEUuCnDeiZI9NNMezgExxcYYDIVl77Hxfxw
	8EcENF9GVTliF0eoEBgu/HOMWTnmCKAGr470UZwyWG2rjHeXDj0Av3fFZA5lFWg9FpVEWzm499arZ
	9i/h5HMFUvjkooAFcfPN8jKx0TxsQBWovNS3mGE8TT03uzEjhCqiHBn79V0TlH4q/O5O9cYU9np5v
	3CfgUCxxDFw5wA/GMaqEax0YvYTUsGzmxhrfTB32NzxSTjPH0CTCZUlILqrh83Y931CYb99wNIwnO
	oXfRM4pPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guZUt-0005Em-1R; Fri, 15 Feb 2019 09:09:27 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guZUo-0005EL-1Y
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 09:09:24 +0000
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1F91vIP022581; Fri, 15 Feb 2019 10:09:17 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2qmwsurrqb-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Fri, 15 Feb 2019 10:09:17 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8B1C038;
 Fri, 15 Feb 2019 09:09:16 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DAF0F2A55;
 Fri, 15 Feb 2019 09:09:15 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.46) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 15 Feb
 2019 10:09:15 +0100
Subject: Re: [net-next] net: stmmac: handle endianness in dwmac4_get_timestamp
To: Florian Fainelli <f.fainelli@gmail.com>, Giuseppe Cavallaro
 <peppe.cavallaro@st.com>,
 Jose Abreu <joabreu@synopsys.com>, <davem@davemloft.net>
References: <1550165176-10099-1-git-send-email-alexandre.torgue@st.com>
 <59a381e6-02eb-3c97-bc63-5a8f511a1901@gmail.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <a60a1a29-5f68-9573-1fde-35b7e721c964@st.com>
Date: Fri, 15 Feb 2019 10:09:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <59a381e6-02eb-3c97-bc63-5a8f511a1901@gmail.com>
Content-Language: en-US
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-15_06:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_010923_205736_425F5A07 
X-CRM114-Status: GOOD (  15.43  )
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
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 2/14/19 7:09 PM, Florian Fainelli wrote:
> On 2/14/19 9:26 AM, Alexandre Torgue wrote:
>> GMAC IP is little-endian and used on several kind of CPU (big or little
>> endian). Main callbacks functions of the stmmac drivers take care about
>> it. It was not the case for dwmac4_get_timestamp function.
> 
> This is clearly a bugfix, so you should be targeting the 'net' tree and
> provide a Fixes: tag so this can be backported to relevant stable kernels.
> 

Ok Florian, I just have to find the right commit to fix :)

>>
>> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
>> index 20299f6..736e296 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
>> @@ -241,15 +241,18 @@ static inline void dwmac4_get_timestamp(void *desc, u32 ats, u64 *ts)
>>   static int dwmac4_rx_check_timestamp(void *desc)
>>   {
>>   	struct dma_desc *p = (struct dma_desc *)desc;
>> +	unsigned int rdes0 = le32_to_cpu(p->des0);
>> +	unsigned int rdes1 = le32_to_cpu(p->des1);
>> +	unsigned int rdes3 = le32_to_cpu(p->des3);
>>   	u32 own, ctxt;
>>   	int ret = 1;
>>   
>> -	own = p->des3 & RDES3_OWN;
>> -	ctxt = ((p->des3 & RDES3_CONTEXT_DESCRIPTOR)
>> +	own = rdes3 & RDES3_OWN;
>> +	ctxt = ((rdes3 & RDES3_CONTEXT_DESCRIPTOR)
>>   		>> RDES3_CONTEXT_DESCRIPTOR_SHIFT);
>>   
>>   	if (likely(!own && ctxt)) {
>> -		if ((p->des0 == 0xffffffff) && (p->des1 == 0xffffffff))
>> +		if ((rdes0 == 0xffffffff) && (rdes1 == 0xffffffff))
>>   			/* Corrupted value */
>>   			ret = -EINVAL;
>>   		else
>>
> 
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
