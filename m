Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14218C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:00:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D22C020B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lz6VJJ1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D22C020B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dYHMLTCAQdHr/QEHX/45wcO1ym9jyL2VtMFuswhDTAY=; b=lz6VJJ1l0OZzVy
	zVpBQ3YL4OJ9BXlrFXZYmjACmMlWpBYYbCQ4p4t6VN4uApZ4AmHy9NEa2pmOBGoIeUT6wpqfyBkKP
	aCf6OsX1KvRVAgvO/a2MMttMO96lLZ7reaiwqM2ppYEi6oZ1HQEm3WbvQQIqrfLhqPNaVFHUm8hd6
	Cs1mteriVaPBX0iSEr9q46UXq9mFw5a0a1QdI3OTU2wUSN6HBkYrQWPLltrwTC6GLyeFOBQXNPTbu
	ujK1FfhqhDRO1bryD2i5LeZuRI1YO/YbEUu5kWK0eDKFfkMgXyrwMuRgakyrqMOLETVnP4m7JmWpX
	36FG/YtoJLqA0ZkT3ibw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp98o-0007oK-UI; Thu, 31 Jan 2019 10:00:14 +0000
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp98m-0007o7-Au; Thu, 31 Jan 2019 10:00:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id C070C20423039; Thu, 31 Jan 2019 11:00:09 +0100 (CET)
Date: Thu, 31 Jan 2019 11:00:09 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Alex Kogan <alex.kogan@oracle.com>
Subject: Re: [PATCH 3/3] locking/qspinlock: Introduce starvation avoidance
 into CNA
Message-ID: <20190131100009.GB31534@hirez.programming.kicks-ass.net>
References: <20190131030136.56999-1-alex.kogan@oracle.com>
 <20190131030136.56999-4-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190131030136.56999-4-alex.kogan@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, dave.dice@oracle.com,
 will.deacon@arm.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
 rahul.x.yadav@oracle.com, mingo@redhat.com, steven.sistare@oracle.com,
 longman@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
 daniel.m.jordan@oracle.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 10:01:35PM -0500, Alex Kogan wrote:
> Choose the next lock holder among spinning threads running on the same
> socket with high probability rather than always. With small probability,
> hand the lock to the first thread in the secondary queue or, if that
> queue is empty, to the immediate successor of the current lock holder
> in the main queue.  Thus, assuming no failures while threads hold the
> lock, every thread would be able to acquire the lock after a bounded
> number of lock transitions, with high probability.
> 
> Note that we could make the inter-socket transition deterministic,
> by sticking a counter of intra-socket transitions in the head node
> of the secondary queue. At the handoff time, we could increment
> the counter and check if it is below a threshold. This adds another
> field to queue nodes and nearly-certain local cache miss to read and
> update this counter during the handoff. While still beating stock,
> this variant adds certain overhead over the probabilistic variant.

(also heavily suffers from the socket == node confusion)

How would you suggest RT 'tunes' this?

RT relies on FIFO fairness of the basic spinlock primitives; you just
completely wrecked that.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
