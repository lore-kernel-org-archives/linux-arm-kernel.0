Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C73EC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:11:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC8F21852
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="St07LwbZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC8F21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c/KujxTQDONI+gd/6X8xawoG1god4A+yggLEEgUyB+k=; b=St07LwbZW0jhRg
	dkAzmcto0JQx2s6/qB4Ur6s3ofVW4vB6rnAoiIBFv3PtMvtQL2Zuq//wEQBn0+xVZwl+BG8E75k7q
	Os7h2e5bo7w6svqOHYnKVh1DD6Rahab0/HKZetf3I12plNysXiepIH0COQ2nWHxsXZ+1sFjcfhPgE
	KjhbvzbDdwqPXMZRA53GQK9wjue0LsgTxgQvxNA8y8TH6F7bobi9YeAOc200MR7PnrzJduvCDKGfe
	yENiZ5OaKL93FPAfhiiNDHCX1J7y5kFfiAqMRD7YhdXvYD17S9UfIlqw+iHD7WOKM/ziVOA4J7955
	HoUte0yCX49we4t0xtzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goVz2-0004pB-JC; Tue, 29 Jan 2019 16:11:32 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goVyw-0004j0-Fq
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 16:11:30 +0000
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 66619D7930;
 Tue, 29 Jan 2019 16:11:25 +0000 (UTC)
Received: from redhat.com (dhcp-10-20-1-13.bss.redhat.com [10.20.1.13])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 53BA05D6A6;
 Tue, 29 Jan 2019 16:11:21 +0000 (UTC)
Date: Tue, 29 Jan 2019 11:11:19 -0500
From: Peter Jones <pjones@redhat.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] acpi: bgrt: parse BGRT to obtain BMP address before it
 gets clobbered
Message-ID: <20190129161118.yncs67ud56hmjs7a@redhat.com>
References: <20190122150616.850-1-ard.biesheuvel@linaro.org>
 <20190123053141.GA7376@dhcp-128-65.nay.redhat.com>
 <CAKv+Gu9yVSfxfy37Z3xt-Ft70VtNs4YYQfcAvMB2qEdSLHhruw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9yVSfxfy37Z3xt-Ft70VtNs4YYQfcAvMB2qEdSLHhruw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Tue, 29 Jan 2019 16:11:25 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_081126_980383_BA09D494 
X-CRM114-Status: GOOD (  20.65  )
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Graeme Gregory <graeme.gregory@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Leif Lindholm <leif.lindholm@linaro.org>, Al Stone <astone@redhat.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 linux-efi <linux-efi@vger.kernel.org>, "Hsiung,
 Harry L" <harry.l.hsiung@intel.com>, Dave Young <dyoung@redhat.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 23, 2019 at 10:44:47AM +0100, Ard Biesheuvel wrote:
> On Wed, 23 Jan 2019 at 06:31, Dave Young <dyoung@redhat.com> wrote:
> > On 01/22/19 at 04:06pm, Ard Biesheuvel wrote:
> > > The bitmap left in the framebuffer by the firmware is described by an
> > > ACPI table called "BGRT", which describes the size, pixel format and
> > > the address of a BMP image in memory. While the BGRT ACPI table is
> > > guaranteed to reside in a "ACPI reclaim" memory region, which is
> > > never touched by Linux. The BMP image, however, typically resides
> > > in EFI Boot Services Memory, which may have been overwritten by the
> > > time the BGRT discovery routine runs.
> >
> > I vaguely remember boot service memory is reserved on X86,  so this
> > is an issue of arm only?
> 
> No both ARM and x86 are affected. Harry and/or Peter should be able to
> comment on the details.

I've definitely seen an x86 machine with this issue - Michael Kinney has
given me firmware for a MinnowBoard-MAX that results in having this
issue.  I'm don't recall if the image was in boot services memory or
not, but if we need I can test it tomorrow (I'm at my desk at work, it's
at my desk at home.)  In any case, whether or not it was clobbered
seemed to be mostly about the interaction between the memory layout the
firmware picked and luck on the order of what we allocate in kernel.

-- 
  Peter

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
