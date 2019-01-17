Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335E9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:14:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 051F520855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lfRKoMvA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051F520855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:
	References:Message-ID:Subject:To:From:Date:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Q4Pv0nD+IimvXbbY6q8yitX+fl2dVk4NhRgs+oTYt84=; b=lfRKoMvAHIktOE
	6S1qh3oe6mkTiT5QIFMkSSscqLAOyFFOEa9TdiwN6PtZvhJX92qQHlxdLKDReJyQi7KDt943a/c87
	cFtA2TX2yaXYNBreSdlCliwW9EDwxDIO9slNKOoAZDJaDIf/4SetvxkDBGUOel51MHjnWmI4i5QiH
	VhnOgTRyqJYl06m4dvTt6h5cKkbb8cNcbX4xRAk4v12iW/8wjz5VX7QvvQAosIY1FaaB/CsFV6Vl2
	KzN+a1pGVRU6zAq7+Rgolv2oXN/spdLGgTcttIEZjQAdpY9Z6UW1ZKpPnhXWS63B0Co/2dPAnrc8z
	bDkXGPJTsDMUhqzwXHjg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkEza-0003OI-AY; Thu, 17 Jan 2019 21:14:26 +0000
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkEzW-0003Nv-5T
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 21:14:23 +0000
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
 by mx0a-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0HL781g016458; Thu, 17 Jan 2019 21:14:13 GMT
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
 by mx0a-002e3701.pphosted.com with ESMTP id 2q2vemtr6x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Jan 2019 21:14:13 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net
 [16.196.225.135])
 by g2t2352.austin.hpe.com (Postfix) with ESMTP id F0359A7;
 Thu, 17 Jan 2019 21:14:11 +0000 (UTC)
Received: from anatevka (anatevka.americas.hpqcorp.net [10.34.81.61])
 by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id B6FC336;
 Thu, 17 Jan 2019 21:14:10 +0000 (UTC)
Date: Thu, 17 Jan 2019 14:14:10 -0700
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: Guenter Roeck <groeck@google.com>
Subject: Re: [PATCHv2] watchdog: qcom: Add suspend/resume support
Message-ID: <20190117211410.GA30749@anatevka>
References: <20190117151942.6092-1-saiprakash.ranjan@codeaurora.org>
 <154775022743.169631.1716489383315213219@swboyd.mtv.corp.google.com>
 <CABXOdTfE+_q8DrRfPE1V+3pU7x5rLoOy7k5LYMrwd+xojsBWvw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CABXOdTfE+_q8DrRfPE1V+3pU7x5rLoOy7k5LYMrwd+xojsBWvw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-17_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901170147
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_131422_315528_F8B1E600 
X-CRM114-Status: GOOD (  22.31  )
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
Reply-To: Jerry.Hoemann@hpe.com
Cc: linux-arm-kernel@lists.infradead.org,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Rajendra Nayak <rnayak@codeaurora.org>, linux-watchdog@vger.kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Doug Anderson <dianders@chromium.org>, Stephen Boyd <swboyd@chromium.org>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 17, 2019 at 11:09:31AM -0800, Guenter Roeck wrote:
> On Thu, Jan 17, 2019 at 10:37 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Sai Prakash Ranjan (2019-01-17 07:19:42)
> > > diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> > > index 780971318810..5dfd604477a4 100644
> > > --- a/drivers/watchdog/qcom-wdt.c
> > > +++ b/drivers/watchdog/qcom-wdt.c
> > > @@ -245,6 +245,28 @@ static int qcom_wdt_remove(struct platform_device *pdev)
> > >         return 0;
> > >  }
> > >
> > > +static int __maybe_unused qcom_wdt_suspend(struct device *dev)
> > > +{
> > > +       struct qcom_wdt *wdt = dev_get_drvdata(dev);
> > > +
> > > +       if (watchdog_active(&wdt->wdd))
> > > +               qcom_wdt_stop(&wdt->wdd);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int __maybe_unused qcom_wdt_resume(struct device *dev)
> > > +{
> > > +       struct qcom_wdt *wdt = dev_get_drvdata(dev);
> > > +
> > > +       if (watchdog_active(&wdt->wdd))
> > > +               qcom_wdt_start(&wdt->wdd);
> > > +
> > > +       return 0;
> > > +}
> >
> > This looks fairly generic. For example, the Mediatek driver also stops
> > and starts (but also pings after starting). Grepping for 'active' in
> > drivers/watchdog/ finds more examples. Could there be some functions in
> > watchdog core that do the common things like watchdog_stop() and
> > watchdog_start() and watchdog_start_and_ping()? Or maybe a bit can be
> > set during registration so that the 'struct class watchdog_class' can
> > get PM ops to stop and start on suspend/resume of the watchdog character
> > device?
> >
> > Nothing is wrong with the patch, I'm just bemoaning the amount of code
> > duplication here.
> >
> 
> Patch(es) to add the functionality to the watchdog core are welcome;
> it should be possible to move the functionality into the core (maybe
> to be enabled with a new watchdog API call). Doing it using the class
> device sounds like an excellent idea. This should be straightforward
> to implement, though the question of "should we ping on resume or not"
> might be an endless source for bike shedding fun.
> 
> Guenter

It could be controlled by a currently unused bit in the
watchdog_info.options.  Then people can agree to disagree.



-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
