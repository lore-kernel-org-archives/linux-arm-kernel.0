Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E76C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:48:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2494121B18
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GxqyWm+j";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="O3bs5ZdH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2494121B18
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=A42SXch8StDGLOexDzE618b+sxNRJG/dsCA6LNjtSbY=; b=GxqyWm+jiUoMQmNsQIO5TQRje
	m/AbyL+n77eJs4Q7OAxCs4EJabeYBipFs3MrV83W8+HadVrlaaKbfZPrOQAI7M+rQ3igQtI6MfYVo
	ztOIdMNEHFesfIXxQf5Qu4QXh9enicvxJ7EJWSFgzCUIk/lOiyEBH5Xo2cgt63anMbSD4nYetKm8N
	psSBXT6i28CvvHuCMUO1IObo6VHkrze5gpxbCSrK/BDst/ISWBJ0rEakxwtWrsfDKKnEbmNA9POMT
	3tOCWMVxO8B3xi3uHsorBuzEbxcN0j+34K2yX9mJlkgc+HHukvb6FmxbPsy+SifyY3hyfl2SBz4ND
	xykOEOv4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guZ9n-000481-8X; Fri, 15 Feb 2019 08:47:39 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guZ9j-00046v-Gy
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 08:47:36 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1F8l45F009427;
 Fri, 15 Feb 2019 02:47:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550220424;
 bh=nUJepTBtTwngvi6oNNkiaprUXgTouPzurWm6N7pL0Qo=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=O3bs5ZdHdFbv+U/iFhy82Gb8IBttho4URzllTvOZKrxd4oJYdg2LMGxmLe4QcvFCw
 IgubyvMVV5dJHXBTLW5Uda7LVBLwJAbHWX1INVPG2ra2hDbTmCR7ZFtQp3y4YK9Al3
 9bs8NmysBNV6dseoyR653YpelQ42STajPfBey8Zw=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1F8l47Z111923
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 15 Feb 2019 02:47:04 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 15
 Feb 2019 02:47:02 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 15 Feb 2019 02:47:02 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1F8kx90019290;
 Fri, 15 Feb 2019 02:46:59 -0600
Subject: Re: [PATCH] arm64: dts: ti: k3-am65: Add MSMC RAM node
To: Roger Quadros <rogerq@ti.com>
References: <1547199855-16374-1-git-send-email-rogerq@ti.com>
 <5C5980B6.4010502@ti.com>
From: Tero Kristo <t-kristo@ti.com>
Message-ID: <a2227e9f-dd47-cc33-b0f2-0be682462d36@ti.com>
Date: Fri, 15 Feb 2019 10:46:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <5C5980B6.4010502@ti.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_004735_638036_1AC28725 
X-CRM114-Status: GOOD (  16.58  )
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
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
 Lokesh Vutla <lokeshvutla@ti.com>, linux-kernel@vger.kernel.org,
 "Andrew F . Davis" <afd@ti.com>, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 05/02/2019 14:25, Roger Quadros wrote:
> Tero,
> 
> On 11/01/19 11:44, Roger Quadros wrote:
>> The AM65 SoC has 2MB MSMC RAM. Add this as a mmio-sram
>> node so drivers can use it via genpool API.
>>
>> Following areas are marked reserved:
>> - Lower 128KB for ATF
>> - 64KB@0xf0000 for SYSFW
>> - Upper 1MB for cache
>>
>> The reserved locations are subject to change at runtime by
>> the bootloader.
>>
>> Cc: Nishanth Menon <nm@ti.com>
>> Cc: Lokesh Vutla <lokeshvutla@ti.com>
>> Cc: Andrew F. Davis <afd@ti.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
> 
> Is this patch good to pick for -next?

Queued for 5.1, thanks.

-Tero

> 
> cheers,
> -roger
> 
>> ---
>>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> index 272cf8f..5a18150 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> @@ -6,6 +6,26 @@
>>    */
>>   
>>   &cbass_main {
>> +	msmc_ram: sram@70000000 {
>> +		compatible = "mmio-sram";
>> +		reg = <0x0 0x70000000 0x0 0x200000>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0x0 0x0 0x70000000 0x200000>;
>> +
>> +		atf-sram@0 {
>> +			reg = <0x0 0x20000>;
>> +		};
>> +
>> +		sysfw-sram@f0000 {
>> +			reg = <0xf0000 0x10000>;
>> +		};
>> +
>> +		l3cache-sram@100000 {
>> +			reg = <0x100000 0x100000>;
>> +		};
>> +	};
>> +
>>   	gic500: interrupt-controller@1800000 {
>>   		compatible = "arm,gic-v3";
>>   		#address-cells = <2>;
>>
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
