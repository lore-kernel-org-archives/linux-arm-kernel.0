Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B89C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:01:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F20462087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kNDZHx67";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyKFB4dj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F20462087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+VWZvV1TN86fiC3ij3tiqhXl8zzZRGqjQ5xTalg05CM=; b=kNDZHx67GnMFnL
	4myok6awikGJG6qZnRhNJ9JjhfVR82YbmxPWFYIK82Jala36yrG74Vr/mxHE9s78IUF9B9isgiptx
	tjysuB9BdItBCwQx3VE0l+4F3QWc/klk/OzbLFyh4ljBOE1dgeIyUuIHxigEkSH4uUihMqhDrAP9V
	6Vm8VizG1UpqheM0CoCl6bw28VlEnsQy4F00liMAS1T724N5ehjAnLKTgN9F6GnSU0kJ41+7L++w6
	IDzBE0jroWmBvOyzkPBwfOW9kOw6OFcj8ULSiRxfCdZZwtIW35p0sRnVe+njSwQtFYMSYfyvo0z+e
	MSlpkxESk0CzuYE+E3Jw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfQyA-00004y-OP; Fri, 04 Jan 2019 15:01:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfQy7-0008W2-1Y
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 15:01:04 +0000
Received: from localhost (unknown [171.76.109.220])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D853A2087F;
 Fri,  4 Jan 2019 15:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546614062;
 bh=/zwwNu++gfkmKjPWwxQJjZZPc5F2wQfM4f/iVJ3vzEk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gyKFB4dj0IIAk7hKnjzC5TziXU43j8Q0TLIqSlYzJaDRGW76YaanJ20jDX6dwn1Jr
 XWyFXTSAznXRI/EYpYsZrp5E8t8QE+9zM1HD14QdvFFHnK3cyAVs+xpr8gSbopl8CY
 SMGpPiCRoNvTwQLhQDTp8PSzgz69Dzcmd14sjbBU=
Date: Fri, 4 Jan 2019 20:29:24 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Andrea Merello <andrea.merello@gmail.com>
Subject: Re: [PATCH v6 1/7] dmaengine: xilinx_dma: commonize DMA copy size
 calculation
Message-ID: <20190104145924.GG13372@vkoul-mobl.Dlink>
References: <20181120153151.18024-1-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181120153151.18024-1-andrea.merello@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_070103_106063_0F2DF071 
X-CRM114-Status: UNSURE (   8.50  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 radhey.shyam.pandey@xilinx.com, linux-kernel@vger.kernel.org,
 michal.simek@xilinx.com, robh+dt@kernel.org, appana.durga.rao@xilinx.com,
 dmaengine@vger.kernel.org, dan.j.williams@intel.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 20-11-18, 16:31, Andrea Merello wrote:
> This patch removes a bit of duplicated code by introducing a new
> function that implements calculations for DMA copy size, and
> prepares for changes to the copy size calculation that will
> happen in following patches.

Applied all, thanks
-- 
~Vinod

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
