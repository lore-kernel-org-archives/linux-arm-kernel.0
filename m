Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EA3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:07:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BFBB206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aVfFkTEg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BFBB206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=grRotkcUy71IsbiiAmp/Ubvl2Bqf236nGCkQRlViu7c=; b=aVfFkTEgZTxitj
	eZgHB0tx16Vxf24GQuowoLIHDR4DQr721QTGPA9MUb9n8dg8SBHtjG0oRWfyYW8Ysw4XCOJeFC6BD
	Hp0j4GuRvxyo4bDI7pvmYFc4uUHj3hfLo5YJ/uEV1MOg1xe8io4wNGU+FuLYXg2rT9/FD9GaaJpzA
	4Bt4vfraE3i3FqtgNK1S3fyQU8hgpyRkfh1hBChVdh/Ww8CHWuPXwtAK4nW6djMK+SJc7KK59NxyF
	qahCRBSzjJudrcjrl6Qk+nhQIXbIs8KynEXNzI7/zGA/5duK+Lq8n16BzpTul0cuOqIJlgiPNMgh4
	8qzhCpoywsc/ndbaBR6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvetq-0007ph-1o; Mon, 18 Feb 2019 09:07:42 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvetm-0007p9-DS
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 09:07:39 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73AADA78;
 Mon, 18 Feb 2019 01:07:37 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17C5E3F589;
 Mon, 18 Feb 2019 01:07:35 -0800 (PST)
Date: Mon, 18 Feb 2019 09:07:31 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
To: Dave Martin <Dave.Martin@arm.com>, Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH 1/2] KVM: arm/arm64: Add save/restore support for
 firmware workaround state
Message-ID: <20190218090731.3d313d81@why.wild-wind.fr.eu.org>
In-Reply-To: <20190215172558.GO3567@e103592.cambridge.arm.com>
References: <20190107120537.184252-1-andre.przywara@arm.com>
 <20190107120537.184252-2-andre.przywara@arm.com>
 <20190122151714.GG3578@e103592.cambridge.arm.com>
 <20190125144657.3db91c91@donnerap.cambridge.arm.com>
 <20190129213223.GB3567@e103592.cambridge.arm.com>
 <20190130113900.10089070@donnerap.cambridge.arm.com>
 <20190215095857.2fd7e0fb@donnerap.cambridge.arm.com>
 <864l95s2fw.wl-marc.zyngier@arm.com>
 <20190215172558.GO3567@e103592.cambridge.arm.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_010738_466712_8AC4AC25 
X-CRM114-Status: GOOD (  28.32  )
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
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 15 Feb 2019 17:26:02 +0000
Dave Martin <Dave.Martin@arm.com> wrote:

> On Fri, Feb 15, 2019 at 11:42:27AM +0000, Marc Zyngier wrote:
> > On Fri, 15 Feb 2019 09:58:57 +0000,
> > Andre Przywara <andre.przywara@arm.com> wrote:  
> > > 
> > > On Wed, 30 Jan 2019 11:39:00 +0000
> > > Andre Przywara <andre.przywara@arm.com> wrote:
> > > 
> > > Peter, Marc, Christoffer,
> > > 
> > > can we have an opinion on whether it's useful to introduce some
> > > common scheme for firmware workaround system registers (parts of
> > > KVM_REG_ARM_FW_REG(x)), which would allow checking them for
> > > compatibility between two kernels without specifically knowing about
> > > them?
> > > Dave suggested to introduce some kind of signed encoding in the 4
> > > LSBs for all those registers (including future ones), where 0 means
> > > UNKNOWN and greater values are better. So without knowing about the
> > > particular register, one could judge whether it's safe to migrate.
> > > I am just not sure how useful this is, given that QEMU seems to ask
> > > the receiving kernel about any sysreg, and doesn't particularly care
> > > about the meaning of those registers. And I am not sure we really
> > > want to introduce some kind of forward looking scheme in the kernel
> > > here, short of a working crystal ball. I think the kernel policy was
> > > always to be as strict as possible about those things.  
> > 
> > I honestly don't understand how userspace can decide whether a given
> > configuration is migratable or not solely based on the value of such a
> > register. In my experience, the target system has a role to play, and
> > is the only place where we can find out about whether migration is
> > actually possible.  
> 
> Both origin and target system need to be taken into account.  I don't
> think that's anything new.

Well, that was what I understood from Andre's question.

> 
> > As you said, userspace doesn't interpret the data, nor should it. It
> > is only on the receiving end that compatibility is assessed and
> > whether some level of compatibility can be safely ensured.
> > 
> > So to sum it up, I don't believe in this approach as a general way of
> > describing the handling or errata.  
> 
> For context, my idea attempted to put KVM, not userspace, in charge of
> the decision: userspace applies fixed comparison rules determined ahead
> of time, but KVM supplies the values compared (and hence determines the
> result).
> 
> My worry was that otherwise we may end up with a wild-west tangle of
> arbitrary properties that userspace needs specific knowledge about.

And this is where our understanding differs. I do not think userspace
has to care at all. All it has to do is to provide the saved register
values to the target system, and let KVM accept or refuse these
settings. I can't see what providing a set of predefined values back to
userspace gains us.

An unknown register on the target system fails the restore phase:
that's absolutely fine, as we don't want to run on a system that
doesn't know about the mitigation.

An incompatible value fails the restore as well, as KVM itself finds
that this is a service it cannot safely provide.

No userspace involvement, no QEMU upgrade required. Only the kernel
knows about it.

> We can tolerate a few though.  If we accumulate a significant number
> of errata/vulnerability properties that need to be reported to
> userspace, this may be worth revisiting.  If not, it doesn't matter.

Andre: if you want this to make it into 5.1, the time is now.

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
