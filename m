Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18138C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:58:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF04120834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PHTgAjeS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF04120834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yeWJ/Z4xLqGw5x+5elON2xY5Okmlt9oX6+LuWX+uRKA=; b=PHTgAjeSJgxrzs
	gjRhp4FibQj6oXy6k4D3MTPCDyOhCCcbhUm8ot/qHLY0xkHN60Rz3E0TbnimIKsT0p1qztuabUqgY
	X+bJFQQHmDFePHw+Wujqc7rzBwv7YbN5KPxqD82DiE/59KZ9JQo/bo7ebA24Kh9gbCCd8dSbsitEB
	1S0Uy86e6KCpeT7f4EKoe5O+0ZVRcAJIFF4UCp1gY0qm57LSjhgBGxhozvOiYUsRdb0XutteUrqsH
	9h+U9dYKa2AvEdsveVUdyLydrl9SL1UV2nzJ5I9IOvNUYcRxm/SvG9qchsP7W9z5DhNjdCtXKBEV/
	xs9lRkXk/7OPANNI3hJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU3it-00035M-AQ; Tue, 04 Dec 2018 05:58:19 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU3iq-00034L-41
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 05:58:17 +0000
Received: from vmware.local.home (unknown [184.48.106.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D11472146D;
 Tue,  4 Dec 2018 05:58:04 +0000 (UTC)
Date: Tue, 4 Dec 2018 00:58:03 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH] Uprobes: Fix kernel oops with delayed_uprobe_remove()
Message-ID: <20181204005803.787578e7@vmware.local.home>
In-Reply-To: <9f73b926-b3a5-2519-3a9e-91de35899a6e@linux.ibm.com>
References: <20181114081921.26484-1-ravi.bangoria@linux.ibm.com>
 <20181114160600.GD13885@redhat.com>
 <556c2aa5-550d-d96f-7ed2-549d8f3d803b@linux.ibm.com>
 <20181115124317.GA23272@redhat.com>
 <9f73b926-b3a5-2519-3a9e-91de35899a6e@linux.ibm.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_215816_178629_7037F57A 
X-CRM114-Status: GOOD (  12.78  )
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
Cc: linux-mips@linux-mips.org, srikar@linux.vnet.ibm.com, linux@armlinux.org.uk,
 peterz@infradead.org, ralf@linux-mips.org, liu.song.a23@gmail.com,
 Oleg Nesterov <oleg@redhat.com>, acme@kernel.org, linux-kernel@vger.kernel.org,
 alexander.shishkin@linux.intel.com, paul.burton@mips.com, mingo@redhat.com,
 mhiramat@kernel.org, ananth@linux.vnet.ibm.com, namhyung@kernel.org,
 naveen.n.rao@linux.vnet.ibm.com, alexis.berlemont@gmail.com, jolsa@redhat.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 3 Dec 2018 11:52:41 +0530
Ravi Bangoria <ravi.bangoria@linux.ibm.com> wrote:

> Hi Steve,
> 
> Please pull this patch.
> 

Please send a v2 version of the patch with the updated change log. And
should it have a Fixes and be tagged for stable?

-- Steve

> Thanks.
> 
> On 11/15/18 6:13 PM, Oleg Nesterov wrote:
> > On 11/15, Ravi Bangoria wrote:  
> >>
> >> There could be a race between task exit and probe unregister:
> >>
> >>   exit_mm()
> >>   mmput()
> >>   __mmput()                     uprobe_unregister()
> >>   uprobe_clear_state()          put_uprobe()
> >>   delayed_uprobe_remove()       delayed_uprobe_remove()
> >>
> >> put_uprobe() is calling delayed_uprobe_remove() without taking
> >> delayed_uprobe_lock and thus the race sometimes results in a
> >> kernel crash. Fix this by taking delayed_uprobe_lock before
> >> calling delayed_uprobe_remove() from put_uprobe().
> >>
> >> Detailed crash log can be found at:
> >>   https://lkml.org/lkml/2018/11/1/1244  
> > 
> > Thanks, looks good,
> > 
> > Oleg.
> >   


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
