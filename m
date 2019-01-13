Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FF8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 15:40:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7FE020675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 15:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oJmBo5DL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qT9Ntmu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7FE020675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2Ok6R8vrtbdQ/vKSxzm6TgNnkE9sBZF4QcyXklt2og4=; b=oJmBo5DLQCJqyX
	z4+r5Fbg+rbCJwVUkJ5fy2BqkhetnDsSfsPX401SYKwM+Ppkzg9Sr5LJX/vnx8l9OwAEuzcT+ELC8
	vZhaSCI+Tsf/4c7jAQwEsdYHXSZW242zYiou7Pk13fwl6DiVAxop5SHcUqb0Lss1rNpUjt2WNtDNB
	K6jw5EZ/8U1rBguI94KZcs8046m+H/VZ10Ib0NQeH0jEowEoh6RytpbyHa5ZGAHkqYqUVe6abrJLa
	rjT+8EBHVAaPIUgq7ECae/zjq7bFx+agAVvkePlJV1IH6jL/+T5DjkK4JlMf6/tONOGgsgaMc2ONg
	cVuwSg9av55HrFIpiR5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gihsV-00071L-HB; Sun, 13 Jan 2019 15:40:47 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gihsS-0006zt-IX
 for linux-arm-kernel@lists.infradead.org; Sun, 13 Jan 2019 15:40:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; 
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
 bh=Lld8vr13ypBCxHW8tq5dy9vDbUx+fb5D5jHr8CTg+Wc=; 
 b=qT9Ntmu02+4GePzG3AuZxhz1y8DD642M2Xl0bQb++WocJkGi1VQYjAlEBZP/al+cPba/gmRsbI4vdgNaO8+0NSn1KbcybL7VrE0MF+rNwDFTafS3m9Iw4tgSOph/0/TcRSvJewxImJjBDjf4kYmjcB3AplqvSOOTTTcI9xRp5og=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
 (envelope-from <andrew@lunn.ch>)
 id 1gihsC-0002uh-JC; Sun, 13 Jan 2019 16:40:28 +0100
Date: Sun, 13 Jan 2019 16:40:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH 2/2] PCI: armada8k: don't toggle reset twice
Message-ID: <20190113154028.GB4635@lunn.ch>
References: <024cc24efa7b99186750f90c91880b29357d379d.1547123182.git.baruch@tkos.co.il>
 <94cd23a60c647020dd87a923684b59255b89f02c.1547123182.git.baruch@tkos.co.il>
 <20190110125548.GA29612@lunn.ch> <8736q0irwy.fsf@tarshish>
 <20190110131912.GB29612@lunn.ch> <87zhs8h5ej.fsf@tarshish>
 <87pnt0vil3.fsf@tarshish>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87pnt0vil3.fsf@tarshish>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_074044_763194_4CA9E66B 
X-CRM114-Status: UNSURE (   9.20  )
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
Cc: linux-pwm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Sven Auhagen <sven.auhagen@voleatech.de>, Jason Cooper <jason@lakedaemon.net>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-pci@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> Another look at this comment made me realize that we need comphy
> initialization support in the kernel for PCIe reset to work correctly.
> 
> The workaround that this patch proposes will not solve the problem for
> v5.0, since the GPIO get_direction patch will only appear in v5.1.

You could ask for it to be applied to v5.0 since a real fix depends on
it.

We have a bit of a balancing act to sort out. The revert will fix
Macchiatobin. But i assume it breaks some other platforms which just
started to work. Ideally we want the best of both worlds. So maybe
getting the GPIO change into stable is the correct thing to do?

	Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
