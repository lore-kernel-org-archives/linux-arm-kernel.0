Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F498C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:43:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE8F9206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KXwO2S/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE8F9206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9Tc5acOpETPnTamUD4MwsckwLKCR5+64sN2LedXuFtY=; b=KXwO2S/fmbFxap
	15PqwO4y96PUhUl3JjS5NiLUwLuG9C56Olmr7/Gcjsr3wcSDJEtJifjW1dTeaCVmviWKQ0p2L+5cd
	PLkQaPnP5e2ZiedftwVwouzNNa/0nOGNG41QQvQVCWogMpWARV7Ml8kD9pseiwoReNyOXbiycrWcD
	Ch9tUAUeVe0mrqz8IvFfgO9Tdh3V5uIQbz/DCJfomRO68IgcTiyQ+4Ey8FGLj8BMlZb1MZi/Lpfj9
	I/VugTkht+mVlJhhwbv5ivcX4F8P1qmeMlP4JOqwDBu+F57jmfYH5s1/WZxqK+whGf5rSomcYDFmS
	HBMkqpFIovzAUxFISE3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghDCK-0001Lk-A3; Wed, 09 Jan 2019 12:43:04 +0000
Received: from smtp3-g21.free.fr ([2a01:e0c:1:1599::12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghDCH-0001KI-1c
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 12:43:03 +0000
Received: from [192.168.108.68] (unknown [213.36.7.13])
 (Authenticated sender: marc.w.gonzalez)
 by smtp3-g21.free.fr (Postfix) with ESMTPSA id DB7B013F8AC;
 Wed,  9 Jan 2019 13:42:29 +0100 (CET)
Subject: Re: [PATCH v1] scsi: ufs: Use explicit access size in ufshcd_dump_regs
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
 Andy Gross <andy.gross@linaro.org>, Jeffrey Hugo <jhugo@codeaurora.org>
References: <3bf7ea8e-4cf2-1f9b-7f46-15609dfcad19@free.fr>
Message-ID: <214700f8-a381-5740-47c0-54923dae60b1@free.fr>
Date: Wed, 9 Jan 2019 13:42:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <3bf7ea8e-4cf2-1f9b-7f46-15609dfcad19@free.fr>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_044301_387328_E59A48AB 
X-CRM114-Status: GOOD (  16.96  )
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
Cc: SCSI <linux-scsi@vger.kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Joao Pinto <jpinto@synopsys.com>, MSM <linux-arm-msm@vger.kernel.org>,
 Avri Altman <avri.altman@wdc.com>, Tomas Winkler <tomas.winkler@intel.com>,
 Vinayak Holikatti <vinholikatti@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Bjorn, Andy, Jeffrey,

What do you think about the patch below?

Regards.

On 11/12/2018 15:18, Marc Gonzalez wrote:

> memcpy_fromio() doesn't provide any control over access size.
> For example, on arm64, it is implemented using readb and readq.
> This may trigger a synchronous external abort:
> 
> [    3.729943] Internal error: synchronous external abort: 96000210 [#1] PREEMPT SMP
> [    3.737000] Modules linked in:
> [    3.744371] CPU: 2 PID: 1 Comm: swapper/0 Tainted: G S                4.20.0-rc4 #16
> [    3.747413] Hardware name: Qualcomm Technologies, Inc. MSM8998 v1 MTP (DT)
> [    3.755295] pstate: 00000005 (nzcv daif -PAN -UAO)
> [    3.761978] pc : __memcpy_fromio+0x68/0x80
> [    3.766718] lr : ufshcd_dump_regs+0x50/0xb0
> [    3.770767] sp : ffff00000807ba00
> [    3.774830] x29: ffff00000807ba00 x28: 00000000fffffffb
> [    3.778344] x27: ffff0000089db068 x26: ffff8000f6e58000
> [    3.783728] x25: 000000000000000e x24: 0000000000000800
> [    3.789023] x23: ffff8000f6e587c8 x22: 0000000000000800
> [    3.794319] x21: ffff000008908368 x20: ffff8000f6e1ab80
> [    3.799615] x19: 000000000000006c x18: ffffffffffffffff
> [    3.804910] x17: 0000000000000000 x16: 0000000000000000
> [    3.810206] x15: ffff000009199648 x14: ffff000089244187
> [    3.815502] x13: ffff000009244195 x12: ffff0000091ab000
> [    3.820797] x11: 0000000005f5e0ff x10: ffff0000091998a0
> [    3.826093] x9 : 0000000000000000 x8 : ffff8000f6e1ac00
> [    3.831389] x7 : 0000000000000000 x6 : 0000000000000068
> [    3.836676] x5 : ffff8000f6e1abe8 x4 : 0000000000000000
> [    3.841971] x3 : ffff00000928c868 x2 : ffff8000f6e1abec
> [    3.847267] x1 : ffff00000928c868 x0 : ffff8000f6e1abe8
> [    3.852567] Process swapper/0 (pid: 1, stack limit = 0x(____ptrval____))
> [    3.857900] Call trace:
> [    3.864473]  __memcpy_fromio+0x68/0x80
> [    3.866683]  ufs_qcom_dump_dbg_regs+0x1c0/0x370
> [    3.870522]  ufshcd_print_host_regs+0x168/0x190
> [    3.874946]  ufshcd_init+0xd4c/0xde0
> [    3.879459]  ufshcd_pltfrm_init+0x3c8/0x550
> [    3.883264]  ufs_qcom_probe+0x24/0x60
> [    3.887188]  platform_drv_probe+0x50/0xa0
> 
> Assuming aligned 32-bit registers, let's use readl, after making sure
> that 'offset' and 'len' are indeed multiples of 4.
> 
> Fixes: ba80917d9932d ("scsi: ufs: ufshcd_dump_regs to use memcpy_fromio")
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
>  drivers/scsi/ufs/ufshcd.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 535180c01ce8..320bbd9849bc 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -112,13 +112,19 @@
>  int ufshcd_dump_regs(struct ufs_hba *hba, size_t offset, size_t len,
>  		     const char *prefix)
>  {
> -	u8 *regs;
> +	u32 *regs;
> +	size_t pos;
> +
> +	if (offset % 4 != 0 || len % 4 != 0) /* keep readl happy */
> +		return -EINVAL;
>  
>  	regs = kzalloc(len, GFP_KERNEL);
>  	if (!regs)
>  		return -ENOMEM;
>  
> -	memcpy_fromio(regs, hba->mmio_base + offset, len);
> +	for (pos = 0; pos < len; pos += 4)
> +		regs[pos / 4] = ufshcd_readl(hba, offset + pos);
> +
>  	ufshcd_hex_dump(prefix, regs, len);
>  	kfree(regs);
>  

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
