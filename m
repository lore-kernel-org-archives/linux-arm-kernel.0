Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEF3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:33:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 201DF21848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S/k+0kj5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 201DF21848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M8VqrYoPQ/+Bg9ouXEW1MY8RG3fUlXcZMf0nYKCjpcE=; b=S/k+0kj5Xb8WT+
	fBokc7J5t2bRvvU05K1pbfK4VlsvitiSuw2FN9voCepACHRMrxdWop4WIb1OlB695ursvdPGshzLi
	LuKG3PQ3cWMKGkol2XCbusOiUyuuB+EX1u/zEN27TmIIa8TqmSmCFdPN5DBwscDn3QrALfTMpgmRj
	GDYiDKQ8Q8EYbZPzZQbGaLfzloZUUJkgCz7PIfnDpdT9mG4OgmKJA5usloRbW0O6Q7c6C0c+XCy2N
	OLOLe49JE0DAoM5F1sicM1PsySF0BwbqXwYqzdRs13E/KIqy7LfOo/UlFiS03TGt1oJ861GouJBR0
	0tnl/GjgUYYInJDSQS5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvsPc-0007bI-AE; Mon, 18 Feb 2019 23:33:24 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvsPZ-0007aQ-Na
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 23:33:23 +0000
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 69E9212E4E2D5;
 Mon, 18 Feb 2019 15:33:13 -0800 (PST)
Date: Mon, 18 Feb 2019 15:33:10 -0800 (PST)
Message-Id: <20190218.153310.393264778478086662.davem@davemloft.net>
To: vlomovtsev@marvell.com
Subject: Re: [PATCH v2 3/8] net: thunderx: make CFG_DONE message to run
 through generic send-ack sequence
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190218095159.3847-4-vlomovtsev@marvell.com>
References: <20190218095159.3847-1-vlomovtsev@marvell.com>
 <20190218095159.3847-4-vlomovtsev@marvell.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Mon, 18 Feb 2019 15:33:13 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_153321_772462_C454D22B 
X-CRM114-Status: UNSURE (   9.03  )
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
Cc: rric@kernel.org, netdev@vger.kernel.org, dnelson@redhat.com,
 linux-kernel@vger.kernel.org, sgoutham@cavium.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Vadim Lomovtsev <vlomovtsev@marvell.com>
Date: Mon, 18 Feb 2019 09:52:14 +0000

> @@ -169,6 +169,20 @@ static int nicvf_check_pf_ready(struct nicvf *nic)
>  	return 1;
>  }
>  
> +static int nicvf_send_cfg_done(struct nicvf *nic)
> +{
> +	union nic_mbx mbx = {};
> +
> +	mbx.msg.msg = NIC_MBOX_MSG_CFG_DONE;
> +	if (nicvf_send_msg_to_pf(nic, &mbx)) {
> +		netdev_err(nic->netdev,
> +			   "PF didn't respond to CFG DONE msg\n");
> +		return 0;
> +	}
> +
> +	return 1;
> +}
 ...
> @@ -1515,8 +1528,7 @@ int nicvf_open(struct net_device *netdev)
>  		nicvf_enable_intr(nic, NICVF_INTR_RBDR, qidx);
>  
>  	/* Send VF config done msg to PF */
> -	mbx.msg.msg = NIC_MBOX_MSG_CFG_DONE;
> -	nicvf_write_to_mbx(nic, &mbx);
> +	nicvf_send_cfg_done(nic);

If the one and only call site doesn't even bother to check the return
value, just make it return void.

Thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
