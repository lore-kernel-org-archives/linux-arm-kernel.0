Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE27C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:57:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6017C2085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HapWqlgl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6017C2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oMktbSVeDiq4HjAOxTrMuVspSitewdjcctyOJSCvz18=; b=HapWqlglDppXCM
	1vyauUCQ+xTZRuS7S6m9oNcP0i+RFme4AdMNFJc106vS8Ik/6adIUIB0yy9HTer0fwdVZLXMvIwZ0
	MfbUpAbEOttWavSQeoHDKAJuSoyrXwKHbheU6zPKAJYJFrEbA7EN0UIClYbDdViSuADWiwCGK5TwL
	LU1HEhEsoDh/l4VhIoN8/7bSe76b7hbLiYHHgziVC+vMqGPvllFCKxUR0BqwgByU5/RsgzF9yl6BF
	SmMW8+jYzvfHfDvJiJdDi2J9YYCFdMbkrGXqA/E6M9e3/NJ0Lvm86k546y2+eqdblod5Sf4QnAL8I
	dL9rWh6/nE1WZChNuVBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm1EL-0002cI-9i; Tue, 22 Jan 2019 18:57:01 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm1EH-0002bx-Ur
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 18:56:59 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 313DBEBD;
 Tue, 22 Jan 2019 10:56:57 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDDC33F5C1;
 Tue, 22 Jan 2019 10:56:54 -0800 (PST)
Date: Tue, 22 Jan 2019 18:56:52 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] acpi: bgrt: parse BGRT to obtain BMP address before it
 gets clobbered
Message-ID: <20190122185652.GC13206@e107981-ln.cambridge.arm.com>
References: <20190122150616.850-1-ard.biesheuvel@linaro.org>
 <20190122173222.GB11720@e107981-ln.cambridge.arm.com>
 <CAKv+Gu9-tDRbmt+T3or9pMs78-pU-9BpKorhB60N_=Bxo78A1g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9-tDRbmt+T3or9pMs78-pU-9BpKorhB60N_=Bxo78A1g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_105657_994775_DD098B9B 
X-CRM114-Status: GOOD (  21.05  )
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
Cc: linux-efi <linux-efi@vger.kernel.org>,
 Graeme Gregory <graeme.gregory@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Leif Lindholm <leif.lindholm@linaro.org>, Al Stone <astone@redhat.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Peter Jones <pjones@redhat.com>, "Hsiung, Harry L" <harry.l.hsiung@intel.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 22, 2019 at 07:07:30PM +0100, Ard Biesheuvel wrote:
> On Tue, 22 Jan 2019 at 18:32, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> >
> > On Tue, Jan 22, 2019 at 04:06:16PM +0100, Ard Biesheuvel wrote:
> > > The bitmap left in the framebuffer by the firmware is described by an
> > > ACPI table called "BGRT", which describes the size, pixel format and
> > > the address of a BMP image in memory. While the BGRT ACPI table is
> > > guaranteed to reside in a "ACPI reclaim" memory region, which is
> > > never touched by Linux. The BMP image, however, typically resides
> > > in EFI Boot Services Memory, which may have been overwritten by the
> > > time the BGRT discovery routine runs.
> > >
> > > So instead, drop the handling from the ACPI init code, and call the
> > > BGRT parsing code immediately after going over the EFI configuration
> > > table array, at which time no memory has been touched yet except for
> > > the .data/.bss regions covered by the static kernel image.
> > >
> > > Unfortunately, this involves a non-trivial amount of ACPI entry
> > > point and root table parsing, but we cannot rely on the normal
> > > ACPI infrastructure yet this early in the boot.
> > >
> > > Also note that we cannot take the 'acpi_disabled' global variable
> > > into account, since it may not have assumed the correct value yet
> > > (on arm64, the default value is '1' which is overridden to '0' if
> > > no DT description has been made available by the firmware)
> > >
> > > Cc: Peter Jones <pjones@redhat.com>
> > > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >
> > Technically this is a fix, right ?
> >
> 
> I would argue that it is a hack to work around a deficiency in the
> ACPI spec, i.e., that the BGRT table but not the image are passed in
> ACPI reclaim memory.

I assume there are designs out there that this patch is fixing (I
understand it is hackish but there is not much else you can do,
especially so with firmware already in the field), I was wondering
if we want to update older kernels too.

Cheers,
Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
