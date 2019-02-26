Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC46C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 02:19:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6512E21841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 02:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fZAHf6pu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6512E21841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.panasonic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	From:Subject:To:Message-ID:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XgVJnkd0OucyaTzGcsClPnhFlB+lLlu/u99a8vA3quw=; b=fZAHf6puVvEw44
	hKL/wac7zxTL4zZXHQkaOWn4tG9whgkMLuv1GU6c/CeZ+/lOqBpCcxT/nHXnMe21seBr/SCaJfG36
	lTX+PXfAfwCkvoBo8cQz5wZoz07E7l7hJoNtop8aNCWJDgYB1sOUrv+stF1bgO0e8sa9bbb0pD2CT
	JHg/hw0oAg5tO4k2yW/mBO608nGEUSDJRPq8zBGt8xaWZjMKMbjiOekVSrWkmpCA+M+JOx+V6XA1E
	tUe5xDgQG2ycPNRMe9jjeoFKQCaCzQsIHa3iUb6c1OZeN27bDgw6lTiKY76a/vVUWUREHqLXf6zYx
	qgMZa5ERyk1t+7VObGxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gySLC-0002dL-W3; Tue, 26 Feb 2019 02:19:31 +0000
Received: from smtp.mei.co.jp ([133.183.100.20])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gySL7-0002cu-L8
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 02:19:27 +0000
Received: from mail-gw.jp.panasonic.com ([157.8.1.157])
 by smtp.mei.co.jp (8.14.4/8.14.4/lvzy11) with ESMTP id x1Q2JJoq028851;
 Tue, 26 Feb 2019 11:19:19 +0900
Received: from epochmail.jp.panasonic.com ([157.8.1.130])
 by mail.jp.panasonic.com (8.11.6p2/3.7W/kc-maili13) with ESMTP id x1Q2JJX28671;
 Tue, 26 Feb 2019 11:19:19 +0900
Received: by epochmail.jp.panasonic.com (8.12.11.20060308/3.7W/pml-send2) id
 x1Q2JJ91022984; Tue, 26 Feb 2019 11:19:19 +0900
Received: from jpa000secmn21.palet.jp.panasonic.com [10.74.216.56] 
 by JPA000SGWMN04.palet.jp.panasonic.com with ESMTP id MAA41087;
 Tue, 26 Feb 2019 11:19:19 +0900
Received: from localhost (10.74.216.121) by
 JPA000SECMN21.palet.jp.panasonic.com (10.74.216.56) with Microsoft SMTP
 Server (TLS) id 15.0.1076.9; Tue, 26 Feb 2019 11:19:18 +0900
Date: Tue, 26 Feb 2019 11:19:16 +0900
Message-ID: <20190226.111916.501059283228026708.okuno.kohji@jp.panasonic.com>
To: <festevam@gmail.com>
Subject: Re: [PATCH v2] ARM: imx6q: cpuidle: fix bug that CPU might not
 wake up at expected time
From: Kohji Okuno <okuno.kohji@jp.panasonic.com>
In-Reply-To: <CAOMZO5BzMuWa16d3NOtOFgdBNOCL3YGsYW2s0eGxbnnx8+wdJA@mail.gmail.com>
References: <20190222.174953.431124434951497467.okuno.kohji@jp.panasonic.com>
 <20190226020623.18324-1-okuno.kohji@jp.panasonic.com>
 <CAOMZO5BzMuWa16d3NOtOFgdBNOCL3YGsYW2s0eGxbnnx8+wdJA@mail.gmail.com>
Organization: Panasonic Corporation
X-Mailer: Mew version 6.7 on Emacs 25.2 / Mule 6.0 (HANACHIRUSATO)
MIME-Version: 1.0
X-Originating-IP: [10.74.216.121]
X-ClientProxiedBy: JPA000SECMN43.palet.jp.panasonic.com (10.74.216.87) To
 JPA000SECMN21.palet.jp.panasonic.com (10.74.216.56)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_181925_951690_ABC6C9B2 
X-CRM114-Status: UNSURE (   9.56  )
X-CRM114-Notice: Please train this message.
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
Cc: s.hauer@pengutronix.de, okuno.kohji@jp.panasonic.com, linux-imx@nxp.com,
 kernel@pengutronix.de, fabio.estevam@nxp.com, shawnguo@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Fabio,

Than you for your comment.
Just to be sure, let me check.

Should we change as follows?

-      if (++num_idle_cpus == num_online_cpus()) {
+      num_idle_cpus++
+      if (num_idle_cpus == num_online_cpus()) {

Fabio Estevam <festevam@gmail.com> wrote:
> Hi Kohji,
> 
> On Mon, Feb 25, 2019 at 11:08 PM Kohji Okuno
> <okuno.kohji@jp.panasonic.com> wrote:
> 
>> +       if (++num_idle_cpus == num_online_cpus()) {
>>                 imx6_set_lpm(WAIT_UNCLOCKED);
> 
> You should remove the braces for a single statement inside the if block.
> 
>> -               cpu_do_idle();
>> -               imx6_set_lpm(WAIT_CLOCKED);
>> -               spin_unlock(&master_lock);
>> -               goto done;
>>         }
>> +       spin_unlock(&cpuidle_lock);
>>
>> -idle:
>>         cpu_do_idle();
>> -done:
>> -       atomic_dec(&master);
>> +
>> +       spin_lock(&cpuidle_lock);
>> +       if (num_idle_cpus-- == num_online_cpus()) {
>> +               imx6_set_lpm(WAIT_CLOCKED);
>> +       }
> 
> Same here.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
