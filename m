Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C6DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:47:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D72F206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TaFEb/jh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D72F206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RjvmFV0PSd7gsm8lbBKboibpOQq+1MvnuLAbtPpR0bw=; b=TaFEb/jhvEXEfi
	FrCFCPQdaA4XkfVlIovI54XPXTIpDe7xx6y56AM/qg+NeE5mrxT+UmB/M5QSKwsB1+aIqU83ztl48
	VhRo6brSsw36WAO11ROJmjt15U3gfQuvQDcSWStM+paT3AF8dC6jfmanj0cPSPsRn6mKcfe+cM3pk
	czcjaE3Z+4iJbCkcAYJ+QPRTlTR/2AfmbkDkb36f7+tC3Dt4m4sWk4o3k1reeuXM72VN19k08Ur/q
	sbcNxgUrzMm23uEnn9fPhwNASQXqs+fOUu+VCkDx0Cl5jMBdePizORZjZOduIePeO1cImLJ3k/pKp
	dZ46D/vUGKylg6rPT42A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjoLP-00075U-M1; Wed, 16 Jan 2019 16:47:11 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjoLM-000756-2Z
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 16:47:09 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DEC0A78;
 Wed, 16 Jan 2019 08:47:07 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBB5E3F5AF;
 Wed, 16 Jan 2019 08:47:05 -0800 (PST)
Date: Wed, 16 Jan 2019 16:46:58 +0000
From: Will Deacon <will.deacon@arm.com>
To: "huanglingyan (A)" <huanglingyan2@huawei.com>
Subject: Re: [PATCH v3] arm64: lib: accelerate do_csum with NEON instruction
Message-ID: <20190116164657.GA1910@brain-police>
References: <1546739729-17234-1-git-send-email-huanglingyan2@huawei.com>
 <CAKv+Gu_wsK1UNXSp=5Hvd7XCHKC3cVkYjTYHhvqM4Xt09A9iKg@mail.gmail.com>
 <9129b882-60f3-8046-0cb9-e0b2452a118d@huawei.com>
 <20190108135444.GB14476@fuggles.cambridge.arm.com>
 <cd5bb83e-bb0e-b348-5365-095c5fcd9648@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cd5bb83e-bb0e-b348-5365-095c5fcd9648@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_084708_121678_3DD3A6D0 
X-CRM114-Status: GOOD (  21.16  )
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
Cc: Zhangshaokun <zhangshaokun@hisilicon.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org, ard.biesheuvel@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 09, 2019 at 10:03:05AM +0800, huanglingyan (A) wrote:
> 
> On 2019/1/8 21:54, Will Deacon wrote:
> > [re-adding Ard and LAKML -- not sure why the headers are so munged]
> >
> > On Mon, Jan 07, 2019 at 10:38:55AM +0800, huanglingyan (A) wrote:
> >> On 2019/1/6 16:26, Ard Biesheuvel wrote:
> >>     Please change this into
> >>
> >>     if (IS_ENABLED(CONFIG_KERNEL_MODE_NEON) &&
> >>         len >= CSUM_NEON_THRESHOLD &&
> >>         may_use_simd()) {
> >>             kernel_neon_begin();
> >>             res = do_csum_neon(buff, len);
> >>             kernel_neon_end();
> >>         }
> >>
> >>     and drop the intermediate do_csum_arm()
> >>
> >>
> >>         +               return do_csum_arm(buff, len);
> >>         +#endif  /* CONFIG_KERNEL_MODE_NEON */
> >>
> >>     No else? What happens if len < CSUM_NEON_THRESHOLD ?
> >>
> >>
> >>         +#undef do_csum
> >>
> >>     Can we drop this?
> >>
> >> Using NEON instructions will bring some costs. The spending maybe introduced
> >> when reservering/restoring
> >> neon registers with kernel_neon_begin()/kernel_neon_end(). Therefore NEON code
> >> is Only used when
> >> the length exceeds CSUM_NEON_THRESHOLD. General do csum() codes in lib/
> >> checksum.c will be used in
> >> shorter length. To achieve this goal, I use the "#undef do_csum" in else clause
> >> to have the oppotunity to
> >> utilize the general codes.
> > I don't think that's how it works :/
> >
> > Before we get deeper into the implementation, please could you justify the
> > need for a CPU-optimised checksum implementation at all? I thought this was
> > usually offloaded to the NIC?
> >
> > Will
> >
> > .
> This problem is introduced when testing Intel x710 network card on my ARM server.
> Ip forward is set for ease of testing. Then send lots of packages to server by Tesgine
> machine and then receive.

In the marketing blurb, that card boasts:

  `Tx/Rx IP, SCTP, TCP, and UDP checksum offloading (IPv4, IPv6) capabilities'

so we shouldn't need to run this on the CPU. Again, I'm not keen to optimise
this given that it /really/ shouldn't be used on arm64 machines that care
about network performance.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
