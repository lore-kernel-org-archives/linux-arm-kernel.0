Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E3CC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:39:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C047620850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ohtUarnZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C047620850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SnCmdOboTqmniSdfxyKR1+jyiLscwTL4VEqBP5v8Opk=; b=ohtUarnZmBrHHB
	sV0ENCO+7AP0rYfu6g0AJGmG63dqjlCkr7saP/4kBraDXwqj05nfNDnjL5iZLxbwKDKmzjoDiBOeI
	l16x+B8p2tYAANZgYoK0W0mAkER6R0rP83w4kXobKhje8xKAhyy6Aq31UqGD3DlieZQG6v/rknk0t
	8jscRNYDnH49AE3H3otX+V1xVJcUWvm/mqkLTOyTIlMZa/BQCe8m0qBVoivM85Ow/hVqtaidVVKF/
	zCi/bN1EdVHN/Qs1qyK41Zky2ei/xvR1dXLKpdTzToHMGIHCHQsVz1vIKgRR4Pujsa/1+/rPrdOtQ
	2Jlqqgrg32fc2CdeCfvA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUYL6-0004pw-0F; Wed, 05 Dec 2018 14:39:48 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUYKp-0004Mv-2C
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 14:39:34 +0000
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DED51C057F9F;
 Wed,  5 Dec 2018 14:39:19 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.29])
 by smtp.corp.redhat.com (Postfix) with SMTP id 8ED47261B0;
 Wed,  5 Dec 2018 14:39:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
 oleg@redhat.com; Wed,  5 Dec 2018 15:39:19 +0100 (CET)
Date: Wed, 5 Dec 2018 15:39:14 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH v2] Uprobes: Fix kernel oops with delayed_uprobe_remove()
Message-ID: <20181205143914.GB9535@redhat.com>
References: <20181204005803.787578e7@vmware.local.home>
 <20181205033423.26242-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181205033423.26242-1-ravi.bangoria@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Wed, 05 Dec 2018 14:39:20 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_063931_596445_E5A243BE 
X-CRM114-Status: GOOD (  11.80  )
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
Cc: linux-mips@linux-mips.org, srikar@linux.vnet.ibm.com, peterz@infradead.org,
 jolsa@redhat.com, ralf@linux-mips.org, liu.song.a23@gmail.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org, linux@armlinux.org.uk,
 alexander.shishkin@linux.intel.com, paul.burton@mips.com, mingo@redhat.com,
 mhiramat@kernel.org, ananth@linux.vnet.ibm.com, namhyung@kernel.org,
 naveen.n.rao@linux.vnet.ibm.com, alexis.berlemont@gmail.com, acme@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/05, Ravi Bangoria wrote:
>
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -572,7 +572,9 @@ static void put_uprobe(struct uprobe *uprobe)
>  		 * gets called, we don't get a chance to remove uprobe from
>  		 * delayed_uprobe_list from remove_breakpoint(). Do it here.
>  		 */
> +		mutex_lock(&delayed_uprobe_lock);
>  		delayed_uprobe_remove(uprobe, NULL);
> +		mutex_unlock(&delayed_uprobe_lock);
>  		kfree(uprobe);

Acked-by: Oleg Nesterov <oleg@redhat.com>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
