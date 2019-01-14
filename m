Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCBDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:37:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D72B20656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CWhYPnhH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D72B20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eUKIl+EC/LoyNM4W6oy+05aHFMRUkkW0rTRvbPi7BdE=; b=CWhYPnhH3h03P8CSSt6tU6CIG
	aWkMsPwo8JR8ULbztb5H9oJYT3W3tmOWFYVWegzvLssKp6FUUY69u5FAmNTU0spji/XP3ppvsNIu7
	jvk2OKGDmy2lJ9agH3GNRaLCFJHbIILby5GCCPLUto4OObqvu9h5h+1eF2WmkgMx1JD5nS7yaTqPT
	mIlSRrOYYQ4m2l+/R21OAb+X4rpQjhIgjaqRaxj7ozIwrgxZb26TTrIM5ZQvUMWnlgasCtqBYxm1h
	OmgNGzM5i3lYnNDjm9H5neWafsC9P5E3kva6uzteWp38+QLW1xNS8hbPr7iE2m7IFy3wBmJ5P0TOw
	7wCKcAbbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gizcB-0001xC-2B; Mon, 14 Jan 2019 10:37:07 +0000
Received: from nbd.name ([2a01:4f8:221:3d45::2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gizc6-0001wd-Vl; Mon, 14 Jan 2019 10:37:04 +0000
Subject: Re: [PATCH] netfilter: fix checking method of conntrack helper
To: Henry Yen <henry.yen@mediatek.com>,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 "David S. Miller" <davem@davemloft.net>
References: <1547459983-15724-1-git-send-email-henry.yen@mediatek.com>
From: John Crispin <john@phrozen.org>
Message-ID: <ac699d64-cb0d-8cf2-99cb-54d6da52d6a8@phrozen.org>
Date: Mon, 14 Jan 2019 11:36:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1547459983-15724-1-git-send-email-henry.yen@mediatek.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_023703_171545_1EA41A08 
X-CRM114-Status: GOOD (  19.22  )
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
Cc: Ryder Lee <ryder.lee@mediatek.com>, netdev@vger.kernel.org,
 Sean Wang <sean.wang@kernel.org>, Weijie Gao <weijie.gao@mediatek.com>,
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 14/01/2019 10:59, Henry Yen wrote:
> This patch uses nfct_help() to detect whether an
> established connection needs conntrack helper instead of using
> test_bit(IPS_HELPER_BIT, &ct->status).
>
> The reason is that IPS_HELPER_BIT is only set when using explicit
> CT target.
>
> However, in the case that a device enables conntrack helper via
> command "echo 1 > /proc/sys/net/netfilter/nf_conntrack_helper",
> the status of IPS_HELPER_BIT will not present any change, and
> consequently it loses the checking ability in the context.
>
> Signed-off-by: Henry Yen <henry.yen@mediatek.com>
> Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
Tested-by: John Crispin <john@phrozen.org>
> ---
>   net/netfilter/nft_flow_offload.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
> index 974525eb92df..de4684cc4633 100644
> --- a/net/netfilter/nft_flow_offload.c
> +++ b/net/netfilter/nft_flow_offload.c
> @@ -12,6 +12,7 @@
>   #include <net/netfilter/nf_conntrack_core.h>
>   #include <linux/netfilter/nf_conntrack_common.h>
>   #include <net/netfilter/nf_flow_table.h>
> +#include <net/netfilter/nf_conntrack_helper.h>
>   
>   struct nft_flow_offload {
>   	struct nft_flowtable	*flowtable;
> @@ -71,6 +72,7 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
>   	struct flow_offload *flow;
>   	enum ip_conntrack_dir dir;
>   	struct nf_conn *ct;
> +	const struct nf_conn_help *help;
>   	int ret;
>   
>   	if (nft_flow_offload_skip(pkt->skb))
> @@ -88,7 +90,8 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
>   		goto out;
>   	}
>   
> -	if (test_bit(IPS_HELPER_BIT, &ct->status))
> +	help = nfct_help(ct);
> +	if (help)
>   		goto out;
>   
>   	if (ctinfo == IP_CT_NEW ||

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
