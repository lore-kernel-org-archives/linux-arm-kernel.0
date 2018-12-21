Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D50C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 00:33:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54696217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 00:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CBk/Bjzd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NwKnrSXn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54696217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:Date:Message-ID:
	In-Reply-To:To:From:Subject:Mime-Version:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hWZj+3k8D6XXxug4GfBRlOCkPW6H7Pt32+jpCwg1kBA=; b=CBk/BjzdVwIP86
	Q8o+ff4tWg7D/0f3vHgoLD62JWkhqM+IVbs/Rtnu0fJqzXT/6q4Z890V0R1r4AiNMV5uzRYWleMBM
	1akEdB+THyUM8/Vaa0yGhs3KfWHX7OnaSrXzwTYKQs/i8YO3gbyDlB5ZOg5RcO7GfAGpCXEAabW9u
	tJxh/c3Gmd5sbaDPhIxp9xWjSAnnTulpy+EtuiZ8j9TJ2fUzcPhDiUZ+Ft9ArcE1/dE6DrhuM8F0W
	ersLQBjjOSDb3HWaKjxwrdpALXDzYxxU53Ms6/JH5KizNypSJGftv00Ql4GXttU0vIozeeJuLSSzy
	cy4FeC2uiIZ87+BpEhfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga8ku-0003hC-AX; Fri, 21 Dec 2018 00:33:32 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga8kp-0003cg-U2
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 00:33:30 +0000
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20181221003311epoutp029184140333d77dc354250d7203b39553~yMdAIUJgi3121031210epoutp02g
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 00:33:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20181221003311epoutp029184140333d77dc354250d7203b39553~yMdAIUJgi3121031210epoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1545352391;
 bh=7dtocj51qYu8hNBeOSL3dkVqRxypPh57FOVK2N4+jlk=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=NwKnrSXnKhSGnB960JtCGO9MZBYfG7yTYJRbjCMl4ubalhTcSjVfH5/vxbvu6YYi8
 JF91EVbcGSJP+gVCN7ZDjtpORePcOqlArss4kfoFecADob+DO7lLbA8KqYWGZIYWQN
 hHhXrt6EQ77VBZW6+w+eWLYWr5LA0wt+DohWI8tM=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.155]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20181221003306epcas1p3213e28f4c5fb4f5ae0e1497893af23af~yMc7Jj7lH0603906039epcas1p32;
 Fri, 21 Dec 2018 00:33:06 +0000 (GMT)
X-AuditID: b6c32a36-d19ff70000000fd9-67-5c1c34c27094
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 F4.11.04057.2C43C1C5; Fri, 21 Dec 2018 09:33:06 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH v3 4/5] drivers: power: suspend: call devfreq
 suspend/resume
From: MyungJoo Ham <myungjoo.ham@samsung.com>
To: Lukasz Luba <l.luba@partner.samsung.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org"
 <linux-samsung-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <ce1d415d-2a00-ef0e-6b58-23d16cffee4a@partner.samsung.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20181221003305epcms1p756d76191d5f233c6e3238400d233b3c6@epcms1p7>
Date: Fri, 21 Dec 2018 09:33:05 +0900
X-CMS-MailID: 20181221003305epcms1p756d76191d5f233c6e3238400d233b3c6
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkl+LIzCtJLcpLzFFi42LZdlhTT/eQiUyMQecTfouDWzUtNs5Yz2qx
 feM3VovrX56zWsw/co7VonnxejaLM925Fv2PXzNbnD+/gd3ibNMbdotbDTIWs6bsZbLY9Pga
 q8XlXXPYLD73HmG0mHF+H5PF2iN32S2WXr/IZHH31FGg9tOXWC1a9x5ht2hb/YHV4s2FeywO
 4h7bdm9j9Vgzbw2jx+yGiyweE/o/MXos3vOSyWPTqk42j/1z17B7bF5S7/HvGLvHwXd7mDy2
 XG1n8ejbsorRY8Xq7+wenzfJBfBFZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqY
 KynkJeam2iq5+AToumXmAL2vpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySmwLNAr
 TswtLs1L10vOz7UyNDAwMgUqTMjOOPewnaVgLXfFka//WRoY93N2MXJwSAiYSMw/atHFyMUh
 JLCDUaJt4l1mkDivgKDE3x3CXYycHMICYRL3Th5hBLGFBJQkGm7uY4aI60t0PNgGFmcT0JXY
 uuEuC8gcEYFGZokle76wgjjMApPZJGY9a2ADqZIQ4JWY0f6UBcKWlti+fCtYN6eAu0TH11NQ
 cVGJm6vfssPY74/NZ4SwRSRa751lhrAFJR783A0Vl5J48nYhVH21xKOei8wgiyUEWhglVs3c
 xgSR0Jc4M/ck2BG8Ar4SF48+B7NZBFQlHs3tZ4WEhIvEzMtpIGFmAXmJ7W/ngAOCWUBTYv0u
 fYgwn8S7rz2sMK/smPcEarqaxKHdS6BOkJE4PX0h1JkeEk/vPWCGBO4EJok7Fz6yT2CUn4UI
 31lIts1C2LaAkXkVo1hqQXFuemqxYYERcoxuYgQnfy2zHYyLzvkcYhTgYFTi4b2wXTpGiDWx
 rLgy9xCjBAezkghvKYtMjBBvSmJlVWpRfnxRaU5q8SFGU6CfJzJLiSbnAzNTXkm8oamRsbGx
 hYmhmamhoZI47xOpudFCAumJJanZqakFqUUwfUwcnFINjF6/v5fPVl9r/TM5bfcap615cTP3
 5UX+ON/DK6DdraPo/Yx/ldzlbWxONZejzu6bxnXXfH/K2gKZpzd5+Tpizr/Zbjs7WbwrT2zy
 S8bAe3ZX/xk2P7z7pES4fs6MGdc9Wd0eKHiETrsWlLVaSZQnokxzgjyvSSXrujz9zdsPXe4+
 dPy1vfONciWW4oxEQy3mouJEAPoMnEIUBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181205110623eucas1p120f9d8b38822bf856a5b7d427d00e49f
References: <ce1d415d-2a00-ef0e-6b58-23d16cffee4a@partner.samsung.com>
 <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com>
 <1544007956-28889-5-git-send-email-l.luba@partner.samsung.com>
 <CGME20181205110623eucas1p120f9d8b38822bf856a5b7d427d00e49f@epcms1p7>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_163328_134333_4A1B9332 
X-CRM114-Status: GOOD (  21.37  )
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
Reply-To: myungjoo.ham@samsung.com
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "len.brown@intel.com" <len.brown@intel.com>,
 "tony.luck@intel.com" <tony.luck@intel.com>,
 "keescook@chromium.org" <keescook@chromium.org>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "anton@enomsg.org" <anton@enomsg.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "krzk@kernel.org" <krzk@kernel.org>,
 "tjakobi@math.uni-bielefeld.de" <tjakobi@math.uni-bielefeld.de>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "kgene@kernel.org" <kgene@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>,
 "ccross@android.com" <ccross@android.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

>On 2018-12-05 12:05, Lukasz Luba wrote:
>> Devfreq framework supports suspend of its devices.
>> Call the the devfreq interface and allow devfreq devices preserve/restore
>> their states during suspend/resume.
>>
>> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>

This looks all good to me.

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

>> ---
>>  drivers/base/power/main.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
>> index a690fd4..0992e67 100644
>> --- a/drivers/base/power/main.c
>> +++ b/drivers/base/power/main.c
>> @@ -32,6 +32,7 @@
>>  #include <trace/events/power.h>
>>  #include <linux/cpufreq.h>
>>  #include <linux/cpuidle.h>
>> +#include <linux/devfreq.h>
>>  #include <linux/timer.h>
>>  
>>  #include "../base.h"
>> @@ -1078,6 +1079,7 @@ void dpm_resume(pm_message_t state)
>>  	dpm_show_time(starttime, state, 0, NULL);
>>  
>>  	cpufreq_resume();
>> +	devfreq_resume();
>>  	trace_suspend_resume(TPS("dpm_resume"), state.event, false);
>>  }
>>  
>> @@ -1852,6 +1854,7 @@ int dpm_suspend(pm_message_t state)
>>  	trace_suspend_resume(TPS("dpm_suspend"), state.event, true);
>>  	might_sleep();
>>  
>> +	devfreq_suspend();
>>  	cpufreq_suspend();
>>  
>>  	mutex_lock(&dpm_list_mtx);

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
