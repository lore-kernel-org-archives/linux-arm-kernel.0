Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0544C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:39:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82EC320672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r+3Ak7Ak";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="euHSpLNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82EC320672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8NoORbyQ5bZxi1HR7P7QKESSxXxdYkftdVA/MAorXtA=; b=r+3Ak7AkW85RkT
	ZFJ1nUkMxTmcm7/bq8yI8+9OVtWeXAUHV+1XZisRXPgWRbxePWwaOF0CsXc2KwSM+yR0lJWTDO8Ok
	zP8D802mwdIU/yFpvYNGktGM++KXP77h3tL2sNGaUsQ5UunbkeY+1NecNvlNaCcS7+YV7ablNbVq1
	CIgMMUcxQ1BbZtFBCAnG74gqaOAYo7moDzaZtsKFlC+6rQ4+fCvP8+qK46x5VtQqqxiZukFNMW0fz
	Y71u8nQqscYBjBh8vvSD/gIwGIrqq0ApVZnGjs8NW1+ahRLPqYTZZRokp0YgONzX04U8GzVuu5q3w
	piK8sWWTdoGQwSvC2zCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVIDk-0003O3-Kc; Fri, 07 Dec 2018 15:39:16 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVIDh-0003Nb-RJ
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 15:39:15 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9E0E220672;
 Fri,  7 Dec 2018 15:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544197143;
 bh=dtP0TpUG4AYsA0L3w4YvqcC+JY7x9eY9bRkmjiW0ZJw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=euHSpLNq8owsZcV4aHsWfRVdt8HOkIWYcEiP0WItnJy+E4iU2O+Qq1YgKQim23BGp
 cZVsEQrPqPi7KjLfs09G4I9/YpOkolx7j6zzJjd6rBolIpi4Q4sMhrrMHw2HBniXk3
 JNztdNyt8B/tI949p8Akw/7iRYpLIoC4A9i6tkvc=
Date: Fri, 7 Dec 2018 16:39:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 01/10] mailbox: Support blocking transfers in atomic
 context
Message-ID: <20181207153901.GA29185@kroah.com>
References: <20181112151853.29289-1-thierry.reding@gmail.com>
 <20181112151853.29289-2-thierry.reding@gmail.com>
 <0545f5e1-1740-2129-9d0e-5c950bd9bf74@nvidia.com>
 <CABb+yY1u24JYO68f74qSJ1RpqidJ4H7cnP1Sy=RdqcBHru5XQg@mail.gmail.com>
 <20181129152312.GB23750@ulmo>
 <CABb+yY1G+6MQmrSeZvOXnuREB87+DYHGxNu1tBb9W6apizLtGw@mail.gmail.com>
 <20181207113245.GA30719@ulmo>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181207113245.GA30719@ulmo>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_073913_897209_90E9F1DE 
X-CRM114-Status: GOOD (  16.59  )
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
Cc: Devicetree List <devicetree@vger.kernel.org>,
 Jassi Brar <jassisinghbrar@gmail.com>, mliljeberg@nvidia.com,
 Mikko Perttunen <mperttunen@nvidia.com>, talho@nvidia.com,
 linux-serial@vger.kernel.org, jslaby@suse.com, linux-tegra@vger.kernel.org,
 ppessi@nvidia.com, Jon Hunter <jonathanh@nvidia.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 07, 2018 at 12:32:45PM +0100, Thierry Reding wrote:
> Greg,
> 
> any ideas on how we can move forward here? For reasons given elsewhere
> in this thread I understand that there is no way to make the console
> code run in non-atomic context. Have you ever run into a case where the
> console driver couldn't busy-loop? Were there any solutions to this?

I don't know of any such cases, hardware sucks at times, and we just
have to deal with getting it to work by doing stuff like this :(

> I've looked through quite a few drivers and they all end up with a busy
> loop, waiting for the transmission FIFO to become empty. There are also
> a few implementations for hypervisors that call back into some firmware
> in order to send the characters, but I expect those to do the busy
> looping in the firmware.

busy loops are ok here, as you point out.

> Perhaps the most prominent case that I came across and that is quite
> similar to this discussion is netconsole. There's a lot of code in the
> network layer that exists only to allow using a network device for
> outputting a console. I don't think the changes to the mailbox
> framework are anywhere near as complicated.

Neither do I, I have no objection to your changes at all.

thanks,

greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
