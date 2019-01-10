Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1BCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:42:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A17B1214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JiLUwzvd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A17B1214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hxt-semitech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nyn217g7jrHqRfHdjatnRI8f5UU0YXDET6v738sqBh4=; b=JiLUwzvd99t+U4
	Ot0GO4YdJSNYsN5bJmFnW3bx1VzGZTeVnNjvXDGJn47B91Du3rFpQvZPNbBNNtHbcN+fVLHOG/Pqe
	faJeYmzHtlHRrTyjkjjDONZiuTHX/MUGkVmeq9OVouLNE3yYbqCo2g8T513l2OqIZYq79XrdQjwfz
	cBL7ee1h01SOtwysaJtuEjVTFQoVrtUpAEW7cq03EtG7ucJ6OgKBWWQ+RQJhwo5cczj6CVuRUdfiQ
	NX4m992m+IJs1ZG8s0I7s5wbuCyxCtPYq6UQoFLZ6m/ytHjb0hFk9+6vfLdQCi2OKI9BWD0N471NW
	UUzLGliGazJ//C/TKHuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghWrP-0001KG-UW; Thu, 10 Jan 2019 09:42:47 +0000
Received: from mx01.hxt-semitech.com ([223.203.96.7]
 helo=barracuda.hxt-semitech.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghWrL-0001JC-QE
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 09:42:46 +0000
X-ASG-Debug-ID: 1547113357-093b7e40ef0d260001-tbGyMd
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([10.128.0.15]) by
 barracuda.hxt-semitech.com with ESMTP id K6a7nSiqnbCeoU8t (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
 Thu, 10 Jan 2019 17:42:37 +0800 (CST)
X-Barracuda-Envelope-From: yuanyuan.zhao@hxt-semitech.com
Received: from HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) by
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 10 Jan 2019 17:42:30 +0800
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6]) by
 HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6%12]) with mapi id
 15.00.1395.000; Thu, 10 Jan 2019 17:42:30 +0800
From: "Zhao, Yuanyuan" <yuanyuan.zhao@hxt-semitech.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: RE: [RESEND 1/1] gic: its: Make sure a LPI is discarded before free.
Thread-Topic: [RESEND 1/1] gic: its: Make sure a LPI is discarded before free.
X-ASG-Orig-Subj: RE: [RESEND 1/1] gic: its: Make sure a LPI is discarded
 before free.
Thread-Index: AQHUp+8DksFLG785G0++VUmPBlsY5qWmkCdg//+b1gCAAhBd8A==
Date: Thu, 10 Jan 2019 09:42:28 +0000
Message-ID: <8ebfa53337724799b4b6b2ed8bb06866@HXTBJIDCEMVIW02.hxtcorp.net>
References: <e37e3f5e0146be65c60092a457ca5c82e25581a0.1545292748.git.yuanyuan.zhao@hxt-semitech.com>
 <20190109074324.6445118d@why.wild-wind.fr.eu.org>
 <c81f42aa93904353bbeac590da7b0945@HXTBJIDCEMVIW02.hxtcorp.net>
 <38d7afaf-e800-f6e7-83e3-eb006f4d6f4c@arm.com>
In-Reply-To: <38d7afaf-e800-f6e7-83e3-eb006f4d6f4c@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.65.11.40]
MIME-Version: 1.0
X-Barracuda-Connect: UNKNOWN[10.128.0.15]
X-Barracuda-Start-Time: 1547113357
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.60
X-Barracuda-Spam-Status: No, SCORE=0.60 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=ISO2022JP_CHARSET,
 MARKETING_SUBJECT
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.65452
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.00 ISO2022JP_CHARSET      ISO-2022-JP message
 0.60 MARKETING_SUBJECT      Subject contains popular marketing words
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_014244_190562_B46A2BD4 
X-CRM114-Status: GOOD (  16.50  )
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
Cc: "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>,
 "jason@lakedaemon.net" <jason@lakedaemon.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "Zheng,
 Joey" <yu.zheng@hxt-semitech.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



> -----Original Message-----
> From: Marc Zyngier [mailto:marc.zyngier@arm.com]
> Sent: 2019年1月9日 17:52
> To: Zhao, Yuanyuan <yuanyuan.zhao@hxt-semitech.com>
> Cc: tglx@linutronix.de; jason@lakedaemon.net; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Zheng, Joey
> <yu.zheng@hxt-semitech.com>; Wang, Dongsheng <dongsheng.wang@hxt-
> semitech.com>
> Subject: Re: [RESEND 1/1] gic: its: Make sure a LPI is discarded before free.
> 
> On 09/01/2019 09:29, Zhao, Yuanyuan wrote:
> > Hi Marc:
> >
> > Thank you for your reply.
> >
> > As you said, APIs such as free_irq will deactivate irq before free it.
> > But deactivation is not forced by every API, for example
> > irq_dispose_mapping.  So I think it's better to check that irq was
> > deactivated as expected.
> 
> In general, we should fix the problem at the core API level instead of hacking
> individual drivers.
> 
> But more to the point, irq_dispose_mapping is not supposed to do anything
> with the an active irq, as it doesn't have the required information to safely
> remove it.
> 
> So calling irq_dispose_mapping on an interrupt that still has registered
> actions is a bug, and I'm not convinced we want to cater for such a case. Do
> you have a concrete example of some kernel code expecting this behaviour?
> 
> Thanks,
> 
> 	M.
> 

Most driver use free_irq after register actions, I found this problem by a test case. 
But if this problem happen and the same DeviceID & EventID are reused, 
the freed ITT will be visit which cause delayed kernel panic,
the prev INTs are triggered unexpected, but the new INTs lost.

So I think this check spend less, but gains more.

BRs,
Yuanyuan.


> >
> > BRs,
> > Yuanyuan
> >
> >
> >> -----Original Message-----
> >> From: Marc Zyngier [mailto:marc.zyngier@arm.com]
> >> Sent: 2019年1月9日 15:43
> >> To: Zhao, Yuanyuan <yuanyuan.zhao@hxt-semitech.com>
> >> Cc: tglx@linutronix.de; jason@lakedaemon.net; linux-
> >> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Zheng,
> >> Joey <yu.zheng@hxt-semitech.com>; Wang, Dongsheng
> >> <dongsheng.wang@hxt- semitech.com>
> >> Subject: Re: [RESEND 1/1] gic: its: Make sure a LPI is discarded before free.
> >>
> >> On Wed, 9 Jan 2019 11:53:27 +0800
> >> Zhao Yuanyuan <yuanyuan.zhao@hxt-semitech.com> wrote:
> >>
> >> Hi Zhao,
> >>
> >>> Its device will be removed after all events be freed.
> >>> Undisarded events can lead to unpredictable behaviar.
> >>>
> >>> Signed-off-by: Zhao Yuanyuan <yuanyuan.zhao@hxt-semitech.com>
> >>> ---
> >>>  drivers/irqchip/irq-gic-v3-its.c | 4 ++++
> >>>  1 file changed, 4 insertions(+)
> >>>
> >>> diff --git a/drivers/irqchip/irq-gic-v3-its.c
> >>> b/drivers/irqchip/irq-gic-v3-its.c
> >>> index db20e99..4fee008 100644
> >>> --- a/drivers/irqchip/irq-gic-v3-its.c
> >>> +++ b/drivers/irqchip/irq-gic-v3-its.c
> >>> @@ -2572,6 +2572,10 @@ static void its_irq_domain_free(struct
> >> irq_domain *domain, unsigned int virq,
> >>>  								virq + i);
> >>>  		u32 event = its_get_event_id(data);
> >>>
> >>> +		/* Discard irq before free */
> >>> +		if (irqd_is_activated(d))
> >>> +			its_send_discard(its_dev, event);
> >>> +
> >>>  		/* Mark interrupt index as unused */
> >>>  		clear_bit(event, its_dev->event_map.lpi_map);
> >>>
> >>
> >> But we already do send a discard on deactivate, which logically
> >> happens before we free the domain. So what are you fixing here?
> >>
> >> Thanks,
> >>
> >> 	M.
> >> --
> >> Without deviation from the norm, progress is not possible.
> 
> 
> --
> Jazz is not dead. It just smells funny...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
