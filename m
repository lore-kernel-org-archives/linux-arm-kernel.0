Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DB0C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:01:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42F2320850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="giPyMgd5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F2320850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PDEl7AgvW/UWhxn786OQ5ne293bfXaG9sbZRRx8UUOU=; b=giPyMgd55/qc0EdZXRNbdzXIW
	zne2W7Y4jpG+UzdM2r/Jo/BCSJRNXg/h5p62t8Yeep2Apl9tpVdBCBxJ+w51ZOZSZj/a8J7ERRW/K
	NGQcZO/6vqgDYzNatwprQCQGgnera9tCh49Cz8Py7JFa1K+CK83z59YzT9ZOPMW8Cz4xnq1NoVnpQ
	kfbvQzwpBOs7TCVHPDnPslpCAtyA+JsAZlxmm3M2tTZH2Ch9EqIrueztgvcSt1CjmSk52wsZXb92X
	E6KakyDgi4S8Hwa9pgKebybnilSb5DSB2OaQVTG/msRECtBeQf/8rH3Xomnamp43+aJF5l/zx7sPm
	iSCfceuaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUZcM-0003yt-0A; Wed, 05 Dec 2018 16:01:42 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUZbS-0003tT-HI
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 16:00:48 +0000
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 wB5G0F8P011959; Wed, 5 Dec 2018 17:00:30 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2p3w2rxvna-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Wed, 05 Dec 2018 17:00:30 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A4AFB31;
 Wed,  5 Dec 2018 16:00:29 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 71A7151E2;
 Wed,  5 Dec 2018 16:00:29 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.50) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 5 Dec
 2018 17:00:28 +0100
Subject: Re: [PATCH V2 1/2] mmc: mmci: send stop command if sbc error issue
To: Ulf Hansson <ulf.hansson@linaro.org>
References: <1541583041-17461-1-git-send-email-ludovic.Barre@st.com>
 <1541583041-17461-2-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFpLTEwrBagJrd98Zyrd_pwJa9Zkgsi+geZainQV+OgpOQ@mail.gmail.com>
 <CAPDyKFp06tiMVgKyKLLKKwGtDPkAKuGWo=NaS+j=3oWGq-UV_A@mail.gmail.com>
From: Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <4d5b86fa-aa89-5b19-1fee-ecdbc57f6d20@st.com>
Date: Wed, 5 Dec 2018 17:00:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFp06tiMVgKyKLLKKwGtDPkAKuGWo=NaS+j=3oWGq-UV_A@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-05_06:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_080046_954877_30DD4A42 
X-CRM114-Status: GOOD (  18.94  )
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
Cc: DTML <devicetree@vger.kernel.org>,
 Alexandre Torgue <alexandre.torgue@st.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 12/5/18 3:23 PM, Ulf Hansson wrote:
> On Tue, 20 Nov 2018 at 10:42, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> On 7 November 2018 at 10:30, Ludovic Barre <ludovic.Barre@st.com> wrote:
>>> From: Ludovic Barre <ludovic.barre@st.com>
>>>
>>> Refer to "4.15 set block count command" of sd specification:
>>> Host needs to issue CMD12 if any error is detected in
>>> the CMD18 and CMD25 operations.
>>>
>>> In sbc case, the data->stop is fill by framework.
>>>
>>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>>> ---
>>>   drivers/mmc/host/mmci.c | 5 ++---
>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>>> index 82bab35..13fa640 100644
>>> --- a/drivers/mmc/host/mmci.c
>>> +++ b/drivers/mmc/host/mmci.c
>>> @@ -1190,11 +1190,10 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
>>>                          /* The error clause is handled above, success! */
>>>                          data->bytes_xfered = data->blksz * data->blocks;
>>>
>>> -               if (!data->stop || host->mrq->sbc) {
>>> +               if (!data->stop || (host->mrq->sbc && !data->error))
>>>                          mmci_request_end(host, data->mrq);
>>> -               } else {
>>> +               else
>>>                          mmci_start_command(host, data->stop, 0);
>>
>> This looks correct to me!
>>
>> Although, just wanted to double check that you tested this for a case
>> where we have host->mrq->sbc set and got an error in data->error? I
>> guess it can be tricky, so I was thinking of manually trying to
>> instruct the code, to set an error in data->error, at some point to
>> trigger this code. That would at least give us some confidence that it
>> works as expected.
> 
> I did some manual tests to trigger the error path. As far as I can
> tell, it works as expected and I observes that the core is able to
> recover and re-send the request.

Ulf, very thanks for the tests, and sorry for my busy status.
I will send as soon as possible the 2/2 with your recommendation (I will 
more spare time for upstream)

> 
> [...]
> 
> So, I have added my tested-by tag and applied this for next. Thanks!
> 
> In regards to patch2/2 I am awaiting your update.
> 
> Kind regards
> Uffe
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
