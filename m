Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207F6C10F04
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:52:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4408222B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="reHVFsiK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4408222B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LWK18FRwyKtU1cvT65fVGDVM9ciFVBspYK10s8Gfp5A=; b=reHVFsiK0+ES8E
	/lCoGoATx1ryqW6KlGgAvqa8jKZccp8/wWn6AtEqmDalwqQMAWGqBVSTH3iS/M6PE1fAvoUSI23dP
	w3W2ZVtfjoFnlApfxsCWuHlfALelT9AqQnXt6zsoBIj8PfwRSybtlEkgnKTHwebqx1OOeAmun5in/
	jvD8ft2MOTmg0LEl6TzG9QkRXjhhVhJR9ErYEkUX26w72bZVRi1Z7fpqekfIOhZp5o95fAou0CsAK
	O9NtExg5tL3WFU7cpBZIb2lGv5ZwSkbS7czxCRuCBmhKh6EUP/NMw2Rno/BM+Iad+bYWj2WMjOkOg
	ejyzZ/o3XEHbVdWis0nw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guHQm-000530-Ov; Thu, 14 Feb 2019 13:52:00 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guHQj-00051m-QA
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 13:51:59 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0181F80D;
 Thu, 14 Feb 2019 05:51:55 -0800 (PST)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A0943F675;
 Thu, 14 Feb 2019 05:51:53 -0800 (PST)
Subject: Re: [PATCH 2/8] initramfs: free initrd memory if opening
 /initrd.image fails
To: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>
References: <20190213174621.29297-1-hch@lst.de>
 <20190213174621.29297-3-hch@lst.de>
From: Steven Price <steven.price@arm.com>
Message-ID: <e4246b25-628e-de5e-56ba-8d45ad9c9fa6@arm.com>
Date: Thu, 14 Feb 2019 13:51:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190213174621.29297-3-hch@lst.de>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_055157_858451_9A0CE5E3 
X-CRM114-Status: GOOD (  20.93  )
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
Cc: linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, Guan Xuetao <gxt@pku.edu.cn>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 13/02/2019 17:46, Christoph Hellwig wrote:
> We free the initrd memory for all successful or error cases except
> for the case where opening /initrd.image fails, which looks like an
> oversight.

This also changes the behaviour when CONFIG_INITRAMFS_FORCE is enabled -
specifically it means that the initrd is freed (previously it was
ignored and never freed). But that seems like reasonable behaviour and
the previous behaviour looks like another oversight. FWIW:

Reviewed-by: Steven Price <steven.price@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  init/initramfs.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/init/initramfs.c b/init/initramfs.c
> index 7cea802d00ef..1cba6bbeeb75 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -610,13 +610,12 @@ static int __init populate_rootfs(void)
>  		printk(KERN_INFO "Trying to unpack rootfs image as initramfs...\n");
>  		err = unpack_to_rootfs((char *)initrd_start,
>  			initrd_end - initrd_start);
> -		if (!err) {
> -			free_initrd();
> +		if (!err)
>  			goto done;
> -		} else {
> -			clean_rootfs();
> -			unpack_to_rootfs(__initramfs_start, __initramfs_size);
> -		}
> +
> +		clean_rootfs();
> +		unpack_to_rootfs(__initramfs_start, __initramfs_size);
> +
>  		printk(KERN_INFO "rootfs image is not initramfs (%s)"
>  				"; looks like an initrd\n", err);
>  		fd = ksys_open("/initrd.image",
> @@ -630,7 +629,6 @@ static int __init populate_rootfs(void)
>  				       written, initrd_end - initrd_start);
>  
>  			ksys_close(fd);
> -			free_initrd();
>  		}
>  	done:
>  		/* empty statement */;
> @@ -642,9 +640,9 @@ static int __init populate_rootfs(void)
>  			printk(KERN_EMERG "Initramfs unpacking failed: %s\n", err);
>  			clean_rootfs();
>  		}
> -		free_initrd();
>  #endif
>  	}
> +	free_initrd();
>  	flush_delayed_fput();
>  	return 0;
>  }
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
