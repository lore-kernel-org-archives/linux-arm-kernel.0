Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994E2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:27:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67A5C20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="czpwM+5f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67A5C20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Pamtu2vFL+QnIESrADepQmQzTqNkv1yXy6mN5XSpbZE=; b=czpwM+5fbEk11K
	ieyECd9DfvjwtPaNZFPPplqrJoOryyolJLHTsOFIn9sGoj4eDSRxHYGFoyeb3VTf4QyXv2MswS3z0
	LR5nsf0P7P6pjQsUC+nBjx65FvyfdWePm9jYLhmrA6a2wNTIdQFCKxprltChf5sHccHZorpz7tuTi
	eOXJzwb8/OgWWTU2dvZ3UD3nZlj4UFQ/71DQjBGo2PepyzAk/4ue7UDe9MfyT9vlZrEIYVGsZ2T9K
	TDlvwxSZjGkj/lrISw6utnexbktOTNwgYwqUElYZ/ngZBTi4bb6mxzqqGlb1lfcDgpJ9x4GKAQ/4a
	kjZXHbZScvDoYcin8IPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk4tn-0006Go-3g; Thu, 17 Jan 2019 10:27:47 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk4tj-0006Fu-96
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 10:27:44 +0000
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3B429CCB86;
 Thu, 17 Jan 2019 10:27:41 +0000 (UTC)
Received: from ming.t460p (ovpn-8-27.pek2.redhat.com [10.72.8.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DF8F25C7B7;
 Thu, 17 Jan 2019 10:27:02 +0000 (UTC)
Date: Thu, 17 Jan 2019 18:26:58 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [BUG bisect] kernel BUG at block/bio.c:1833 and fail to mount disk
Message-ID: <20190117102657.GB20220@ming.t460p>
References: <CAJKOXPdQaxKH3z3yMBggP3dAFJ3ecgCcHk=bGaVHZ-Q+V2Riug@mail.gmail.com>
 <CAJKOXPd2WiMC8uc1YuyR+_vEScSewMzQe1Y7UGHgxvkCD+tQ7A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJKOXPd2WiMC8uc1YuyR+_vEScSewMzQe1Y7UGHgxvkCD+tQ7A@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 17 Jan 2019 10:27:41 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_022743_340930_47F9C30C 
X-CRM114-Status: GOOD (  18.02  )
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
Cc: Jens Axboe <axboe@kernel.dk>,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org,
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
 Omar Sandoval <osandov@fb.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 16, 2019 at 09:54:05AM +0100, Krzysztof Kozlowski wrote:
> On Wed, 16 Jan 2019 at 09:52, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > Hi,
> >
> > On today's next-20190116 I see a bug during boot:
> > [ 6.843308] kernel BUG at ../block/bio.c:1833!
> > [ 6.847723] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
> > ...
> > [ 7.543824] [<c044c144>] (bio_split) from [<00000000>] ( (null))
> > [ 7.549881] Code: 13833b01 11c630bc e1a00006 e8bd8070 (e7f001f2)
> >
> > (not much in the calltrace)
> > On all my boards. Also QEMU-arm fails.
> >
> 
> I forgot the bisect commit:
> 
> 258cfdfaf7bd729e759a0a91fd00ac9794796ad3 is the first bad commit
> commit 258cfdfaf7bd729e759a0a91fd00ac9794796ad3
> Author: Ming Lei <ming.lei@redhat.com>
> Date:   Fri Jan 11 19:01:15 2019 +0800
> 
>     block: use bio_for_each_bvec() to compute multi-page bvec count
> 
> :040000 040000 d79b2e71d308650df4764ff644f29d3a24dbab96
> 0a5d624843b805ee0c9fd9a7e2d5163f5b15b167 M block

It should be one 32-bit arch specific issue, I guess.

The following patch should fix this issue:

diff --git a/block/blk-merge.c b/block/blk-merge.c
index dc4877eaf9f9..4dd7183de849 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -166,6 +166,9 @@ static unsigned get_max_segment_size(struct request_queue *q,
 {
 	unsigned long mask = queue_segment_boundary(q);
 
+	if (mask == BLK_SEG_BOUNDARY_MASK)
+		return queue_max_segment_size(q);
+
 	return min_t(unsigned long, mask - (mask & offset) + 1,
 		     queue_max_segment_size(q));
 }

Thanks,
Ming

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
