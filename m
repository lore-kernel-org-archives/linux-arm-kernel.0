Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9045C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:43:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96B9A2145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AoX5213v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B9A2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lTWt+4qLuGdhYV0NFR7xgufBnqs2EHUs/92Cp895O+4=; b=AoX5213vfWe73B
	wEzWCMQMKihTu3VCZa39Cu9QkWufw8QT/IvlincqJzQrB4dD9B7k2/C8yyPZ53pnc8P96+7YGL6c9
	s1IDUJaGV3T0CqrtNXB6XBDnk6gARycoWxS8DFOYWjVYDBSZtI//+fFjBrG47Nl9gW6UB5QQxiSaj
	DIiF1gfL2K5NVnDVTFHB7Lgc6owxyYTpx+MuMIrQFOv8Wl3CUHVcRSVwzWfmz5mqt26aJaHb1JBm6
	P1KVcDuqZ7I9bXnKzywzR2ugSI10xSDpykDTCt2L7S6eVyKfNokfL4khtn8Pev+kMEiNyfonxZzki
	t3ekJLJIhL6Mtx6as5wA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYrJG-00031x-Ck; Mon, 17 Dec 2018 11:43:42 +0000
Received: from cloudserver094114.home.pl ([79.96.170.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYrJC-00030i-RZ
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 11:43:40 +0000
Received: from 79.184.255.25.ipv4.supernova.orange.pl (79.184.255.25) (HELO
 aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id b62af5eb65ad5666; Mon, 17 Dec 2018 12:43:23 +0100
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Yangtao Li <tiny.windzz@gmail.com>
Subject: Re: [PATCH v4] cpuidle: big.LITTLE: fix refcount leak
Date: Mon, 17 Dec 2018 12:42:59 +0100
Message-ID: <5791255.IEhMFO6dfL@aspire.rjw.lan>
In-Reply-To: <ee49b2fc-f855-4406-8780-0638d5fe09a0@linaro.org>
References: <20181210162641.21029-1-tiny.windzz@gmail.com>
 <ee49b2fc-f855-4406-8780-0638d5fe09a0@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_034339_053799_1E7D4915 
X-CRM114-Status: GOOD (  15.15  )
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
Cc: lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Monday, December 10, 2018 6:00:12 PM CET Daniel Lezcano wrote:
> On 10/12/2018 17:26, Yangtao Li wrote:
> > of_find_node_by_path() acquires a reference to the node
> > returned by it and that reference needs to be dropped by its caller.
> > bl_idle_init() doesn't do that, so fix it.
> > 
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> > ---
> > changes in v4:
> > -update tile
> > -refactor code,suggested by Daniel
> > ---
> >  drivers/cpuidle/cpuidle-big_little.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
> > index db2ede565f1a..b44476a1b7ad 100644
> > --- a/drivers/cpuidle/cpuidle-big_little.c
> > +++ b/drivers/cpuidle/cpuidle-big_little.c
> > @@ -167,6 +167,7 @@ static int __init bl_idle_init(void)
> >  {
> >  	int ret;
> >  	struct device_node *root = of_find_node_by_path("/");
> > +	const struct of_device_id *match_id;
> >  
> >  	if (!root)
> >  		return -ENODEV;
> > @@ -174,7 +175,11 @@ static int __init bl_idle_init(void)
> >  	/*
> >  	 * Initialize the driver just for a compliant set of machines
> >  	 */
> > -	if (!of_match_node(compatible_machine_match, root))
> > +	match_id = of_match_node(compatible_machine_match, root);
> > +
> > +	of_node_put(root);
> > +
> > +	if (!match_id)
> >  		return -ENODEV;
> >  
> >  	if (!mcpm_is_available())
> > 
> 
> 
> 

Patch applied, thanks!



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
